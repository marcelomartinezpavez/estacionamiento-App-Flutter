import 'package:estacionamiento/src/pages/salir.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../services/api_service.dart';

class EstacionadosHoy extends StatefulWidget {
  const EstacionadosHoy({Key? key}) : super(key: key);

  @override
  State<EstacionadosHoy> createState() => _EstacionadosHoyState();
}

class _EstacionadosHoyState extends State<EstacionadosHoy> {
  Api_Service api = Api_Service();
  var _data;

  void getData() async {
    _data = await api.getEstacionadoHoy();
    _data = _data.reversed.toList();

    setState(() {
      _data = _data;
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: _data != null
          ? _buildDetail()
          : const Center(child: CircularProgressIndicator.adaptive()),
    );
  }

  Widget _buildDetail() {
    return _data.length == 0
        ? const Text('No se han encontrado datos')
        : ListView.builder(
            itemCount: _data.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => _data[index]['estado'].toString() == '1'
                    ? null
                    : Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) =>
                              SalirPage(patente: _data[index]['patente']),
                          fullscreenDialog: true,
                        )).then((value) => {
                          getData(),
                        }),
                child: Card(
                  child: ListTile(
                    title: Text('${_data[index]['patente']}'),
                    subtitle: _data[index]['valorTotal'] != 0
                        ? Text('${_data[index]['valorTotal']}')
                        : const Text('...'),
                    trailing: '${_data[index]['estado']}' == '1'
                        ? Text('Pagado',
                            style: TextStyle(
                              color: Colors.green[300],
                            ))
                        : Text('Estacionado',
                            style: TextStyle(color: Colors.red[300])),
                    leading: Text(DateFormat('dd/MM/yyyy HH:mm').format(
                        DateTime.parse('${_data[index]['fechaIngreso']}')
                            .subtract(const Duration(hours: 3)))),
                  ),
                ),
              );
            },
          );
  }
}
