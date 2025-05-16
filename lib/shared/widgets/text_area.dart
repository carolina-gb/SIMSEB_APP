import 'package:flutter/material.dart';

class TextAreaWidget extends StatelessWidget {
  final String? initialValue;
  final String hintText;
  final int maxLines;
  final ValueChanged<String>? onChanged;

  const TextAreaWidget({
    super.key,
    this.initialValue,
    this.hintText = 'Ingrese texto...',
    this.maxLines = 5,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      onChanged: onChanged,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        filled: true,
        fillColor: Colors.grey[100],
      ),
    );
  }
}
