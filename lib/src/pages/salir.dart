import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SalirPage extends StatefulWidget {
  const SalirPage({Key? key}) : super(key: key);

  @override
  State<SalirPage> createState() => salir();
}

class salir extends State<SalirPage> {
  static const String routeName = '/salir';
  String _data = '';
  String _patente = '';
  int valorTotal = 0;

  Future<dynamic> _toPayVehicle() async {
    final response = await http.post(
      Uri.parse('http://204.48.31.201:8080/estacionamiento/insert/pago'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
          <String, String>{'patente': _patente, 'estacionamiento_id': '3'}),
    );

    if (response.statusCode == 200) {
      print(response.body);
      print(response.statusCode);
      print(jsonDecode(response.body));
      print(jsonDecode(response.body)['valorTotal']);

      _data = response.body;
      setState(() {
        valorTotal = jsonDecode(response.body)['valorTotal'];
        _data = 'El valor a cancelar para el vehiculo ' +
            _patente +
            ' es: ' +
            valorTotal.toString();
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
    return new Scaffold(
        appBar: AppBar(
          title: Text("Pagar"),
        ),
        // drawer: NavDrawer(),
        //body: Center(child: Text("This is salir page")));
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Ingrese patente del Vehiculo que pagara',
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
                onPressed: _toPayVehicle,
                child: Text('Salir'),
              ),
              Text(
                '$_data',
                style: Theme.of(context).textTheme.headline4,
              ),
            ],
          ),
        ));
  }
}
