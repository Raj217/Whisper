part of theme_provider;

final StateNotifierProvider<ThemeProvider, ThemeMode> themeProvider =
    StateNotifierProvider<ThemeProvider, ThemeMode>((ref) {
  return ThemeProvider();
});

class ThemeProvider extends StateNotifier<ThemeMode> {
  ThemeProvider() : super(ThemeMode.system);

  void changeTheme(bool isLightTheme) {
    state = isLightTheme ? ThemeMode.light : ThemeMode.dark;
  }

  ThemeMode theme(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? ThemeMode.dark
        : ThemeMode.light;
  }
}
