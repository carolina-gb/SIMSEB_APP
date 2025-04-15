import 'package:flutter/material.dart';

class AppTheme {
  //colors
  static const Color transparent = Color(0x00000000);
  static const Color white = Color(0xFFFFFFFF);
  static const Color whiteAlternative = Color(0xFFFEFFFA);
  static const Color primaryDarkest = Color(0xFF00587C);
  static const Color primaryDark = Color(0xFF007694);
  static const Color primaryMedium = Color(0xFF00A1CB);
  static const Color highlightMedium = Color(0xFFD6001C);
  static const Color naturalsDarkest = Color(0xFF15192E);
  static const Color naturalsMedium = Color(0xFFDBDDE6);
  static const Color positive = Color(0xFF79D279);
  static const Color positiveMedium = Color(0xFF008A05);
  static const Color pink = Color(0xFFE1197A);
  static const Color warning = Color(0xFFE07900);
  static const Color textTitleForm = Color(0xFFA3A3A3);
  static const Color gray1 = Color(0xFF626262);
  static const Color gray2 = Color(0xFFDBDDE6);
  static const Color gray3 = Color(0xFFF8F8F8);
  static const Color gray4 = Color(0xFFF3F3F3);

  static const Color error = Color(0xFF5C001F);
  static const Color error2 = Color(0xFFAD0048);

  static const Color black = Color(0xFF000000);

  //icons
  static const String logoIcon = "assets/sun_logo.png";
  // static const String logoIconLoading = "assets/promarisco_logo_loading.svg";
  static const String icon404Path = "assets/barrio_not_found.png";
  // static const String iconCautionPath = "assets/caution.svg";

  ThemeData theme() {
    return ThemeData(
      textSelectionTheme: const TextSelectionThemeData(
          selectionHandleColor: AppTheme.primaryDark,
          cursorColor: AppTheme.primaryDark),
      filledButtonTheme: const FilledButtonThemeData(
          style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(highlightMedium))),
      useMaterial3: true,
    );
  }
}
