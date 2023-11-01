import 'package:flutter/material.dart';

class categorias extends StatefulWidget {
  const categorias({super.key});

  @override
  State<categorias> createState() => _categoriasState();
}

class _categoriasState extends State<categorias> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: 
        ListView(
          children: [
            InkWell(
              child: _myCard("Pollo Frito", "20 min","Simple", "Expensive"),
              onTap: () {
                //Navigator.push(context, MaterialPageRoute(builder: (context) => const Receta1(),));
              },
            ),

            InkWell(
              child:  _myCard("Pechugas a la Plancha", "30 min","Dificil", "Afforable"),
              onTap: () {
                //Navigator.push(context, MaterialPageRoute(builder: (context) => const Receta2(),));
              },
            ),

            InkWell(
              child: _myCard("Taquitos", "20 min","Simple", "Expensive"),
              onTap: () {
                //Navigator.push(context, MaterialPageRoute(builder: (context) => const Receta3(),));
              },
            ),

            InkWell(
              child: _myCard("Hamburguesas", "30 min","Dificil", "Afforable"),
              onTap: () {
                //Navigator.push(context, MaterialPageRoute(builder: (context) => const Receta4(),));
              },
            ),

            InkWell(
              child: _myCard("Pizza", "40 min","Simple", "Expensive"),
              onTap: () {
                //avigator.push(context, MaterialPageRoute(builder: (context) => const Receta5(),));
              },
            ),
          ],
        )
    );
  }

  Widget _myCard(String _nomReceta,_duracion, _dificultad, _costo ){
  return Container(
        width: 150,  // Ancho de la tarjeta
        height: 150, // Alto de la tarjeta
        child: Card(
          child: Text('Contenido de la tarjeta'),
        ),
   );

}
}