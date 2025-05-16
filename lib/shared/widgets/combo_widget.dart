import 'package:flutter/material.dart';

class ComboBoxWidget extends StatelessWidget {
  final String? selectedValue;
  final List<String> items;
  final String hintText;
  final ValueChanged<String?> onChanged;

  const ComboBoxWidget({
    super.key,
    required this.selectedValue,
    required this.items,
    required this.onChanged,
    this.hintText = 'Seleccione una opción',
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: selectedValue,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        filled: true,
        fillColor: Colors.grey[100],
      ),
      hint: Text(hintText),
      items: items.map((String item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(item),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}
