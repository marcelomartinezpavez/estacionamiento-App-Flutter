import 'package:estacionamiento/salir.dart';
import 'package:flutter/material.dart';

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Estacionamiento',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Estacionamiento'),

    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class NavDrawer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text('Menu'),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            title: Text('Entrar estacionamiento'),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => MyHomePage(title: 'Estacionamiento')));
            },
          ),
          ListTile(
            title: Text('Salir estacionamiento'),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => SalirPage(title: 'Salir')));
            },
          ),

        ],
      ),
    );
  }
}

class _MyHomePageState extends State<MyHomePage> {
  String _data = '';
  String _patente = '';

  Future<dynamic> _insertVehicle() async{

    final response = await http.post(
        Uri.parse('http://204.48.31.201:8080/estacionamiento/insert/estacionado')
      ,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'patente': _patente,
        'estacionamiento_id': '3'
      }),);

    if (response.statusCode == 200) {
      _data = 'Vehiculo estacionado!';
      setState(() {
        _data = 'Vehiculo estacionado!';

      });
    }else {
      print(response.body);
      print(response.statusCode);

      _data = response.body;
      setState(() {
        _data = response.body;

      });

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),

      appBar: AppBar(
        title: Text(widget.title),
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Ingrese patente del Vehiculo que ingresa',
            ),

            TextField(
              onChanged: (text) {
                setState(() {
                  _patente = text;
                });
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Patente',
              ),

            ),

            ElevatedButton(
              onPressed: _insertVehicle,
              child: Text('Ingresar'),
            ),

            Text(
              '$_data',
              style: Theme.of(context).textTheme.headline4,
            ),

          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
