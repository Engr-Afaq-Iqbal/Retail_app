import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../Config/utils.dart';
import '../../Services/api_services.dart';
import '../../Services/api_urls.dart';
// import 'package:http/http.dart' as http;

class UploadController extends GetxController {
  File? image;

  ///Upload Function
  Future<bool?> uploadFunction() async {
    Map<String, String> _field = {
      "file": '${image?.path}',
    };
    return await ApiServices.postMethod(
            feedUrl: '${ApiUrls.uploadApi}', fields: _field)
        .then((_res) {
      if (_res == null) return null;
      update();
      stopProgress();
      // Get.back();
      print('File Uploaded successfully: ');
      print(_res);
      return true;
    }).onError((error, stackTrace) {
      debugPrint('Error => $error');
      logger.e('StackTrace => $stackTrace');
      throw '$error';
    });
  }

  ///function to create Sale Return
  addImage() async {
    /// Working with 2nd approach
    multipartPutMethod();
  }

  multipartPutMethod() async {
    String _url = '${ApiUrls.uploadApi}';

    Map<String, String> _fields = {};
    _fields['file'] = '${image?.path}';

    logger.i(_fields);

    return await ApiServices.postMethod(feedUrl: _url, fields: _fields)
        .then((response) async {
      if (response == null) return;
      stopProgress();
      Get.close(1);
    }).onError((error, stackTrace) {
      debugPrint('Error => $error');
      logger.e('StackTrace => $stackTrace');
      return null;
    });
  }
}
