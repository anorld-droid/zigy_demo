import 'package:zigy_demo/utils/constants.dart';

/// Created by Patrice Mulindi email(mulindipatrice00@gmail.com) on 28.06.2023.
class User {
  final int id;
  final String email;
  final String firstName;
  final String lastName;
  final String? avatar;

  const User({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.avatar,
  });

  Map<String, dynamic> toJson() => {
        Constants.id: id,
        Constants.email: email,
        Constants.firstName: firstName,
        Constants.lastName: lastName,
        Constants.avatar: avatar,
      };

  factory User.fromJson(Map<String, dynamic> snapshot) {
    return User(
      id: snapshot[Constants.id],
      email: snapshot[Constants.email],
      firstName: snapshot[Constants.firstName],
      lastName: snapshot[Constants.lastName],
      avatar: snapshot[Constants.avatar],
    );
  }
}
