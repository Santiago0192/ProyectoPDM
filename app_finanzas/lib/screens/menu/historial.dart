import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:app_finanzas/models/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:fl_chart/fl_chart.dart';

double maxGasto = 0;
int numRegistros = 0;

class historial extends StatefulWidget {
  const historial({super.key});
  @override
  State<historial> createState() => _historialState();
}

// ignore: camel_case_types
class _historialState extends State<historial> {
  @override
  List historial = [];
  List direcciones = [];

  final user = FirebaseAuth.instance.currentUser!;

  @override
  void initState() {
    super.initState();
    maxGasto = 0;
    getData();
  }

  Future getData() async {
    await FirebaseFirestore.instance
        .collection('gasto')
        .where('userId', isEqualTo: user.uid)
        .get()
        .then(
          (value) => value.docs.forEach(
            (element) {
              historial.add(element.data());
              direcciones.add(element.reference.id);
            },
          ),
        );

    numRegistros = historial.length;

    for (int i = 0; i < historial.length; i++) {
      double currentGasto = historial[i]['cantidad'].toDouble();

      if (currentGasto > maxGasto) {
        maxGasto = currentGasto;
      }
    }

    print(historial.length);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: (HistorialList(historial: historial, direcciones: direcciones)));
  }
}

class HistorialList extends StatefulWidget {
  const HistorialList(
      {super.key, required this.historial, required this.direcciones});

  final List historial;
  final List direcciones;

  @override
  State<HistorialList> createState() => _HistorialListState();
}

class _HistorialListState extends State<HistorialList> {
  final TextEditingController textController = TextEditingController();
  Future updateData(String id, int monto) async {
    await FirebaseFirestore.instance
        .collection('gasto')
        .doc(id)
        .update({'cantidad': monto});
  }

  void boxMonto(String id) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('Ingrese cantidad a cambiar:'),
              content: TextField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  icon: Icon(Icons.monetization_on),
                  labelText: "Cantidad",
                  border: OutlineInputBorder(),
                ),
                controller: textController,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
              ),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      updateData(id, int.parse(textController.text));
                      Navigator.pop(context);
                    },
                    child: const Text('Cambiar'))
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      Positioned(
        bottom: 450,
        top: 60,
        left: 0,
        right: 20,
        child: Container(
          width: MediaQuery.of(context).size.width / 3,
          height: MediaQuery.of(context).size.height,
          child: LineChart(
            LineChartData(
              lineBarsData: [
                LineChartBarData(
                  spots: [
                    for (int i = 0; i < widget.historial.length; i++)
                      FlSpot(
                        (i).toDouble(),
                        widget.historial[i]['cantidad'].toDouble(),
                      ),
                  ],
                  //isCurved: true,
                  dotData: FlDotData(show: true),
                  color: Colors.black,
                  barWidth: 3,
                ),
              ],
              minX: 0,
              maxX: numRegistros.toDouble() - 1,
              minY: 0,
              maxY: maxGasto,
              backgroundColor: Colors.white,
              titlesData: FlTitlesData(
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                /*leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        //getTitlesWidget: leftTitleWidgets,
                        interval: 1,
                        reservedSize: 36,
                      ),
                    ),*/
                topTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                rightTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
              ),
            ),
          ),
        ),
      ),
      Positioned(
        bottom: 0,
        left: 0,
        right: 0,
        child: Container(
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 241, 241, 241),
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20.0),
            ),
          ),
          height: MediaQuery.of(context).size.height * 1 / 2,
          width: MediaQuery.of(context).size.width,
          child: ListView.separated(
              separatorBuilder: (context, index) {
                return const Divider();
              },
              itemCount: widget.historial.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: TextButton(
                    child: const Icon(Icons.edit),
                    onPressed: () {
                      boxMonto(widget.direcciones[index]);
                    },
                  ),
                  title: Text(widget.historial[index]['categoria'],
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold)),
                  subtitle: Text(widget.historial[index]['fecha']
                      .toDate()
                      .toString()
                      .substring(0, 10)),
                  trailing: Text(
                      '-\$' + widget.historial[index]['cantidad'].toString(),
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold)),
                );
              }),
        ),
      ),
    ]));
  }
}
