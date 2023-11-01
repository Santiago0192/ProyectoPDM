import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final IconData prefixIcon;
  final TextInputType keyboardType;
  final bool obscureText;
  final TextEditingController controller;

  CustomTextField({
    required this.labelText,
    required this.prefixIcon,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
  });

    @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(prefixIcon, color: Theme.of(context).primaryColor), // Usa el color del tema
        labelStyle: TextStyle(color: Theme.of(context).primaryColor), // Usa el color del tema
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor, // Usa el color del tema
            width: 2.0,
          ),
        ),
      ),
      keyboardType: keyboardType,
      obscureText: obscureText,
    );
  }
}