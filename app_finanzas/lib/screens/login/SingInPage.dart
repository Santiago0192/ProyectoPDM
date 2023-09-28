import 'package:flutter/material.dart';
import 'package:app_finanzas/screens/menu/menu.dart';
import 'package:app_finanzas/screens/login/SingUpPage.dart';

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerRight,
            end: Alignment.centerLeft,
            colors: [
              Color.fromARGB(255, 147, 67, 212),
              Color.fromARGB(255, 191, 101, 207),
            ],
          ),
        ),
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
                      TextFormField(
                        decoration: InputDecoration(labelText: 'Correo'),
                      ),
                      TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(labelText: 'Contraseña'),
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
                                builder: (context) =>
                                    MyPage()), // Cambia a MyPage si es la pantalla correcta
                          );
                        },
                        child: Icon(Icons.arrow_forward),
                        style: ElevatedButton.styleFrom(
                          shape: CircleBorder(),
                          padding: EdgeInsets.all(16.0),
                          primary: Color.fromARGB(255, 169, 44,
                              191), // Cambia el color según tu preferencia
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
                    color: Colors
                        .white, // Cambiado a blanco para mayor visibilidad
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
