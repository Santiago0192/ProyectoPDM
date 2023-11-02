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
            Column(
              children: [
                Row(
                  children: [
                    InkWell(
                      child: _myCard(Icons.food_bank, "Comida", 500),
                      onTap: () {
                        //Navigator.push(context, MaterialPageRoute(builder: (context) => const Receta1(),));
                      },
                    ),

                    InkWell(
                      child: _myCard(Icons.car_rental, "Transporte", 500),
                      onTap: () {
                        //Navigator.push(context, MaterialPageRoute(builder: (context) => const Receta1(),));
                      },
                    ),

                  ],
                ),


                //*****
                Row(
                  children: [
                    InkWell(
                      child: _myCard(Icons.party_mode, "Fiesta", 500),
                      onTap: () {
                        //Navigator.push(context, MaterialPageRoute(builder: (context) => const Receta1(),));
                      },
                    ),

                    InkWell(
                      child: _myCard(Icons.movie, "Entretenimiento", 500),
                      onTap: () {
                        //Navigator.push(context, MaterialPageRoute(builder: (context) => const Receta1(),));
                      },
                    ),

                  ],
                ),

                Row(
                  children: [
                    InkWell(
                      child: _myCard(Icons.school, "Educación", 500),
                      onTap: () {
                        //Navigator.push(context, MaterialPageRoute(builder: (context) => const Receta1(),));
                      },
                    ),

                    InkWell(
                      child: _myCard(Icons.home, "Hogar", 500),
                      onTap: () {
                        //Navigator.push(context, MaterialPageRoute(builder: (context) => const Receta1(),));
                      },
                    ),

                  ],
                ),

                Row(
                  children: [
                    InkWell(
                      child: _myCard(Icons.school, "Educación", 500),
                      onTap: () {
                        //Navigator.push(context, MaterialPageRoute(builder: (context) => const Receta1(),));
                      },
                    ),

                    InkWell(
                      child: _myCard(Icons.home, "Hogar", 500),
                      onTap: () {
                        //Navigator.push(context, MaterialPageRoute(builder: (context) => const Receta1(),));
                      },
                    ),

                  ],
                )
              ],
            )
            
          ],
        )
    );
  }

  Widget _myCard(IconData _iconCategoria, String _nombreCategoria, int _monto,){

  return Container(
        width: 200,  // Ancho de la tarjeta
        height: 250, // Alto de la tarjeta
        child: Card(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(_iconCategoria, size: 50.0, color: Colors.purple),
              Text('$_nombreCategoria', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,),),
              Text('\$ $_monto'),

            ],
          ),
        ),
   );

}
}