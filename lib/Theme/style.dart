import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '/Controllers/AuthController/auth_controller.dart';
import '/Theme/colors.dart';

/// TODO: button bg colors

ThemeData appTheme = ThemeData(
  //primaryColor: Colors.red,
  fontFamily: 'ProductSans',
  scaffoldBackgroundColor: Color(0xfff8f9fd),
  colorScheme: ColorScheme.fromSwatch(
    // primarySwatch: createMaterialColor(primaryColor),
    primarySwatch: createMaterialColor(Color(int.parse(
        Get.find<AuthController>().currentColor
        // AppStorage.getLoggedUserData()?.staffUser.appSetting?.themeSelection ??
        //     'FF008080'
        ,
        radix: 16))), // createMaterialColor(primaryColor),
  ).copyWith(
    background: Color(0xffF8F9FD),
  ),
  useMaterial3: true,
  // textButtonTheme: TextButtonThemeData(
  //   style: ButtonStyle(
  //     foregroundColor: MaterialStateProperty.all<Color>(primaryColor),
  //     overlayColor: MaterialStateProperty.resolveWith<Color?>(
  //       (Set<MaterialState> states) {
  //         if (states.contains(MaterialState.hovered)) return primaryColor.withOpacity(0.04);
  //         if (states.contains(MaterialState.focused) || states.contains(MaterialState.pressed))
  //           return Colors.blue.withOpacity(0.12);
  //         return null; // Defer to the widget's default.
  //       },
  //     ),
  //   ),
  // ),

  /// Chip Theme Configurations
  chipTheme: ChipThemeData(
    labelPadding: const EdgeInsets.symmetric(horizontal: 7.5, vertical: 5.0),
    side: BorderSide(color: primaryColor, width: 0.75),
    selectedColor: primaryColor,
    secondarySelectedColor: primaryColor,
    selectedShadowColor: primaryColor,
    labelStyle: TextStyle(fontWeight: FontWeight.w500, color: Colors.black87),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: ButtonStyle(
      foregroundColor: MaterialStateProperty.all<Color>(primaryColor),
      overlayColor: MaterialStateProperty.resolveWith<Color?>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.hovered))
            return primaryColor.withOpacity(0.04);
          if (states.contains(MaterialState.focused) ||
              states.contains(MaterialState.pressed))
            return Colors.blue.withOpacity(0.12);
          return null; // Defer to the widget's default.
        },
      ),
    ),
  ),

  /// AppBar Theme Configurations
  appBarTheme: AppBarTheme(
      // color: Colors.transparent,
      // elevation: 0.0,
      ),

  /// TabBar Theme Configurations
  tabBarTheme: TabBarTheme(
    labelStyle: TextStyle(fontSize: 15),
    labelColor: primaryColor,
    unselectedLabelStyle: TextStyle(fontSize: 13),
    unselectedLabelColor: primaryColor.withOpacity(0.5),
    indicator: UnderlineTabIndicator(
      borderSide: BorderSide(width: 3, color: primaryColor),
    ),
  ),

  /// Text Theme Configurations
  textTheme: TextTheme(
    //default text style of Text Widget
    bodyLarge: TextStyle(),
    bodyMedium: TextStyle(),
    titleMedium: TextStyle(fontWeight: FontWeight.w500),
    displaySmall: TextStyle(),
    headlineSmall: TextStyle(),
    titleLarge: TextStyle(),
    bodySmall: TextStyle(),
    labelSmall: TextStyle(),
  ) /*.apply(displayColor: Colors.black)*/,
);

final ThemeData appDarkTheme = ThemeData(
  fontFamily: 'ProductSans',
  scaffoldBackgroundColor: Color(0xff222425),
  backgroundColor: Color(0xff222425),
  primarySwatch: createMaterialColor(primaryColor),
  useMaterial3: true,
  // textButtonTheme: TextButtonThemeData(
  //   style: ButtonStyle(
  //     foregroundColor: MaterialStateProperty.all<Color>(primaryColor),
  //     overlayColor: MaterialStateProperty.resolveWith<Color?>(
  //       (Set<MaterialState> states) {
  //         if (states.contains(MaterialState.hovered)) return primaryColor.withOpacity(0.04);
  //         if (states.contains(MaterialState.focused) || states.contains(MaterialState.pressed))
  //           return Colors.blue.withOpacity(0.12);
  //         return null; // Defer to the widget's default.
  //       },
  //     ),
  //   ),
  // ),
  appBarTheme: AppBarTheme(
      // color: Colors.transparent,
      // elevation: 0.0,
      ),

  //text theme
  textTheme: TextTheme(
    //default text style of Text Widget
    bodyLarge: TextStyle(color: Colors.white),
    bodyMedium: TextStyle(),
    titleMedium: TextStyle(fontWeight: FontWeight.w500, color: Colors.black),
    displaySmall: TextStyle(),
    headlineSmall: TextStyle(),
    titleLarge: TextStyle(),
    bodySmall: TextStyle(),
    labelSmall: TextStyle(),
  ) /*.apply(displayColor: Colors.black)*/,
);

/// NAME         SIZE  WEIGHT  SPACING
/// headline1    96.0  light   -1.5
/// headline2    60.0  light   -0.5
/// headline3    48.0  regular  0.0
/// headline4    34.0  regular  0.25
/// headline5    24.0  regular  0.0
/// headline6    20.0  medium   0.15
/// subtitle1    16.0  regular  0.15
/// subtitle2    14.0  medium   0.1
/// body1        16.0  regular  0.5   (bodyText1)
/// body2        14.0  regular  0.25  (bodyText2)
/// button       14.0  medium   1.25
/// caption      12.0  regular  0.4
/// overline     10.0  regular  1.5

class AppStyles {
  /// Paddings & Margins
  static Widget p2p5(Widget child) =>
      Padding(padding: const EdgeInsets.all(2.5), child: child);
  static Widget p5(Widget child) =>
      Padding(padding: const EdgeInsets.all(5.0), child: child);
  static Widget p10(Widget child) =>
      Padding(padding: const EdgeInsets.all(10.0), child: child);
  static Widget p12p5(Widget child) =>
      Padding(padding: const EdgeInsets.all(12.5), child: child);
  static Widget p15(Widget child) =>
      Padding(padding: const EdgeInsets.all(15.0), child: child);
  static Widget p15h(Widget child) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0), child: child);
  static Widget p15v(Widget child) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0), child: child);
  static Widget p20h(Widget child) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0), child: child);
  static Widget p20v(Widget child) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0), child: child);

  /// Text Alignments
  static Widget textCenter(String txt, {TextStyle? style}) =>
      Text(txt, textAlign: TextAlign.center, style: style);

  /// Text Styles
  static TextStyle bottomBarTextStyle = GoogleFonts.openSans().copyWith(
    fontSize: 15.0,
    color: kWhiteColor,
    fontWeight: FontWeight.w400,
  );

  static outlineBorderDecoration(context, {bool isBorderColorApply = true}) =>
      BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          width: 1,
          color: isBorderColorApply
              ? Theme.of(context).colorScheme.primary
              : Colors.transparent,
        ),
      );

  /// Back Button
  static Widget backButton({Function()? onTap}) {
    return IconButton(
      onPressed: onTap,
      icon: Icon(Icons.arrow_back_rounded),
    );
  }

  static TextStyle orderMapAppBarTextStyle = GoogleFonts.openSans().copyWith(
    fontSize: 13.3,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  static TextStyle overlayTitleStyle = GoogleFonts.openSans().copyWith(
    fontSize: 16.0,
    fontWeight: FontWeight.bold,
  );

  static TextStyle overlayMsgStyle = GoogleFonts.openSans().copyWith(
    fontSize: 12.0,
    fontWeight: FontWeight.w500,
  );

  /// Screen Bottom Spacings
  static Widget scrollBottomSpacing() => SizedBox(height: 150);
  static Widget scrollBottomSpacingExtra() =>
      SizedBox(height: Get.size.height * 0.4);

  /// Confirmation Dialog
  static deleteConfirmationDialog({Function()? confirmBtnAct}) {
    return showCupertinoDialog(
      context: Get.context!,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text('Delete Item'),
          actions: [
            CupertinoButton.filled(
                onPressed: () => Get.back(),
                child: Text('No'),
                padding: EdgeInsets.zero),
            CupertinoButton(
                onPressed: () {
                  Get.back();
                  if (confirmBtnAct != null) confirmBtnAct();
                },
                child: Text('Yes'),
                padding: EdgeInsets.zero),
          ],
        );
      },
    );
  }
}

final TextStyle appBarHeaderStyle = GoogleFonts.openSans().copyWith(
  fontSize: 14,
  fontWeight: FontWeight.bold,
  color: blackColor,
);

final TextStyle hintGreyStyle = GoogleFonts.openSans().copyWith(
  fontSize: 14,
  fontWeight: FontWeight.w500,
  color: kHintColor,
);

final TextStyle orderMapAppBarTextStyle = GoogleFonts.openSans().copyWith(
  fontSize: 12,
  fontWeight: FontWeight.bold,
  color: blackColor,
);
