import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/scorecard_data.dart';

class ApiService {
  static const String apiUrl = 'https://httpbin.org/post';

  static Future<bool> submitScorecard(ScorecardData data) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(data.toJson()),
      );

      if (response.statusCode == 200) {
        print('Response: ${response.body}');
        return true;
      } else {
        print('Failed with status code: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Error submitting scorecard: $e');
      throw e;
    }
  }
}
