import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/Components/custom_circular_button.dart';
import '/Config/const.dart';
import '/Theme/colors.dart';

class OrderPlaced extends StatefulWidget {
  @override
  _OrderPlacedState createState() => _OrderPlacedState();
}

class _OrderPlacedState extends State<OrderPlaced> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FadedSlideAnimation(
        SafeArea(
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'weMustSay'.tr,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'youveGreatChoiceOfTaste'.tr,
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          fontSize: 20,
                          letterSpacing: 1,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Spacer(
                  flex: 2,
                ),
                FadedScaleAnimation(
                  Container(
                    width: MediaQuery.of(context).size.height * 0.42,
                    child: Image(
                      image: AssetImage("assets/order confirmed.png"),
                    ),
                  ),
                  durationInMilliseconds: 400,
                ),
                Spacer(),
                Column(
                  children: [
                    Text(
                      'orderConfirmedWith'.tr.toUpperCase(),
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          fontSize: 13,
                          letterSpacing: 2,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueGrey.shade800),
                    ),
                    SizedBox(height: 10),
                    Image.asset(AppImages.eMenuLogo),
                  ],
                ),
                Spacer(),
                Column(
                  children: [
                    Text(
                      'yourOrderWillBeAtYourTable'.tr.toUpperCase(),
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          fontSize: 13,
                          letterSpacing: 1,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueGrey.shade800),
                    ),
                    Text(
                      'anytimeSoon'.tr.toUpperCase(),
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          fontSize: 13,
                          letterSpacing: 1,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueGrey.shade800),
                    ),
                  ],
                ),
                Spacer(),
                SizedBox(
                  width: Get.width * .2,
                  child: CustomButton(
                    onTap: () {
                      setState(() {});
                      Get.back(result: true);
                    },
                    title: Text(
                      'finish'.tr,
                      style: TextStyle(color: Colors.white),
                    ),
                    bgColor: Theme.of(context).colorScheme.primary,
                  ),
                ),
                Spacer(),
              ],
            ),
          ),
        ),
        beginOffset: Offset(0, 0.3),
        endOffset: Offset(0, 0),
        curve: Curves.linearToEaseOut,
      ),
    );
  }
}
