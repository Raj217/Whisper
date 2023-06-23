part of theme;

ThemeData darkTheme(BuildContext context) {
  return ThemeData(
    brightness: Brightness.dark,
    fontFamily: 'Comfortaa',
    colorScheme: const ColorScheme.dark(
      primary: whiteSwatch,
      secondary: accentSwatch,
    ),
    scaffoldBackgroundColor: blueSwatch.shade800,
    useMaterial3: true,
    iconTheme: const IconThemeData(
      color: accentSwatch,
    ),
    iconButtonTheme: IconButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: whiteSwatch,
      ),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: blueSwatch.shade800,
      iconTheme: const IconThemeData(color: accentSwatch),
    ),
  );
}
