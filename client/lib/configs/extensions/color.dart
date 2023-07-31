import 'dart:ui';

extension ColorExtension on Color {
  static Color fromHEX(String hex) {
    if (hex[0] == '#') {
      hex = hex.substring(1);
    }
    return Color(int.parse(hex, radix: 16));
  }
}
