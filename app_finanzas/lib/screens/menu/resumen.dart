import 'package:app_finanzas/funciones/ClickContainer.dart';
import 'package:flutter/material.dart';

class resumen extends StatelessWidget {
  const resumen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 160.0,
            left: -250,
            right: 0,
            child: Center(
              child: Text(
                '-\$42',
                style: TextStyle(
                  fontSize: 54.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Positioned(
            top: 220.0,
            left: 20.0,
            child: Text(
              'Tus Gastos del mes',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: MediaQuery.of(context).size.height * 2 / 3,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 241, 241, 241),
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(30.0),
                ),
              ),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 30.0,
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
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 4),
                          child: Row(
                            children: [
                              Container(
                                width: 12.0,
                                height: 12.0,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color.fromARGB(255, 226, 33, 243),
                                ),
                              ),
                              const Text(
                                ' Este Mes',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(width: 44.0),
                              Container(
                                width: 12.0,
                                height: 12.0,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color.fromARGB(255, 84, 183, 201),
                                ),
                              ),
                              const Text(
                                'Promedio',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  /* Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: DropdownButton<String>(
                      items: <String>[
                        'Option 1',
                        'Option 2',
                        'Option 3',
                        'Option 4'
                      ].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        // Handle selection change here
                      },
                      hint: Text('Select an option'),
                    ),
                  ), */
                  const SizedBox(height: 160.0),
                  Container(
                    color: const Color.fromARGB(255, 56, 56, 56),
                    height: 1.0,
                    margin: const EdgeInsets.symmetric(horizontal: 16.0),
                  ),

                  InkWell(
                    child: buildClickableContainer(
                        icon: Icons.monetization_on_rounded,
                        texto: 'Agregar Nuevo Ingreso',
                        ),
                        onTap: () {
                          _agregarIngreso(context);                      },
                       ),
                  
                  InkWell(
                   child: buildClickableContainer(
                      icon: Icons.monetization_on_rounded,
                      texto: 'Agregar Nuevo Gasto',      
                      ),
                      onTap: () {
                          _agregarGasto(context);                      
                      },
                    ),
                  
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }


  void _agregarGasto(BuildContext context) {
    String nuevoDato = "";
    String categoria = "";
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
                onChanged: (value) {
                  nuevoDato = value;
                },
                decoration: InputDecoration(labelText: 'Cantidad'),
              ),
              TextField(
                onChanged: (value) {
                  categoria = value;
                },
                decoration: InputDecoration(labelText: 'Categoría'),
              ),
              /*TextButton(
                onPressed: () async {
                  fechaSeleccionada = await _mostrarDatePicker(context);
                },
                child: Text(
                  fechaSeleccionada != null
                      ? 'Fecha seleccionada: ${fechaSeleccionada.toLocal()}'
                      : 'Seleccionar Fecha',
                ),
              ),*/
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
                print('Nuevo dato: $nuevoDato');
                print('Categoría: $categoria');
                //if (fechaSeleccionada != null) {
                  //print('Fecha seleccionada: $fechaSeleccionada');
                //}
                Navigator.of(context).pop();
              },
              child: const Text('Agregar Nuevo Gasto'),
            ),
          ],
        );
      },
    );
  }

  /*Future<DateTime> _mostrarDatePicker(BuildContext context) async {
    DateTime fechaActual = DateTime.now();
    DateTime fechaSeleccionada = await showDatePicker(
      context: context,
      initialDate: fechaActual,
      firstDate: fechaActual.subtract(Duration(days: 365)), // Hace un año desde la fecha actual
      lastDate: fechaActual.add(Duration(days: 365)), // Hace un año desde la fecha actual
    );
    return fechaSeleccionada;
  }*/


  void _agregarIngreso(BuildContext context) {
    String nuevoDato = "";
    //String categoria = "";
    //DateTime fechaSeleccionada;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Agrega un nuevo ingreso:'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                onChanged: (value) {
                  nuevoDato = value;
                },
                decoration: const InputDecoration(labelText: 'Cantidad'),
              ),
              /*TextField(
                onChanged: (value) {
                  categoria = value;
                },
                decoration: InputDecoration(labelText: 'Categoría'),
              ),*/
              /*TextButton(
                onPressed: () async {
                  fechaSeleccionada = await _mostrarDatePicker(context);
                },
                child: Text(
                  fechaSeleccionada != null
                      ? 'Fecha seleccionada: ${fechaSeleccionada.toLocal()}'
                      : 'Seleccionar Fecha',
                ),
              ),*/
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
                print('Nuevo dato: $nuevoDato');
                //print('Categoría: $categoria');
                //if (fechaSeleccionada != null) {
                  //print('Fecha seleccionada: $fechaSeleccionada');
                //}
                Navigator.of(context).pop();
              },
              child: const Text('Agregar Nuevo Ingreso'),
            ),
          ],
        );
      },
    );
  }

  /*Future<DateTime> _mostrarDatePicker(BuildContext context) async {
    DateTime fechaActual = DateTime.now();
    DateTime fechaSeleccionada = await showDatePicker(
      context: context,
      initialDate: fechaActual,
      firstDate: fechaActual.subtract(Duration(days: 365)), // Hace un año desde la fecha actual
      lastDate: fechaActual.add(Duration(days: 365)), // Hace un año desde la fecha actual
    );
    return fechaSeleccionada;
  }*/

}//final
