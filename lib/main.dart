import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mama_kris/screens/main_screen.dart';
import 'package:mama_kris/screens/welcome_screen.dart';
import 'package:mama_kris/utils/funcs.dart' as funcs;
import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:mama_kris/constants/api_constants.dart';
import 'package:mama_kris/screens/update_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SessionManager(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const AppInitializer(),
      ),
    );
  }
}

/// Обёртка, которая отслеживает жизненный цикл приложения
/// и вызывает startSession при открытии и endSession при закрытии.
class SessionManager extends StatefulWidget {
  final Widget child;
  const SessionManager({Key? key, required this.child}) : super(key: key);

  @override
  State<SessionManager> createState() => _SessionManagerState();
}

class _SessionManagerState extends State<SessionManager>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _handleAppOpen();
  }

  @override
  void dispose() {
    _handleAppClose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      await _handleAppOpen();
    } else if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.detached) {
      await _handleAppClose();
    }
  }

  Future<void> _handleAppOpen() async {
    final prefs = await SharedPreferences.getInstance();
    int? userId = prefs.getInt('user_id');
    String? accessToken = prefs.getString('auth_token');
    if (userId != null && accessToken != null) {
      // print("SessionManager: Starting session for user $userId");
      await funcs.startSession(userId, accessToken);
    }
  }

  Future<void> _handleAppClose() async {
    final prefs = await SharedPreferences.getInstance();
    int? userId = prefs.getInt('user_id');
    String? accessToken = prefs.getString('auth_token');
    if (userId != null && accessToken != null) {
      // print("SessionManager: Ending session for user $userId");
      await funcs.endSession(userId, accessToken);
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

/// Инициализирует приложение и определяет начальный экран
class AppInitializer extends StatefulWidget {
  const AppInitializer({Key? key}) : super(key: key);

  @override
  State<AppInitializer> createState() => _AppInitializerState();
}

class _AppInitializerState extends State<AppInitializer> {
  late Future<Widget> _initialScreenFuture;

  Future<Widget> _determineInitialScreen() async {
    // Проверяем, нужна ли версия обновления:
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    final String currentVersion = packageInfo.version;
    bool updateRequired = false;
    try {
      final response = await http.get(
        Uri.parse('${kBaseUrl}client-version/1'),
        headers: {'accept': '*/*'},
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final String minRequiredVersion = data['version'];
        if (_compareVersion(currentVersion, minRequiredVersion) < 0) {
          updateRequired = true;
          // print(
          //   "Update needed: current version $currentVersion, min required $minRequiredVersion",
          // );
        } else {
          // print(
          //   "No update needed: current version $currentVersion, min required $minRequiredVersion",
          // );
        }
      } else {
        // print("Error checking version: ${response.statusCode}");
      }
    } catch (e) {
      // print("Exception while checking version: $e");
    }
    if (updateRequired) {
      // Здесь можно вернуть экран обновления приложения
      // Например:
      return UpdateScreen();
      // Пока что выводим отладочное сообщение и возвращаем WelcomeScreen().
      // print("Update screen should be displayed here (code commented out)");
      // return WelcomeScreen();
    }

    // Далее определяем начальный экран на основании состояния входа пользователя
    final prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLogged') ?? false;
    String? currentPage = prefs.getString('current_page');
    String? accessToken = prefs.getString('auth_token');
    int? userId = prefs.getInt('user_id');
    String? refreshToken = prefs.getString('refresh_token');
    // print("isLoggedIn: $isLoggedIn");
    if (isLoggedIn &&
        refreshToken != null &&
        refreshToken.isNotEmpty &&
        userId != null) {
      // Обновляем токен и данные пользователя
      await funcs.refreshAccessToken();
      if (accessToken != null) {
        await funcs.updateUserDataInCache(accessToken, userId);
        await funcs.updateSelectedSpheres();
        await funcs.fetchAdvertisementBanner();
        bool hasSubscription = await funcs.hasSubscription();
        await prefs.setBool('has_subscription', hasSubscription);

        int viewedCount = await funcs.getViewedCount(accessToken, userId);
        await prefs.setInt('viewed_count', viewedCount);

        int likedCount = await funcs.getLikedCount(accessToken, userId);
        await prefs.setInt('liked_count', likedCount);
      // Если currentPage равен "tinder" или "job", запускаем MainScreen, иначе WelcomeScreen
      if (currentPage == 'tinder' || currentPage == 'search' || currentPage == 'job') {
        return MainScreen();
      } else {
        return WelcomeScreen();
      }
      }
      else {
        return WelcomeScreen();
      }
    } else {
      return WelcomeScreen();
    }
  }

  // Функция сравнения версий
  int _compareVersion(String currentVersion, String minRequiredVersion) {
    List<int> currentList = currentVersion.split('.').map(int.parse).toList();
    List<int> requiredList =
        minRequiredVersion.split('.').map(int.parse).toList();
    for (int i = 0; i < 3; i++) {
      int current = i < currentList.length ? currentList[i] : 0;
      int required = i < requiredList.length ? requiredList[i] : 0;
      if (current > required) return 1;
      if (current < required) return -1;
    }
    return 0;
  }
  
  @override
  void initState() {
    super.initState();
    _initialScreenFuture = _determineInitialScreen();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Widget>(
      future: _initialScreenFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            body: Center(child: Text("Ошибка: ${snapshot.error}")),
          );
        } else {
          return snapshot.data!;
        }
      },
    );
  }
}
