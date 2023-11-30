import 'package:app_finanzas/global/common/toast.dart';
import 'package:app_finanzas/screens/login/SingInPage.dart';
import 'package:app_finanzas/funciones/CustomTextField.dart';
import 'package:app_finanzas/user_auth/firebase_auth_implementation/firebase_auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';
import 'package:permission_handler/permission_handler.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool _isChecked = false;
  bool isSigningUp = false;
  final FirebaseAuthService _auth = FirebaseAuthService();

  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _apellidoController = TextEditingController();
  final TextEditingController _ingresosController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _contraController = TextEditingController();
  final TextEditingController _contra2Controller = TextEditingController();

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
            onPressed: () async {
              Navigator.of(context).pop();
              //Agregar permiso necesario
              PermissionStatus storageStatus =
                  await Permission.storage.request();
              if (storageStatus == PermissionStatus.granted) {}
              if (storageStatus == PermissionStatus.denied) {}
              if (storageStatus == PermissionStatus.permanentlyDenied) {
                openAppSettings();
              }
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
  void dispose() {
    _nombreController.dispose();
    _emailController.dispose();
    _contraController.dispose();
    super.dispose();
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
                          controller: _nombreController,
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
                        const SizedBox(height: 16.0),
                        ElevatedButton(
                          onPressed: () {
                            _signUp(); // Llama a la función para guardar datos

                            // Muestra un SnackBar
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Usuario guardado'),
                                duration: Duration(seconds: 2),
                              ),
                            );
                            // Navega a la página de inicio de sesión
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignInPage(),
                              ),
                            );
                          },
                          child: const Text('Guardar'),
                        ),
                        SizedBox(height: 16.0),
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
                      decoration: TextDecoration.underline,
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

  void _signUp() async {
    setState(() {
      isSigningUp = true;
    });

    String nombre = _nombreController.text;
    String email = _emailController.text;
    String contrasena = _contraController.text;

    User? user = await _auth.signUpWithEmailAndPassword(email, contrasena);

    setState(() {
      isSigningUp = false;
    });
    if (user != null) {
      showToast(message: "User is successfully created");
      Navigator.pushNamed(context, "/home");
    } else {
      showToast(message: "Some error happend");
    }
  }
}
