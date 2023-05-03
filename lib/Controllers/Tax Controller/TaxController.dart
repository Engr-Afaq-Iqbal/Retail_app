import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/Config/utils.dart';
import '/Models/TaxModel/taxModel.dart';
import '/Services/api_services.dart';
import '/Services/api_urls.dart';

class TaxController extends GetxController {
  ListTaxModel? listTaxModel;

  /// Fetching All Tax List
  Future fetchListTax({String? pageUrl}) async {
    await ApiServices.getMethod(feedUrl: pageUrl ?? ApiUrls.listTaxAPI)
        .then((_res) {
      update();
      if (_res == null) return null;
      listTaxModel = listTaxModelFromJson(_res);
      update();
    }).onError((error, stackTrace) {
      debugPrint('Error => $error');
      logger.e('StackTrace => $stackTrace');
      update();
    });
  }
}
