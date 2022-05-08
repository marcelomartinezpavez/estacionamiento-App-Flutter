import 'package:estacionamiento/src/routes/routes.dart';
import 'package:estacionamiento/src/services/auth_service.dart';
import 'package:flutter/material.dart';

class MyApp extends StatefulWidget {
  _AppState createState() => _AppState();
}

Widget SomethingWentWrong(context) {
  final GlobalKey<_AppState> somethingWentWrongKey = new GlobalKey<_AppState>();

  return MaterialApp(
    key: somethingWentWrongKey,
    debugShowCheckedModeBanner: false,
    builder: (context, child) => Container(
      child: Center(child: Text('Algo salió mal')),
    ),
    theme: ThemeData(primaryColor: Colors.red),
  );
}

Widget Loading(context) {
  final GlobalKey<_AppState> loadingKey = new GlobalKey<_AppState>();

  return MaterialApp(
    key: loadingKey,
    debugShowCheckedModeBanner: false,
    builder: (context, child) => Container(
        color: Colors.blue,
        child: Scaffold(
          body: Center(
              child: Text(
            'Cargando',
          )),
        )),
  );
}

class _AppState extends State<MyApp> {
  Auth_Service _auth = new Auth_Service();

  // Set default `_initialized` and `_error` state to false
  bool _initialized = false;
  bool _error = false;
  bool _autenticated = false;

  // Define an async function to initialize FlutterFire
  void initializeAPP() async {
    try {
      _autenticated = await _auth.loginFromLocalStorage(context);

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
      return SomethingWentWrong(context);
    }
    // Show a loader until FlutterFire is initialized
    if (!_initialized) {
      print('Loading...');
      return Loading(context);
    }

    final GlobalKey<_AppState> homeAux = new GlobalKey<_AppState>();

    if (_initialized) {
      return MaterialApp(
          key: homeAux,
          debugShowCheckedModeBanner: false,
          routes: getApplicationRoutes(),
          initialRoute: _autenticated ? '/' : 'auth',
          onUnknownRoute: (RouteSettings settings) => MaterialPageRoute(
              builder: (context) => SomethingWentWrong(context)),
          // initialRoute: _autenticated ? 'justification' : 'justification',
          // home: HomePage(), //this is the calling screen
          // onGenerateRoute: (RouteSettings settings) =>
          // MaterialPageRoute(builder: (BuildContext context) => HomePage()),
          theme: ThemeData(primaryColor: Colors.green));
    }
    return SomethingWentWrong(context);
  }
}
