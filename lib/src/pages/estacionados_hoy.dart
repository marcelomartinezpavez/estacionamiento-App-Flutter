import 'package:estacionamiento/src/model/parked.dart';
import 'package:estacionamiento/src/pages/salir.dart';
import 'package:flutter/material.dart';

import '../services/api_service.dart';

class EstacionadosHoy extends StatefulWidget {
  const EstacionadosHoy({Key? key}) : super(key: key);

  @override
  State<EstacionadosHoy> createState() => _EstacionadosHoyState();
}

class _EstacionadosHoyState extends State<EstacionadosHoy> {
  Api_Service api = Api_Service();
  List<Parked> _data = [];
  bool loading = true;

  void getData() async {
    _data = await api.getEstacionadoHoy();
    if (_data.isNotEmpty) _data = _data.toList();

    if (_data.isEmpty) _data = [];
    setState(() {
      print('dataaaaaa $_data');
      _data = _data;
      loading = false;
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
        child: Column(
          children: [
            _data.isNotEmpty
                ? Card(
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          title: Text(
                              'Total recaudado: \$ ${_data.map((e) => e.valorTotal).reduce((value, element) => value + element)}',
                              style: const TextStyle(fontSize: 20)),
                          subtitle: Text('Total estacionados: ${_data.length}',
                              style: const TextStyle(fontSize: 20)),
                        )))
                : Container(),
            !loading
                ? Expanded(child: _buildDetail())
                : const Center(
                    child: CircularProgressIndicator.adaptive(),
                  ),
          ],
        ));
  }

  Widget _buildDetail() {
    return _data.isEmpty
        ? const Text('No se han encontrado datos')
        : ListView.builder(
            itemCount: _data.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  // Mostrar una alerta al hacer longpress
                  onLongPress: () {
                    showAdaptiveDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Opciones'),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Patente: ${_data[index].patente}'),
                                    IconButton(
                                        onPressed: () =>
                                            Navigator.of(context).pop(false),
                                        icon: const Icon(Icons.close)),
                                  ],
                                ),
                                const Text('Fecha de ingreso: '),
                                Text(_data[index].fechaIngresoFormatted()),
                                _data[index].estado == Estado.pagado
                                    ? const Text('Fecha de salida: ')
                                    : Container(),
                                _data[index].estado == Estado.pagado
                                    ? Text(_data[index].fechaSalidaFormatted())
                                    : Container(),
                                _data[index].estado == Estado.pagado
                                    ? Text(
                                        'Valor total: \$ ${_data[index].valorTotal}')
                                    : Container(),
                                _data[index].estado == Estado.pagado
                                    ? Text(
                                        'Tipo pago: ${_data[index].tipoPago.name}')
                                    : Container(),
                              ],
                            ),
                            actions: <Widget>[
                              _data[index].estado == Estado.estacionado
                                  ? TextButton(
                                      onPressed: () => {
                                        Navigator.of(context).pop(false),
                                        // Mostrar una alerta para confirmar la acción de eliminar
                                        showAdaptiveDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: const Text('Eliminar'),
                                                content: Text(
                                                    '¿Desea eliminar el registro de ${_data[index].patente}?'),
                                                actions: <Widget>[
                                                  TextButton(
                                                    onPressed: () => {
                                                      Navigator.of(context)
                                                          .pop(false),
                                                    },
                                                    child:
                                                        const Text('Cancelar'),
                                                  ),
                                                  TextButton(
                                                    onPressed: () => {
                                                      api
                                                          .deleteEstacionado(
                                                              _data[index]
                                                                  .patente)
                                                          .then((value) => {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop(true),
                                                                getData(),
                                                              }),
                                                    },
                                                    child:
                                                        const Text('Eliminar'),
                                                  ),
                                                ],
                                              );
                                            })
                                      },
                                      child: const Text('Eliminar'),
                                    )
                                  : Container(),
                              _data[index].estado == Estado.estacionado
                                  ? TextButton(
                                      onPressed: () => {
                                        Navigator.of(context).pop(false),
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute<void>(
                                              builder: (BuildContext context) =>
                                                  SalirPage(
                                                      patente:
                                                          _data[index].patente),
                                              fullscreenDialog: true,
                                            )).then((value) => {
                                              getData(),
                                            })
                                      },
                                      child: const Text('Ir a pagar'),
                                    )
                                  : Container(),
                            ],
                          );
                        });
                  },

                  onTap: () => _data[index].estado == Estado.estacionado
                      ? Navigator.push(
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) =>
                                SalirPage(patente: _data[index].patente),
                            fullscreenDialog: true,
                          )).then((value) => {
                            getData(),
                          })
                      : null,
                  title: Text(_data[index].patente),
                  subtitle: _data[index].estado == Estado.pagado
                      ? Text(
                          '\$ ${_data[index].valorTotal} con ${_data[index].getTipoPago().toLowerCase()}')
                      : const Text('...'),
                  trailing: _data[index].buildEstado(),
                  leading: Text(_data[index].fechaIngresoFormatted()),
                ),
              );
            },
          );
  }
}
