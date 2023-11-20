import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../CRM/crm.dart';
import '../../Repair/repair.dart';
import '/Models/NavBarModel.dart';
import '/Pages/AppMenu/AppMenuPage.dart';
import '../../HomePageRetail/homepageRetail.dart';

class BottomNavBarController extends GetxController {
  int _selectedNavBarIndex = 0;

  // NavBar Selection Update
  int get selectedNavBarIndex => _selectedNavBarIndex;
  set selectedNavBarIndex(int _ind) {
    _selectedNavBarIndex = _ind;
    update();
  }

  List<NavBarModel> bottomNavBarData = [
    NavBarModel(
      icon: Icons.home_outlined,
      label: 'dashboard_drop',
      onTap: () {
        print('Order Type Selection page');
        // Get.to(() => OrderTypeSelection());
      },
      //page: OrderTypeSelection(),
      page: HomePageRetail(),
    ),

    // NavBarModel(
    //   icon: Icons.point_of_sale_outlined,
    //   label: 'Pos',
    //   onTap: () {
    //     print('Table page');
    //     // Get.to(() => TablePage());
    //   },
    //   page: TablesPage(isForBookedTables: true),
    // ),
    // NavBarModel(
    //   icon: Icons.menu_open_outlined,
    //   label: 'More',
    //   onTap: () {
    //     print('Order Page');
    //     // Get.to(() => OrdersMain());
    //   },
    //   page: BottomNavBarController()._showMoreBottomSheet(Get.context!),
    // ),
    // NavBarModel(
    //   icon: Icons.event_note_outlined,
    //   label: 'booking_tab',
    //   onTap: () {
    //     print('Booking page');
    //     // Get.to(() => TablePage());
    //   },
    //   page: BookingTabs(),
    // ),
    NavBarModel(
      icon: Icons.ramen_dining_outlined,
      label: 'CRM',
      onTap: () {
        print('CRM Page');
        // Get.to(() => TablePage());
      },
      page: CRM(),
    ),
    NavBarModel(
      icon: Icons.handyman_outlined,
      label: 'Repair',
      onTap: () {
        print('Repair Page');
        // Get.to(() => TablePage());
      },
      page: Repair(),
    ),
    NavBarModel(
      icon: Icons.menu,
      label: 'menu_drop',
      onTap: () {
        print('Menu Page');
        // Get.to(() => AppMenuSettings());
      },
      page: AppMenuPage(),
    ),
  ];
  Widget? page;
}
