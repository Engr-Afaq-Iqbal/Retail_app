import 'package:bizmodo_emenu/Theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  Rx<Color> primaryColor = Colors.blue.obs;

  void setPrimaryColor(Color color) {
    primaryColor.value = color;
    updateTheme();
  }

  void updateTheme() {
    Get.changeTheme(ThemeData(
      //primaryColor: primaryColor.value, colorScheme: ColorScheme(background: Color(0xffF8F9FD))
      // Add other theme configurations
      colorScheme: ColorScheme.fromSwatch(
        // primarySwatch: createMaterialColor(primaryColor),
        primarySwatch: createMaterialColor(primaryColor.value),
      ).copyWith(
        background: Color(0xffF8F9FD),
      ),
    ));
  }
}
