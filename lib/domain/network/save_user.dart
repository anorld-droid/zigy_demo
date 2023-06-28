import 'dart:convert';

import 'package:http/http.dart' as http;

/// Created by Patrice Mulindi email(mulindipatrice00@gmail.com) on 28.06.2023.
class SaveUser {
  Future<bool> invoke(String name, String job) async {
    final response = await http.post(
      Uri.parse(
        'https://reqres.in/api/users',
      ),
      body: jsonEncode(
        {
          "name": name,
          "job": job,
        },
      ),
    );
    try {
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      return jsonResponse.keys.contains("createdAt");
    } catch (error) {
      return false;
    }
  }
}
