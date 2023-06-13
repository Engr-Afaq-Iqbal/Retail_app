import 'dart:convert';

import 'package:bizmodo_emenu/Pages/HomePageRetail/homepageRetail.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../Config/utils.dart';
import '../../Models/ProductsModel/SearchProductModel.dart';
import '../../Pages/Orders/Controller/OrderController.dart';
import '../ContactController/ContactController.dart';
import '/Models/ProductsModel/all_products_model.dart';
import '/Services/api_services.dart';
import '/Services/api_urls.dart';
import '/Services/storage_services.dart';
import 'package:http/http.dart' as http;

import 'PaymentController.dart';

class AllProductsController extends GetxController {
  RxBool isFetchingProduct = false.obs;
  CategoriesProductsModel? allCategoriesProductsData;
  PaymentController paymentCtrlObj = Get.find<PaymentController>();
  List<TextEditingController> productQuantityCtrl = [];
  final ContactController contactCtrlObj = Get.find<ContactController>();
  final OrderController orderCtrlObj = Get.find<OrderController>();
  //String? totalAmount;
  List<String> totalAmount = [];
  double finalTotal = 0.00;
  String total = '0.00';

  Future<void> fetchAllProducts() async {
    isFetchingProduct.value = true;
    String? response =
        await ApiServices.getMethod(feedUrl: ApiUrls.allProducts);
    if (response == null) return;
    await AppStorage.setProductsData(response);
    getAllProductsFromStorage(res: response);
  }

  void getAllProductsFromStorage({res}) async {
    allCategoriesProductsData = AppStorage.getProductsData(res: res);
    isFetchingProduct.value = false;
  }

  List<SearchProductModel>? searchProductModel;
  List<SearchProductModel>? searchProductModelFinal;

  /// Searching Product
  Future searchProductList({String? pageUrl, String? term}) async {
    await ApiServices.getMethod(
            feedUrl: pageUrl ??
                '${ApiUrls.searchProductListApi}?location_id=${AppStorage.getBusinessDetailsData()?.businessData?.locations.first.id}&term=${term}') //
        .then((_res) {
      update();
      if (_res == null) return null;
      searchProductModel = searchProductModelFromJson(_res);
      var length = searchProductModel?.length ?? 0;
      for (int i = 0; i < length; i++) {
        productQuantityCtrl.add(TextEditingController());
        totalAmount.add('0.00');
      }
      update();
    }).onError((error, stackTrace) {
      debugPrint('Error => $error');
      logger.e('StackTrace => $stackTrace');
      update();
    });
  }

  calculateFinalAmount() {
    finalTotal = 0.00;
    for (int i = 0; i < totalAmount.length; i++) {
      finalTotal = double.parse('${totalAmount[i]}') + finalTotal;
    }
    print('final Total = ${finalTotal}');
  }

  ///Function to create order:::::
  orderCreate() async {
    // if (orderCtrlObj.singleOrderData?.id == null) {
    //   showToast('Reference for update order is missing!');
    //   return;
    // }

    /// Working with 2nd approach
    multipartPutMethod();
  }

  multipartPutMethod() async {
    // API Method with url

    String _url = '${ApiUrls.createOrder}';
    var length = searchProductModel?.length ?? 0;
    /*
    Approach 2 (Multipart Request simple )
    */

    Map<String, String> _fields = {};
    _fields['transaction_date'] = '${DateTime.now()}';
    _fields['contact_id'] = '${contactCtrlObj.id}';
    _fields['service_staff_id'] =
        '${AppStorage.getLoggedUserData()?.staffUser.id}';
    _fields['created_by'] = '${AppStorage.getLoggedUserData()?.staffUser.id}';

    _fields['status'] = 'final';
    _fields['type'] = 'sell';
    _fields['discounttype'] = 'fixed';
    _fields['discount_amount'] = '0';
    _fields['tax_id'] = '13';
    _fields['final_total'] = '${finalTotal}';
    _fields['exchange_rate'] = '0.00';
    _fields['packing_charge'] = '0.00';
    _fields['packing_charge_type'] = 'fixed';
    _fields['business_id'] =
        '${AppStorage.getBusinessDetailsData()?.businessData?.id ?? AppStorage.getLoggedUserData()?.staffUser.businessId}';
    _fields['location_id'] =
        '${AppStorage.getBusinessDetailsData()?.businessData?.locations.first.id ?? AppStorage.getLoggedUserData()?.staffUser.locationId}';
    _fields['shipping_charges'] = '0';
    _fields['is_suspend'] = '0';
    _fields['total_before_tax'] = '0.00';
    // request.fields['discount_type'] = 'Fixed';
    _fields['tax_amount'] = '0.00';
    _fields['discount_amount'] = '0.00';
    if (searchProductModel != null)
      for (int i = 0; i < length; i++) {
        if (productQuantityCtrl[i].text.isNotEmpty) {
          _fields['product_id[$i]'] = '${searchProductModel?[i].productId}';
          _fields['variation_id[$i]'] = '${searchProductModel?[i].variationId}';
          _fields['quantity[$i]'] = '${productQuantityCtrl[i].text}';
          _fields['line_discount_type[$i]'] = 'fixed';
          _fields['unit_price_before_discount[$i]'] = '0.00';
          _fields['unit_price[$i]'] = '0.00';
          _fields['unit_price_inc_tax[$i]'] = '0.00';
          _fields['item_tax[$i]'] = '0.00';
        }
      }

    if (paymentCtrlObj.totalPayingAmount() == 0) {
      _fields['payment_status'] = 'due';
    } else {
      _fields['payment_status'] =
          paymentCtrlObj.totalPayingAmount() < double.parse('${finalTotal}')
              ? 'partial'
              : 'paid';
    }
    // for order suspend = due, cash = paid / partial,

    // Get.find<PaymentController>().fieldsForCheckout(request);
    /// OR
    for (int checkoutIndex = 0;
        checkoutIndex < paymentCtrlObj.paymentWidgetList.length;
        checkoutIndex++) {
      _fields['amount[$checkoutIndex]'] =
          '${paymentCtrlObj.paymentWidgetList[checkoutIndex].amountCtrl.text}';
      _fields['method[$checkoutIndex]'] =
          '${paymentCtrlObj.paymentWidgetList[checkoutIndex].selectedPaymentOption?.paymentMethod}';
      _fields['account_id[$checkoutIndex]'] =
          '${paymentCtrlObj.paymentWidgetList[checkoutIndex].selectedPaymentOption?.account?.id}';
      _fields['card_type[$checkoutIndex]'] = 'credit'; // debit

      if (paymentCtrlObj.isSelectedPaymentOptionCheque(index: checkoutIndex)) {
        _fields['cheque_number[$checkoutIndex]'] =
            '${paymentCtrlObj.paymentWidgetList[checkoutIndex].checkNoCtrl.text}';
      } else if (!paymentCtrlObj.isSelectedPaymentOptionCash(
          index: checkoutIndex)) {
        _fields['transaction_no_1[$checkoutIndex]'] =
            '${paymentCtrlObj.paymentWidgetList[checkoutIndex].transactionNoCtrl.text}';
      }

      _fields['note[$checkoutIndex]'] =
          '${paymentCtrlObj.paymentWidgetList[checkoutIndex].paymentNoteCtrl.text}';
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
      showToast('Finalize Created Successfully');
      Get.to(HomePageRetail());
      //await Get.to(() => OrderPlaced());
      // Get.offAll(HomePage());
    }).onError((error, stackTrace) {
      debugPrint('Error => $error');
      logger.e('StackTrace => $stackTrace');
      return null;
    });
  }

  // method to submit payment for sell page
  Future addPaymentForSellPage(String orderId) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${AppStorage.getUserToken()?.accessToken}'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('${ApiUrls.orderPaymentAPI}$orderId'));

    fieldsForAddPayment(request);

    logger.i(request.fields);

    request.headers.addAll(headers);

    return await request.send().then((http.StreamedResponse response) async {
      String result = await response.stream.bytesToString();
      logger.i(
          'EndPoint => ${ApiUrls.orderPaymentAPI}$orderId\nStatus Code => ${response.statusCode}\nResponse => $result');

      if (response.statusCode == 200 || response.statusCode == 201) {
        clearAllAddPaymentControllerInformation();
        // addPaymentWidget();
        Get.back(result: true);
      } else {
        final jd = jsonDecode(result);
        showToast(jd["message"]);
        return null;
      }
    }).onError((error, stackTrace) {
      debugPrint('Error => $error');
      logger.e('StackTrace => $stackTrace');
      return null;
    });
  }

  void clearAllAddPaymentControllerInformation() {
    paymentCtrlObj.amountCtrl.clear();
    paymentCtrlObj.transactionNoCtrl.clear();
    paymentCtrlObj.checkNoCtrl.clear();
    paymentCtrlObj.paymentNoteCtrl.clear();
    paymentCtrlObj.paymentAccountCtrl.clear();
    paymentCtrlObj.fileNameCtrl.clear();
    paymentCtrlObj.paymentMethodCtrl.clear();
    paymentCtrlObj.accountIdCtrl.clear();
  }

  fieldsForAddPayment(http.MultipartRequest request) {
    request.fields['amount[0]'] = '${paymentCtrlObj.amountCtrl.text}';
    request.fields['method[0]'] = '${paymentCtrlObj.paymentMethodCtrl.text}';
    // '${paymentWidgetList[checkoutIndex].selectedPaymentOption?.paymentMethod}';
    request.fields['account_id[0]'] =
        '${paymentCtrlObj.accountIdCtrl.text}'; //'27';
    // '${paymentWidgetList[checkoutIndex].selectedPaymentOption?.account?.id}';
    request.fields['card_type[0]'] = 'credit'; // debit
    request.fields['transaction_no_1[0]'] =
        '${paymentCtrlObj.transactionNoCtrl.text}';

    // if (isSelectedPaymentOptionCheque(index: checkoutIndex)) {
    //   request.fields['cheque_number[$checkoutIndex]'] =
    //       '${paymentWidgetList[checkoutIndex].checkNoCtrl.text}';
    // } else if (!isSelectedPaymentOptionCash(index: checkoutIndex)) {
    //   request.fields['transaction_no_1[$checkoutIndex]'] =
    //       '${paymentWidgetList[checkoutIndex].transactionNoCtrl.text}';
    // }

    request.fields['note[0]'] = '${paymentCtrlObj.paymentNoteCtrl.text}';
  }
}
