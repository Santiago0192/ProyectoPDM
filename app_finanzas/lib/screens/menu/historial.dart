import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
//import 'package:app_finanzas/funciones/ClickContainer.dart';
//import '../../data/historial.json';
//import 'dart:convert';
//import 'package:app_finanzas/data/constrants.dart';
//import 'package:provider/provider.dart';
import 'package:app_finanzas/models/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:firebase_core/firebase_core.dart';

class historial extends StatefulWidget {
  const historial({super.key});
  @override
  State<historial> createState() => _historialState();
}

// ignore: camel_case_types
class _historialState extends State<historial> {
  @override
  List historial = [];
  final user = FirebaseAuth.instance.currentUser!;

  @override
  void initState() {
    //historial = jsonDecode(historial_transacciones);
    //fin = FirestoreServices().getHist();
    //FirestoreServices().addHist();
    //historial = fin.data!.docs;
    super.initState();
    getData();
    //historial = FirestoreServices().temp;
  }

  Future getData() async {
    await FirebaseFirestore.instance
        .collection('gasto')
        .where('userId', isEqualTo: user.uid)
        .get()
        .then(
          (value) => value.docs.forEach(
            (element) {
              //print(element.reference);
              //print(element.data());
              //print('chacalito');
              historial.add(element.data());
              //docIDs.add(element.reference.id);
              //totalGastos += element.data()!['cantidad'] as int;
            },
          ),
        );
    print(historial.length);
    setState(() {});
    //return temp;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: (HistorialList(historial: historial)));
  }
}

class HistorialList extends StatelessWidget {
  const HistorialList({super.key, required this.historial});

  final List historial;

  @override
  Widget build(BuildContext context) {
    //final themeModel = Provider.of<ThemeModel>(context);
    return Scaffold(
        body: Stack(
            //color: Colors.white,
            children: [
          Positioned(
            top: 140.0,
            left: -250,
            right: 0,
            child: Center(
                child: Column(children: [
              const Text(
                'Egresos',
                style: TextStyle(
                  fontSize: 36.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 70),
                child: Container(
                    height: 10,
                    width: 200,
                    color: ThemeModel().currentTheme.iconTheme.color),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text(
                  'Ingresos',
                  style: TextStyle(
                    fontSize: 36.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 170),
                child: Container(
                  height: 10,
                  width: 300,
                  color: const Color.fromARGB(255, 84, 183, 201),
                ),
              )
            ])),
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
                  itemCount: historial.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(historial[index]['categoria']),
                      subtitle: Text(historial[index]['fecha']
                          .toDate()
                          .toString()
                          .substring(0, 10)),
                      trailing: Text(historial[index]['cantidad'].toString()),
                    );
                  }),
            ),
          ),
        ]));
  }
}

class FirestoreServices {
  final Query<Map<String, dynamic>> hist =
      FirebaseFirestore.instance.collection("gasto");
  final user = FirebaseAuth.instance.currentUser!;
  List<dynamic> temp = [];

  //
  //Get
  Stream<QuerySnapshot> getHist() {
    final temp = hist.orderBy('fecha', descending: true).snapshots();
    //getData();
    return temp;
  }

  List<dynamic> getAll() {
    getData();
    print(temp);
    return temp;
  }

  Future getData() async {
    await FirebaseFirestore.instance
        .collection('gasto')
        .where('userId', isEqualTo: user.uid)
        .orderBy('fecha', descending: true)
        .get()
        .then(
          (value) => value.docs.forEach(
            (element) {
              //print(element.reference);
              //print(element.data());
              //print('chacalito');
              temp.add(element.data());
              //docIDs.add(element.reference.id);
              //totalGastos += element.data()!['cantidad'] as int;
            },
          ),
        );

    print(temp.length);
    //return temp;
  }
}
