import 'package:estacionamiento/src/model/signup_model.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  SignUp signup = SignUp(
      email: '',
      password: '',
      acceptTerms: 'tr',
      confirmPassword: '',
      name: '');

  final GlobalKey<FormState> signUpKey = GlobalKey<FormState>();
  final _password = TextEditingController();
  final _confirmPassword = TextEditingController();

  // final TextEditingController _password = TextEditingController();
  // final TextEditingController _confirmPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(15.0),
        child: Form(
            key: signUpKey,
            child: Column(
              children: <Widget>[
                _createName(),
                _createEmail(),
                // _createPassword(),
                // _createConfirmPassword(),
                // SizedBox(
                //   height: 20,
                // ),
                // // _createTermsLabel(context),
                // _createButtonSignIn()
              ],
            )),
      ),
    );
  }

  Widget _createName() {
    return TextFormField(
      initialValue: signup.name,
      decoration: const InputDecoration(
          icon: Icon(
            Icons.person,
            color: Colors.greenAccent,
          ),
          hintText: 'Nombre apellido',
          labelText: 'Nombre'),
      keyboardType: TextInputType.name,
      textCapitalization: TextCapitalization.sentences,
      maxLength: 15,
      validator: (value) {
        if (value!.length <= 2) {
          return 'Nombre de usuario muy corto';
        } else {
          return null;
        }
      },
      onSaved: (value) => signup.name = value!,
      enableSuggestions: true,
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }

  Widget _createEmail() {
    return TextFormField(
      initialValue: signup.email,
      decoration: const InputDecoration(
          icon: Icon(
            Icons.alternate_email,
            color: Colors.greenAccent,
          ),
          hintText: 'ejemplo@gmail.com',
          labelText: 'Correo'),
      validator: (value) {
        if (value!.length <= 5) {
          return 'Muy corto email';
        } else {
          RegExp regExp = RegExp(
              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
          if (regExp.hasMatch(value)) {
            return null;
          } else {
            return 'El email no es valido';
          }
        }
      },
      onSaved: (value) => signup.email = value!,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: TextInputType.emailAddress,
    );
  }

  Widget _createPassword() {
    return TextFormField(
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
      onSaved: (value) => signup.password = value!,
    );
  }

  Widget _createConfirmPassword() {
    return TextFormField(
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
        });
  }

  Widget _createButtonSignIn() {
    return Builder(
        builder: (context) => RaisedButton.icon(
            icon: const Icon(Icons.person_add_alt_1_sharp),
            label: const Text('Crear cuenta'),
            // TODO: Deshabilitar botón para una mejor ux
            onPressed: () {
              if (!signUpKey.currentState!.validate()) {
                Scaffold.of(context).showSnackBar(
                    SnackBar(content: Text('Hay campos que no son validos')));
              } else {
                // _createAccount(context);
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

  // void _createAccount(context) {
  //   if (signUpKey.currentState!.validate()) {
  //     signUpKey.currentState!.save();
  //
  //     AuthService.createAccount(signup).then((value) async {
  //       await FirestoreService.addUser(signup)
  //           .then((value) => print("User Added"))
  //           .catchError((error) => print("Failed to add user: $error"));
  //       await FirestoreService.saveIntent(signup)
  //           .then((value) => print("User Stolen"))
  //           .catchError((error) => print("Failed to stolen user: $error"));
  //
  //       navigateAndReplaceToAdmin(context);
  //     }).catchError((err) => {
  //           Scaffold.of(context).showSnackBar(SnackBar(
  //               content:
  //                   Text('Hubo un problema al crear la cuenta, reintente')))
  //         });
  //   } else {
  //     print('No es valido, nunca debería ver esto');
  //   }
  // }
}
