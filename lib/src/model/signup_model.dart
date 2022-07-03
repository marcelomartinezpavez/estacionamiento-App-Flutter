// To parse this JSON data, do
//
//     final signUp = signUpFromJson(jsonString);

import 'dart:convert';

SignUp signUpFromJson(String str) => SignUp.fromJson(json.decode(str));

String signUpToJson(SignUp data) => json.encode(data.toJson());

class SignUp {
  SignUp({
    required this.nombreEmpresa,
    required this.users,
    required this.pass,
    required this.confirmPassword,
    required this.direccionEmpresa,
    required this.rutEmpresa,
  });

  String nombreEmpresa;
  String users;
  String pass;
  String confirmPassword;
  String direccionEmpresa;
  String rutEmpresa;
  String rol = "Admin";

  factory SignUp.fromJson(Map<String, dynamic> json) => SignUp(
        nombreEmpresa: json["nombreEmpresa"],
        users: json["users"],
        pass: json["pass"],
        confirmPassword: json["confirmPassword"],
        direccionEmpresa: json["direccionEmpresa"],
        rutEmpresa: json["rutEmpresa"],
      );

  Map<String, dynamic> toJson() => {
        "nombreEmpresa": nombreEmpresa,
        "users": users,
        "pass": pass,
        "confirmPassword": confirmPassword,
        "direccionEmpresa": direccionEmpresa,
        "rutEmpresa": rutEmpresa,
      };
}
