import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp/whatsapp.dart';

import '/Components/BusinessLogoWidget.dart';
import '/Config/const.dart';
import '/Config/utils.dart';
import '/Controllers/AuthController/auth_controller.dart';
import '/Locale/settings_page.dart';
import '/Pages/terms_and_condations.dart';
import '/Services/storage_services.dart';
import '../Profile_View/profile_view.dart';
import '../ThemePage/themePage.dart';

class AppMenuPage extends StatelessWidget {
  AppMenuPage({Key? key}) : super(key: key);

  final String supportNumber = "+971504059006";
  final WhatsApp whatsApp = WhatsApp();
  final AuthController authCtrlObj = Get.find<AuthController>();
  // List menuList = [
  //   MenuItem(icon: Icons.add_card_outlined, text: "Account List", onTap: () {}),
  //   MenuItem(icon: Icons.badge_outlined, text: "Add Account", onTap: () {}),
  //   MenuItem(icon: Icons.list_outlined, text: "Expense List", onTap: () {}),
  //   MenuItem(icon: Icons.note_add_outlined, text: "Add New Expense", onTap: () {}),
  //   MenuItem(icon: Icons.list_outlined, text: "Income  List", onTap: () {}),
  //   MenuItem(icon: Icons.note_add_outlined, text: "Add New Income", onTap: () {}),
  //   MenuItem(icon: Icons.new_label_outlined, text: "New Transfer", onTap: () {}),
  //   MenuItem(icon: Icons.list_outlined, text: "Transaction List", onTap: () {}),
  //   MenuItem(icon: Icons.list_outlined, text: "Product Categories", onTap: () {}),
  //   MenuItem(icon: Icons.list_outlined, text: "Product Brands", onTap: () {}),
  //   MenuItem(icon: Icons.list_outlined, text: "Product Units", onTap: () {}),
  //   MenuItem(icon: Icons.list_outlined, text: "Product Setup", onTap: () {}),
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: FadedScaleAnimation(
          child: Text(
            'settings'.tr,
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          fadeDuration: const Duration(milliseconds: 400),
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
                    flex: 4,
                    child: Center(
                      child: SizedBox(
                        height: 100,
                        width: 140,
                        child: BusinessLogoWidget(),
                      ),
                    ),
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
                          child: Text(
                            '${AppStorage.getBusinessDetailsData()?.businessData?.locations.first.name}',
                          ),
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
                    context: context,
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
                    context: context,
                    iconData: Icons.translate_outlined,
                  ),
                  listTile(
                    onTap: () async {
                      Get.to(ThemePage());
                    },
                    title: 'change_theme'.tr,
                    context: context,
                    iconData: Icons.color_lens_outlined,
                  ),
                  listTile(
                    onTap: () async {
                      await launchWhatsApp(number: supportNumber, text: '');
                    },
                    title: 'support'.tr,
                    context: context,
                    iconData: Icons.support_outlined,
                  ),
                  listTile(
                      onTap: () {
                        Get.to(TermsAndConditions());
                      },
                      title: 'terms'.tr,
                      context: context,
                      iconData: Icons.notes_outlined),
                  listTile(
                      onTap: () async {
                        logout();
                      },
                      title: 'logout'.tr,
                      iconData: Icons.logout_outlined,
                      context: context),
                  listTile(
                      onTap: () async {
                      },
                      title: "Version : ${authCtrlObj.version}",
                      iconData: Icons.info,
                      context: context),

                  // listTile(
                  //     onTap: () async {
                  //       _showMoreBottomSheet(context);
                  //     },
                  //     title: 'more'.tr,
                  //     iconData: Icons.menu_open_outlined,
                  //     context: context),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget listTile(
      {required onTap,
      required String title,
      required IconData iconData,
      required BuildContext context}) {
    return ListTile(
      leading: Icon(
        iconData,
        color: Theme.of(context).colorScheme.primary,
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

  // _showMoreBottomSheet(BuildContext context) async {
  //   await Get.bottomSheet(
  //     Container(
  //         color: Colors.white,
  //         height: Get.height * 0.5,
  //         child: Column(
  //           children: [
  //             GestureDetector(
  //               onTap: () => Get.back(),
  //               child: Padding(
  //                 padding: const EdgeInsets.all(8.0),
  //                 child: Container(color: Colors.blueGrey,width: 100,child: Text(""),height: 4,),
  //               ),
  //             ),
  //             const SizedBox(height: 10),
  //             GridView.builder(
  //               physics: const NeverScrollableScrollPhysics(),
  //               shrinkWrap: true,
  //               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
  //                   crossAxisCount: 4,
  //                   mainAxisExtent: 100,
  //                   ),
  //               itemCount: menuList.length,
  //               itemBuilder: (context, index) {
  //                 return GestureDetector(
  //                   onTap: menuList[index].onTap,
  //                   child: Column(
  //                     crossAxisAlignment: CrossAxisAlignment.center,
  //                     mainAxisAlignment: MainAxisAlignment.center,
  //                     children: [
  //                       Icon(menuList[index].icon,        color: Theme.of(context).colorScheme.primary,
  //                       ),
  //                       Text(
  //                           menuList[index].text,
  //                       textAlign: TextAlign.center,
  //                         style: TextStyle(fontSize: 8),
  //                       ),
  //                     ],
  //                   ),
  //                 );
  //               },
  //             )
  //           ],
  //         )),
  //     barrierColor: Colors.black.withOpacity(0.5), // Optional
  //     isDismissible: true, // Optional
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.circular(10.0),
  //     ), // Optional
  //   );
  // }

  void logout() async {
    await AppStorage.box.erase();
    Get.offAll(() => Settings());
  }
}

class MenuItem {
  final IconData icon;
  final String text;
  final Function onTap;

  MenuItem({required this.icon, required this.text, required this.onTap});
}
