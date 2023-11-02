import 'package:app_finanzas/screens/menu/categorias.dart';
import 'package:app_finanzas/screens/menu/historial.dart';
import 'package:app_finanzas/screens/menu/resumen.dart';
import 'package:app_finanzas/screens/menu/usuario.dart';
import 'package:flutter/material.dart';

class MyPage extends StatefulWidget {
  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {


   int _selectedPage = 0;

  final List<Widget> _pages = [
    Resumen(),
    historial(),
    categorias(),
    Configuracion(),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: _pages[_selectedPage],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey, // Color de la sombra
              blurRadius: 10,    // Radio de difuminación
              spreadRadius: 1,   // Extensión de la sombra
              offset: Offset(0, 3), // Desplazamiento en x y y
            ),
          ],
        ),
        child:BottomNavigationBar(
        currentIndex: _selectedPage,
        onTap: (int index){
          setState(() {
            _selectedPage = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Resumen"),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: "Historial"),
          BottomNavigationBarItem(icon: Icon(Icons.category), label: "Categorias"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Perfil"),

        ],
        selectedItemColor: const Color.fromARGB(255, 219, 33, 243),
        unselectedItemColor: Colors.grey,

      ),
      ),
      );
  }
}