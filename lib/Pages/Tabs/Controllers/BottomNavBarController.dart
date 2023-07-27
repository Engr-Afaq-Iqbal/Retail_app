import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/Models/NavBarModel.dart';
import '/Pages/AppMenu/AppMenuPage.dart';
import '../../HomePageRetail/homepageRetail.dart';

class BottomNavBarController extends GetxController {
  int selectedNavBarIndexs = 0;

  // NavBar Selection Update
  int get selectedNavBarIndex => selectedNavBarIndexs;
  set selectedNavBarIndex(int _ind) {
    selectedNavBarIndexs = _ind;
    update();
  }

  List<NavBarModel> bottomNavBarData = [
    NavBarModel(
      icon: Icons.home_outlined,
      label: 'dashboard_drop',
      onTap: () {
        print('Dashboard Page');
        // Get.to(() => OrderTypeSelection());
      },
      page: HomePageRetail(),
    ),
    NavBarModel(
      icon: Icons.menu,
      label: 'menu_drop',
      onTap: () {
        print('Menu Page');
      },
      page: AppMenuPage(),
    ),
  ];
}
