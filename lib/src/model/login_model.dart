// To parse this JSON data, do
//
//     final logIn = logInFromJson(jsonString);

import 'dart:convert';

LogIn logInFromJson(String str) => LogIn.fromJson(json.decode(str));

String logInToJson(LogIn data) => json.encode(data.toJson());

class LogIn {
  LogIn({
    required this.email,
    required this.password,
  });

  String email;
  String password;

  factory LogIn.fromJson(Map<String, dynamic> json) => LogIn(
    email: json["email"],
    password: json["password"],
  );

  Map<String, dynamic> toJson() => {
    "email": email,
    "password": password,
  };
}
