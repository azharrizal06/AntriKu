import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  TextInput(
      {super.key,
      required this.controller,
      required this.label,
      required this.icons});

  String label;
  final TextEditingController controller;
  IconData icons;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
            hintText: "$label",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
            prefixIcon: Icon(icons)),
      ),
    );
  }
}
