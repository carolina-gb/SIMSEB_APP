import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../env/theme/app_theme.dart';
import '../helpers/global_helper.dart';

class TextFormFieldWidget extends StatelessWidget {
  const TextFormFieldWidget(
      {super.key,
      this.textAlign = TextAlign.start,
      this.keyboardType,
      this.hintText,
      this.hintIcon,
      this.maxHeigth = double.infinity,
      this.maxWidth = double.infinity,
      this.controller,
      this.validator,
      this.inputFormatters,
      this.textInputAction,
      this.prefixIcon,
      this.suffixIcon,
      this.obscureText = false,
      this.fillColor = AppTheme.white,
      this.fontWeightHintText = FontWeight.bold,
      this.maxLines = 1,
      this.showShading = true,
      this.borderWith = 1,
      this.focusNode,
      this.readOnly = false,
      this.onTap,
      this.onChanged,
      this.enabled,
      this.initialValue,
      this.onFieldSubmitted,
      this.onEditingComplete,
      this.onSaved,
      this.colorBorder = AppTheme.naturalsMedium,
      this.horizontalPadding = 10,
      this.verticalPadding = 12,
      this.fontSize = 10,
      this.borderRadius,
      this.hintColor,
      this.fontFamily,
      this.borderSide,
      this.autovalidateMode,
      this.maxLength});

  final double maxHeigth;
  final double maxWidth;
  final double verticalPadding;
  final double horizontalPadding;
  final double? fontSize;
  final double? borderRadius;
  final TextInputType? keyboardType;
  final TextAlign textAlign;
  final String? hintText;
  final Color? hintColor;
  final IconData? hintIcon;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputAction? textInputAction;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final Color? fillColor;
  final Color? colorBorder;
  final FontWeight? fontWeightHintText;
  final int? maxLines;
  final int? maxLength;
  final bool? showShading;
  final double? borderWith;
  final FocusNode? focusNode;
  final bool? enabled;
  final bool? readOnly;
  final String? fontFamily;
  final void Function()? onTap;
  final void Function(String)? onChanged;
  final String? initialValue;
  final void Function(String)? onFieldSubmitted;
  final void Function()? onEditingComplete;
  final void Function(String?)? onSaved;
  final BorderSide? borderSide;
  final AutovalidateMode? autovalidateMode;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onFieldSubmitted: onFieldSubmitted,
      onSaved: onSaved,
      onTap: onTap,
      onChanged: onChanged,
      onEditingComplete: onEditingComplete,
      initialValue: initialValue,
      readOnly: readOnly!,
      enabled: enabled,
      focusNode: focusNode,
      maxLines: maxLines,
      obscuringCharacter: '*',
      obscureText: obscureText,
      autovalidateMode: autovalidateMode,
      maxLength: maxLength,
      style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w400,
          fontSize: fontSize,
          fontFamily: fontFamily),
      textInputAction: textInputAction,
      inputFormatters: inputFormatters,
      validator: validator,
      controller: controller,
      onTapOutside: (pointerDownEvent) {
        GlobalHelper.dismissKeyboard(context);
      },
      textAlign: textAlign,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        errorStyle:
            const TextStyle(color: AppTheme.highlightMedium, fontSize: 13),
        filled: true,
        fillColor: fillColor,
        hintText: hintText,
        hintStyle: TextStyle(
            color: hintColor ?? AppTheme.textTitleForm,
            fontSize: 13,
            fontFamily: fontFamily),
        prefixIcon: prefixIcon ??
            (hintIcon != null
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(hintIcon, color: AppTheme.primaryDarkest),
                    ],
                  )
                : null),
        suffixIcon: suffixIcon,
        alignLabelWithHint: true,
        isCollapsed: false,
        isDense: true,
        contentPadding: EdgeInsets.symmetric(
            horizontal: horizontalPadding, vertical: verticalPadding),
        constraints: BoxConstraints(maxWidth: maxWidth, maxHeight: maxHeigth),
        enabledBorder: OutlineInputBorder(
          borderSide: borderSide ??
              BorderSide(width: borderWith!, color: colorBorder!),
          borderRadius: BorderRadius.circular(borderRadius ?? 10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: borderSide ??
              BorderSide(width: borderWith!, color: colorBorder!),
          borderRadius: BorderRadius.circular(borderRadius ?? 10),
        ),
        // errorBorder: OutlineInputBorder(
        //   borderSide: borderSide ??
        //       BorderSide(width: borderWith!, color: AppTheme.highlightMedium),
        //   borderRadius: BorderRadius.circular(borderRadius ?? 10),
        // ),
        // focusedErrorBorder: OutlineInputBorder(
        //   borderSide: borderSide ??
        //       BorderSide(width: borderWith!, color: AppTheme.highlightMedium),
        //   borderRadius: BorderRadius.circular(10),
        // )
      ),
    );
  }
}
