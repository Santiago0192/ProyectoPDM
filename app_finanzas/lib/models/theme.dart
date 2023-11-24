import 'package:flutter/material.dart';

ThemeData countryTheme = ThemeData(
  primaryColor: Colors.brown[400],
  scaffoldBackgroundColor: const Color.fromARGB(255, 67, 47, 38),
  textTheme: const TextTheme(
    bodyText2: TextStyle(color: Color.fromARGB(255, 167, 127, 120)),
  ),
  appBarTheme: const AppBarTheme(
    color: Color.fromARGB(255, 21, 14, 12),
  ),
  iconTheme: const IconThemeData(
      color: Color.fromARGB(255, 87, 39, 7)), // Cambia el color de los íconos
  buttonTheme: const ButtonThemeData(
    buttonColor: Colors.brown,
    textTheme: ButtonTextTheme.primary,
  ),
  visualDensity: VisualDensity.adaptivePlatformDensity,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      primary: Colors.brown,
    ),
  ),
);

ThemeData lightTheme = ThemeData(
  primaryColor: Color.fromARGB(255, 0, 102, 65),
  scaffoldBackgroundColor: Color.fromARGB(255, 96, 221, 204),
  textTheme: const TextTheme(
    bodyText2: TextStyle(color: Colors.black),
  ),
  appBarTheme: const AppBarTheme(
    color: Color.fromARGB(255, 0, 102, 65),
  ),
  iconTheme: const IconThemeData(
      color: Color.fromARGB(255, 23, 51, 3)), // Cambia el color de los íconos
  buttonTheme: const ButtonThemeData(
    buttonColor: Color.fromARGB(255, 0, 102, 65),
    textTheme: ButtonTextTheme.primary,
  ),
  visualDensity: VisualDensity.adaptivePlatformDensity,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      primary: Color.fromARGB(255, 0, 102, 65),
    ),
  ),
);

ThemeData darkTheme = ThemeData(
  primaryColor: const Color.fromARGB(255, 2, 30, 61),
  scaffoldBackgroundColor: Color.fromARGB(255, 14, 2, 63),
  textTheme: const TextTheme(
    bodyText2: TextStyle(color: Color.fromARGB(255, 123, 173, 197)),
  ),
  appBarTheme: const AppBarTheme(
    color: Color.fromARGB(255, 14, 2, 63),
  ),
  iconTheme: const IconThemeData(
      color: Color.fromARGB(255, 8, 83, 118)), // Cambia el color de los íconos
  buttonTheme: const ButtonThemeData(
    buttonColor: Color.fromARGB(255, 9, 77, 108),
    textTheme: ButtonTextTheme.primary,
  ),
  visualDensity: VisualDensity.adaptivePlatformDensity,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      primary: const Color.fromARGB(255, 9, 77, 108),
    ),
  ),
);

ThemeData purpleTheme = ThemeData(
  primaryColor: Colors.purple[400],
  scaffoldBackgroundColor: Color.fromARGB(255, 148, 108, 195),
  textTheme: const TextTheme(
    bodyText2: TextStyle(color: Color.fromARGB(255, 54, 8, 65)),
  ),
  appBarTheme: const AppBarTheme(
    color: Colors.purple,
  ),
  iconTheme: const IconThemeData(
    color: Colors.purple
  ), // Cambia el color de los íconos
  buttonTheme: const ButtonThemeData(
    buttonColor: Colors.purple,
    textTheme: ButtonTextTheme.primary,
  ),
  visualDensity: VisualDensity.adaptivePlatformDensity,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      primary: Colors.purple,
    ),
  ),
);

class ThemeModel with ChangeNotifier {
  ThemeData _currentTheme = purpleTheme;

  ThemeData get currentTheme => _currentTheme;

  void setTheme(ThemeData theme) {
    _currentTheme = theme;
    notifyListeners();
  }
}
