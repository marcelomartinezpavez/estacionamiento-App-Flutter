import 'package:estacionamiento/src/services/api_service.dart';
import 'package:flutter/material.dart';

class SalirPage extends StatefulWidget {
  const SalirPage({Key? key}) : super(key: key);

  @override
  State<SalirPage> createState() => Salir();
}

class Salir extends State<SalirPage> {
  final GlobalKey<FormState> salirFormKey = GlobalKey<FormState>();

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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            const FittedBox(
              fit: BoxFit.contain,
              child: Text(
                "Ingrese patente del Vehiculo que sale",
                style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
              ),
            ),
            Form(
                key: salirFormKey,
                autovalidateMode: AutovalidateMode.always,
                child: TextFormField(
                  onChanged: (text) {
                    setState(() {
                      _patente = text;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.length <= 4) {
                      return 'Por favor ingrese una patente';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Patente',
                  ),
                )),
            _data != ''
                ? Text(
                    _data,
                    style: Theme.of(context).textTheme.headline4,
                  )
                : Container(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(
                    40), // fromHeight use double.infinity as width and 40 is the height
              ),
              onPressed: _patente.length >= 5
                  ? () async {
                      var response = await api.toPayVehicle(_patente);

                      setState(() {
                        _data = response;
                      });
                      await api.userHasConfig();
                    }
                  : null,
              child: const Text('Sacar vehículo'),
            ),
          ],
        ),
      ),
    );
  }
}
