import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Theme/colors.dart';
import '/Components/custom_circular_button.dart';
import 'utils.dart';

class AppConst {
  static void updateMapValues({
    required Map<String, dynamic> map,
    required String key,
    required var value,
  }) {
    if (map.containsKey(key)) {
      map.update(key, (v) => value);
    } else {
      map.putIfAbsent(key, () => value);
    }
    logger.i(map);
  }

  /// ImagePicker
  static Future<String> chooseImageSource() async {
    String value = "";
    await Get.bottomSheet(
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: Get.width,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: Get.width * .9,
                    child: CustomButton(
                      borderRadius: 10,
                      title: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          'camera'.tr,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      onTap: () {
                        value = "Camera";

                        if (Get.isBottomSheetOpen!) Get.back();
                        return value;
                      },
                    ),
                  ),
                  SizedBox(
                    width: Get.width * .9,
                    child: dividerLine(),
                  ),
                  SizedBox(
                    width: Get.width * .9,
                    child: CustomButton(
                      borderRadius: 10,
                      title: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Text(
                          'gallery'.tr,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      onTap: () {
                        value = "Gallery";
                        if (Get.isBottomSheetOpen!) Get.back();
                        return value;
                      },
                    ),
                  ),
                ],
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
      enableDrag: true,
      isDismissible: false,
    );
    return value;
  }

  /// Divider Line
  static Widget dividerLine({double? height, double? width, Color? color}) =>
      Container(
        margin:
            width != null ? const EdgeInsets.symmetric(horizontal: 3.5) : null,
        height: height ?? 1.5,
        width: width,
        color: color ?? Colors.black87,
      );

  static Widget dividerLineLight({double? height, double? width}) =>
      dividerLine(
        height: height,
        width: width,
        color: Colors.black26,
      );

  static bool? intToBool(int? _val) {
    if (_val == 1) return true;
    if (_val == 0) return false;
    return null;
  }
}

class AppImages {
  static const String appIcon = 'assets/bizmodo_icons/appIcon.png';
  static const String chefIcon = 'assets/bizmodo_icons/BizModo Chef Icon.png';
  static const String chefLogo = 'assets/bizmodo_icons/BizModo Chef Logo.png';
  static const String eMenuIcon = 'assets/bizmodo_icons/BizModo eMenu Icon.png';
  static const String eMenuLogo = 'assets/bizmodo_icons/BizModo eMenu Logo.png';
  static const String restroIcon =
      'assets/bizmodo_icons/BizModo Restro Icon.png';
  static const String restroLogo =
      'assets/bizmodo_icons/BizModo Restro Logo.png';
  static const String retailIcon =
      'assets/bizmodo_icons/Bizmodo_RetailIicon.png';
  static const String retailLogo =
      'assets/bizmodo_icons/Bizmodo_RetailLogo.png';
}

class AppTextStyles {
  static const TextStyle style12Black = TextStyle(
    color: Colors.black,
  );

  static const TextStyle style13w500 = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.w500,
  );
}

class AppValues {
  static String dineIn = 'Dine-In';
  static String takeAway = 'Take-Away';
  static String delivery = 'Delivery';
  static String chequeMethod = 'cheque';
  static String cashMethod = 'cash';

  static String walkInCustomerID = "1";
}

PreferredSize appBarBottomLine() {
  return PreferredSize(
    preferredSize: const Size.fromHeight(1.0),
    child: Container(
      color: primaryColor,
      height: 2.0,
    ),
  );
}

BoxShadow settingsPageBoxShadow() {
  return BoxShadow(
    color: Colors.grey.withOpacity(0.1),
    blurRadius: 8.0, // soften the shadow
    spreadRadius: 1.0, //extend the shadow
    offset: Offset(
      1.0, // Move to right 5  horizontally
      1.0, // Move to bottom 5 Vertically
    ),
  );
}
