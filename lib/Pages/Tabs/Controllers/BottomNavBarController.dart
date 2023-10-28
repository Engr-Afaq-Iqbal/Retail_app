import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/Models/NavBarModel.dart';
import '/Pages/AppMenu/AppMenuPage.dart';
import '/Pages/Orders/View/OrdersTabPage.dart';
import '../../HomePageRetail/homepageRetail.dart';

class BottomNavBarController extends GetxController {
  int _selectedNavBarIndex = 0;

  // NavBar Selection Update
  int get selectedNavBarIndex => _selectedNavBarIndex;
  set selectedNavBarIndex(int _ind) {
    _selectedNavBarIndex = _ind;
    update();
  }
   _showMoreBottomSheet(BuildContext context) async{
    await Get.bottomSheet(
      Container(
        color: Colors.red,
        // height: Get.height * 0.5,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'This is a Get Bottom Sheet',
            style: TextStyle(fontSize: 18.0),
          ),
        ),
      ),
      barrierColor: Colors.black.withOpacity(0.5), // Optional
      isDismissible: true, // Optional
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ), // Optional
    );
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
      icon: Icons.menu,
      label: 'menu_drop',
      onTap: () {
        print('Menu Page');
        // Get.to(() => AppMenuSettings());
      },
      page: AppMenuPage(),
    ),
  ];
}
