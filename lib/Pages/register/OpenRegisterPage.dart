import 'package:bizmodo_emenu/Pages/HomePageRetail/homepageRetail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Components/custom_circular_button.dart';
import '../../Controllers/AuthController/auth_controller.dart';
import '/Components/textfield.dart';

import '/Controllers/register/RegisterController.dart';

import 'BusinessLocationSelection.dart';

class OpenRegisterPage extends StatelessWidget {
  OpenRegisterPage({Key? key}) : super(key: key);

  final GlobalKey<FormState> registerOpenFormKey = GlobalKey<FormState>();
  final RegisterController regCtrlObj = Get.find<RegisterController>();

  @override
  Widget build(BuildContext context) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isPortrait
                      ? 15
                      : MediaQuery.of(context).size.width * 0.35,
                ),
                child: Form(
                  key: registerOpenFormKey,
                  child: Column(
                    children: [
                      AppFormField(
                        keyboardType: TextInputType.number,
                        labelText: 'cash_in_hand'.tr,
                        validator: (String? v) {
                          if (v!.isEmpty) return 'cash_in_hand_required'.tr;
                          return null;
                        },
                        title: 'cash_in_hand'.tr,
                        controller: regCtrlObj.cashInHandCtrl,
                      ),
                      AppFormField(
                        readOnly: true,
                        labelText: 'business_location'.tr,
                        validator: (String? v) {
                          if (v!.isEmpty)
                            return 'business_location_required'.tr;
                          return null;
                        },
                        title: 'business_location'.tr,
                        controller: regCtrlObj.businessLocationCtrl,
                        onTap: (regCtrlObj.isBusinessLocationsMoreThenOne())
                            ? () {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: Text('select_location'.tr),
                                    content: BusinessLocationSelection(),
                                  ),
                                );
                              }
                            : null,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: CustomButton(
                          btnTxtAxisSize: MainAxisSize.min,
                          padding: const EdgeInsets.all(25),
                          onTap: () {
                            if (!registerOpenFormKey.currentState!.validate())
                              return;
                            regCtrlObj.openTheRegister().then((value) {
                              if (value) {
                                Get.off(() => HomePageRetail());
                              }
                            });
                          },
                          btnTxt: 'open_register'.tr,
                          bgColor: Theme.of(context).primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: CustomButton(
              btnTxtAxisSize: MainAxisSize.min,
              onTap: () => Get.find<AuthController>().logout(),
              btnTxt: 'logout'.tr,
            ),
          ),
        ],
      ),
    );
  }
}
