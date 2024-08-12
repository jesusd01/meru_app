import 'package:flutter/material.dart';
import 'package:meru_app/models/product.dart';

import 'package:meru_app/service/product.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Meru Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List<Product> _data = [];

  void initState() {
    getDataTable();
  }

  void getDataTable() async {
    final dataTable = await FetchTable().getProducts();
    setState(() {
      this._data = dataTable;
    });
  }

  List<DataColumn> _cols(BuildContext context) {
    final List<DataColumn> col = [
      DataColumn(
        label: Text('Nombre'),
      ),
      DataColumn(
        label: Text('Descripcíon'),
      ),
      DataColumn(
        label: Text('Precio'),
      ),
    ];
    return col;
  }

  List<DataRow> _rows(BuildContext context) {
    final List<DataRow> row = [];
    _data.forEach((item) {
      final widgetTemp = DataRow(cells: [
        DataCell(Text(item.name)),
        DataCell(Text(item.description)),
        DataCell(Text('${item.price}')),
      ]);
      row..add(widgetTemp);
      // ..add(Divider())
    });
    return row;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 16,
                      ),
                      Container(
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          // color: Color(0xFF2A2D3E),
                          color: Colors.white,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                                width: double.infinity,
                                child: Padding(
                                  padding: const EdgeInsets.all(4),
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.vertical,
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: DataTable(
                                        sortColumnIndex: 0,
                                        dataRowHeight: 90,
                                        sortAscending: true,
                                        columns: _cols(context),
                                        rows: _rows(context),
                                      ),
                                    ),
                                  ),
                                )),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
