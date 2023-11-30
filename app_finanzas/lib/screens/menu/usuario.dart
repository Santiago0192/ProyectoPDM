import 'package:app_finanzas/models/theme.dart';
import 'package:app_finanzas/screens/login/SingInPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Configuracion extends StatelessWidget {
  const Configuracion({super.key});

  @override
  Widget build(BuildContext context) {
    final themeModel = Provider.of<ThemeModel>(context);

    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 50.0),
              const Text(
                'Configuración de Temas',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {
                  themeModel.setTheme(countryTheme);
                },
                style: ElevatedButton.styleFrom(
                  primary: countryTheme.primaryColor,
                ),
                child: const Text('Tema Country'),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {
                  themeModel.setTheme(lightTheme);
                },
                style: ElevatedButton.styleFrom(
                  primary: lightTheme.primaryColor,
                ),
                child: const Text('Tema Claro'),
              ),
              ElevatedButton(
                onPressed: () {
                  themeModel.setTheme(darkTheme);
                },
                style: ElevatedButton.styleFrom(
                  primary: darkTheme.primaryColor,
                ),
                child: const Text('Tema Oscuro'),
              ),
              ElevatedButton(
                onPressed: () {
                  themeModel.setTheme(purpleTheme);
                },
                style: ElevatedButton.styleFrom(
                  primary: purpleTheme.primaryColor,
                ),
                child: const Text('Tema Original'),
              ),
              SizedBox(height: 30.0),
              const Text(
                'Configuración de Usuario',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              // ElevatedButton(
              //   onPressed: () {},
              //   child: const Text('Resetear Gastos e Ingresos'),
              // ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SignInPage(),
                    ),
                  );
                },
                child: const Text('Cerrar Sesión'),
              ),
            ],
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
