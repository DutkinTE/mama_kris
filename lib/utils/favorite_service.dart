// utils/favorite_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mama_kris/utils/funcs.dart' as funcs;
import 'package:mama_kris/constants/api_constants.dart';

class FavoriteService {
  /// Получает список одобренных вакансий для пользователя
  static Future<List<Map<String, dynamic>>> getApprovedJobs() async {
    final prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('auth_token');
    int? userId = prefs.getInt('user_id');

    // print(
    //   "FavoriteService.getApprovedJobs: accessToken = $accessToken, userId = $userId",
    // );

    if (accessToken == null || userId == null) {
      // print("FavoriteService.getApprovedJobs: Нет токена или userId");
      return [];
    }

    try {
      final response = await http.get(
        Uri.parse('${kBaseUrl}viewed-jobs/liked-ids/$userId'),
        headers: {'Authorization': 'Bearer $accessToken'},
      );

      // print(
      //   "FavoriteService.getApprovedJobs: response.statusCode = ${response.statusCode}",
      // );
      // print(
      //   "FavoriteService.getApprovedJobs: response.body = ${response.body}",
      // );

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        // Преобразуем данные, беря значение поля 'job'
        List<Map<String, dynamic>> jobs =
            data.map((job) => job['job'] as Map<String, dynamic>).toList();
        // Фильтруем вакансии, оставляем только со статусом "approved"
        List<Map<String, dynamic>> approvedJobs =
            jobs.where((job) => job['status'] == 'approved').toList();
        // print(
        //   "FavoriteService.getApprovedJobs: найдено approved вакансий = ${approvedJobs.length}",
        // );
        return approvedJobs;
      } else if (response.statusCode == 401) {
        bool refreshed = await funcs.refreshAccessToken();
        // print("FavoriteService.getApprovedJobs: token refreshed = $refreshed");
        if (refreshed) {
          return await getApprovedJobs();
        } else {
          throw Exception('Failed to refresh token');
        }
      } else {
        throw Exception('Failed to load liked jobs');
      }
    } catch (e) {
      // print("FavoriteService.getApprovedJobs: Exception: $e");
      return [];
    }
  }
}
