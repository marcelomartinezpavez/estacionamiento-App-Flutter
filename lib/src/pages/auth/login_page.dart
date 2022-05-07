import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:estacionamiento/src/model/login_model.dart';
import 'package:estacionamiento/src/routes/routes.dart';

class LogInPage extends StatefulWidget {
  @override
  _LogInPagePageState createState() => _LogInPagePageState();
}

class _LogInPagePageState extends State<LogInPage> {
  final GlobalKey<FormState> logInKey = new GlobalKey<FormState>();

  LogIn logIn =
      LogIn(email: 'diegomartinezpavez@icloud.com', password: 'q1w2e3r4');

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            width: size.width * 0.85,
            padding: const EdgeInsets.symmetric(vertical: 30.0),
            margin: const EdgeInsets.symmetric(vertical: 15.0),

            decoration: BoxDecoration(
                color: Theme.of(context).backgroundColor,
                borderRadius: BorderRadius.circular(5.0),
                boxShadow: [
                  BoxShadow(
                      blurRadius: 3.0,
                      color: Theme.of(context).shadowColor,
                      offset: const Offset(0.0, 5.0),
                      spreadRadius: 3.0)
                ]),
            child: Column(
              children: [
                Form(
                    key: logInKey,
                    child: Column(
                      children: <Widget>[
                        const Text(
                          'Iniciar Sesión',
                          style: TextStyle(fontSize: 20.0),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        _crearEmail(),
                        const SizedBox(
                          height: 10.0,
                        ),
                        _crearPassword(),
                        const SizedBox(
                          height: 20.0,
                        ),
                        _crearBotonIniciarSesion(),
                        const SizedBox(
                          height: 20.0,
                        ),
                      ],
                    )),
              ],
            ),
          ),
          // RichText(
          //   text: TextSpan(
          //     children: <TextSpan>[
          //       TextSpan(
          //           text: '¿Olvidaste tu contraseña?',
          //           style: TextStyle(color: Colors.blue),
          //           recognizer: TapGestureRecognizer()
          //             ..onTap = () {
          //               print('Olvidaste tu contraseña');
          //             })
          //     ],
          //   ),
          // ),
          const SizedBox(
            height: 100.0,
          )
        ],
      ),
    );
  }

  Widget _crearEmail() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: TextFormField(
          initialValue: logIn.email,
          decoration: const InputDecoration(
              icon: Icon(
                Icons.alternate_email,
                color: Colors.greenAccent,
              ),
              hintText: 'ejemplo@correo.cl',
              labelText: 'Correo'),
          keyboardType: TextInputType.emailAddress,
          textCapitalization: TextCapitalization.sentences,
          validator: (value) {
            RegExp regExp = RegExp(
                r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
            if (regExp.hasMatch(value!)) {
              return null;
            } else {
              return 'El email no es valido';
            }
          },
          onSaved: (value) => logIn.email = value!,
          enableSuggestions: true,
          autovalidateMode: AutovalidateMode.onUserInteraction,
        ));
  }

  Widget _crearPassword() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: TextFormField(
          initialValue: logIn.password,
          decoration: const InputDecoration(
              icon: Icon(
                Icons.lock,
                color: Colors.greenAccent,
              ),
              hintText: '********',
              labelText: 'Contraseña'),
          obscureText: true,
          validator: (value) {
            if (value!.length <= 5) {
              return 'La contraseña debe ser mas larga';
            } else {
              return null;
            }
          },
          autovalidateMode: AutovalidateMode.onUserInteraction,
          onSaved: (value) => logIn.password = value!,
        ));
  }

  Widget _crearBotonIniciarSesion() {
    return StreamBuilder(
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return RaisedButton(
            onPressed: () {
              if (!logInKey.currentState!.validate()) {
                Scaffold.of(context).showSnackBar(
                    SnackBar(content: Text('Hay campos que no son validos')));
              } else {
                _userLogIn(context);
              }
            },
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 20.0),
                child: Text('Iniciar Sesión')));
      },
    );
  }

  void _userLogIn(context) {
    goHome(context);
    // if (logInKey.currentState!.validate()) {
    //   logInKey.currentState!.save();
    //   AuthService.logIn(logIn)
    //       .then((value) => navigateAndReplaceToAdmin(context))
    //       .catchError((err) => {
    //             //TODO: Aquí debe especificar el error
    //             Scaffold.of(context).showSnackBar(SnackBar(
    //                 content: Text('Hubo problemas para iniciar sesión')))
    //           });
    // } else {
    //   print('No es valido, nunca debería ver esto');
    // }
  }
}
