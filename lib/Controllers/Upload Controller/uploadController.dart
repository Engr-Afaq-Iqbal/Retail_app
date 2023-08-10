import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../Config/utils.dart';
import '../../Services/api_services.dart';
import '../../Services/api_urls.dart';
// import 'package:http/http.dart' as http;

class UploadController extends GetxController {
  File? image;

  ///function to create Sale Return
  addImage() async {
    String _url = '${ApiUrls.uploadApi}';

    Map<String, String> _fields = {};
    _fields['file'] = '${image?.path}';

    logger.i(_fields);

    return await ApiServices.postMultiPartQuery(feedUrl: _url, files: _fields)
        .then((response) {
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
