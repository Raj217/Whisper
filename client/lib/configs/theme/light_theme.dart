import 'package:flutter/material.dart';
import 'pallet.dart';

ThemeData lightTheme(BuildContext context) {
  return ThemeData(
    brightness: Brightness.light,
    fontFamily: 'Comfortaa',
    colorScheme: const ColorScheme.light(
      primary: primarySwatch,
      secondary: accentSwatch,
    ),
    useMaterial3: true,
    iconTheme: const IconThemeData(color: accentSwatch),
    appBarTheme: const AppBarTheme(
      iconTheme: IconThemeData(color: accentSwatch),
    ),
  );
}
