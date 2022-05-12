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

  Future<String> toPayVehicle(String patente) async {
    final response = await http.post(
      Uri.parse('http://204.48.31.201:8080/estacionamiento/insert/pago'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
          <String, String>{'patente': patente, 'estacionamiento_id': '3'}),
    );

    if (response.statusCode == 200) {
      print(response.body);
      print(response.statusCode);
      print(jsonDecode(response.body));
      print(jsonDecode(response.body)['valorTotal']);

      return jsonDecode(response.body)['valorTotal'].toString();
    } else {
      print(response.body);
      print(response.statusCode);
      return response.body;
    }
  }

  Future<String> insertVehicle(String patente) async {
    final response = await http.post(
      Uri.parse('http://204.48.31.201:8080/estacionamiento/insert/estacionado'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
          <String, String>{'patente': patente, 'estacionamiento_id': '3'}),
    );

    if (response.statusCode == 200) {
      return 'Vehiculo estacionado';
    } else {
      return (response.body);
    }
  }
}
