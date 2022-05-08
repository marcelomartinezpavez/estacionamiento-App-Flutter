import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Ingresar extends StatefulWidget {
  const Ingresar({Key? key}) : super(key: key);

  @override
  _IngresarState createState() => _IngresarState();
}

class _IngresarState extends State<Ingresar> {
  String _data = '';
  String _patente = '';

  Future<dynamic> _insertVehicle() async {
    final response = await http.post(
      Uri.parse('http://204.48.31.201:8080/estacionamiento/insert/estacionado'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
          <String, String>{'patente': _patente, 'estacionamiento_id': '3'}),
    );

    if (response.statusCode == 200) {
      _data = 'Vehiculo estacionado!';
      setState(() {
        _data = 'Vehiculo estacionado!';
      });
    } else {
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
      // drawer: NavDrawer(),

      appBar: AppBar(
        title: Text('Ingresar'),
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
