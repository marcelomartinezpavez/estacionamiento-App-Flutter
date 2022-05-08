import 'package:estacionamiento/src/pages/configuration_page.dart';
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
          builder: (context) => ConfigurationPage(),
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
        body: Column(
          children: [
            Placeholder(
              fallbackHeight: 400,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Card(child: Text('Ingresar veíhiculo')),
                Card(child: Text('Sacar veíhiculo')),
              ],
            )
          ],
        ));
  }
}
