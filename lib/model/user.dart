// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  int code;
  String message;
  String userId;
  String password;
  String username;
  String email;

  User({
    required this.code,
    required this.message,
    required this.userId,
    required this.password,
    required this.username,
    required this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        code: json["code"],
        message: json["message"],
        userId: json["user_id"],
        password: json["password"],
        username: json["username"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "user_id": userId,
        "password": password,
        "username": username,
        "email": email,
      };
}
