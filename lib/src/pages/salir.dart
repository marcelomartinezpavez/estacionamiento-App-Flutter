import 'package:estacionamiento/src/model/parked.dart';
import 'package:estacionamiento/src/services/api_service.dart';
import 'package:flutter/material.dart';

class SalirPage extends StatefulWidget {
  SalirPage({Key? key, this.patente}) : super(key: key);

  String? patente;

  @override
  State<SalirPage> createState() => Salir();
}

class Salir extends State<SalirPage> {
  final GlobalKey<FormState> salirFormKey = GlobalKey<FormState>();
  final myController = TextEditingController();

  static const String routeName = '/salir';
  String? _data;
  String _patente = '';
  TipoPago tipoPago = TipoPago.efectivo;
  int? valorTotal;
  late Parked parked;
  late List<String> actuallyParked;
  bool loading = false;
  Api_Service api = Api_Service();

  @override
  void initState() {
    setState(() {
      _patente = widget.patente ?? '';
      myController.value =
          myController.value.copyWith(text: _patente.toUpperCase());
    });
    getActuallyParked();
    super.initState();
  }

  getActuallyParked() async {
    print('ObtenerEstacionados');
    await api.getEstacionadoActualmente().then((value) {
      setState(() {
        var patentesList = value.map((e) => e.patente).toList();
        print('ObtenerEstacionados: ' + patentesList.toString());
        actuallyParked = patentesList;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pagar", style: TextStyle(color: Colors.orange)),
        backgroundColor: Colors.orange.shade100,
      ),
      // drawer: NavDrawer(),
      //body: Center(child: Text("This is salir page")));
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            const FittedBox(
              fit: BoxFit.contain,
              child: Text(
                "Ingrese patente del Vehiculo que sale",
                style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
              ),
            ),
            Form(
                key: salirFormKey,
                autovalidateMode: AutovalidateMode.always,
                child: Column(
                  children: [
                    // TextFormField(
                    //   textCapitalization: TextCapitalization.characters,
                    //   controller: myController,
                    //   onChanged: (text) {
                    //     setState(() {
                    //       _patente = text.toUpperCase();
                    //       myController.value = myController.value
                    //           .copyWith(text: _patente.toUpperCase());
                    //     });
                    //   },
                    //   validator: (value) {
                    //     if (value == null || value.length <= 4) {
                    //       return 'Por favor ingrese una patente';
                    //     }
                    //     RegExp r = RegExp(r"^[a-zA-Z0-9]*$");
                    //     if (!r.hasMatch(value)) {
                    //       return 'La patente no puede contener caracteres especiales';
                    //     }
                    //     return null;
                    //   },
                    //   decoration: const InputDecoration(
                    //     border: OutlineInputBorder(),
                    //     hintText: 'Patente',
                    //   ),
                    // ),

                    // RawAutocomplete<String>(
                    //   optionsBuilder: (TextEditingValue textEditingValue) {
                    //     if (textEditingValue.text == '') {
                    //       return const Iterable<String>.empty();
                    //     }
                    //     return actuallyParked.where((String option) {
                    //       return option
                    //           .contains(textEditingValue.text.toUpperCase());
                    //     });
                    //   },
                    //   focusNode: FocusNode(),
                    //   textEditingController: myController,
                    //   fieldViewBuilder: (BuildContext context,
                    //       TextEditingController fieldTextEditingController,
                    //       FocusNode fieldFocusNode,
                    //       VoidCallback onFieldSubmitted) {
                    //     return TextFormField(
                    //       controller: fieldTextEditingController,
                    //       textCapitalization: TextCapitalization.characters,
                    //       focusNode: fieldFocusNode,
                    //       onFieldSubmitted: (String value) {
                    //         onFieldSubmitted();
                    //       },
                    //       decoration: const InputDecoration(
                    //         border: OutlineInputBorder(),
                    //         hintText: 'Patente',
                    //       ),
                    //       onChanged: (text) {
                    //         setState(() {
                    //           _patente = text.toUpperCase();
                    //           fieldTextEditingController.value =
                    //               fieldTextEditingController.value
                    //                   .copyWith(text: _patente.toUpperCase());
                    //         });
                    //       },
                    //       validator: (value) {
                    //         if ((value == null || value.length <= 4) &&
                    //             value != '') {
                    //           return 'Por favor ingrese una patente valida';
                    //         }
                    //         RegExp r = RegExp(r"^[a-zA-Z0-9]*$");
                    //         if (!r.hasMatch(value!)) {
                    //           return 'La patente no puede contener caracteres especiales';
                    //         }
                    //         return null;
                    //       },
                    //     );
                    //   },
                    //   optionsViewBuilder: (BuildContext context,
                    //       AutocompleteOnSelected<String> onSelected,
                    //       Iterable<String> options) {
                    //     print('OPTIONS: ' + options.toString());
                    //     return ListView.builder(
                    //       padding: const EdgeInsets.all(8.0),
                    //       itemCount: options.length,
                    //       itemBuilder: (BuildContext context, int index) {
                    //         final String option = options.elementAt(index);
                    //         return GestureDetector(
                    //           onTap: () {
                    //             onSelected(option);
                    //           },
                    //           child: ListTile(
                    //             title: Text(option),
                    //           ),
                    //         );
                    //       },
                    //     );
                    //   },
                    //   onSelected: (String selection) {
                    //     _patente = selection.toUpperCase();
                    //     myController.value = myController.value
                    //         .copyWith(text: _patente.toUpperCase());
                    //   },
                    // ),

                    Autocomplete<String>(
                      initialValue: TextEditingValue(text: _patente ?? ''),
                      optionsBuilder: (TextEditingValue textEditingValue) {
                        if (textEditingValue.text == '') {
                          return const Iterable<String>.empty();
                        }
                        return actuallyParked.where((String option) {
                          return option
                              .contains(textEditingValue.text.toUpperCase());
                        });
                      },
                      fieldViewBuilder: (BuildContext context,
                          TextEditingController fieldTextEditingController,
                          FocusNode fieldFocusNode,
                          VoidCallback onFieldSubmitted) {
                        return TextFormField(
                          controller: fieldTextEditingController,
                          textCapitalization: TextCapitalization.characters,
                          focusNode: fieldFocusNode,
                          onFieldSubmitted: (String value) {
                            onFieldSubmitted();
                          },
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Patente',
                          ),
                          onChanged: (text) {
                            setState(() {
                              _patente = text.toUpperCase();
                              fieldTextEditingController.value =
                                  fieldTextEditingController.value
                                      .copyWith(text: _patente.toUpperCase());
                            });
                          },
                          validator: (value) {
                            if ((value == null || value.length <= 4) &&
                                value != '') {
                              return 'Por favor ingrese una patente valida';
                            }
                            RegExp r = RegExp(r"^[a-zA-Z0-9]*$");
                            if (!r.hasMatch(value!)) {
                              return 'La patente no puede contener caracteres especiales';
                            }
                            return null;
                          },
                        );
                      },
                      onSelected: (String selection) {
                        setState(() {
                          _patente = selection.toUpperCase();
                          myController.value = myController.value
                              .copyWith(text: _patente.toUpperCase());
                        });
                      },
                    ),
                  ],
                )),
            _data != null
                ? Column(
                    children: [
                      Text(
                        _data!,
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    ],
                  )
                : valorTotal != null
                    ? Column(
                        children: [
                          Text('\$ ' +
                              valorTotal!.toString().replaceAllMapped(
                                  RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                  (Match m) => '${m[1]},')),
                          Card(
                            child: ListTile(
                              title: Text(
                                  '${parked.minutosEstacionado} minutos',
                                  style: const TextStyle(fontSize: 20)),
                              subtitle: Text(
                                  'Ingreso: ${parked.fechaIngresoFormatted()}'),
                              trailing: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  parked.buildEstado(),
                                ],
                              ),
                              visualDensity: VisualDensity.comfortable,
                            ),
                          ),
                          const SizedBox(height: 10),
                          SegmentedButton<TipoPago>(
                            segments: const <ButtonSegment<TipoPago>>[
                              ButtonSegment<TipoPago>(
                                  value: TipoPago.efectivo,
                                  label: Text('Efectivo'),
                                  icon: Icon(Icons.calendar_view_day)),
                              ButtonSegment<TipoPago>(
                                  value: TipoPago.debito,
                                  label: Text('Debito'),
                                  icon: Icon(Icons.calendar_view_week)),
                              ButtonSegment<TipoPago>(
                                  value: TipoPago.credito,
                                  label: Text('Crédito'),
                                  icon: Icon(Icons.calendar_view_month)),
                            ],
                            selected: <TipoPago>{tipoPago},
                            onSelectionChanged: (Set<TipoPago> newSelection) {
                              setState(() {
                                tipoPago = newSelection.first;
                                parked.tipoPago = tipoPago;
                                print(parked.toJson());

                                api.updateVehicle(parked).then((value) {
                                  print('updateVehicle: ' + value.toString());
                                });
                              });
                            },
                          ),
                        ],
                      )
                    : const Text('Busca una patente para ver el monto'),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(
                    40), // fromHeight use double.infinity as width and 40 is the height
              ),
              onPressed: (_patente.length >= 5 && !loading)
                  ? () async {
                      setState(() {
                        _data = null;
                        valorTotal = null;
                        loading = true;
                      });

                      await api
                          .toPayVehicle(_patente, tipoPago)
                          .then((parkedResponse) {
                        print('reeesponse: ' + parkedResponse.toString());
                        setState(() {
                          _data = null;
                          loading = false;
                          valorTotal = parkedResponse.valorTotal;
                          parked = parkedResponse;
                        });
                      }).onError((error, stackTrace) {
                        print('error desde el catch: ' + error.toString());
                        setState(() {
                          valorTotal = null;
                          loading = false;
                          _data = error.toString();
                        });
                      });

                      await api.userHasConfig();
                    }
                  : null,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Sacar vehículo'),
                  if (loading) const CircularProgressIndicator.adaptive(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildText(String value) {
    switch (value) {
      case 'efectivo':
        return const Text('Efectivo');
      case 'credito':
        return const Text('Crédito');
      case 'debito':
        return const Text('Débito');
      default:
        return const Text('Efectivo');
    }
  }
}
