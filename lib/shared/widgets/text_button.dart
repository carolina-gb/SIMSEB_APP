import 'package:flutter/material.dart';

import '../../env/theme/app_theme.dart';

class TextButtonWidget extends StatefulWidget {
  const TextButtonWidget(
      {super.key,
      this.onPressed,
      required this.nameButton,
      this.fontSize = 10,
      this.color = AppTheme.primaryMedium,
      this.underline = false,
      this.fontWeight,
      this.fontFamily,
      this.whitPadding = true});

  final void Function()? onPressed;
  final String nameButton;
  final double? fontSize;
  final Color? color;
  final bool? underline;
  final FontWeight? fontWeight;
  final String? fontFamily;
  final bool? whitPadding;

  @override
  State<TextButtonWidget> createState() => _TextButtonWidgetState();
}

class _TextButtonWidgetState extends State<TextButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: widget.whitPadding!
          ? null
          : const ButtonStyle(
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
      onPressed: widget.onPressed,
      child: Text(
        widget.nameButton,
        style: TextStyle(
            color: widget.color,
            fontSize: widget.fontSize,
            fontFamily: widget.fontFamily,
            fontWeight: widget.fontWeight ?? FontWeight.bold,
            decoration: widget.underline! ? TextDecoration.underline : null,
            decorationColor: widget.color,
            decorationThickness: 2),
      ),
    );
  }
}
