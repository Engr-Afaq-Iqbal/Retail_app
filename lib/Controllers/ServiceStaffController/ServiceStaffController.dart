import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/Services/api_services.dart';
import '/Services/api_urls.dart';
import '../../Config/utils.dart';
import '../../Models/ServiceStaffModel/ServiceStaffModel.dart';

class ServiceStaffController extends GetxController {
  //ServiceStaffController serviceStaffCtrlObj = Get.find<ServiceStaffController>();

  // ServiceStaffModel? serviceStaffModel;
  List<ServiceStaffModel>? serviceStaffModel;

  final TextEditingController serviceStaffId = TextEditingController();

  /// Fetching ServiceStaff
  // Future fetchAllServiceStaff({String? pageUrl}) async {
  //   await ApiServices.getMethod(feedUrl: pageUrl ?? ApiUrls.serviceStaffAPI).then((_res) {
  //     update();
  //     if (_res == null) return null;
  //     serviceStaffModel = serviceStaffModelFromJson(_res);
  //     // debugPrint('Response::::');
  //     // debugPrint(_res);
  //     // update();
  //   }).onError((error, stackTrace) {
  //     debugPrint('Error => $error');
  //     logger.e('StackTrace => $stackTrace');
  //     update();
  //   });
  // }

  Future fetchingServiceStaff({String? pageUrl}) async {
    await ApiServices.getMethod(feedUrl: pageUrl ?? ApiUrls.newserviceStaffAPI)
        .then((_res) {
      update();
      if (_res == null) return null;
      serviceStaffModel = serviceStaffModelFromJson(_res);
      // debugPrint('Response::::');
      // debugPrint(_res);
      // update();
    }).onError((error, stackTrace) {
      debugPrint('Error => $error');
      logger.e('StackTrace => $stackTrace');
      update();
    });
  }
}
