// lib/login_sheet.dart
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:mama_kris/screens/register_confidentiality_sheet.dart';
import 'package:mama_kris/utils/login_logic.dart' as lgn;
import 'package:mama_kris/widgets/custom_text_field.dart';
import 'package:mama_kris/widgets/next_button.dart';
import 'package:mama_kris/screens/register_role_sheet.dart';
import 'package:mama_kris/screens/registration_flow.dart';
import 'package:mama_kris/utils/login_logic.dart'; // Импорт бизнес-логики
import 'package:mama_kris/utils/google_apple_auth.dart';
import 'package:mama_kris/screens/pass_reset_email.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginSheetContent extends StatelessWidget {
  final double scaleX;
  final double scaleY;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  const LoginSheetContent({
    Key? key,
    required this.scaleX,
    required this.scaleY,
    required this.emailController,
    required this.passwordController,
  }) : super(key: key);

  Widget _buildLoginForm(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 329 * scaleY,
          left: 16 * scaleX,
          child: Container(
            width: 396 * scaleX,
            height: 627 * scaleY,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15 * scaleX),
                topRight: Radius.circular(15 * scaleX),
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0x78E7E7E7),
                  offset: Offset(0, 4 * scaleY),
                  blurRadius: 19 * scaleX,
                ),
              ],
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 40 * scaleY,
                  left: 20 * scaleX,
                  child: SvgPicture.asset(
                    'assets/login_sheet/text.svg',
                    width: 249 * scaleX,
                    height: 28 * scaleY,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 88 * scaleY,
                  left: 20 * scaleX,
                  child: CustomTextField(
                    scaleX: scaleX,
                    scaleY: scaleY,
                    hintText: "Email",
                    isPassword: false,
                    enableToggle: false,
                    controller: emailController,
                  ),
                ),
                Positioned(
                  top: 168 * scaleY,
                  left: 20 * scaleX,
                  child: CustomTextField(
                    scaleX: scaleX,
                    scaleY: scaleY,
                    hintText: "Пароль",
                    isPassword: true,
                    enableToggle: true,
                    controller: passwordController,
                  ),
                ),
                Positioned(
                  top: 258 * scaleY,
                  left: 20 * scaleX,
                  child: NextButton(
                    scaleX: scaleX,
                    scaleY: scaleY,
                    onPressed: () async {
                      bool navigated = await loginAndContinue(
                        context: context,
                        emailController: emailController,
                        passwordController: passwordController,
                      );
                      // Если loginAndContinue вернул false, значит нужно закрыть окно и показать панель выбора ролей.
                      if (!navigated) {
                        Navigator.pop(context);
                        showRoleSelectionPanel(context);
                      }
                    },
                  ),
                ),
                Positioned(
                  top: 258 * scaleY, // (645 - 329) = 316
                  right: 20 * scaleX, // (36 - 16) = 20
                  child: PopButton(
                    scaleX: scaleX,
                    scaleY: scaleY,
                    // onPressed: _onNextPressed,
                  ),
                ),
                Positioned(
                  top: 333 * scaleY,
                  left: 75 * scaleX,
                  right: 75 * scaleX,
                  child: SvgPicture.asset(
                    'assets/welcome_screen/text3.svg',
                    height: 29 * scaleY,
                  ),
                ),
                buildSocialButtons(
                  top: 372,
                  scaleX: scaleX,
                  scaleY: scaleY,
                  onGooglePressed: () => onGooglePressed(context),
                  onApplePressed: () => onApplePressed(context),
                  context: context,
                ),
                Positioned(
                  top: 490 * scaleY,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: TextButton(
                      style: ButtonStyle(
                        overlayColor:
                            WidgetStateProperty.all(Colors.transparent),
                        foregroundColor:
                            WidgetStateProperty.all(Color(0xFF00A80E)),
                        textStyle: WidgetStateProperty.resolveWith<TextStyle>((
                          Set<WidgetState> states,
                        ) {
                          if (states.contains(WidgetState.pressed)) {
                            return TextStyle(
                              decoration: TextDecoration.underline,
                              fontFamily: 'Jost',
                              fontSize: 16 * scaleX,
                            );
                          }
                          return TextStyle(
                            decoration: TextDecoration.none,
                            fontFamily: 'Jost',
                            fontSize: 16 * scaleX,
                          );
                        }),
                      ),
                      onPressed: () {
                        showPassResetEmailSheet(context);
                      },
                      child: const Text('Сбросить пароль'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildLoginForm(context);
  }
}

/// Показывает панель выбора ролей.
void showRoleSelectionPanel(BuildContext context) {
  final double screenWidth = MediaQuery.of(context).size.width;
  final double screenHeight = MediaQuery.of(context).size.height;
  double scaleX = screenWidth / 428;
  double scaleY = screenHeight / 956;

  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: "RegistrationFlow",
    barrierColor: Colors.white.withOpacity(0.5),
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (context, animation, secondaryAnimation) {
      return Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Positioned(
              top: 329 * scaleY,
              left: 16 * scaleX,
              child: Container(
                width: 396 * scaleX,
                height: 627 * scaleY,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15 * scaleX),
                    topRight: Radius.circular(15 * scaleX),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0x78E7E7E7),
                      offset: Offset(0, 4 * scaleY),
                      blurRadius: 19 * scaleX,
                    ),
                  ],
                ),
                child: RoleSelectionPanel(
                  scaleX: scaleX,
                  scaleY: scaleY,
                  onExecutorPressed: () {
                    // Для исполнителя отправляем выбор "Looking for job"
                    updateChoice('Looking for job', context);
                  },
                  onEmployerPressed: () {
                    // Для заказчика отправляем выбор "Have vacancies"
                    updateChoice('Have vacancies', context);
                  },
                ),
              ),
            ),
          ],
        ),
      );
    },
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 1),
          end: const Offset(0, 0),
        ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOut)),
        child: child,
      );
    },
  );
}

void _nextStep(context) async {
  final prefs = await SharedPreferences.getInstance();
  final accessToken = await prefs.getString('auth_token');
  final userId = await prefs.getInt('user_id');
  final String? currentPage = prefs.getString('current_page');
  final confirmed = await prefs.getBool('subscription_confirmed');

  if (confirmed != null && confirmed == true) {
    final url2 = Uri.parse(
        'https://dev.mamakris.ru/mail/api/mail/confirm-subscription/$userId');
    final headers2 = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };
    try {
      // print("Подтверждение подписки для userId: ${responseData['userId']}");
      // print("Используемый токен: ${responseData['accessToken']}");

      final response2 = await http.post(
        url2,
        headers: headers2,
      );

      // print("Статус подтверждения подписки: ${response2.statusCode}");
      // print("Ответ сервера: ${response2.body}");

      if (response2.statusCode == 200) {
        print('Подписка успешно подтверждена');
      } else {
        print('Ошибка подтверждения подписки: ${response2.statusCode}');
        print('Ответ сервера: ${response2.body}');
      }
    } catch (e) {
      // print('Ошибка при подтверждении подписки: $e');
    }
  } else {
    // print('Не согласился на рассылку');
  }
  if (currentPage == 'choice' || currentPage == null) {
    print(currentPage);
    showRoleSelectionPanel(context);
  } else {
    double scaleX = MediaQuery.of(context).size.width / 428;
    double scaleY = MediaQuery.of(context).size.height / 956;
    Widget nextPage =
        await lgn.determineNextPage(accessToken!, userId!, scaleX, scaleY);
    print(nextPage);
    Navigator.of(context).pushAndRemoveUntil(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 300),
        pageBuilder: (_, animation, __) => nextPage,
        transitionsBuilder: (_, animation, __, child) {
          final tween = Tween(begin: const Offset(1.0, 0.0), end: Offset.zero)
              .chain(CurveTween(curve: Curves.easeInOut));
          return SlideTransition(
              position: animation.drive(tween), child: child);
        },
      ),
      (route) => false,
    );
  }
}

void showCheckboxSelectionPanel(BuildContext context) {
  final double screenWidth = MediaQuery.of(context).size.width;
  final double screenHeight = MediaQuery.of(context).size.height;
  double scaleX = screenWidth / 428;
  double scaleY = screenHeight / 956;

  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: "ConfidentialityPanel",
    barrierColor: Colors.white.withOpacity(0.5),
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (context, animation, secondaryAnimation) {
      return Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Positioned(
              top: 329 * scaleY, // Такое же позиционирование как в showRoleSelectionPanel
              left: 16 * scaleX,
              child: Container(
                width: 396 * scaleX,
                height: 627 * scaleY, // Фиксированная высота
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15 * scaleX),
                    topRight: Radius.circular(15 * scaleX),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0x78E7E7E7),
                      offset: Offset(0, 4 * scaleY),
                      blurRadius: 19 * scaleX,
                    ),
                  ],
                ),
                child: ConfidentialityPanel(
                  scaleX: scaleX,
                  scaleY: scaleY,
                  onNext: () => _nextStep(context),
                ),
              ),
            ),
          ],
        ),
      );
    },
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 1),
          end: const Offset(0, 0),
        ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOut)),
        child: child,
      );
    },
  );
}

/// Показывает модальное окно с LoginSheetContent.
void showLoginSheet(BuildContext context) {
  final double screenWidth = MediaQuery.of(context).size.width;
  final double screenHeight = MediaQuery.of(context).size.height;
  double scaleX = screenWidth / 428;
  double scaleY = screenHeight / 956;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: "LoginSheet",
    barrierColor: Colors.white.withOpacity(0.5),
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (context, animation, secondaryAnimation) {
      return Scaffold(
        backgroundColor: Colors.transparent,
        body: Builder(
          builder: (context) {
            return LoginSheetContent(
              scaleX: scaleX,
              scaleY: scaleY,
              emailController: emailController,
              passwordController: passwordController,
            );
          },
        ),
      );
    },
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 1),
          end: const Offset(0, 0),
        ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOut)),
        child: child,
      );
    },
  );
}
