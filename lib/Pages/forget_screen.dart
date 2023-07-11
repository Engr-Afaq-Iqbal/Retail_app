import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/Components/custom_circular_button.dart';
import '/Components/textfield.dart';
import '/Config/const.dart';

class ForgetPasswordScreen extends StatelessWidget {
  ForgetPasswordScreen({Key? key}) : super(key: key);
  final TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back, color: Colors.black),
        ),
        // title: FadedScaleAnimation(
        //   child: SizedBox(
        //       height: 50,
        //       child: Image(image: AssetImage(AppImages.retailIcon))),
        //   fadeDuration: const Duration(milliseconds: 400),
        // ),
      ),
      body: SizedBox(
        height: Get.height,
        width: Get.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FadedScaleAnimation(
              child: Container(
                // width: 100,
                // height: 100,
                child: Image(image: AssetImage(AppImages.retailLogo)),
              ),
              fadeDuration: const Duration(milliseconds: 200),
            ),
            SizedBox(
              width: 300,
              child: AppFormField(
                labelText: 'user'.tr,
                validator: (String? v) {
                  if (v!.isEmpty) return 'user_name_required'.tr;
                  return null;
                },
                title: 'user_name'.tr,
                controller: textEditingController,
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.only(left: 50, right: 50),
              child: CustomButton(
                borderRadius: 10,
                onTap: () {},
                title: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    'submit'.tr,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
