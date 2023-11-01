import 'package:app_finanzas/models/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Configuracion extends StatelessWidget {
  const Configuracion({super.key});

  @override
  Widget build(BuildContext context) {
    final themeModel = Provider.of<ThemeModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Configuración'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Configuración de Temas',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {
                  themeModel.setTheme(originalTheme);
                },
                style: ElevatedButton.styleFrom(
                  primary: originalTheme.primaryColor,
                ),
                child: const Text('Tema Original'),
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
                child: const Text('Tema Claro'),
              ),
               ElevatedButton(
                onPressed: () {
                  themeModel.setTheme(purpleTheme);
                },
                style: ElevatedButton.styleFrom(
                  primary: purpleTheme.primaryColor,
                ),
                child: const Text('Tema Claro'),
              ),
            ],
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
