import 'dart:convert';

import 'package:estacionamiento/src/services/auth_service.dart';
import 'package:http/http.dart' as http;

class Api_Service {
  String _disponibles = '';

  final _url = 'http://45.236.128.8:8080/';
  final Auth_Service _auth = new Auth_Service();
  var _estacionamientoId = '';

  Future<String> userHasConfig() async {
    //this.userHasConfig();

    print('El usuario acutal es -> ' + this._auth.getActualUser().toString());
    print('El id acutal es -> ' +
        this._auth.getActualUser()['empresa']['id'].toString());

    // /configuracion/exist/7
    var response = await http.get(Uri.parse(_url +
        'configuracion/exist/' +
        this._auth.getActualUser()['empresa']['id'].toString()));
    print(response);
    print('Llegamos a response -> ' + response.body.toString());
    //var body = json.decode(response.body);
    print('JSON -> ' + jsonDecode(response.body).toString());
    print('EST -> ' + jsonDecode(response.body)['estacionamiento'].toString());
    print('ESTACIONAMIENTO -> ' +
        (jsonDecode(response.body)['estacionamiento']['cantidadOcupado'])
            .toString());
    print('ESTACIONAMIENTOID -> ' +
        (jsonDecode(response.body)['estacionamientoId']).toString());

    _estacionamientoId =
        (jsonDecode(response.body)['estacionamientoId']).toString();
    _disponibles = (jsonDecode(response.body)['estacionamiento']
            ['cantidadOcupado'])
        .toString();

    //FIXME: Retornar la respuesta del servicio
    //return true;
    return response.body;
  }

  Future<String> toPayVehicle(String patente) async {
    await this.userHasConfig();

    print("_estacionamientoId: " + _estacionamientoId);
    final response = await http.post(
      Uri.parse('http://45.236.128.8:8080/estacionamiento/insert/pago'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'patente': patente,
        'estacionamiento_id': _estacionamientoId
      }),
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
    await userHasConfig();
    print('_estacionamientoId ==>: ' + _estacionamientoId);

    final response = await http.post(
      Uri.parse('http://45.236.128.8:8080/estacionamiento/insert/estacionado'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'patente': patente,
        'estacionamiento_id': _estacionamientoId
      }),
    );

    if (response.statusCode == 200) {
      return 'Vehiculo estacionado';
    } else {
      return (response.body);
    }
  }

  Future getEstacionado() async {
    await userHasConfig();
    print('ESTACIONADO _estacionamientoId ==>: ' + _estacionamientoId);

    final response = await http.get(
      Uri.parse('http://45.236.128.8:8080/estacionado/idEstacionamiento/' +
          _estacionamientoId),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    print(response.body);
    if (response.statusCode == 200) {
      print('ESTACIONADO response.body');
      print(response.body);
      return jsonDecode(response.body);
    } else {
      return (response.body);
    }
  }
}
