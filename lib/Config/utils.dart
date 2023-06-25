import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '/Theme/colors.dart';

Logger logger = Logger();

showToast(String msg) async {
  await Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 16.0);
}

showProgress() {
  Get.defaultDialog(
    title: 'loading'.tr,
    content: Container(
      decoration: BoxDecoration(
          color: Colors.transparent, borderRadius: BorderRadius.circular(10)),
      child: progressIndicator(),
    ),
    barrierDismissible: true,
  );
}

Widget progressIndicator({
  double? height,
  double? width,
}) =>
    Builder(builder: (context) {
      return Center(
        child: SizedBox(
          height: height,
          width: width,
          child: CircularProgressIndicator(
            backgroundColor: Colors.grey,
            color: Theme.of(context).colorScheme.primary,
            strokeWidth: 1.5,
          ),
        ),
      );
    });

stopProgress() {
  if (Get.isDialogOpen!) Get.back();
}
