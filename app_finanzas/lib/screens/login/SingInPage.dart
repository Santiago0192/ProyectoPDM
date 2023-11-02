import 'package:flutter/material.dart';
import 'package:app_finanzas/screens/menu/menu.dart';
import 'package:app_finanzas/screens/login/SingUpPage.dart';
import 'package:app_finanzas/funciones/CustomTextField.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _contraController = TextEditingController();
  
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Card(
                margin: EdgeInsets.all(16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        'Sign In',
                        style: TextStyle(
                          fontSize: 40.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16.0),
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
                      ElevatedButton(
                        onPressed: () {
                          // Agregar aquí la lógica para iniciar sesión
                          // ...
                          // Después de que el usuario haya iniciado sesión, navegamos a la página de menú
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    MyPage()), // Cambia a MyPage si es la pantalla correcta
                          );
                        },
                        child: Icon(Icons.arrow_forward),
                        style: ElevatedButton.styleFrom(
                          shape: CircleBorder(),
                          padding: EdgeInsets.all(16.0),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              GestureDetector(
                onTap: () {
                  // Agregar aquí la lógica para navegar a la pantalla de registro
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignUpPage()),
                  );
                },
                child: Text(
                  '¿No tiene cuenta? SIGN UP',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
