import 'package:estacionamiento/src/services/api_service.dart';
import 'package:flutter/material.dart';

class SalirPage extends StatefulWidget {
  SalirPage({Key? key, this.patente}) : super(key: key);

  String? patente;

  @override
  State<SalirPage> createState() => Salir();
}

class Salir extends State<SalirPage> {
  final GlobalKey<FormState> salirFormKey = GlobalKey<FormState>();
  final myController = TextEditingController();

  static const String routeName = '/salir';
  String? _data;
  String _patente = '';
  int? valorTotal;

  Api_Service api = Api_Service();

  @override
  void initState() {
    setState(() {
      _patente = widget.patente ?? '';
      myController.value =
          myController.value.copyWith(text: _patente.toUpperCase());
    });
    super.initState();
  }

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
                  textCapitalization: TextCapitalization.characters,
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
                    return null;
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Patente',
                  ),
                )),
            _data != null
                ? Text(
                    _data!,
                    style: Theme.of(context).textTheme.headline4,
                  )
                : valorTotal != null
                    ? Text('\$ ' +
                        valorTotal!.toString().replaceAllMapped(
                            RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                            (Match m) => '${m[1]},'))
                    : const Text('Busca una patente para ver el monto'),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(
                    40), // fromHeight use double.infinity as width and 40 is the height
              ),
              onPressed: _patente.length >= 5
                  ? () async {
                      print('patente: ' + _patente);
                      var response = await api.toPayVehicle(_patente);

                      print('responseeeeee: ' + response);

                      // intentar parsear response a numero, si no se puede que siga la ejecucion
                      try {
                        valorTotal = int.parse(response);
                        setState(() {
                          _data = null;
                          valorTotal = int.parse(response);
                        });
                      } catch (e) {
                        setState(() {
                          valorTotal = null;

                          _data = response;
                        });
                      }

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
