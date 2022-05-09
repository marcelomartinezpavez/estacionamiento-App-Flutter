import 'package:estacionamiento/src/services/api_service.dart';
import 'package:flutter/material.dart';

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

  Api_Service api = Api_Service();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Pagar", style: TextStyle(color: Colors.orange)),
          backgroundColor: Colors.orange.shade100,
        ),
        // drawer: NavDrawer(),
        //body: Center(child: Text("This is salir page")));
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
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
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Patente',
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    var response = await this.api.toPayVehicle(this._patente);
                    print(response);

                    setState(() {
                      this._data = response;
                    });
                  },
                  child: const Text('Salir'),
                ),
                Text(
                  '$_data',
                  style: Theme.of(context).textTheme.headline4,
                ),
              ],
            ),
          ),
        ));
  }
}
