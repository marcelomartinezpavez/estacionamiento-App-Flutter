import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';

import '../model/login_model.dart';
import '../model/signup_model.dart';
import '../routes/routes.dart';

class Auth_Service {
  // final _url = 'http://45.236.128.8:8080/';
  final _url = 'http://localhost:8080/';
  final headers = <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
  };

  final LocalStorage storage = LocalStorage('authCredentials');

  // Aquí voy a intentar iniciar sesión con los últimos datos ingresados
  /* Future<bool> loginFromLocalStorage(context) async {
    return await storage.ready.then((value) async {
      print('LocalStorage ready');
      var username = storage.getItem('username');
      var pass = storage.getItem('pass');
      print(
          'username and pass: ' + username.toString() + ' ' + pass.toString());
      if (username == null || pass == null) {
        return false;
      } else {
        LogIn login = LogIn(username: username, password: pass);
        var response = await http.post(Uri.parse(_url + 'login/'),
            headers: headers,
            body: jsonEncode(<String, String>{
              'users': login.username,
              'pass': login.password
            }));
        if (response.statusCode == 200) {
          return true;
        } else {
          print('Login incorrecto desde localstorage');
          return false;
          // throw Exception('Error al consultar el usuario');
        }
      }
    });
  }*/

  dynamic getActualUser() {
    var user = storage.getItem('userEstacionamiento');
    var userJson = json.decode(user.toString());
    return userJson;
  }

  Future<bool> logIn(LogIn logInForm) async {
    var response = await http.post(Uri.parse(_url + 'login/'),
        headers: headers,
        body: jsonEncode(<String, String>{
          'users': logInForm.username,
          'pass': logInForm.password
        }));
    if (response.statusCode == 200) {
      print('Login correcto, se guardará -> ' + response.body);
      // await storage.ready.then((value) async {
      //   await storage.setItem('username', logInForm.username);
      //   await storage.setItem('pass', logInForm.password);
      // });
      await storage.setItem('userEstacionamiento', response.body);
      return true;
    } else {
      print('Login incorrecto');
      throw response.body;
      return false;
      // throw Exception('Error al consultar el usuario');
    }
  }

  Future<bool> signUp(SignUp signUpForm) async {
    var response = await http.post(Uri.parse(_url + 'login/create'),
        headers: headers,
        body: jsonEncode(<String, String>{
          'users': signUpForm.users,
          'pass': signUpForm.pass,
          'rol': "admin",
          'direccionEmpresa': signUpForm.direccionEmpresa,
          'nombreEmpresa': signUpForm.nombreEmpresa,
          'rutEmpresa': signUpForm.rutEmpresa,
        }));
    if (response.statusCode == 200) {
      return true;
    } else {
      print('SignUp incorrecto');
      throw response.body;
      return false;
      // throw Exception('Error al consultar el usuario');
    }
  }

  signOut(context) {
    storage.deleteItem('userEstacionamiento');
    storage.deleteItem('username');
    storage.deleteItem('pass');
    goLogin(context);
  }
}
