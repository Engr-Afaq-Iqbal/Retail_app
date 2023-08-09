import 'dart:convert';

import 'package:bizmodo_emenu/Controllers/ProductController/all_products_controller.dart';
import 'package:bizmodo_emenu/Pages/Return/return.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../Config/DateTimeFormat.dart';
import '../../Config/utils.dart';
import '../../Models/SaleReturn/editSaleReturnModel.dart';
import '../../Models/SaleReturn/saleReturn.dart';
import '../../Pages/HomePageRetail/homepageRetail.dart';
import '../../Services/api_services.dart';
import '../../Services/api_urls.dart';
import '../ProductController/product_cart_controller.dart';
import '../exception_controller.dart';

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
    }).onError((error, stackTrace) async {
      debugPrint('Error => $error');
      logger.e('StackTrace => $stackTrace');
      await ExceptionController().exceptionAlert(
        errorMsg: '$error',
        exceptionFormat: ApiServices.methodExceptionFormat(
            'POST', ApiUrls.saleReturnListApi, error, stackTrace),
      );
      update();
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
      for (int i = 0; i < length; i++) {
        returnQtyCtrl.add(TextEditingController());
        subtotal.add('0.00');
      }
      stopProgress();
      update();
    }).onError((error, stackTrace) async {
      debugPrint('Error => $error');
      logger.e('StackTrace => $stackTrace');
      await ExceptionController().exceptionAlert(
        errorMsg: '$error',
        exceptionFormat: ApiServices.methodExceptionFormat(
            'POST', ApiUrls.editSaleReturnApi, error, stackTrace),
      );
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

  ///Add Sale Returb
  // Future addSaleReturn() async {
  //   Map<String, String> _field = {
  //     "transaction_id": '${transactionIdCtrl.text}',
  //     "invoice_no": '${invoiceNbrCtrl.text}',
  //     "discount_amount": '${productCtrlCtrlObj.discoutCtrl.text}',
  //     "discount_type": '${productCtrlCtrlObj.discountType.text}',
  //     "products": jsonEncode([
  //       {"sell_line_id": 22744, "quantity": 1, "unit_price_inc_tax": 437.5}
  //     ])
  //   };
  //
  //   return await ApiServices.postMethod(
  //           feedUrl: ApiUrls.addSaleReturnApi, fields: _field)
  //       .then((_res) {
  //     if (_res == null) return null;
  //
  //     return true;
  //   }).onError((error, stackTrace) {
  //     debugPrint('Error => $error');
  //     logger.e('StackTrace => $stackTrace');
  //     throw '$error';
  //   });
  // }

  ///function to create Sale Return
  addSaleReturn() async {
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
    String _url = '${ApiUrls.createSaleReturnApi}';
    var length = editSaleReturnModelDart?.sellLines?.length ?? 0;
    /*
    Approach 2 (Multipart Request simple )
    */

    Map<String, String> _fields = {};
    _fields['transaction_id'] = '${transactionIdCtrl.text}';
    // _fields['transaction_date'] = AppFormat.dateYYYYMMDDHHMM24(DateTime.now());
    _fields['invoice_no'] = '${invoiceNbrCtrl.text}';
    _fields['discount_amount'] = '${productCtrlCtrlObj.discoutCtrl.text}';
    _fields['discount_type'] = '${productCtrlCtrlObj.discountType.text}';
    if (editSaleReturnModelDart != null)
      for (int i = 0; i < length; i++) {
        if (returnQtyCtrl[i].text.isNotEmpty) {
          _fields['sell_line_id[$i]'] =
              '${editSaleReturnModelDart?.sellLines?[i].id}';
          _fields['quantity[$i]'] = '${returnQtyCtrl[i].text}';
          _fields['unit_price_inc_tax[$i]'] =
              '${editSaleReturnModelDart?.sellLines?[i].unitPriceIncTax}';
        }
      }

    logger.i(_fields);

    // return await request.send().then((response) async {
    //   String result = await response.stream.bytesToString();
    return await ApiServices.postMethod(feedUrl: _url, fields: _fields)
        .then((response) async {
      // logger.i('EndPoint => ${_url}'
      //     '\nStatus Code => {response.statusCode}'
      //     '\nResponse => $response');

      if (response == null) return;
      // clearOnOrderPlaceSuccess();
      stopProgress();
      // print('order created successfully');
      // showToast('Finalize Created Successfully');
      clearAllFields();
      Get.close(1);
      //await Get.to(() => OrderPlaced());
      // Get.offAll(HomePage());
    }).onError((error, stackTrace) async {
      debugPrint('Error => $error');
      logger.e('StackTrace => $stackTrace');
      await ExceptionController().exceptionAlert(
        errorMsg: '$error',
        exceptionFormat: ApiServices.methodExceptionFormat(
            'POST', ApiUrls.createSaleReturnApi, error, stackTrace),
      );
      return null;
    });
  }

  clearAllFields() {
    transactionIdCtrl.clear();
    saleReturnDateCtrl.clear();
    invoiceNbrCtrl.clear();
    productCtrlCtrlObj.discoutCtrl.clear();
    productCtrlCtrlObj.discountType.clear();
    returnQtyCtrl.clear();
    editSaleReturnModelDart = null;
  }
}
