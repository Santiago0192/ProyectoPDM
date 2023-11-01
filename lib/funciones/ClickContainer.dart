import 'package:flutter/material.dart';

Widget buildClickableContainer({
  required IconData icon,
  required String texto,
  required VoidCallback onTap,
}) {
return GestureDetector(
    //onTap: onTap,
    child: Container(
      height: 60,
      margin: const EdgeInsets.all(16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.purple),
          const SizedBox(width: 16.0),
          Text(
            texto,
            style: const TextStyle(
              fontSize: 16.0,
              color: Colors.black,
            ),
          ),
        ],
      ),
    ),
  );
}


