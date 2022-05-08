import 'package:estacionamiento/src/model/login_model.dart';
import 'package:estacionamiento/src/routes/routes.dart';
import 'package:estacionamiento/src/services/auth_service.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LogInPage extends StatefulWidget {
  @override
  _LogInPagePageState createState() => _LogInPagePageState();
}

class _LogInPagePageState extends State<LogInPage> {
  final GlobalKey<FormState> logInKey = new GlobalKey<FormState>();

  LogIn logIn = LogIn(username: 'admin', password: '123456');

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
                        _rednerInputUsername(),
                        const SizedBox(
                          height: 10.0,
                        ),
                        _rednerInputPassword(),
                        const SizedBox(
                          height: 20.0,
                        ),
                        _renderButtonLogIn(),
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

  Widget _rednerInputUsername() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: TextFormField(
          initialValue: logIn.username,
          decoration: const InputDecoration(
              icon: Icon(
                Icons.person,
                color: Colors.greenAccent,
              ),
              hintText: 'ejemplo@correo.cl',
              labelText: 'Correo'),
          keyboardType: TextInputType.text,
          textCapitalization: TextCapitalization.sentences,
          validator: (value) {
            if (value != null) {
              return null;
            } else {
              return 'Campo obligatorio';
            }
          },
          onSaved: (value) => logIn.username = value!,
          enableSuggestions: true,
          autovalidateMode: AutovalidateMode.onUserInteraction,
        ));
  }

  Widget _rednerInputPassword() {
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

  Widget _renderButtonLogIn() {
    return StreamBuilder(
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return ElevatedButton(
            onPressed: () {
              if (!logInKey.currentState!.validate()) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Hay campos que no son validos')));
              } else {
                _userLogIn(context);
              }
            },
            child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 80.0, vertical: 20.0),
                child: const Text('Iniciar Sesión')));
      },
    );
  }

  void _userLogIn(context) {
    Auth_Service auth_service = Auth_Service();

    if (logInKey.currentState!.validate()) {
      logInKey.currentState!.save();
      auth_service.logIn(logIn).then((value) {
        print(value);
        goHome(context);
      }).catchError((err) {
        print(err);
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(err)));
      });
    } else {
      print('No es valido, nunca debería ver esto');
    }
  }
}
