import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StatService {
  static const String baseUrl = 'https://dev.mamakris.ru';
  static const String usersCountPath = '/api/analytics/download-count';
  static const String jobsStatusPath = '/api/analytics/jobs-status-count';
  static const String authTokenKey = 'auth_token';

  static Future<Map<String, dynamic>> getPlatformStats() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final accessToken = prefs.getString(authTokenKey);
      if (accessToken == null) throw Exception('No auth token available');

      final headers = {
        'accept': 'application/json',
        'Authorization': 'Bearer $accessToken',
      };

      final now = DateTime.now();
      final formatter = DateFormat('yyyy-MM-dd');
      final usersUrl = Uri.parse(
          '$baseUrl$usersCountPath?startDate=2000-01-01&endDate=${formatter.format(now)}');

      final usersResponse = await http.get(usersUrl, headers: headers);
      final usersCount = _parseUsersCount(usersResponse);

      final jobsUrl = Uri.parse('$baseUrl$jobsStatusPath');
      final jobsResponse = await http.get(jobsUrl, headers: headers);
      final vacanciesCount = _parseVacanciesCount(jobsResponse);

      return {
        'users': usersCount,
        'vacancies': vacanciesCount,
      };
    } catch (e) {
      print('Error in getPlatformStats: $e');
      return {'users': 0, 'vacancies': 0};
    }
  }

  static int _parseUsersCount(http.Response response) {
    if (response.statusCode == 200) {
      if (response.body.trim().isNotEmpty && 
          RegExp(r'^\d+$').hasMatch(response.body.trim())) {
        return int.tryParse(response.body.trim()) ?? 0;
      } else {
        final jsonData = jsonDecode(response.body);
        return jsonData['count'] ?? 0;
      }
    }
    return 0;
  }

  static int _parseVacanciesCount(http.Response response) {
    if (response.statusCode == 200) {
      try {
        final jobsData = jsonDecode(response.body) as Map<String, dynamic>;
        return jobsData.values
            .whereType<int>() 
            .fold(0, (sum, count) => sum + count);
      } catch (e) {
        print('Error parsing vacancies: $e');
      }
    }
    return 0;
  }
}