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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
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

  void logout() async {
    await AppStorage.box.erase();
    Get.offAll(() => Settings());
  }
}
