import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../Config/utils.dart';
import '../../Models/order_type_model/SaleOrderModel.dart';
import '../../Services/api_services.dart';
import '../../Services/api_urls.dart';
import '../../Services/storage_services.dart';
import '../AllSalesController/allSalesController.dart';

class ReceiptsController extends GetxController {
  String totalAmount = '0';
  SaleOrderModel? order;
  void markUnMarkOrder(SaleOrderDataModel orderSellLine, {int? index}) {
    // --------------------- is item cooked or not condition with popup
    // if (!isItCooked(index: index)) {
    //   showToast('Item is not Cooked yet!');
    //   return;
    // }

    orderSellLine.isSelected = !orderSellLine.isSelected;
    if (orderSellLine.isSelected == true) {
      totalAmount =
          '${double.parse(totalAmount) + double.parse(orderSellLine.finalTotal!)}';
      listSaleOrderDataModel?.add(orderSellLine);
      print(listSaleOrderDataModel);
    } else if (orderSellLine.isSelected == false) {
      totalAmount =
          '${double.parse(totalAmount) - double.parse(orderSellLine.finalTotal!)}';
    }
    print(orderSellLine.isSelected);
    print(totalAmount);
    update();
  }

  SaleOrderDataModel? singleOrderData;
  List<SaleOrderDataModel>? listSaleOrderDataModel;
  markUnMarkAllOrder() {
    // listSaleOrderDataModel
    //     ?.forEach((element) => element.isSelected = !element.isSelected);
    if (listSaleOrderDataModel != null) {
      for (int i = 0; i < listSaleOrderDataModel!.length; i++) {
        listSaleOrderDataModel?[i].isSelected =
            !listSaleOrderDataModel![i].isSelected;
        totalAmount =
            '${double.parse(totalAmount) + double.parse(listSaleOrderDataModel?[i].finalTotal ?? '0')}';
        print(totalAmount);
      }
    }

    print(totalAmount);
    update();
  }

  addReceipt() async {
    // if (orderCtrlObj.singleOrderData?.id == null) {
    //   showToast('Reference for update order is missing!');
    //   return;
    // }

    /// Working with 2nd approach
    multipartPutMethod();
  }

  multipartPutMethod() async {
    // API Method with url
    // PaymentController _paymentCtrlObj = Get.find<PaymentController>();
    AllSalesController allSalesCtrl = Get.find<AllSalesController>();
    String _url = '${ApiUrls.createSaleReturnApi}';
    var length = allSalesCtrl.allSaleOrders?.saleOrdersData.length ?? 0;

    // 'card_number': '',
    // 'card_holder_name': '',
    // 'card_transaction_number': '',
    // 'card_type': 'credit',
    // 'card_month': '',
    // 'card_year': '',
    // 'card_security': '',
    // 'cheque_number': '',
    // 'bank_account_number': '',
    // 'transaction_no_1': '',
    // 'transaction_no_2': '',
    // 'transaction_no_3': '',
    // 'transaction_no_4': '',
    // 'transaction_no_5': '',
    // 'transaction_no_6': '',
    // 'transaction_no_7': '',
    // 'is_return': '0',
    // 'paid_on': '2023-06-15 21:43:43',
    // 'created_by': '1539',
    // 'payment_ref_no': '',
    // 'amount': '30.4800',
    // 'account_id': '35'

    Map<String, String> _fields = {};
    for (int i = 0; i < length; i++) {
      if (allSalesCtrl.allSaleOrders?.saleOrdersData[i].isSelected != false)
        _fields['transaction_id[$i]'] =
            '${allSalesCtrl.allSaleOrders?.saleOrdersData[i].id}';
      print('${allSalesCtrl.allSaleOrders?.saleOrdersData[i].id}');
    }

    _fields['method'] = 'cash';
    _fields['note'] = 'test';
    _fields['card_type'] = 'credit';
    _fields['is_return'] = '0';
    _fields['paid_on'] = '2023-06-25 21:43:43';
    _fields['created_by'] = '${AppStorage.getLoggedUserData()?.staffUser.id}';
    _fields['amount'] = '$totalAmount';
    _fields['account_id'] = '35';

    logger.i(_fields);

    // return await request.send().then((response) async {
    //   String result = await response.stream.bytesToString();
    return await ApiServices.postMethod(feedUrl: _url, fields: _fields)
        .then((response) async {
      // logger.i('EndPoint => ${_url}'
      //     '\nStatus Code => {response.statusCode}'
      //     '\nResponse => $response');

      if (response == null) return;
      stopProgress();
      Get.close(1);
      //await Get.to(() => OrderPlaced());
      // Get.offAll(HomePage());
    }).onError((error, stackTrace) {
      debugPrint('Error => $error');
      logger.e('StackTrace => $stackTrace');
      return null;
    });
  }
}
