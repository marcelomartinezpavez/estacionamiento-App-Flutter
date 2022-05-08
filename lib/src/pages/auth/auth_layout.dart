import 'package:flutter/material.dart';

import 'login_page.dart';

class AuthLayout extends StatelessWidget {
  const AuthLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Estacionamiento')),
        body: Center(child: LogInPage(),));

    // return DefaultTabController(
    //   length: 2,
    //   child: Scaffold(
    //     appBar: AppBar(
    //       bottom: const TabBar(
    //         tabs: [
    //
    //           Tab(
    //             icon: Icon(Icons.login),
    //             text: 'Iniciar sesión',
    //           ),
    //           Tab(icon: Icon(Icons.assignment), text: 'Crear cuenta'),
    //         ],
    //       ),
    //       title: const Text('PTU'),
    //     ),
    //     body: TabBarView(
    //       children: [
    //         LogInPage(),
    //         SignUpPage(),
    //       ],
    //     ),
    //   ),
    // );
  }
}
