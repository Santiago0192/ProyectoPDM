//import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:app_finanzas/funciones/ClickContainer.dart';

class Resumen extends StatefulWidget {
  @override
  _ResumenState createState() => _ResumenState();
}

class _ResumenState extends State<Resumen> {
  final user = FirebaseAuth.instance.currentUser!;

  List<String> categorias = ["Comida", "Transporte", "Entretenimiento","Educacion","Hogar","Otros"];

  int totalGastos = 0;
  int totalIngresos = 0;
  String? _selectedCategoria;

  @override
  void initState(){
    getGastos();
    getingresos();
    super.initState();
  }

  Future getGastos() async {

    totalGastos = 0;
    DateTime now = DateTime.now();
    DateTime firstDayOfMonth = DateTime(now.year, now.month, 1);
    DateTime lastDayOfMonth = DateTime(now.year, now.month + 1, 0);

    await FirebaseFirestore.instance.collection('gasto').where('userId', isEqualTo: user.uid).where('fecha', isGreaterThanOrEqualTo: firstDayOfMonth).where('fecha', isLessThanOrEqualTo: lastDayOfMonth).get().then(
      (value) => value.docs.forEach(
        (element) {
          //print(element.reference);
          //print(user.uid);
          //docIDs.add(element.reference.id);
          totalGastos += element.data()!['cantidad'] as int;
        },
      ),
    );
    setState(() {});
  }

  Future getingresos() async {

    totalIngresos = 0;
    DateTime now = DateTime.now();
    DateTime firstDayOfMonth = DateTime(now.year, now.month, 1);
    DateTime lastDayOfMonth = DateTime(now.year, now.month + 1, 0);

    await FirebaseFirestore.instance.collection('ingreso').where('userId', isEqualTo: user.uid).where('fecha', isGreaterThanOrEqualTo: firstDayOfMonth).where('fecha', isLessThanOrEqualTo: lastDayOfMonth).get().then(
      (value) => value.docs.forEach(
        (element) {
          totalIngresos += element.data()!['cantidad'] as int;
        },
      ),
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.10),
          Container(
            width: 350.0,
            height: 140.0,
            padding: EdgeInsets.symmetric(vertical: 20.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                ),
              ],
            ),
            child: Column(
              children: [
                Text(
                  'Balance General',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${totalIngresos - totalGastos}',
                  style: TextStyle(
                  fontSize: 56.0,
                  fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          
          // Gastos e Ingresos
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                width: 150.0,
                height: 150.0,
                margin: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 8.0),
                      Text(
                        'Gastos',
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      Text(
                        '$totalGastos',
                        style: TextStyle(
                          fontSize: 48.0,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: 150.0,
                height: 150.0,
                margin: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 8.0),
                      Text(
                        'Ingresos',
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      Text(
                        '$totalIngresos',
                        style: TextStyle(
                          fontSize: 48.0,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // InkWell para Gastos e Ingresos
          InkWell(
            child: buildClickableContainer(
                icon: Icons.add_circle,
                texto: 'Ingresos',
                ),
                onTap: () {
                  _agregarIngreso(context);
                  },
                ),

          InkWell(
            child: buildClickableContainer(
              icon: Icons.remove_circle,
              texto: 'Gastos',
            ),
            onTap: () {
              _agregarGasto(context);
            },
          ),
        ],
      ),
    );
  }

  void _agregarGasto(BuildContext context) {
    TextEditingController _nuevoGasto = TextEditingController();
    TextEditingController _categoria = TextEditingController();
    
    Future AddGastoDetails(int cant, String categoria) async{
      await FirebaseFirestore.instance.collection('gasto').add({
        'cantidad': cant,
        'categoria': categoria,
        'userId': user.uid,
        'fecha': FieldValue.serverTimestamp()
      });
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Agrega un nuevo gasto:'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              
              TextField(
                  controller: _nuevoGasto,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.monetization_on),
                    labelText: "Cantidad",
                    border: OutlineInputBorder(),
                  ),
              ),
              SizedBox(
                height: 20,
              ),
              DropdownButtonFormField<String>(
                value: _selectedCategoria,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedCategoria = newValue;
                  });
                },
                decoration: const InputDecoration(
                  icon: Icon(Icons.category),
                  labelText: "Categoria",
                  border: OutlineInputBorder(),
                ),
                items: categorias.map((String categoria) {
                  return DropdownMenuItem<String>(
                    value: categoria,
                    child: Text(categoria),
                  );
                }).toList(),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                AddGastoDetails(int.parse(_nuevoGasto.text.trim()),_selectedCategoria!);
                Navigator.of(context).pop();
                getGastos(); 
              },
              child: const Text('Agregar Nuevo Gasto'),
              
            ),
          ],
        );
      },
    );
  }

  void _agregarIngreso(BuildContext context) {
  TextEditingController _nuevoIngreso = TextEditingController();

    Future AddIngresoDetails(int cant) async{
      await FirebaseFirestore.instance.collection('ingreso').add({
        'cantidad': cant,
        'userId': user.uid,
        'fecha': FieldValue.serverTimestamp()
      });
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Agrega un nuevo ingreso:'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                  controller: _nuevoIngreso, // Usar el controlador
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.monetization_on),
                    labelText: "Cantidad",
                    border: OutlineInputBorder(),
                  ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                AddIngresoDetails(int.parse(_nuevoIngreso.text.trim()));
                Navigator.of(context).pop();
                getingresos(); 
              },
              child: const Text('Agregar Nuevo Ingreso'),
            ),
          ],
        );
      },
    );
  }

}
