class ImagePath {
  final String _basePath = "assets/image/";
  final String _googleLogo = "google.png";

  String get googleLogo => _basePath + _googleLogo;
}

class RivePath {
  /// Please note that none of the getters won't directly work as it expects
  /// to add the light/dark based on the theme
  RivePath();

  final String _basePath = "assets/rive/";
  final String _hamburgerMenu = "hamburger_menu";

  String get hamburgerMenu => _basePath + _hamburgerMenu;
}
