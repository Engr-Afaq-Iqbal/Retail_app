import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../Config/utils.dart';
import '../../Models/SaleReturn/saleReturn.dart';
import '../../Services/api_services.dart';
import '../../Services/api_urls.dart';
import '../ProductController/product_cart_controller.dart';

class SaleReturnController extends GetxController {
  bool isTrue = false;
  TextEditingController searchSalesReturn = TextEditingController();
  TextEditingController saleReturnDateCtrl = TextEditingController();
  TextEditingController returnQtyCtrl = TextEditingController();
  TextEditingController productNameCtrl = TextEditingController();
  TextEditingController transactionIdCtrl = TextEditingController();
  TextEditingController invoiceNbrCtrl = TextEditingController();
  ProductCartController productCtrlCtrlObj = Get.find<ProductCartController>();

  SaleReturnListModel? saleReturnListModel;

  /// Fetching Sales Return List
  Future fetchSalesReturnList(
      {String? pageUrl, String global_search = ''}) async {
    await ApiServices.getMethod(
            feedUrl: pageUrl ??
                '${ApiUrls.saleReturnListApi}?pagination=30&global_search=$global_search') //&global_search=$global_search
        .then((_res) {
      update();
      if (_res == null) return null;
      if (global_search.isNotEmpty) {
        stopProgress();
        Get.back();
        // isTrue = true;
        // Get.to(SalesReturn(saleReturnCtrl: _res.));
      }
      saleReturnListModel = saleReturnListModelFromJson(_res);
      update();
    }).onError((error, stackTrace) {
      debugPrint('Error => $error');
      logger.e('StackTrace => $stackTrace');
      update();
    });
  }

  ///Add Sale Returb
  Future addSaleReturn() async {
    Map<String, String> _field = {
      "transaction_id": '${transactionIdCtrl.text}',
      "invoice_no": '${invoiceNbrCtrl.text}',
      "discount_amount": '${productCtrlCtrlObj.discoutCtrl.text}',
      "discount_type": '${productCtrlCtrlObj.discountType.text}',
      "products": jsonEncode([
        {"sell_line_id": 22744, "quantity": 1, "unit_price_inc_tax": 437.5}
      ])
    };

    return await ApiServices.postMethod(
            feedUrl: ApiUrls.addSaleReturnApi, fields: _field)
        .then((_res) {
      if (_res == null) return null;

      return true;
    }).onError((error, stackTrace) {
      debugPrint('Error => $error');
      logger.e('StackTrace => $stackTrace');
      throw '$error';
    });
  }
}
