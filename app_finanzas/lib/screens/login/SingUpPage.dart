import 'package:app_finanzas/screens/login/SingInPage.dart';
import 'package:app_finanzas/screens/menu/menu.dart';
import 'package:app_finanzas/funciones/CustomTextField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';

//Permisos para JSON
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool _isChecked = false;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _name2Controller = TextEditingController();
  final TextEditingController _birthController = TextEditingController();
  final TextEditingController _ocupacionController = TextEditingController();
  final TextEditingController _ingresosController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _contraController = TextEditingController();
  final TextEditingController _contra2Controller = TextEditingController();

  // Función para guardar los datos en JSON
  Future<void> _saveFormData() async {
    //if (_formKey.currentState!.validate()) {
    //Datos del usuario
    final userData = {
      'nombre': _nameController.text,
      'apellido': _name2Controller.text,
      'fecha_nacimiento': _birthController.text,
      'ocupacion': _ocupacionController.text,
      'ingresos': _ingresosController.text,
      'correo': _emailController.text,
      'contrasena': _contraController.text,
      'contrasena2': _contra2Controller.text,
    };

    await saveDataToJSON(userData);

    // Mostrar una confirmación o realizar otras acciones después de guardar los datos
    //}
  }

  //Escritura de JSON
  Future<void> saveDataToJSON(Map<String, dynamic> data) async {
    // Obtener el directorio de documentos en el dispositivo
    final Directory directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/data.json');

    // Convertir los datos a una cadena JSON
    final jsonData = json.encode(data);

    // Escribir los datos en el archivo
    await file.writeAsString(jsonData);

    print('Datos guardados en el archivo JSON');
  }

  //Dialogo de permisos
  void _showPermissionDialog() {
    showPlatformDialog(
      context: context,
      builder: (context) => BasicDialogAlert(
        title: const Text("Permiso Requerido"),
        content: const Text(
            "Autorizar permiso para escribir en la memoria del dispositivo."),
        actions: <Widget>[
          BasicDialogAction(
            onPressed: () {
              Navigator.of(context).pop();
              //Agregar permiso necesario
            },
            title: const Text("Aceptar"),
          ),
          BasicDialogAction(
            onPressed: () {
              setState(() {
                _isChecked = false;
              });
              Navigator.of(context).pop();
            },
            title: const Text("Cancelar"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  margin: const EdgeInsets.all(16.0),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const Text(
                          'Sign Up',
                          style: TextStyle(
                            fontSize: 40.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        CustomTextField(
                          labelText: 'Nombre',
                          prefixIcon: Icons.person,
                          keyboardType: TextInputType.text,
                          controller: _nameController,
                        ),
                        const SizedBox(height: 16.0),
                        CustomTextField(
                          labelText: 'Apellido',
                          prefixIcon: Icons.person,
                          keyboardType: TextInputType.text,
                          controller: _name2Controller,
                        ),
                        const SizedBox(height: 16.0),
                        CustomTextField(
                          labelText: 'Fecha de Nacimiento',
                          prefixIcon: Icons.calendar_today,
                          keyboardType: TextInputType.text,
                          controller: _birthController,
                        ),
                        const SizedBox(height: 16.0),
                        CustomTextField(
                          labelText: 'Ocupación (Opcional)',
                          prefixIcon: Icons.work,
                          keyboardType: TextInputType.text,
                          controller: _ocupacionController,
                        ),
                        const SizedBox(height: 16.0),
                        CustomTextField(
                          labelText: 'Ingresos (Opcional)',
                          prefixIcon: Icons.attach_money,
                          keyboardType: TextInputType.number,
                          controller: _ingresosController,
                        ),
                        const SizedBox(height: 16.0),
                        CustomTextField(
                          labelText: 'Correo',
                          prefixIcon: Icons.email,
                          keyboardType: TextInputType.text, //emailAddress,
                          controller: _emailController,
                        ),
                        const SizedBox(height: 16.0),
                        CustomTextField(
                          labelText: 'Contraseña',
                          prefixIcon: Icons.lock,
                          keyboardType: TextInputType.text,
                          obscureText: true,
                          controller: _contraController,
                        ),
                        const SizedBox(height: 16.0),
                        CustomTextField(
                          labelText: 'Confirmar Contraseña',
                          prefixIcon: Icons.lock,
                          keyboardType: TextInputType.text,
                          obscureText: true,
                          controller: _contra2Controller,
                        ),
                        const SizedBox(height: 16.0),
                        ElevatedButton(
                          onPressed:
                              _saveFormData, // Llama a la función para guardar datos
                          child: const Text('Guardar'),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Checkbox(
                              value: _isChecked,
                              onChanged: (bool? value) {
                                setState(() {
                                  _isChecked = value ?? false;
                                  if (_isChecked) {
                                    _showPermissionDialog();
                                  }
                                });
                              },
                            ),
                            Text(
                              'Acepto los Términos y Condiciones',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 173, 116, 183)),
                            ),
                            SizedBox(width: 16.0),
                            _isChecked
                                ? Icon(
                                    Icons.check_circle,
                                    color: Colors.green,
                                    size: 24.0,
                                  )
                                : Container(),
                          ],
                        ),
                        SizedBox(height: 16.0),
                        ElevatedButton(
                          onPressed: () {
                            // Agregar aquí la lógica para iniciar sesión
                            // ...
                            // Después de que el usuario haya iniciado sesión, navegamos a la página de menú
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MyPage(),
                              ),
                            );
                          },
                          child: Icon(Icons.arrow_forward, color: Colors.white),
                          style: ElevatedButton.styleFrom(
                            shape: CircleBorder(),
                            padding: EdgeInsets.all(16.0),
                            primary: Color.fromARGB(255, 169, 44, 191),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                TextButton(
                  onPressed: () {
                    // Navegar a la página de inicio de sesión
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignInPage(),
                      ),
                    );
                  },
                  child: Text(
                    '¿Ya tienes una cuenta? SIGN IN',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
