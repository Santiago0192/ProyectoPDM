import 'package:flutter/material.dart';
import 'package:app_finanzas/funciones/ClickContainer.dart';

class Resumen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.10),
          // Encabezado
          Container(
            padding: EdgeInsets.symmetric(vertical: 20.0),
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
                  '\$42.00', // Puedes actualizar esta cantidad
                  style: TextStyle(
                    fontSize: 36.0,
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
              _buildCategoryContainer(
                icon: Icons.monetization_on_rounded,
                texto: 'Gastos',
                cantidad: '\$30.00', // Puedes actualizar esta cantidad
              ),
              _buildCategoryContainer(
                icon: Icons.monetization_on_rounded,
                texto: 'Ingresos',
                cantidad: '\$72.00', // Puedes actualizar esta cantidad
              ),
            ],
          ),
          // InkWell para Gastos e Ingresos
          InkWell(
            child: buildClickableContainer(
                icon: Icons.monetization_on_rounded,
                texto: 'Agregar Nuevo Ingreso',
                ),
                onTap: () {
                  _agregarIngreso(context);                      
                  },
                ),

          InkWell(
            child: buildClickableContainer(
              icon: Icons.monetization_on_rounded,
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

  Widget _buildCategoryContainer({
    required IconData icon,
    required String texto,
    required String cantidad,
  }) {
    return Container(
      width: 150.0,
      height: 150.0,
      margin: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
          ),
        ],
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 36.0,
            ),
            SizedBox(height: 8.0),
            Text(
              texto,
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              cantidad,
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

   void _agregarGasto(BuildContext context) {
        TextEditingController _nuevoGasto = TextEditingController();
        TextEditingController _categoria = TextEditingController();


    //String categoria = "";
    //DateTime fechaSeleccionada;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Agrega un nuevo gasto:'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              
              TextField(
                  controller: _nuevoGasto, // Usar el controlador
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
              TextField(
                  controller: _categoria, // Usar el controlador
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.category),
                    labelText: "Categoria",
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
                Navigator.of(context).pop();
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
                Navigator.of(context).pop();
              },
              child: const Text('Agregar Nuevo Ingreso'),
            ),
          ],
        );
      },
    );
  }

}
