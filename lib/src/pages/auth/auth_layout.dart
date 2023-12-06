import 'package:estacionamiento/src/pages/auth/login_page.dart';
import 'package:flutter/material.dart';

class AuthLayout extends StatefulWidget {
  const AuthLayout({Key? key}) : super(key: key);

  @override
  State<AuthLayout> createState() => _AuthLayoutState();
}

class _AuthLayoutState extends State<AuthLayout> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Estacionamiento")),
      body: const Center(child: LogInPage()),

      // bottomNavigationBar: NavigationBar(
      //   onDestinationSelected: (int index) {
      //     setState(() {
      //       currentPageIndex = index;
      //     });
      //   },
      //   selectedIndex: currentPageIndex,
      //   destinations: const <Widget>[
      //     NavigationDestination(
      //       icon: Icon(Icons.explore),
      //       label: 'Iniciar sesión',
      //     ),
      //     NavigationDestination(
      //       icon: Icon(Icons.commute),
      //       label: 'Registrarse',
      //     ),
      //   ],
      // ),
      // body: <Widget>[
      //   const Center(child: LogInPage()),
      //   Center(child: SignUpPage())
      // ][currentPageIndex],
    );
  }
}
