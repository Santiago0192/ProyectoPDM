// ignore_for_file: file_names, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:app_finanzas/screens/menu/menu.dart';
import 'package:app_finanzas/screens/login/SingUpPage.dart';
import 'package:app_finanzas/funciones/CustomTextField.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../global/common/toast.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

Future<UserCredential?> signIn(String email, String password) async {
  try {
    UserCredential userCredential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return userCredential;
  } on FirebaseAuthException {
    return null;
  }
}

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  //bool _isSigning = false;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _contraController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Card(
              margin: const EdgeInsets.all(16.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const Text(
                      'Sign In',
                      style: TextStyle(
                        fontSize: 40.0,
                        fontWeight: FontWeight.bold,
                      ),
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
                    ElevatedButton(
                      onPressed: () {
                        _signIn();
                      },
                      child: const Text('Iniciar sesión'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            GestureDetector(
              onTap: () {
                // Agregar aquí la lógica para navegar a la pantalla de registro
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignUpPage()),
                );
              },
              child: const Text(
                '¿No tiene cuenta? SIGN UP',
                style: TextStyle(
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _signIn() async {
    setState(() {
      //_isSigning = true;
    });

    String email = _emailController.text;
    String contrasena = _contraController.text;

    UserCredential user = await _auth.signInWithEmailAndPassword(
        email: email, password: contrasena);

    setState(() {
      //_isSigning = false;
    });

    if (user != null) {
      showToast(message: "User is successfully signed in");
      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MyPage()),
      );
    } else {
      showToast(message: "some error occured");
    }
  }
}
