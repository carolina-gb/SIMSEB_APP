import 'package:flutter/material.dart';
import 'package:fluttertest/env/theme/app_theme.dart';

class ComboBoxWidget extends StatelessWidget {
  final String? selectedValue;
  final List<String> items;
  final String hintText;
  final ValueChanged<String?> onChanged;
  final Color dropdownBackgroundColor;
  final double? width;
  final TextStyle? itemTextStyle;

  const ComboBoxWidget({
    super.key,
    required this.selectedValue,
    required this.items,
    required this.onChanged,
    this.hintText = '',
    this.dropdownBackgroundColor = Colors.white,
    this.width,
    this.itemTextStyle,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      color: AppTheme.white,
      child: DropdownMenu<String>(
        initialSelection: selectedValue,
        label: Text(hintText),
        onSelected: onChanged,
        width: width ?? size.height * 0.4,
        menuStyle: MenuStyle(
          backgroundColor: WidgetStatePropertyAll(dropdownBackgroundColor),
          elevation: const WidgetStatePropertyAll(8),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          padding:
              const WidgetStatePropertyAll(EdgeInsets.symmetric(vertical: 8)),
        ),
        dropdownMenuEntries: items.map(
          (item) {
            return DropdownMenuEntry<String>(
              value: item,
              label: item,
              style: ButtonStyle(
                padding: const WidgetStatePropertyAll(
                  EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                ),
                textStyle: WidgetStatePropertyAll(
                  itemTextStyle ?? const TextStyle(fontSize: 16),
                ),
              ),
            );
          },
        ).toList(),
      ),
    );
  }
}
