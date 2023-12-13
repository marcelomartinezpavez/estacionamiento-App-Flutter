import 'package:estacionamiento/src/pages/estacionados_hoy.dart';
import 'package:estacionamiento/src/pages/estacionados_total.dart';
import 'package:flutter/material.dart';

class EstacionadosPage extends StatefulWidget {
  const EstacionadosPage({Key? key}) : super(key: key);

  @override
  State<EstacionadosPage> createState() => estacionados();
}

class estacionados extends State<EstacionadosPage>
    with SingleTickerProviderStateMixin {
  static const List<Tab> myTabs = <Tab>[
    Tab(
      icon: Icon(Icons.today_rounded),
      text: 'Hoy',
    ),
    Tab(
      icon: Icon(Icons.calendar_month_rounded),
      text: 'Total',
    ),
  ];
  static const String routeName = '/estacionados';

  late TabController _tabController;

  @override
  void initState() {
    _tabController =
        TabController(vsync: this, length: myTabs.length, initialIndex: 0);
    super.initState();
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
          bottom: TabBar(
            controller: _tabController,
            tabs: myTabs,
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: const <Widget>[
            Center(
              child: EstacionadosHoy(),
            ),
            Center(
              child: EstacionadosTotal(),
            ),
          ],
        ),
      ),
    );

    // return Scaffold(
    //   appBar: AppBar(
    //     title:
    //         const Text("Estacionados", style: TextStyle(color: Colors.yellow)),
    //     backgroundColor: Colors.orange.shade500,
    //   ),
    //   body: Padding(
    //     padding: const EdgeInsets.all(8.0),
    //     child: Column(
    //       children: [
    //         const Text('Vehículos Estacionados hoy',
    //             style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
    //         Container(
    //             child: _data != null
    //                 ? _buildDetail()
    //                 : const Center(
    //                     child: CircularProgressIndicator.adaptive())),
    //       ],
    //     ),
    //   ),
    // );
  }
}
