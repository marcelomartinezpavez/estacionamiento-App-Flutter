import 'package:estacionamiento/src/services/auth_service.dart';
import 'package:flutter/material.dart';

import 'routes/routes.dart' as route;

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

Widget somethingWentWrong(context) {
  final GlobalKey<_AppState> somethingWentWrongKey = GlobalKey<_AppState>();

  return MaterialApp(
    key: somethingWentWrongKey,
    debugShowCheckedModeBanner: false,
    builder: (context, child) => const Center(child: Text('Algo salió mal')),
    theme: ThemeData(primaryColor: Colors.red),
  );
}

// TODO: Sacar lógica del login con localStorage
Widget loading(context) {
  final GlobalKey<_AppState> loadingKey = GlobalKey<_AppState>();

  return MaterialApp(
    key: loadingKey,
    debugShowCheckedModeBanner: false,
    builder: (context, child) => Container(
        color: Colors.blue,
        child: const Scaffold(
          body: Center(
              child: Text(
            'Cargando',
          )),
        )),
  );
}

class _AppState extends State<MyApp> {
  final Auth_Service _auth = Auth_Service();

  // Set default `_initialized` and `_error` state to false
  bool _initialized = false;
  bool _error = false;
  bool _autenticated = false;

  // Define an async function to initialize FlutterFire
  void initializeAPP() async {
    try {
      _autenticated = false;

      setState(() {
        _initialized = true;
      });
    } catch (e) {
      print('Error: $e');
      setState(() {
        _error = true;
      });
    }
  }

  @override
  void initState() {
    initializeAPP();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // new RefreshIndicator(key: new GlobalKey<RefreshIndicatorState>(), child: null,;

    // Show error message if initialization failed
    if (_error) {
      return somethingWentWrong(context);
    }
    // Show a loader until FlutterFire is initialized
    if (!_initialized) {
      print('Cargando...');
      return loading(context);
    }

    final GlobalKey<_AppState> homeAux = GlobalKey<_AppState>();

    if (_initialized) {
      return MaterialApp(
        key: homeAux,
        debugShowCheckedModeBanner: false,
        onGenerateRoute: route.controller,
        // initialRoute: route.authPage,
        // routes: getApplicationRoutes(),
        initialRoute: _autenticated ? route.homePage : route.authPage,
        // onUnknownRoute: (RouteSettings settings) => MaterialPageRoute(
        //     builder: (context) => somethingWentWrong(context)),

        // initialRoute: _autenticated ? 'justification' : 'justification',
        // home: HomePage(), //this is the calling screen
        // onGenerateRoute: (RouteSettings settings) =>
        // MaterialPageRoute(builder: (BuildContext context) => HomePage()),
        theme: ThemeData(
            primaryColor: Colors.orange,
            buttonTheme: const ButtonThemeData(
                buttonColor: Colors.orange, textTheme: ButtonTextTheme.primary),
            useMaterial3: true,
            appBarTheme: const AppBarTheme(color: Colors.blue)),
        themeMode: ThemeMode.system,
      );
    }
    return somethingWentWrong(context);
  }
}
