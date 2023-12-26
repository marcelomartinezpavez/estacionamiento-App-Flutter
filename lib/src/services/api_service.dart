import 'dart:convert';

import 'package:estacionamiento/src/services/auth_service.dart';
import 'package:http/http.dart' as http;

import '../model/parked.dart';

class Api_Service {
  String _disponibles = '';

  final _url = 'http://45.236.128.8:8080/';
  // final _url = 'http://localhost:8080/';
  final Auth_Service _auth = Auth_Service();
  var _estacionamientoId = '';

  Future<String> userHasConfig() async {
    var response = await http.get(Uri.parse(_url +
        'configuracion/exist/' +
        this._auth.getActualUser()['empresa']['id'].toString()));
    print(response);

    _estacionamientoId =
        (jsonDecode(response.body)['estacionamientoId']).toString();
    _disponibles = (jsonDecode(response.body)['estacionamiento']
            ['cantidadOcupado'])
        .toString();

    //FIXME: Retornar la respuesta del servicio
    //return true;
    return response.body;
  }

  Future<String> toPayVehicle(String patente, TipoPago tipoPago) async {
    await this.userHasConfig();

    print("_estacionamientoId: " + _estacionamientoId);
    final response = await http.post(
      Uri.parse('${_url}estacionamiento/insert/pago'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'patente': patente,
        'tipoPago': tipoPago.index.toString(),
        'estacionamiento_id': _estacionamientoId
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['valorTotal'].toString();
    } else {
      return response.body;
    }
  }

  Future<String> insertVehicle(String patente) async {
    await userHasConfig();
    print('_estacionamientoId ==>: ' + _estacionamientoId);

    final response = await http.post(
      Uri.parse('${_url}estacionamiento/insert/estacionado'),
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

  Future<List<Parked>> getEstacionadoHoy() async {
    await userHasConfig();
    print('ESTACIONADO _estacionamientoId ==>: ' + _estacionamientoId);

    final response = await http.get(
      Uri.parse('${_url}estacionado/idEstacionamiento/' + _estacionamientoId),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    print(response.body);
    if (response.statusCode == 200) {
      return Parked.fromJsonList(jsonDecode(response.body));
      // return jsonDecode(response.body);
    } else {
      return (jsonDecode(response.body));
    }
  }

  Future<List<Parked>> getEstacionadoTotal() async {
    await userHasConfig();
    print('ESTACIONADO _estacionamientoId ==>: ' + _estacionamientoId);

    final response = await http.get(
      Uri.parse('${_url}estacionado/idEstacionamiento/' +
          _estacionamientoId +
          '/all'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    print(response.body);
    if (response.statusCode == 200) {
      return Parked.fromJsonList(jsonDecode(response.body));
    } else {
      return (jsonDecode(response.body));
    }
  }

  Future deleteEstacionado(String patente) async {
    await userHasConfig();
    print('ESTACIONADO _estacionamientoId ==>: ' + _estacionamientoId);

    final response = await http.post(
      Uri.parse(_url + 'estacionamiento/insert/sin/pago'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'patente': patente,
        'estacionamiento_id': _estacionamientoId
      }),
    );

    if (response.statusCode == 200) {
      print('exluido');
      return 'Vehiculo excluido';
    } else {
      print('asdffdsasadffdsa');
      print(response);
      print(response.body);
      return (response.body);
    }
  }
}
