import 'package:estacionamiento/src/model/login_model.dart';
import 'package:estacionamiento/src/routes/routes.dart';
import 'package:estacionamiento/src/services/auth_service.dart';
import 'package:flutter/material.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({Key? key}) : super(key: key);

  @override
  _LogInPagePageState createState() => _LogInPagePageState();
}

class _LogInPagePageState extends State<LogInPage> {
  final GlobalKey<FormState> logInKey = GlobalKey<FormState>();

  LogIn logIn = LogIn(username: '', password: '');

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Card(
            elevation: 12,
            child: Container(
              width: size.width * 0.85,
              padding: const EdgeInsets.symmetric(vertical: 30.0),
              margin: const EdgeInsets.symmetric(vertical: 15.0),
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
                          _renderInputUsername(),
                          const SizedBox(
                            height: 10.0,
                          ),
                          _renderInputPassword(),
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

  Widget _renderInputUsername() {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: TextFormField(
          initialValue: logIn.username,
          decoration: const InputDecoration(
              icon: Icon(
                Icons.person,
                color: Colors.greenAccent,
              ),
              labelText: 'Nombre de usuario'),
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

  Widget _renderInputPassword() {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
            if (value!.length <= 4) {
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
      stream: null,
    );
  }

  void _userLogIn(context) {
    Auth_Service authService = Auth_Service();

    if (logInKey.currentState!.validate()) {
      logInKey.currentState!.save();
      authService.logIn(logIn).then((value) {
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
