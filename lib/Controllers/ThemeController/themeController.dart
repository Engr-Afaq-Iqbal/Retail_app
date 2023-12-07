import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/Services/storage_services.dart';
import '/Theme/colors.dart';
import '../../Config/utils.dart';
import '../../Models/StoreSettingsModel/storeSettingsModel.dart';
import '../../Services/api_services.dart';
import '../../Services/api_urls.dart';
import '../../Theme/style.dart';
import '../exception_controller.dart';

class ThemeController extends GetxController {
  Rx<Color> primaryColor = Colors.blue.obs;

  void setPrimaryColor(Color color) {
    primaryColor.value = color;
    updateTheme();
  }

  void updateTheme() {
    appTheme = ThemeData(
      //primaryColor: primaryColor.value, colorScheme: ColorScheme(background: Color(0xffF8F9FD))
      // Add other theme configurations
      colorScheme: ColorScheme.fromSwatch(
        // primarySwatch: createMaterialColor(primaryColor),
        primarySwatch: createMaterialColor(primaryColor.value),
      ).copyWith(
        background: Color(0xffF8F9FD),
      ),
    );
    Get.changeTheme(appTheme);
    Get.forceAppUpdate();
  }

  StoreSettingsModel? storeSettingsModel;
  Future setThemeColor({String color = 'ff591cd3'}) async {
    Map<String, String> _field = {
      'theme_selection': '${color}',
      'lang': 'eng',
      'printer_id': '4',
      'auto_printer': '1',
      'user_id': '${AppStorage.getLoggedUserData()?.staffUser.id}'
    };

    return await ApiServices.postMethod(
            feedUrl: ApiUrls.storeSettingsAPI, fields: _field)
        .then((_res) {
      if (_res == null) return null;
      storeSettingsModel = storeSettingsModelFromJson(_res);
      if (storeSettingsModel?.success == true) {
        debugPrint('');
        debugPrint(storeSettingsModel?.msg?.themeSelection);
        stopProgress();
        Get.back();
      }

      return true;
    }).onError((error, stackTrace) async {
      debugPrint('Error => $error');
      logger.e('StackTrace => $stackTrace');
      await ExceptionController().exceptionAlert(
        errorMsg: '$error',
        exceptionFormat: ApiServices.methodExceptionFormat(
            'POST', ApiUrls.storeSettingsAPI, error, stackTrace),
      );
      throw '$error';
    });
  }
}
