import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

import '../../Payment_Accounts/Payment_Account_view.dart';
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
  static List menuList = [
    MenuItem(icon:  Icons.group  , text: "User Management", onTap: () {}),
    MenuItem(icon:  Icons.contact_page_outlined , text: "Contacts", onTap: () {}),
    MenuItem(icon:  Icons.settings_input_antenna_outlined , text: "CRM", onTap: () {}),
    MenuItem(icon:  Icons.note_add_outlined  , text: "Project Management", onTap: () {}),
    MenuItem(icon:  Icons.group  , text: "HRM", onTap: () {}),
    MenuItem(icon:  Icons.woo_commerce_outlined  , text: "WooCommerce", onTap: () {}),
    MenuItem(icon:  Icons.view_list_outlined , text: "Products", onTap: () {}),
    MenuItem(icon:  Icons.arrow_circle_down_outlined , text: "Purchase", onTap: () {}),
    MenuItem(icon:  Icons.do_not_disturb_on_outlined, text: "Expense", onTap: () {}),
    MenuItem(icon:  Icons.payment, text: "Payment Accounts", onTap: () {Get.to(PaymentAccounts());}),
    MenuItem(icon:  Icons.assessment_outlined, text: "Reports", onTap: () {}),
    MenuItem(icon:  Icons.list_alt_outlined, text: "Asset Management", onTap: () {}),
    MenuItem(icon:  Icons.settings, text: "Settings", onTap: () {}),
  ];
  static _showMoreSheet(BuildContext context) async {
    await Get.bottomSheet(
      Container(
          color: Colors.white,
          height: Get.height * 0.6,
          padding: EdgeInsets.only(left: 8.0,right: 8.0),
          child: Column(
            children: [
              GestureDetector(
                onTap: () => Get.back(),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(color: Colors.blueGrey,width: 100,child: Text(""),height: 4,),
                ),
              ),
              const SizedBox(height: 10),
              GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisExtent: 100,
                ),
                itemCount: menuList.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: menuList[index].onTap,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(menuList[index].icon,        color: Theme.of(context).colorScheme.primary,
                        ),
                        Text(
                          menuList[index].text,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 8),
                        ),
                      ],
                    ),
                  );
                },
              )
            ],
          )),
      barrierColor: Colors.black.withOpacity(0.5), // Optional
      isDismissible: true, // Optional
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ), // Optional
    );
  }

  // _showMoreBottomSheet(BuildContext context) async{
  //   await Get.bottomSheet(
  //     Container(
  //       color: Colors.red,
  //       // height: Get.height * 0.5,
  //       child: Padding(
  //         padding: EdgeInsets.all(16.0),
  //         child: Text(
  //           'This is a Get Bottom Sheet',
  //           style: TextStyle(fontSize: 18.0),
  //         ),
  //       ),
  //     ),
  //     barrierColor: Colors.black.withOpacity(0.5), // Optional
  //     isDismissible: true, // Optional
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.circular(10.0),
  //     ), // Optional
  //   );
  // }


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
      icon: Icons.menu_open_outlined,
      label: 'more_drop',
      onTap: () async {
        await _showMoreSheet(Get.context!);
        // Get.to(() => AppMenuSettings());
      },
      page: HomePageRetail(),
    ),
  ];

}
