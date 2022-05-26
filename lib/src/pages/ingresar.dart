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

      appBar: AppBar(title: const Text('Ingresar vehículo')),

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            const FittedBox(
              fit: BoxFit.contain,
              child: Text(
                "Ingrese patente del Vehiculo que ingresa",
                style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
              ),
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
              style: ElevatedButton.styleFrom(
                minimumSize: Size.fromHeight(40), // fromHeight use double.infinity as width and 40 is the height
              ),
              onPressed: () async {
                var response = await api.insertVehicle(_patente);
                await this.api.userHasConfig();
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
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
