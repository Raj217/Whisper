part of theme;

ThemeData lightTheme(BuildContext context) {
  return ThemeData(
    brightness: Brightness.light,
    fontFamily: 'Comfortaa',
    colorScheme: const ColorScheme.light(
      primary: blueSwatch,
      secondary: accentSwatch,
    ),
    scaffoldBackgroundColor: whiteSwatch,
    useMaterial3: true,
    iconTheme: const IconThemeData(
      color: accentSwatch,
    ),
    iconButtonTheme: IconButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: blueSwatch,
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: whiteSwatch,
      iconTheme: IconThemeData(color: accentSwatch),
    ),
  );
}
