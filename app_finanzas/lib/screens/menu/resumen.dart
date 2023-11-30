import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:app_finanzas/funciones/ClickContainer.dart';

class Resumen extends StatefulWidget {
  const Resumen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ResumenState createState() => _ResumenState();
}

class _ResumenState extends State<Resumen> {
  final user = FirebaseAuth.instance.currentUser!;

  List<String> categorias = [
    "Comida",
    "Transporte",
    "Entretenimiento",
    "Educación",
    "Hogar",
    "Otros"
  ];

  int totalGastos = 0;
  int totalIngresos = 0;
  String? _selectedCategoria;

  @override
  void initState() {
    getGastos();
    getingresos();
    super.initState();
  }

  Future getGastos() async {
    totalGastos = 0;
    // DateTime now = DateTime.now();
    // DateTime firstDayOfMonth = DateTime(now.year, now.month, 1);
    // DateTime lastDayOfMonth = DateTime(now.year, now.month + 1, 0);

    await FirebaseFirestore.instance
        .collection('gasto')
        .where('userId', isEqualTo: user.uid)
        //.where('fecha', isGreaterThanOrEqualTo: firstDayOfMonth)
        //.where('fecha', isLessThanOrEqualTo: lastDayOfMonth)
        .get()
        .then(
          // ignore: avoid_function_literals_in_foreach_calls
          (value) => value.docs.forEach(
            (element) {
              totalGastos += element.data()['cantidad'] as int;
            },
          ),
        );
    setState(() {});
  }

  Future getingresos() async {
    totalIngresos = 0;
    //DateTime now = DateTime.now();
    // DateTime firstDayOfMonth = DateTime(now.year, now.month, 1);
    // DateTime lastDayOfMonth = DateTime(now.year, now.month + 1, 0);

    await FirebaseFirestore.instance
        .collection('ingreso')
        .where('userId', isEqualTo: user.uid)
        //.where('fecha', isGreaterThanOrEqualTo: firstDayOfMonth)
        //.where('fecha', isLessThanOrEqualTo: lastDayOfMonth)
        .get()
        .then(
          // ignore: avoid_function_literals_in_foreach_calls
          (value) => value.docs.forEach(
            (element) {
              totalIngresos += element.data()['cantidad'] as int;
            },
          ),
        );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.10),
            Container(
              width: 350.0,
              height: 140.0,
              padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Balance General',
                    style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ), // Espaciado entre los textos
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        '\$${totalIngresos - totalGastos}',
                        style: const TextStyle(
                          fontSize: 45.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
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
                  margin: const EdgeInsets.all(16.0),
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
                        const SizedBox(height: 8.0),
                        const Text(
                          'Gastos',
                          style: TextStyle(
                              fontSize: 24.0, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '\$'  '$totalGastos',
                          style: const TextStyle(
                              fontSize: 40.0, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: 150.0,
                  height: 150.0,
                  margin: const EdgeInsets.all(16.0),
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
                        const SizedBox(height: 8.0),
                        const Text(
                          'Ingresos',
                          style: TextStyle(
                              fontSize: 24.0, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '\$'  '$totalIngresos',
                          style: const TextStyle(
                              fontSize: 40.0, fontWeight: FontWeight.bold),
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
      ),
    );
  }

  void _agregarGasto(BuildContext context) {
    TextEditingController nuevoGasto = TextEditingController();
    //TextEditingController categoria = TextEditingController();

    // ignore: non_constant_identifier_names
    Future AddGastoDetails(int cant, String categoria) async {
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
                controller: nuevoGasto,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  icon: Icon(Icons.monetization_on),
                  labelText: "Cantidad",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
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
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                AddGastoDetails(
                    int.parse(nuevoGasto.text.trim()), _selectedCategoria!);
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
    TextEditingController nuevoIngreso = TextEditingController();

    // ignore: non_constant_identifier_names
    Future AddIngresoDetails(int cant) async {
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
                controller: nuevoIngreso, // Usar el controlador
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
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                AddIngresoDetails(int.parse(nuevoIngreso.text.trim()));
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
