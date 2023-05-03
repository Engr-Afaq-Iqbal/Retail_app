import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/Config/utils.dart';
import '/Services/api_services.dart';
import '/Services/api_urls.dart';
import '../../Models/Notifications/NotificationShowing.dart';

class NotificationsController extends GetxController {
  NotificationShowingModel? notificationShowingModelObj;
  String notificationId = '';

  ///View All Notifications
  Future fetchNotificationsList() async {
    await ApiServices.getMethod(feedUrl: '${ApiUrls.listNotificationsAPI}')
        .then((_res) {
      if (_res == null) return null;
      notificationShowingModelObj = notificationShowingModelFromJson(_res);
      update();
    }).onError((error, stackTrace) {
      debugPrint('Error => $error');
      logger.e('StackTrace => $stackTrace');
    });
  }

  Future<bool?> notificationMarked() async {
    Map<String, String> _field = {
      "id": '${notificationId}',
    };

    return await ApiServices.postMethod(
            feedUrl: ApiUrls.notificationMarkedApi, fields: _field)
        .then((_res) {
      if (_res == null) return null;

      print('Notification marked: ');
      print(_res);
      return true;
    }).onError((error, stackTrace) {
      debugPrint('Error => $error');
      logger.e('StackTrace => $stackTrace');
      throw '$error';
    });
  }
}
