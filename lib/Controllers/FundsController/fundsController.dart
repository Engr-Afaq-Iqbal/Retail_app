import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../Config/DateTimeFormat.dart';
import '../../Config/utils.dart';
import '../../Models/PaymentMethodModel/paymentAccountModel.dart';
import '../../Services/api_services.dart';
import '../../Services/api_urls.dart';

class FundsController extends GetxController {
  TextEditingController amountCtrl = TextEditingController();
  TextEditingController dateCtrl = TextEditingController();
  TextEditingController noteCtrl = TextEditingController();
  String? fromStatus;
  String? fromStatusValue;
  String? toStatus;
  String? toStatusValue;
  File? image;

  PaymentAccountModel? paymentAccountModel;

  /// Fetching Payment Accounts
  Future fetchPaymentAccountList({String? pageUrl}) async {
    await ApiServices.getMethod(feedUrl: pageUrl ?? ApiUrls.paymentAccountApi)
        .then((_res) {
      update();
      if (_res == null) return null;
      paymentAccountModel = paymentAccountModelFromJson(_res);
      update();
    }).onError((error, stackTrace) {
      debugPrint('Error => $error');
      logger.e('StackTrace => $stackTrace');
      update();
    });
  }

  List<String> paymentAccountList() {
    List<String> paymentAccountsList = [];
    var length = paymentAccountModel?.data?.length ?? 0;
    for (int i = 0; i < length; i++) {
      paymentAccountsList.add('${paymentAccountModel?.data?[i].name}' ?? '');
    }

    return paymentAccountsList;
  }

  clearAllFields() {
    fromStatus = null;
    toStatus = null;
    fromStatusValue = null;
    toStatusValue = null;
    amountCtrl.clear();
    dateCtrl.text = '${AppFormat.dateYYYYMMDDHHMM24(DateTime.now())}';
    image = null;
    noteCtrl.clear();
  }

  createFundsTransfer() async {
    // API Method with url

    String _url = '${ApiUrls.fundsTransferAPI}';
    Map<String, String> _fields = {};

    _fields['from_account'] = '${fromStatusValue}';

    _fields['to_account'] = '${toStatusValue}';
    _fields['amount'] = '${amountCtrl.text}';
    _fields['operation_date'] = '${dateCtrl.text}';
    _fields['note'] = '${noteCtrl.text}';
    _fields['document'] = '${image?.path}';

    logger.i(_fields);
    return await ApiServices.postMultiPartQuery(feedUrl: _url, fields: _fields)
        .then((response) async {
      // logger.i('EndPoint => ${_url}'
      //     '\nStatus Code => {response.statusCode}'
      //     '\nResponse => $response');

      clearAllFields();
      stopProgress();
      showToast('Finalize Created Successfully');
      Get.close(1);
    }).onError((error, stackTrace) {
      debugPrint('Error => $error');
      logger.e('StackTrace => $stackTrace');
      return null;
    });
  }
}
