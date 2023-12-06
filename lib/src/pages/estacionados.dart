import 'package:estacionamiento/src/pages/salir.dart';
import 'package:estacionamiento/src/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // for date format

class EstacionadosPage extends StatefulWidget {
  const EstacionadosPage({Key? key}) : super(key: key);

  @override
  State<EstacionadosPage> createState() => estacionados();
}

class estacionados extends State<EstacionadosPage> {
  static const String routeName = '/estacionados';

  var _data;

  Api_Service api = Api_Service();

  @override
  void initState() {
    getData();
    super.initState();
  }

  void getData() async {
    _data = await api.getEstacionado();
    _data = _data.reversed.toList();

    setState(() {
      _data = _data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Estacionados'),
          backgroundColor: Colors.yellow.shade300,
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.today_rounded),
                text: 'Hoy',
              ),
              Tab(
                icon: Icon(Icons.calendar_month_rounded),
                text: 'Total',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    const Text('Vehículos Estacionados hoy',
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold)),
                    Container(
                        child: _data != null
                            ? _buildDetail()
                            : const Center(
                                child: CircularProgressIndicator.adaptive())),
                  ],
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    const Text('Vehículos Estacionados hoy',
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold)),
                    Container(
                        child: _data != null
                            ? _buildDetail()
                            : const Center(
                                child: CircularProgressIndicator.adaptive())),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title:
            const Text("Estacionados", style: TextStyle(color: Colors.yellow)),
        backgroundColor: Colors.orange.shade500,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Text('Vehículos Estacionados hoy',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
            Container(
                child: _data != null
                    ? _buildDetail()
                    : const Center(
                        child: CircularProgressIndicator.adaptive())),
          ],
        ),
      ),
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
