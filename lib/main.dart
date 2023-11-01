import 'package:app_finanzas/screens/menu/menu.dart';
import 'package:flutter/material.dart';
import 'package:app_finanzas/screens/login/SingInPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyPage(), 
    );
  }
}
