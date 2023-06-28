import 'dart:convert';

import 'package:zigy_demo/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:zigy_demo/utils/constants.dart';

/// Created by Patrice Mulindi email(mulindipatrice00@gmail.com) on 28.06.2023.

class GetUsers {
  Future<List<User>?> invoke() async {
    final response = await http.get(
      Uri.parse(
        'https://reqres.in/api/users?page=2',
      ),
    );
    try {
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      var snapshot = jsonResponse[Constants.data] as List;
      return snapshot.map((e) {
        e as Map<String, dynamic>;
        return User.fromJson(e);
      }).toList();
    } catch (error) {
      return null;
    }
  }
}
