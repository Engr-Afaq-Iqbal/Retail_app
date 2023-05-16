import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../Config/utils.dart';
import '../../Models/ViewStockAdjustmentModel/viewStockAdjusmentModel.dart';
import '../../Services/api_services.dart';
import '../../Services/api_urls.dart';

class StockAdjustmentController extends GetxController {
  ViewStockAdjustmentModel? viewStockAdjustmentModel;

  /// Fetching Stock Adjustment
  Future fetchStockAdjustmentList({String? pageUrl}) async {
    await ApiServices.getMethod(feedUrl: pageUrl ?? ApiUrls.viewStockAdjustment)
        .then((_res) {
      update();
      if (_res == null) return null;
      viewStockAdjustmentModel = viewStockAdjustmentModelFromJson(_res);
      update();
    }).onError((error, stackTrace) {
      debugPrint('Error => $error');
      logger.e('StackTrace => $stackTrace');
      update();
    });
  }
}
