import 'package:estacionamiento/src/app.dart';
import 'package:flutter/material.dart';
//import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  runApp(const MyApp());
}

/*

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Estacionamiento',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Estacionamiento'),
    );
  }
}


class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text('Menu'),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            title: Text('Login'),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => AuthLayout()));
            },
          ),
          ListTile(
            title: Text('Entrar estacionamiento'),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) =>
                      MyHomePage(title: 'Estacionamiento')));
            },
          ),
          ListTile(
            title: Text('Salir estacionamiento'),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) =>
                      SalirPage(title: 'Salir')));
            },
          ),
        ],
      ),
    );
  }
}

class _MyHomePageState extends State<MyHomePage> {
  bool isLoggedIn = false;

  void autoLogIn() async {
    //final SharedPreferences prefs = await SharedPreferences.getInstance();
    //final String? userId = prefs.getString('username');
    //final String? idEmpresa = prefs.getString('idEmpresa');
    //final String? nameEmpresa = prefs.getString('nameEmpresa');
    //if (userId != null) {
    setState(() {
      isLoggedIn = true;
      //name = userId;
    });
    return;
    //}
  }

  Future<Null> logout() async {
    //final SharedPreferences prefs = await SharedPreferences.getInstance();
    //prefs.setString('username', '');
    //prefs.setString('idEmpresa', '');
    //prefs.setString('nameEmpresa', '');

    setState(() {
      //name = '';
      isLoggedIn = false;
    });
  }

  @override
  void initState() {
    super.initState();
    autoLogIn();
  }

  String _data = '';
  String _patente = '';

  Future<dynamic> _insertVehicle() async {
    final response = await http.post(
      Uri.parse('http://204.48.31.201:8080/estacionamiento/insert/estacionado'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
          <String, String>{'patente': _patente, 'estacionamiento_id': '3'}),
    );

    if (response.statusCode == 200) {
      _data = 'Vehiculo estacionado!';
      setState(() {
        _data = 'Vehiculo estacionado!';
      });
    } else {
      print(response.body);
      print(response.statusCode);

      _data = response.body;
      setState(() {
        _data = response.body;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),

      appBar: AppBar(
        title: Text(widget.title),
      ),

      body: Center(
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
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Patente',
              ),
            ),
            ElevatedButton(
              onPressed: _insertVehicle,
              child: Text('Ingresar'),
            ),
            Text(
              '$_data',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
*/
