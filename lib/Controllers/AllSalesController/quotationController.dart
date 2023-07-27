import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../Config/utils.dart';
import '../../Models/QuotationModel/listQuotationModel.dart';
import '../../Models/QuotationModel/showDetailsQuotationModel.dart';
import '../../Services/api_services.dart';
import '../../Services/api_urls.dart';
import '../../Services/storage_services.dart';
import '../exception_controller.dart';

class QuotationController extends GetxController {
  TextEditingController startDateCtrl = TextEditingController();
  TextEditingController endDateCtrl = TextEditingController();
  ListQuotationModel? listQuotationModel;

  /// Fetching list of Quotations
  Future fetchListQuotations(
      {String? pageUrl, String? start_date, String? end_date}) async {
    await ApiServices.getMethod(
            feedUrl: pageUrl ??
                '${ApiUrls.listQuotationApi}?is_quotation=1&start_date=${start_date}&end_date=${end_date}&location_id=${AppStorage.getBusinessDetailsData()?.businessData?.locations.first.id ?? AppStorage.getLoggedUserData()?.staffUser.locationId}&created_by=${AppStorage.getLoggedUserData()?.staffUser.id}')
        .then((_res) {
      update();
      if (_res == null) return null;
      listQuotationModel = listQuotationModelFromJson(_res);
      stopProgress();
      update();
    }).onError((error, stackTrace) async {
      debugPrint('Error => $error');
      logger.e('StackTrace => $stackTrace');
      await ExceptionController().exceptionAlert(
        errorMsg: '$error',
        exceptionFormat: ApiServices.methodExceptionFormat(
            'POST', ApiUrls.unitListApi, error, stackTrace),
      );
      update();
    });
  }

  ShowDetailsQuotationModel? showDetailsQuotationModel;

  /// Fetching list of Quotations
  Future fetchShowDetailsQuotations({
    String? pageUrl,
    String? id,
  }) async {
    await ApiServices.getMethod(
            feedUrl: pageUrl ?? '${ApiUrls.showDetailsQuotationApi}/$id')
        .then((_res) {
      update();
      if (_res == null) return null;
      showDetailsQuotationModel = showDetailsQuotationModelFromJson(_res);
      update();
    }).onError((error, stackTrace) async {
      debugPrint('Error => $error');
      logger.e('StackTrace => $stackTrace');
      await ExceptionController().exceptionAlert(
        errorMsg: '$error',
        exceptionFormat: ApiServices.methodExceptionFormat(
            'POST', ApiUrls.unitListApi, error, stackTrace),
      );
      update();
    });
  }
}
