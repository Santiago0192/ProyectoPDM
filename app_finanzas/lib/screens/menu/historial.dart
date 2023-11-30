import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:app_finanzas/models/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:fl_chart/fl_chart.dart';

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
        bottom: 400,
        top: 60,
        left: 0,
        right: 0,
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
                  isCurved: true,
                  dotData: FlDotData(show: true),
                  color: Colors.black,
                  barWidth: 5,
                ),
              ],
              minX: 0,
              maxX: 12,
              minY: 0,
              maxY: 500,
              backgroundColor: Colors.white,
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
                          fontWeight: FontWeight.bold, fontSize: 20)),
                  subtitle: Text(widget.historial[index]['fecha']
                      .toDate()
                      .toString()
                      .substring(0, 10)),
                  trailing: Text(
                      '-\$' + widget.historial[index]['cantidad'].toString(),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16)),
                );
              }),
        ),
      ),
    ]));
  }
}
