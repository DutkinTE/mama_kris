import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class StatService {
  static Future<Map<String, dynamic>> getPlatformStats() async {
    try {
      final now = DateTime.now();
      final formatter = DateFormat('yyyy-MM-dd');
      final endDate = formatter.format(now);
      final startDate = formatter.format(now.subtract(const Duration(days: 30)));

      final usersResponse = await http.get(
        Uri.parse('https://app.mamakris.ru/api/analytics/download-count?'
            'startDate=$startDate&endDate=$endDate'),
      );

      print(usersResponse.statusCode);
      if (usersResponse.statusCode == 200) {
        return {
          'users': jsonDecode(usersResponse.body)['count'] ?? 0,
          'vacancies': 0
        };
      }
      
      return {'users': 0, 'vacancies': 0};
    } catch (e) {
      return {'users': 0, 'vacancies': 0};
    }
  }
}