import 'package:flutter/material.dart';

class historial extends StatefulWidget {
  const historial({super.key});

  @override
  State<historial> createState() => _historialState();
}

class _historialState extends State<historial> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        /*width: 200,  // Ancho de la tarjeta
        height: 100,
        child: Row(
            //mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Card(
                elevation: 5.0, // Agregamos sombra al Card
                child: Column(
                  children: [
                    Text("13,000.00"),
                    Text("Ingresos")
                  ],
                )
              ),

              Card(
                elevation: 5.0, // Agregamos sombra al Card
                child: Column(
                  children: [
                    Text("3,000.00"),
                    Text("Gastos")
                  ],
                )
              )
                /*Card(
                elevation: 5.0, // Agregamos sombra al Card
                child: ListTile(
                  leading: Icon(Icons.circle, color: Colors.red),
                  title: Text("13,000.00",style: TextStyle(fontSize: 20.0),),
                  subtitle: Text("Gastos"),
                  ),
                  
                ),*/
            ]
          ),*/
      )
    );
  }
}