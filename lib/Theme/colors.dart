import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Color buttonColor = Color(0xffED3F40);
Color blackColor = Colors.black;
Color? strikeThroughColor = Colors.grey[400];
Color newOrderColor = Color(0xff009946);
Color primaryColor = Color(0xff591cd3);

Color transparentColor = Colors.transparent;

Color kMainColor = Color(0xff591cd3);
Color kDisabledColor = Color(0xff616161);
Color kWhiteColor = Colors.white;
Color kLightTextColor = Colors.grey;
Color kCardBackgroundColor = Color(0xfff8f9fd);
Color kTransparentColor = Colors.transparent;
Color kHintColor = Color(0xff999e93);
Color kTextColor = Color(0xff6a6c74);
Color kMainTextColor = Color(0xff000000);
Color partialColor = Color(0xFF11cdef);
Color dueColor = Color(0xFFffc107);
Color orangeColor = Color(0xffffa025);
Color paidColor = Color(0xFF98D973);
Color txtFieldHintColor = Color(0xFFA8ADB7);

/// Returns MaterialColor from Color
MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map<int, Color> swatch = <int, Color>{};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  strengths.forEach((strength) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  });
  return MaterialColor(color.value, swatch);
}
