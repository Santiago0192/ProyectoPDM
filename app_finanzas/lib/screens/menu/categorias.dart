import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class categorias extends StatefulWidget {
  const categorias({super.key});

  @override
  State<categorias> createState() => _categoriasState();
}

class _categoriasState extends State<categorias> {
  final user = FirebaseAuth.instance.currentUser!;

  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: [
        Column(
          children: [
            Row(
              children: [
                InkWell(
                  child: _myCard(Icons.food_bank, "Comida"),
                ),
                InkWell(
                  child: _myCard(Icons.car_rental, "Transporte"),
                ),
              ],
            ),
            Row(
              children: [
                InkWell(
                  child: _myCard(Icons.party_mode, "Otros"),
                ),
                InkWell(
                  child: _myCard(Icons.movie, "Entretenimiento"),
                ),
              ],
            ),
            Row(
              children: [
                InkWell(
                  child: _myCard(Icons.school, "Educación"),
                ),
                InkWell(
                  child: _myCard(Icons.home, "Hogar"),
                ),
              ],
            ),
          ],
        )
      ],
    ));
  }

  Widget _myCard(IconData _iconCategoria, String _nombreCategoria) {
    return Container(
      width: 200, // Ancho de la tarjeta
      height: 250, // Alto de la tarjeta
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              _iconCategoria,
              size: 50.0,
            ),
            Text(
              '$_nombreCategoria',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SumaCategoriaWidget(
              categoria: _nombreCategoria,
              userId: user.uid,
            ),
          ],
        ),
      ),
    );
  }
}

class SumaCategoriaWidget extends StatelessWidget {
  final String categoria;
  final String userId;

  SumaCategoriaWidget({required this.categoria, required this.userId});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<int>(
      future: _obtenerSumaCategoria(),
      builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Muestra un indicador de carga mientras se obtienen los datos
        } else if (snapshot.hasError) {
          return Text("Error: ${snapshot.error}");
        } else {
          int sumaCantidad =
              snapshot.data ?? 0; // Obtiene el resultado o usa 0 si es nulo
          return Text(
            '\$' + '$sumaCantidad',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          );
        }
      },
    );
  }

  Future<int> _obtenerSumaCategoria() async {
    int sumaCantidad = 0;
    await FirebaseFirestore.instance
        .collection('gasto')
        .where('userId', isEqualTo: userId)
        .where('categoria', isEqualTo: categoria)
        .get()
        .then((value) => value.docs.forEach((element) {
              sumaCantidad += element.data()!['cantidad'] as int;
            }));
    return sumaCantidad;
  }
}
