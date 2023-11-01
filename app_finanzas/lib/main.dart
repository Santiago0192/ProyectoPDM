import 'package:app_finanzas/models/theme.dart';
import 'package:flutter/material.dart';
import 'package:app_finanzas/screens/login/SingInPage.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
  MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeModel()),
      ],
  child: MyApp()
  ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeModel = Provider.of<ThemeModel>(context);
    return MaterialApp(
      theme: themeModel.currentTheme,
      home: SignInPage(), 
    );
  }
}
