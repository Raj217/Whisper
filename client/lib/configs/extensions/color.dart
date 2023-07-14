import 'dart:ui';

class ColorExtension extends Color {
  ColorExtension(super.value);

  static Color fromHEX(String hex) {
    if (hex.length == 7) {
      hex = "FF${hex.substring(1)}";
    }
    return Color(int.parse(hex, radix: 16));
  }
}
