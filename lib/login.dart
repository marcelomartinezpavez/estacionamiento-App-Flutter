import 'package:flutter/material.dart';

import 'main.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

//import 'package:shared_preferences/shared_preferences.dart';
//import 'package:flutter_session/flutter_session.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';


class Login extends StatefulWidget {


  const Login() : super();

  //final String title;

  @override
  State<Login> createState() => login();
}


class login extends State<Login> {

  //final LocalStorage storage = new LocalStorage('localstorage_app');
  bool isLoggedIn = false;

  String _users = '';
  String _pass = '';



  Future<dynamic> _toLogin() async{
    print('ToLogin');
    final response = await http.post(
      Uri.parse('http://204.48.31.201:8080/login/')
      ,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'users': _users,
        'pass': _pass
      }),);

    if (response.statusCode == 200) {
      //final SharedPreferences prefs = await SharedPreferences.getInstance();

      print(response.body);
      print(response.statusCode);
      print(jsonDecode(response.body));
      //print(jsonDecode(response.body)['valorTotal']);
      //storage.setItem('login', jsonDecode(response.body));

      //prefs.setString('username', jsonDecode(response.body));
      //prefs.setString('idEmpresa', jsonDecode(response.body));
      //prefs.setString('nameEmpresa', jsonDecode(response.body));



      setState(() {
        //name = nameController.text;
        isLoggedIn = true;
      });

      //nameController.clear();


      //_data = response.body;
      setState(() {

      });

      MaterialPageRoute(
          builder: (BuildContext context) => MyHomePage(title: 'Estacionamiento'));

    }else {
      print(response.body);
      print(response.statusCode);

      //_data = response.body;
      setState(() {
        //_data = response.body;

      });

    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: ListView(children: [
        TextFormField(
          decoration: InputDecoration(
            hintText: 'Usuario',
          ),
          onChanged: (text) {
            setState(() {
              _users = text;
            });
          },
        ),
        TextFormField(
          decoration: InputDecoration(
            hintText: 'Contraseña',
          ),
          onChanged: (text) {
            setState(() {
              _pass = text;
            });
          },
        ),
          ElevatedButton(
            onPressed: _toLogin,
            child: Text('Ingresar'),
          ),

        ]),
      ),
    );
  }
}