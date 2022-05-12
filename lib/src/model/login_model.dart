// To parse this JSON data, do
//
//     final logIn = logInFromJson(jsonString);

import 'dart:convert';

LogIn logInFromJson(String str) => LogIn.fromJson(json.decode(str));

String logInToJson(LogIn data) => json.encode(data.toJson());

class LogIn {
  String username;
  String password;

  LogIn({
    required this.username,
    required this.password,
  });

  factory LogIn.fromJson(Map<String, dynamic> json) => LogIn(
        username: json["username"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "password": password,
      };
}
