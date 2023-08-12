class ImagePath {
  final String _basePath = "assets/image/";
  final String _googleLogo = "google.png";

  String get googleLogo => _basePath + _googleLogo;
}

class RivePath {
  /// Please note that none of the getters won't directly work as it expects
  /// to add the light/dark based on the theme
  RivePath._();

  static const String _basePath = "assets/rive/";
  static const String _hamburgerMenu = "hamburger_menu";
  static const String _filterMenu = "filter_menu";
  static const String _themeToggle = "theme_toggle";
  static const String _settings = "animated_icon_set";

  static String get hamburgerMenu => _basePath + _hamburgerMenu;
  static String get filterMenu => _basePath + _filterMenu;
  static String get themeToggle => _basePath + _themeToggle;
  static String get settings => _basePath + _settings;
}
