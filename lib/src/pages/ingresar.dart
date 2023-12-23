import 'package:flutter/material.dart';

import '../services/api_service.dart';

class Ingresar extends StatefulWidget {
  const Ingresar({Key? key}) : super(key: key);

  @override
  _IngresarState createState() => _IngresarState();
}

class _IngresarState extends State<Ingresar> {
  final GlobalKey<FormState> ingresarFormKey = GlobalKey<FormState>();
  final myController = TextEditingController();

  String _patente = '';
  Api_Service api = Api_Service();

  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: NavDrawer(),

      appBar: AppBar(
        title: const Text("Ingresar", style: TextStyle(color: Colors.green)),
        backgroundColor: Colors.green.shade100,
      ),

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
            Form(
                key: ingresarFormKey,
                autovalidateMode: AutovalidateMode.always,
                child: TextFormField(
                  controller: myController,
                  onChanged: (text) {
                    setState(() {
                      _patente = text.toUpperCase();
                      myController.value = myController.value
                          .copyWith(text: _patente.toUpperCase());
                    });
                  },
                  validator: (value) {
                    if (value == null || value.length <= 4) {
                      return 'Por favor ingrese una patente';
                    }
                    // validar que no permita Ñ ni caracteres especiales, solo letras y números
                    if (value.contains(RegExp(r'[ñÑ]'))) {
                      return 'La patente no puede contener Ñ';
                    }
                    if (value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
                      return 'La patente no puede contener caracteres especiales';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Patente',
                  ),
                )),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(
                    40), // fromHeight use double.infinity as width and 40 is the height
              ),
              onPressed: _patente.length >= 5 && !_loading
                  ? () async {
                      setState(() {
                        _loading = true;
                      });
                      var response = await api.insertVehicle(_patente);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(response),
                        action: SnackBarAction(
                          label: 'Ok',
                          onPressed: () => Navigator.pop(context),
                        ),
                      ));
                      setState(() {
                        _loading = false;
                      });
                    }
                  : null,
              child: const Text('Ingresar'),
            ),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
