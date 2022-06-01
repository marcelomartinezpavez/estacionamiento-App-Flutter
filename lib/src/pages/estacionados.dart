import 'package:estacionamiento/src/services/api_service.dart';
import 'package:flutter/material.dart';

class EstacionadosPage extends StatefulWidget {
  const EstacionadosPage({Key? key}) : super(key: key);

  @override
  State<EstacionadosPage> createState() => estacionados();
}

class estacionados extends State<EstacionadosPage> {
  static const String routeName = '/estacionados';
  var _data = Api_Service().getEstacionado();
  //String _patente = '';
  //int valorTotal = 0;

  Api_Service api = Api_Service();

  //var _estacionados = api.getEstacionado();
  //var response = Api_Service().getEstacionado();


  @override
  Widget build(BuildContext context) {
    //var response = api.getEstacionado().toString();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Estacionados", style: TextStyle(color: Colors.yellow)),
        backgroundColor: Colors.yellowAccent.shade100,
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
                "Historial de estacionados",
                style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
              ),
            ),

            _data != ''
                ? Text(
              '$_data',
              style: Theme.of(context).textTheme.headline4,
            )
                : Container(),

          ],
        ),
      ),
    );
  }
}
