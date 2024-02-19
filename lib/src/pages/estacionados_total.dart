import 'package:estacionamiento/src/model/parked.dart';
import 'package:estacionamiento/src/pages/salir.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../services/api_service.dart';

class EstacionadosTotal extends StatefulWidget {
  const EstacionadosTotal({Key? key}) : super(key: key);

  @override
  State<EstacionadosTotal> createState() => _EstacionadosTotalState();
}

class _EstacionadosTotalState extends State<EstacionadosTotal> {
  Api_Service api = Api_Service();
  List<Parked> _data = [];
  bool loading = true;
  bool showReport = false;
  DateTime startDate = DateTime.now().subtract(const Duration(days: 30));
  DateTime endDate = DateTime.now();
  final myController = TextEditingController();

  // void getData() async {
  //   _data = await api.getEstacionadoTotal();
  //   if (_data.isNotEmpty) _data = _data.toList();
  //
  //   if (_data.isEmpty) _data = [];
  //   setState(() {
  //     print('dataaaaaa $_data');
  //     _data = _data;
  //     loading = false;
  //   });
  // }

  void getRangeData(DateTime start, DateTime end) async {
    setState(() {
      loading = true;
      startDate = start;
      endDate = end;
    });
    print('start $startDate');
    print('end $endDate');
    _data = await api.getEstacionadoPorFechas(startDate, endDate);
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
    getRangeData(startDate, endDate);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            //Un TextField para filtrar por patente en la lista
            Focus(
                onKey: (node, event) {
                  if (event.logicalKey == LogicalKeyboardKey.backspace) {
                    print('backspace');
                    getRangeData(startDate, endDate);
                    myController.clear();

                    return KeyEventResult.handled;
                  }
                  return KeyEventResult.ignored;
                },
                child: TextFormField(
                  controller: myController,
                  onChanged: (text) {
                    setState(() {
                      _data = _data
                          .where((element) => element.patente
                              .toLowerCase()
                              .contains(text.toLowerCase()))
                          .toList();
                    });
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Filtrar por patente',
                  ),
                )),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton(
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                    backgroundColor: Colors.blue,
                    onSurface: Colors.grey,
                  ),
                  onPressed: () async {
                    final dynamic picked = await showDateRangePicker(
                        context: context,
                        cancelText: 'Cancelar',
                        locale: const Locale('es', 'CL'),
                        confirmText: 'Confirmar',
                        fieldStartLabelText: 'Fecha de inicio',
                        fieldEndLabelText: 'Fecha de fin',
                        errorInvalidRangeText: 'Rango de fechas inválido',
                        errorFormatText: 'Formato de fecha inválido',
                        errorInvalidText: 'Fecha inválida',
                        fieldEndHintText: 'Fecha de fin',
                        fieldStartHintText: 'Fecha de inicio',
                        helpText: 'Seleccionar rango de fechas',
                        initialDateRange: DateTimeRange(
                          start: startDate,
                          end: endDate,
                        ),
                        firstDate: DateTime(2015),
                        lastDate: DateTime(2025));
                    if (picked != null) {
                      print('picked $picked');
                      getRangeData(picked.start, picked.end);
                    }
                  },
                  child: const Text('Seleccionar rango de fechas'),
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //   Mostrar dos cards indicando la fecha de inicio y fin del rango de fechas
                Expanded(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          const Text('Fecha de inicio'),
                          // formatear la fecha a dd-MM-yyyy
                          Text(DateFormat('dd-MM-yyyy').format(startDate)),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          const Text('Fecha de fin'),
                          Text(DateFormat('dd-MM-yyyy').format(endDate)),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            _data.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ExpansionPanelList(
                        expansionCallback: (int index, bool isExpanded) {
                          setState(() {
                            showReport = isExpanded;
                          });
                        },
                        children: [
                          ExpansionPanel(
                              headerBuilder:
                                  (BuildContext context, bool isExpanded) {
                                return const ListTile(
                                  title: Text('Reportes'),
                                );
                              },
                              body: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Card(
                                      color: Colors.green.shade50,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Row(
                                              children: [
                                                Icon(Icons.analytics_outlined),
                                                Text('Total recaudado:',
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold))
                                              ],
                                            ),
                                            Text(
                                                'Suma total: \$' +
                                                    _data
                                                        .map(
                                                            (e) => e.valorTotal)
                                                        .reduce(
                                                            (value, element) =>
                                                                value + element)
                                                        .toString(),
                                                style: const TextStyle(
                                                    fontSize: 15)),
                                            Text(
                                                'Conteo: ' +
                                                    _data
                                                        .where((e) =>
                                                            e.estado !=
                                                            Estado.cancelado)
                                                        .length
                                                        .toString(),
                                                style: const TextStyle(
                                                    fontSize: 10)),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: Card(
                                            color: Colors.blue.shade50,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const Row(
                                                      children: [
                                                        Icon(Icons
                                                            .credit_card_outlined),
                                                        Text('Total tarjeta:',
                                                            style: TextStyle(
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                      ],
                                                    ),
                                                    Text(
                                                        'Suma total: \$' +
                                                            _data
                                                                .map((e) => ((e.tipoPago !=
                                                                            TipoPago
                                                                                .efectivo) &&
                                                                        (e.estado !=
                                                                            Estado
                                                                                .cancelado))
                                                                    ? e
                                                                        .valorTotal
                                                                    : 0)
                                                                .reduce((value,
                                                                        element) =>
                                                                    value +
                                                                    element)
                                                                .toString(),
                                                        style: const TextStyle(
                                                            fontSize: 15)),
                                                    Text(
                                                        'Conteo: ' +
                                                            _data
                                                                .where((element) =>
                                                                    (element.tipoPago !=
                                                                        TipoPago
                                                                            .efectivo) &&
                                                                    (element.estado !=
                                                                        Estado
                                                                            .cancelado))
                                                                .length
                                                                .toString(),
                                                        style: const TextStyle(
                                                            fontSize: 10)),
                                                  ]),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Card(
                                            color: Colors.yellow.shade50,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Row(
                                                    children: [
                                                      Icon(
                                                          Icons.money_outlined),
                                                      Text('Total efectivo:',
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                    ],
                                                  ),
                                                  Text(
                                                      'Suma total: \$' +
                                                          _data
                                                              .map((e) => e.tipoPago ==
                                                                          TipoPago
                                                                              .efectivo &&
                                                                      (e.estado !=
                                                                          Estado
                                                                              .cancelado)
                                                                  ? e.valorTotal
                                                                  : 0)
                                                              .reduce((value,
                                                                      element) =>
                                                                  value +
                                                                  element)
                                                              .toString(),
                                                      style: const TextStyle(
                                                          fontSize: 15)),
                                                  Text(
                                                      'Conteo: ' +
                                                          _data
                                                              .where((element) =>
                                                                  element.tipoPago ==
                                                                      TipoPago
                                                                          .efectivo &&
                                                                  (element.estado !=
                                                                      Estado
                                                                          .cancelado))
                                                              .length
                                                              .toString(),
                                                      style: const TextStyle(
                                                          fontSize: 10)),
                                                ],
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              isExpanded: showReport)
                        ]),
                  )
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
                                    ? const Text('Tiempo: ')
                                    : Container(),
                                _data[index].estado == Estado.pagado
                                    ? Text(
                                        '${_data[index].minutosEstacionado.toString()} mínutos')
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
                                                                getRangeData(
                                                                    startDate,
                                                                    startDate),
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
                                              getRangeData(
                                                  startDate, startDate),
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
                            getRangeData(startDate, startDate),
                          })
                      : null,
                  title: Text(_data[index].patente,
                      style: const TextStyle(fontSize: 20)),
                  subtitle:
                      Text('Ingreso: ${_data[index].fechaIngresoFormatted()}'),
                  trailing: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      _data[index].buildEstado(),
                      _data[index].estado == Estado.pagado
                          ? Text(
                              '\$${_data[index].valorTotal}\n${_data[index].getTipoPago().toLowerCase()}')
                          : const Text(''),
                    ],
                  ),

                  visualDensity: VisualDensity.comfortable,
                ),
              );
            },
          );
  }
}
