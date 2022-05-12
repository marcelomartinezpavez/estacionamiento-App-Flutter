import 'package:estacionamiento/src/pages/configuration_page.dart';
import 'package:estacionamiento/src/pages/ingresar.dart';
import 'package:estacionamiento/src/pages/salir.dart';
import 'package:estacionamiento/src/services/api_service.dart';
import 'package:estacionamiento/src/services/auth_service.dart';
import 'package:flutter/material.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  _HomeLayoutState createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  Auth_Service _auth = new Auth_Service();
  Api_Service _api = new Api_Service();

  @override
  void initState() {
    super.initState();
    getConfig();
  }

  // ejecutar una funcion cada vez que se carga la pagina

  Future<void> getConfig() async {
    var userHasConfig = await this._api.userHasConfig();

    if (!userHasConfig) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ConfigurationPage(),
        ),
        // MaterialPageRoute<void>(
        //   builder: (BuildContext context) => ConfigurationPage(),
        //   fullscreenDialog: true,
        // ),
      ).then((value) => getConfig());
    } else {
      //  TODO: Validar la configuracion del usuario
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Estacionamiento'),
          actions: [
            ElevatedButton(
                onPressed: () {
                  _auth.signOut(context);
                },
                child: const Text('Cerrar sesión'))
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Placeholder(
                fallbackHeight: 100,
              ),
              const Center(
                  child: Text(
                      'Aqui en el placeholder van los cupos disponibles^')),
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
                          )),
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
                          )),
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
              )
            ],
          ),
        ));
  }
}
