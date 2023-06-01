import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../Config/DateTimeFormat.dart';
import '../../Config/utils.dart';
import '../../Models/SaleReturn/editSaleReturnModel.dart';
import '../../Models/SaleReturn/saleReturn.dart';
import '../../Services/api_services.dart';
import '../../Services/api_urls.dart';
import '../ProductController/product_cart_controller.dart';

class SaleReturnController extends GetxController {
  bool isTrue = false;
  TextEditingController searchSalesReturn = TextEditingController();
  TextEditingController saleReturnDateCtrl = TextEditingController();
  TextEditingController productNameCtrl = TextEditingController();
  TextEditingController transactionIdCtrl = TextEditingController();
  TextEditingController invoiceNbrCtrl = TextEditingController();
  String totalReturnTax = '0.00';
  String totalAmount = '0.00';
  List<TextEditingController> returnQtyCtrl = [];
  List<String> subtotal = [];
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

  EditSaleReturnModelDart? editSaleReturnModelDart;

  /// Fetching Edit Sale Return List
  Future fetchEditSalesReturnList({String? pageUrl, String id = ''}) async {
    await ApiServices.getMethod(
            feedUrl: pageUrl ??
                '${ApiUrls.editSaleReturnApi}$id') //&global_search=$global_search
        .then((_res) {
      update();
      if (_res == null) return null;
      editSaleReturnModelDart = editSaleReturnModelDartFromJson(_res);
      var length = editSaleReturnModelDart?.sellLines?.length ?? 0;
      print('length ;::::');
      print(length);
      for (int i = 0; i < length; i++) {
        returnQtyCtrl.add(TextEditingController());
        subtotal.add('0.00');
      }
      stopProgress();
      update();
    }).onError((error, stackTrace) {
      debugPrint('Error => $error');
      logger.e('StackTrace => $stackTrace');
      update();
    });
  }

  double totalOrderedTaxAmount() {
    return 0.0;
  }

  ///Functions
  double totalTaxAmountWithDiscount(
      {ordersItemsTotalTax = 0.0,
      required SaleReturnController saleReturnCtrl}) {
    double itemsTax = 0.0;
    var length = saleReturnCtrl.editSaleReturnModelDart?.sellLines?.length ?? 0;
    print(length);
    try {
      for (int i = 0; i < length; i++) {
        print('item tx""""""""');
        print(saleReturnCtrl.editSaleReturnModelDart?.sellLines?[i].itemTax);
        print('""""""""""""""');
        itemsTax = (double.parse(saleReturnCtrl
                        .editSaleReturnModelDart?.sellLines?[i].itemTax ??
                    '0')) *
                double.parse(returnQtyCtrl[i].text) +
            itemsTax;
      }
    } catch (e) {
      logger.e('Error to calculate sub total amount => $e');
    }
    print('Items Tax:::::::::::::');
    print('${itemsTax + ordersItemsTotalTax}');
    totalReturnTax = '${itemsTax + ordersItemsTotalTax}';
    return double.parse(AppFormat.doubleToStringUpTo2('${itemsTax}') ?? '0.00');
  }

  double returnTotalAmount() {
    double itemsTotal = 0.0;
    // var length = saleReturnCtrl.editSaleReturnModelDart?.sellLines?.length ?? 0;
    // print(length);
    try {
      if (productCtrlCtrlObj.discountType.text == 'Percentage') {
        for (int i = 0; i < subtotal.length; i++) {
          itemsTotal =
              ((double.tryParse(productCtrlCtrlObj.discoutCtrl.text) ?? 0) /
                          100) *
                      (double.parse(subtotal[i])) +
                  itemsTotal;
          print('after disocunt');
        }
      } else {
        for (int i = 0; i < subtotal.length; i++) {
          itemsTotal = (double.parse(subtotal[i])) + itemsTotal;
          print('before discount');
        }
      }
    } catch (e) {
      logger.e('Error to calculate sub total amount => $e');
    }
    print('Total Amount:::::::::::::');
    print('${itemsTotal}');
    totalAmount = '${itemsTotal}';
    return double.parse(
        AppFormat.doubleToStringUpTo2('${itemsTotal}') ?? '0.00');
  }
}
