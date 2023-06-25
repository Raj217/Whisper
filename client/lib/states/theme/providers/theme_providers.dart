part of theme_provider;

final StateNotifierProvider<ThemeProvider, ThemeMode> themeProvider =
    StateNotifierProvider<ThemeProvider, ThemeMode>((ref) {
  return ThemeProvider(ThemeProvider.initThemeMode);
});

class ThemeProvider extends StateNotifier<ThemeMode> {
  ThemeProvider(ThemeMode? themeMode) : super(themeMode ?? ThemeMode.system);

  Future<void> changeTheme(bool isDarkTheme) async {
    state = isDarkTheme ? ThemeMode.dark : ThemeMode.light;
    await StorageHandler.instance
        .setBool(StoredValues.isDarkTheme.name, isDarkTheme);
  }

  static ThemeMode get initThemeMode {
    return theme(_checkLocalStorage);
  }

  static bool? get _checkLocalStorage {
    return StorageHandler.instance.getBool(StoredValues.isDarkTheme.name);
  }

  bool isDarkTheme(BuildContext context) {
    return _checkLocalStorage ??
        Theme.of(context).brightness == Brightness.dark;
  }

  static ThemeMode theme(bool? isDarkTheme) {
    return isDarkTheme == null
        ? ThemeMode.system
        : (isDarkTheme == true ? ThemeMode.dark : ThemeMode.light);
  }
}
