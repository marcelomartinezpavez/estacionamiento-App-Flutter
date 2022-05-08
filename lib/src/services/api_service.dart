import 'dart:convert';

import 'package:estacionamiento/src/services/auth_service.dart';
import 'package:http/http.dart' as http;

class Api_Service {
  var _url = 'http://204.48.31.201:8080/';
  Auth_Service _auth = new Auth_Service();

  Future<bool> userHasConfig() async {
    print('El usuario acutal es -> ' + this._auth.getActualUser().toString());
    print('El id acutal es -> ' +
        this._auth.getActualUser()['empresa']['id'].toString());
    // /configuracion/exist/7
    var response = await http.get(Uri.parse(_url +
        'configuracion/exist/' +
        this._auth.getActualUser()['empresa']['id'].toString()));
    print('Llegamos a response -> ' + response.body.toString());
    //FIXME: Retornar la respuesta del servicio
    return true;
  }

  Future<List<dynamic>> getArrearsByStudent(studentId) async {
    List<dynamic> arrears = [];

    var response = await http.get(
      Uri.parse(_url + 'atrasosbyalumno/' + studentId.toString()),
    );

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);

      for (var arrear in jsonData) {
        arrears.add(arrear);
      }
    } else {}

    return arrears;
  }
}
