import 'package:flutter/material.dart';
import 'package:fluttertest/env/theme/app_theme.dart';

class PlaceHolderWidget extends StatelessWidget {
  const PlaceHolderWidget(
      {super.key,
      required this.placeholder,
      this.color = AppTheme.naturalsDarkest,
      this.fontWeight = FontWeight.bold,
      this.fontSize = 15.5});

  final String placeholder;
  final Color color;
  final FontWeight fontWeight;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        overflow: TextOverflow.clip,
        maxLines: 1,
        placeholder,
        style:
            TextStyle(color: color, fontWeight: fontWeight, fontSize: fontSize),
      ),
    );
  }
}
