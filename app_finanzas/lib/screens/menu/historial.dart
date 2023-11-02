import 'package:flutter/material.dart';
import 'package:app_finanzas/funciones/ClickContainer.dart';
//import '../../data/historial.json';
import 'dart:convert';
import 'package:app_finanzas/data/constrants.dart';

import 'package:provider/provider.dart';
import 'package:app_finanzas/models/theme.dart';

class historial extends StatefulWidget {
  const historial({super.key});
  @override
  State<historial> createState() => _historialState();
}

class _historialState extends State<historial> {
  @override
  List<dynamic> historial = [];
  

  void initState(){
    historial = jsonDecode(historial_transacciones);
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: (
        HistorialList(historial: historial)
      )
    );
  }
}

class HistorialList extends StatelessWidget{
  const HistorialList({super.key, required this.historial});

  final List historial;
  @override
  Widget build(BuildContext context){
    final themeModel = Provider.of<ThemeModel>(context);
    return Stack(
      children: [
Positioned(
            top: 140.0,
            left: -250,
            right: 0,
            child: Center(
              child: Column(
                children : [
                  Text(
                'Egresos',
                style: TextStyle(
                  fontSize: 36.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),

                
              ),
              Padding(
                padding: EdgeInsets.only(left: 70),
                child: Container(
                  height: 10,
                  width: 200,
                  color: themeModel.currentTheme.iconTheme.color,
                ),
              ),

              Padding(
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
                padding: EdgeInsets.only(left: 170),
                child: Container(
                  height: 10,
                  width: 300,
                  color: Color.fromARGB(255, 84, 183, 201),
                ),
              )
              ]
              )
            ),
          ),

        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            height: MediaQuery.of(context).size.height * 1 / 2,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 241, 241, 241),
              borderRadius: BorderRadius.vertical(
              top: Radius.circular(30.0),
              ),
            ),

            child: ListView.separated(
              itemCount: historial.length,
              separatorBuilder: (context, index){
              return const Divider();
              },

              itemBuilder: (context, index){
                return ListTile(
                leading: Text(
                  "       ${historial[index]['tipo']}",
                  style: TextStyle(
                    color: (historial[index]['tipo']) == "Gasto" ? themeModel.currentTheme.iconTheme.color : Color.fromARGB(255, 84, 183, 201),
                  )),
                title: Text('   ${historial[index]['tienda']}'),
                subtitle: Text('   ${historial[index]['fecha']} \n   ${historial[index]['argumento']}'),
                trailing: Text(
                  "\$${historial[index]['monto']}.00          ",
                  style: TextStyle(
                    color: (historial[index]['tipo']) == "Gasto" ? themeModel.currentTheme.iconTheme.color : Color.fromARGB(255, 84, 183, 201),
                  )),
                
               );
             }
            )
          )
        ),
      ]
    );
  }
}


        