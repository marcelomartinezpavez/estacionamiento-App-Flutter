import 'package:estacionamiento/src/model/signup_model.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../services/auth_service.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<FormState> signUpKey = GlobalKey<FormState>();

  SignUp signup = SignUp(
    nombreEmpresa: '',
    pass: '',
    confirmPassword: '',
    users: '',
    direccionEmpresa: '',
    rutEmpresa: '',
  );

  final _password = TextEditingController();
  final _confirmPassword = TextEditingController();

  // final TextEditingController _password = TextEditingController();
  // final TextEditingController _confirmPassword = TextEditingController();

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
              child: Column(children: [
                Form(
                    key: signUpKey,
                    child: Column(
                      children: <Widget>[
                        const Text(
                          'Crear cuenta',
                          style: TextStyle(fontSize: 20.0),
                        ),
                        const SizedBox(
                          height: 5.0,
                        ),
                        _renderCreateName(),
                        const SizedBox(
                          height: 5.0,
                        ),
                        _renderCreateRut(),
                        const SizedBox(
                          height: 5.0,
                        ),
                        _renderCreateAddress(),
                        const SizedBox(
                          height: 5.0,
                        ),
                        _renderCreateUserName(),
                        const SizedBox(
                          height: 5.0,
                        ),
                        _createPassword(),
                        const SizedBox(
                          height: 5.0,
                        ),
                        _createConfirmPassword(),
                        const SizedBox(
                          height: 10,
                        ),
                        // _createTermsLabel(context),
                        _createButtonSignIn()
                      ],
                    )),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _renderCreateName() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        initialValue: signup.nombreEmpresa,
        decoration: const InputDecoration(
            icon: Icon(
              Icons.person,
              color: Colors.greenAccent,
            ),
            hintText: 'Nombre del estacionamiento',
            labelText: 'Nombre del estacionamiento'),
        keyboardType: TextInputType.name,
        textCapitalization: TextCapitalization.sentences,
        maxLength: 15,
        validator: (value) {
          if (value!.length <= 2) {
            return 'Nombre del estacionamiento muy corto';
          } else {
            return null;
          }
        },
        onSaved: (value) => signup.nombreEmpresa = value!,
        enableSuggestions: true,
        autovalidateMode: AutovalidateMode.onUserInteraction,
      ),
    );
  }

  Widget _renderCreateUserName() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        initialValue: signup.users,
        decoration: const InputDecoration(
            icon: Icon(
              Icons.person,
              color: Colors.greenAccent,
            ),
            hintText: 'Username',
            labelText: 'Username'),
        keyboardType: TextInputType.name,
        textCapitalization: TextCapitalization.sentences,
        maxLength: 15,
        validator: (value) {
          if (value!.length <= 2) {
            return 'Username muy corto';
          } else {
            return null;
          }
        },
        onSaved: (value) => signup.users = value!,
        enableSuggestions: true,
        autovalidateMode: AutovalidateMode.onUserInteraction,
      ),
    );
  }

  Widget _renderCreateAddress() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        initialValue: signup.direccionEmpresa,
        decoration: const InputDecoration(
            icon: Icon(
              Icons.person,
              color: Colors.greenAccent,
            ),
            hintText: 'Dirección del estacionamiento',
            labelText: 'Dirección'),
        keyboardType: TextInputType.name,
        textCapitalization: TextCapitalization.sentences,
        maxLength: 15,
        validator: (value) {
          if (value!.length <= 2) {
            return 'Direccion no valida';
          } else {
            return null;
          }
        },
        onSaved: (value) => signup.direccionEmpresa = value!,
        enableSuggestions: true,
        autovalidateMode: AutovalidateMode.onUserInteraction,
      ),
    );
  }

  Widget _renderCreateRut() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        initialValue: signup.rutEmpresa,
        decoration: const InputDecoration(
            icon: Icon(
              Icons.person,
              color: Colors.greenAccent,
            ),
            hintText: 'Rut del estacionamiento',
            labelText: 'Rut'),
        keyboardType: TextInputType.name,
        textCapitalization: TextCapitalization.sentences,
        maxLength: 15,
        validator: (value) {
          if (value!.length <= 6) {
            return 'Rut del estacionamiento muy corto';
          } else {
            return null;
          }
        },
        onSaved: (value) => signup.rutEmpresa = value!,
        enableSuggestions: true,
        autovalidateMode: AutovalidateMode.onUserInteraction,
      ),
    );
  }

  Widget _createPassword() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        // initialValue: signup.password,
        controller: _password,
        decoration: const InputDecoration(
            icon: Icon(
              Icons.lock,
              color: Colors.greenAccent,
            ),
            hintText: '********',
            labelText: 'Contraseña'),
        // decoration: const InputDecoration(labelText: 'Contraseña'),
        obscureText: true,
        validator: (value) {
          if (value!.length <= 5) {
            return 'La contraseña debe ser mas segura (min 6 caracteres)';
          } else {
            return null;
          }
        },
        autovalidateMode: AutovalidateMode.onUserInteraction,
        onSaved: (value) => signup.pass = value!,
      ),
    );
  }

  Widget _createConfirmPassword() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
          // initialValue: signup.confirmPassword,
          controller: _confirmPassword,
          decoration: const InputDecoration(
              icon: Icon(
                Icons.lock,
                color: Colors.greenAccent,
              ),
              hintText: '********',
              labelText: 'Confirmar ontraseña'),
          obscureText: true,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          onSaved: (value) => signup.confirmPassword = value!,
          validator: (val) {
            if (val != _password.text) return 'Las contraseñas no coinciden';
            return null;
          }),
    );
  }

  Widget _createButtonSignIn() {
    return Builder(
        builder: (context) => ElevatedButton(
            child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 80.0, vertical: 20.0),
                child: const Text('Crear cuenta')),
            // TODO: Deshabilitar botón para una mejor ux
            onPressed: () {
              if (!signUpKey.currentState!.validate()) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Hay campos que no son validos')));
              } else {
                _createAccount(context);
              }
            }));
  }

  Widget _createTermsLabel(context) {
    return RichText(
      text: TextSpan(
        children: <TextSpan>[
          const TextSpan(
              text: 'Al crear la cuenta aceptas los',
              style: TextStyle(color: Colors.black)),
          TextSpan(
              text: 'Términos y condiciones',
              style: const TextStyle(color: Colors.blue),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  // print('Registrate ahora');
                  // goTerms(context);
                })
        ],
      ),
    );
  }

  void _createAccount(context) {
    Auth_Service authService = Auth_Service();

    if (signUpKey.currentState!.validate()) {
      signUpKey.currentState!.save();
      authService.signUp(signup).then((value) {
        Navigator.pushReplacementNamed(context, '/login');

        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Usuario creado, inicia sesión para continuar'),
        ));
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
