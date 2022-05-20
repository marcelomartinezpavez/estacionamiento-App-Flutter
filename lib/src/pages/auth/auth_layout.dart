import 'package:flutter/material.dart';

import 'login_page.dart';

class AuthLayout extends StatelessWidget {
  const AuthLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Estacionamiento')),
        body: Center(
          child: LogInPage(),
        ));
  }
}
