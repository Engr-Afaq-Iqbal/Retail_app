import 'package:animation_wrappers/Animations/faded_scale_animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '/Pages/Tabs/Controllers/BottomNavBarController.dart';
import '/Theme/colors.dart';
import '../../../Config/const.dart';
import '../../../Controllers/OrderController/order_type_controller.dart';
import '../../Notifications/notifications.dart';

class TabsPage extends StatefulWidget {
  const TabsPage({Key? key}) : super(key: key);

  @override
  State<TabsPage> createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage> {
  @override
  void initState() {
    Get.find<OrderTypeSelectionController>().fetchOrderTypes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(builder: (BottomNavBarController _bottomNavBarCtrlObj) {
      return WillPopScope(
        onWillPop: () async {
          if (_bottomNavBarCtrlObj.selectedNavBarIndex != 0) {
            _bottomNavBarCtrlObj.selectedNavBarIndex = 0;
            return false;
          } else {
            /// TODO: Double back press to exit app
            return true;
          }
        },
        child: Scaffold(
          /// if selected nav bar index is 3 which means setting selected, the app bar will hide.
          appBar: _bottomNavBarCtrlObj.selectedNavBarIndex != (0)
              ? AppBar(
                  centerTitle: true,
                  title: FadedScaleAnimation(
                    SizedBox(
                      height: kBottomNavigationBarHeight,
                      child: Image(image: AssetImage(AppImages.eMenuLogo)),
                    ),
                    durationInMilliseconds: 400,
                  ),
                  actions: [
                    // IconButton(
                    //   onPressed: () => Get.to(() => Notifications()),
                    //   icon: Icon(
                    //     Icons.notifications_active_outlined,
                    //     color: primaryColor,
                    //   ),
                    // ),
                  ],
                )
              : null,
          body: _bottomNavBarCtrlObj
              .bottomNavBarData[_bottomNavBarCtrlObj.selectedNavBarIndex].page,
          bottomNavigationBar: GNav(
            gap: 2,
            tabBackgroundColor: Colors.grey.withOpacity(0.2),
            activeColor: primaryColor,
            tabMargin: const EdgeInsets.all(5),
            color: primaryColor.withOpacity(0.5),
            padding: const EdgeInsets.all(10),
            backgroundColor: Colors.white,
            selectedIndex: _bottomNavBarCtrlObj.selectedNavBarIndex,
            tabs: _bottomNavBarCtrlObj.bottomNavBarData.map(
              (_navData) {
                return GButton(
                  icon: _navData.icon,
                  text: _navData.label.tr,
                  onPressed: () {
                    _bottomNavBarCtrlObj.selectedNavBarIndex =
                        _bottomNavBarCtrlObj.bottomNavBarData.indexOf(_navData);
                    if (_navData.onTap != null) {
                      _navData.onTap!();
                    }
                  },
                );
              },
            ).toList(),
          ),
        ),
      );
    });
  }
}
