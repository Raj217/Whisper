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
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 4,
        backgroundColor: whiteSwatch,
        foregroundColor: blueSwatch,
      ),
    ),
    iconButtonTheme: IconButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 4,
        shadowColor: whiteSwatch,
        backgroundColor: whiteSwatch,
        foregroundColor: blueSwatch,
      ),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: blueSwatch.shade800,
      iconTheme: const IconThemeData(color: accentSwatch),
    ),
  );
}
