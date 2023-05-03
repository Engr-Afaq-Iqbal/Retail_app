import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp/whatsapp.dart';

import '/Config/const.dart';
import '/Config/utils.dart';
import '/Controllers/AuthController/auth_controller.dart';
import '/Locale/settings_page.dart';
import '/Pages/Tabs/Components/BusinessLogoWidget.dart';
import '/Pages/terms_and_condations.dart';
import '/Services/storage_services.dart';
import '../../Theme/colors.dart';
import '../Profile_View/profile_view.dart';

class AppMenuPage extends StatelessWidget {
  AppMenuPage({Key? key}) : super(key: key);

  final String supportNumber = "+971504059006";
  final WhatsApp whatsApp = WhatsApp();
  final AuthController authCtrlObj = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bottomNavigationBar: Padding(
      //   padding: EdgeInsets.symmetric(horizontal: 7, vertical: 10),
      //   child: GNav(
      //       gap: 8,
      //       tabBackgroundColor: Colors.grey.withOpacity(0.2),
      //       activeColor: primaryColor,
      //       color: primaryColor.withOpacity(0.5),
      //       padding: EdgeInsets.all(12),
      //       selectedIndex: 3,
      //       tabs: [
      //         GButton(
      //           icon: Icons.home_outlined,
      //           text: 'dashboard_drop'.tr,
      //           onPressed: () {
      //             print('Order Type Selection page');
      //             Get.to(OrderTypeSelection());
      //           },
      //         ),
      //         GButton(
      //           icon: Icons.shopping_bag_outlined,
      //           text: 'orders'.tr,
      //           onPressed: () {
      //             print('Order Page');
      //             Get.to(OrdersMain());
      //           },
      //         ),
      //         GButton(
      //           icon: Icons.table_restaurant_outlined,
      //           text: 'table_drop'.tr,
      //           onPressed: () {
      //             print('Table page');
      //             Get.to(TablePage());
      //           },
      //         ),
      //         GButton(
      //           icon: Icons.menu,
      //           text: 'menu_drop'.tr,
      //           active: true,
      //           onPressed: () {
      //             print('Menu Page');
      //
      //             Get.to(() => AppMenuSettings());
      //           },
      //         )
      //       ]),
      // ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: FadedScaleAnimation(
          Text(
            'settings'.tr,
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          durationInMilliseconds: 400,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Colors.white,
              margin: const EdgeInsets.symmetric(vertical: 10),
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: SizedBox(
                        height: 100, width: 120, child: BusinessLogoWidget()),
                  ),

                  /// TODO: Localization remaining
                  Expanded(
                    flex: 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${AppStorage.getBusinessDetailsData()?.businessData?.locations.first.name}',
                        ),
                        RichText(
                          text: TextSpan(
                            style: AppTextStyles.style12Black,
                            children: [
                              WidgetSpan(
                                  child: Icon(Icons.location_on_outlined,
                                      size: 20)),
                              TextSpan(
                                  text: authCtrlObj.businessLocationAddress())
                            ],
                          ),
                        ),
                        TextButton(
                          child: Text('restaurant_profile'.tr),
                          onPressed: () {
                            /// TODO: Catalog
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              child: Column(
                children: [
                  listTile(
                    onTap: () {
                      Get.to(() => ProfileView());
                    },
                    title: 'profile'.tr,
                    iconData: Icons.person_outlined,
                  ),
                  listTile(
                    onTap: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext ctx) {
                            return Settings(
                              allowToNaviGate: false,
                            );
                          },
                        ),
                      );
                    },
                    title: 'change_language'.tr,
                    iconData: Icons.translate_outlined,
                  ),
                  listTile(
                    onTap: () async {
                      await launchWhatsApp(number: supportNumber, text: '');
                    },
                    title: 'support'.tr,
                    iconData: Icons.support_outlined,
                  ),
                  listTile(
                      onTap: () {
                        Get.to(TermsAndConditions());
                      },
                      title: 'terms'.tr,
                      iconData: Icons.notes_outlined),
                  listTile(
                    onTap: () async {
                      logout();
                    },
                    title: 'logout'.tr,
                    iconData: Icons.logout_outlined,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget listTile(
      {required onTap, required String title, required IconData iconData}) {
    return ListTile(
      leading: Icon(
        iconData,
        color: primaryColor,
      ),
      title: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      onTap: onTap,
    );
  }

  Future<void> launchWhatsApp(
      {required String number, required String text}) async {
    final whatsappAndroid =
        Uri.parse("whatsapp://send?phone=$number&text=$text");
    try {
      await launchUrl(whatsappAndroid);
    } on Exception catch (e) {
      logger.e(e);
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }

  void logout() async {
    await AppStorage.box.erase();
    Get.offAll(() => Settings());
  }
}
