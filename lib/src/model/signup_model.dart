// To parse this JSON data, do
//
//     final signUp = signUpFromJson(jsonString);

import 'dart:convert';

SignUp signUpFromJson(String str) => SignUp.fromJson(json.decode(str));

String signUpToJson(SignUp data) => json.encode(data.toJson());

class SignUp {
  SignUp({
    required this.name,
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.acceptTerms,
  });

  String name;
  String email;
  String password;
  String confirmPassword;
  String acceptTerms;

  factory SignUp.fromJson(Map<String, dynamic> json) => SignUp(
    name: json["name"],
    email: json["email"],
    password: json["password"],
    confirmPassword: json["confirmPassword"],
    acceptTerms: json["acceptTerms"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "email": email,
    "password": password,
    "confirmPassword": confirmPassword,
    "acceptTerms": acceptTerms,
  };
}
