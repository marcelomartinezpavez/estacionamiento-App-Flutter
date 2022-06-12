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

  //String _patente = '';
  //int valorTotal = 0;

  var _data;

  Api_Service api = Api_Service();

  @override
  void initState() {
    getData();
    super.initState();
  }

  void getData() async {
    _data = await api.getEstacionado();
    setState(() {
      _data = _data;
    });
  }

  //var _estacionados = api.getEstacionado();
  //var response = Api_Service().getEstacionado();

  @override
  Widget build(BuildContext context) {
    //var response = api.getEstacionado().toString();

    return Scaffold(
      appBar: AppBar(
        title:
            const Text("Estacionados", style: TextStyle(color: Colors.yellow)),
        backgroundColor: Colors.orange.shade500,
      ),
      // drawer: NavDrawer(),
      //body: Center(child: Text("This is salir page")));
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: _data != null
            ? _buildDetail()
            : const Center(child: CircularProgressIndicator.adaptive()),
      ),
    );
  }

  Widget _buildDetail() {
    return ListView.builder(
      itemCount: _data.length,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            title: Text('${_data[index]['patente']}'),
            subtitle: Text('${_data[index]['valorTotal']}'),
            trailing: '${_data[index]['estado']}' == '1'
                ? Text('Pagado',
                    style: TextStyle(
                      color: Colors.green[300],
                    ))
                : Text('Estacionado', style: TextStyle(color: Colors.red[300])),
            leading: Text(DateFormat('dd/MM/yyyy HH:mm')
                .format(DateTime.parse('${_data[index]['fechaIngreso']}'))),
          ),
        );
      },
    );
    _data.forEach((element) {
      print('DATA: ' + element.toString());
    });
    return Text(
      _data[0]['id'].toString(),
      style: Theme.of(context).textTheme.headline4,
    );
  }
}
