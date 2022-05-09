import 'package:flutter/material.dart';

import '../services/api_service.dart';

class Ingresar extends StatefulWidget {
  const Ingresar({Key? key}) : super(key: key);

  @override
  _IngresarState createState() => _IngresarState();
}

class _IngresarState extends State<Ingresar> {
  String _patente = '';
  Api_Service api = Api_Service();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: NavDrawer(),

      appBar: AppBar(
        title: const Text('Ingresar vehículo',
            style: TextStyle(color: Colors.green)),
        backgroundColor: Colors.green.shade100,
      ),

      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
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
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Patente',
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  var response = await api.insertVehicle(_patente);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(response),
                    action: SnackBarAction(
                      label: 'Ok',
                      onPressed: () => Navigator.pop(context),
                    ),
                  ));
                },
                child: const Text('Ingresar'),
              ),
            ],
          ),
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
