import 'package:flutter/material.dart';
import 'package:fluttertest/env/theme/app_theme.dart';

class OutlinedButtonWidget extends StatelessWidget {
  const OutlinedButtonWidget(
      {super.key,
      this.onPressed,
      this.color = AppTheme.primaryDarkest,
      required this.text,
      this.width = double.infinity,
      this.height = 20,
      this.borderRadius = 5,
      this.fontSize,
      this.withPadding = true});

  final void Function()? onPressed;
  final Color? color;
  final String text;
  final double? width;
  final double? height;
  final double? borderRadius;
  final double? fontSize;
  final bool? withPadding;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        style: OutlinedButton.styleFrom(
          minimumSize: Size(width!, height!),
          padding:
              withPadding! ? null : const EdgeInsets.symmetric(horizontal: 10),
          side: BorderSide(color: color!, width: 1.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius!),
          ),
        ),
        onPressed: onPressed,
        child: Text(text,
            style: TextStyle(
                color: color,
                fontWeight: FontWeight.w600,
                fontSize: fontSize ?? 18)));
  }
}
