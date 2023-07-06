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
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 2,
      ),
    ),
    iconButtonTheme: IconButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 4,
        backgroundColor: blueSwatch,
        foregroundColor: whiteSwatch,
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: whiteSwatch,
      iconTheme: IconThemeData(color: whiteSwatch),
    ),
  );
}
