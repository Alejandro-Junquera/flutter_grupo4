import 'package:flutter/material.dart';

class InputDecorations {
  static InputDecoration authInputDecoration({
    required String hinText,
    required String labelText,
    IconData? prefixIcon,
  }) {
    return InputDecoration(
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.blueGrey),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.blue, width: 2),
        ),
        hintText: hinText,
        labelText: labelText,
        labelStyle: const TextStyle(color: Colors.grey),
        prefixIcon: prefixIcon != null
            ? Icon(prefixIcon, color: Colors.blueGrey[600])
            : null);
  }
}
