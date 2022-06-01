import 'dart:convert';

import 'package:estacionamiento/src/pages/estacionados.dart';
import 'package:estacionamiento/src/pages/ingresar.dart';
import 'package:estacionamiento/src/pages/salir.dart';
import 'package:estacionamiento/src/services/api_service.dart';
import 'package:estacionamiento/src/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  _HomeLayoutState createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  final Auth_Service _auth = Auth_Service();
  final Api_Service _api = Api_Service();

  String _disponibles = '';
  String _ocupados = '';
  String _valorMinuto = '';

  @override
  void initState() {
    super.initState();
    getConfig();

  }

  // ejecutar una funcion cada vez que se carga la pagina

  Future<void> getConfig() async {
    var userHasConfig = await _api.userHasConfig();

    setState(() {
      _ocupados = (jsonDecode(userHasConfig)['estacionamiento']['cantidadOcupado']).toString();
      _disponibles = (jsonDecode(userHasConfig)['estacionamiento']['cantidadLibre']).toString();
      _valorMinuto = (jsonDecode(userHasConfig)['valorMinuto']).toString();

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Estacionamiento'), actions: [
          Tooltip(
            message: 'Cerrar sesión',
            child: IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                _auth.signOut(context);
              },
            ),
          )
        ]),
        body: SingleChildScrollView(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: GestureDetector(
                      child: Card(
                        color: Colors.lightBlue.shade100,
                        child: Column(
                          //mainAxisAlignment: MainAxisAlignment.center,
                          //crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                    margin:  EdgeInsets.all(10),
                                    width: 80,
                                    height: 80,
                                    //alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: Colors.lightBlue.shade100,
                                      borderRadius: BorderRadius.circular(40),
                                    ),
                                    child:  Icon(Icons.info_outline,
                                        size: 40, color: Colors.black)),
                              ],
                            ),
                            Row(
                              //mainAxisAlignment: MainAxisAlignment.center,
                              //crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                                Container(
                                  //padding: const EdgeInsets.all(10),
                                  padding: EdgeInsets.only(left: 8.0, right: 8.0),

                                  //alignment: Alignment.center,

                                  child: FittedBox(
                                    //alignment: Alignment.center,
                                    fit: BoxFit.scaleDown,
                                    child: Text('$_ocupados \tEstacionamientos ocupados\v\n$_disponibles Estacionamientos disponibles\v\nValor por minuto $_valorMinuto \v\n',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                            fontSize: 18)),

                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),

                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) => const Ingresar(),
                            fullscreenDialog: true,
                          )).then((value) => getConfig()),
                      child: Card(
                        color: Colors.green.shade100,
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                    margin: const EdgeInsets.all(10),
                                    width: 80,
                                    height: 80,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(40),
                                    ),
                                    child: const Icon(Icons.input,
                                        size: 40, color: Colors.green)),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  child: const FittedBox(
                                    alignment: Alignment.centerLeft,
                                    fit: BoxFit.scaleDown,
                                    child: Text('Ingresar vehículo',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.green,
                                            fontSize: 18)),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) => SalirPage(),
                            fullscreenDialog: true,
                          )).then((value) => getConfig()),
                      child: Card(
                        color: Colors.orange.shade100,
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                    margin: const EdgeInsets.all(10),
                                    width: 80,
                                    height: 80,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(40),
                                    ),
                                    child: const Icon(Icons.output,
                                        size: 40, color: Colors.orange)),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  child: const FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text('Sacar vehículo',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.orange,
                                            fontSize: 18)),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) => EstacionadosPage(),
                            fullscreenDialog: true,
                          )).then((value) => getConfig()),

                      child: Card(
                        color: Colors.yellowAccent.shade100,
                        child: Column(
                          //mainAxisAlignment: MainAxisAlignment.center,
                          //crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                    margin:  EdgeInsets.all(10),
                                    width: 80,
                                    height: 80,
                                    //alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(40),
                                    ),
                                    child:  Icon(Icons.directions_car,
                                        size: 40, color: Colors.black)),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  child: const FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text('Historial estacionados',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.orange,
                                            fontSize: 18)),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),

                ],
              ),

            ],
          ),
        ));
  }
}
