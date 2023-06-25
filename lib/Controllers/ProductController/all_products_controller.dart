import 'dart:convert';

import 'package:bizmodo_emenu/Controllers/ProductController/product_cart_controller.dart';
import 'package:bizmodo_emenu/Pages/Tabs/View/TabsPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../Config/utils.dart';
import '../../Models/ProductsModel/ListProductsModel.dart';
import '../../Models/ProductsModel/ProductShowListModel.dart';
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

  //loading more variables:
  int allSaleOrdersPage = 1;
  bool isFirstLoadRunning = true;
  bool hasNextPage = true;
  RxBool isLoadMoreRunning = false.obs;

  Future<void> fetchAllProducts() async {
    isFetchingProduct.value = true;
    String? response =
        await ApiServices.getMethod(feedUrl: ApiUrls.allProducts);
    if (response == null) return;
    await AppStorage.setProductsData(response);
    getAllProductsFromStorage(res: response);
  }

  ProductShowListModel? productShowListModel;
  Future getProductShowList({String? pageUrl}) async {
    await ApiServices.getMethod(
            feedUrl: pageUrl ??
                '${ApiUrls.productListApi}location_id=${AppStorage.getBusinessDetailsData()?.businessData?.locations.first.id ?? AppStorage.getLoggedUserData()?.staffUser.locationId}&per_page=50')
        .then((_res) {
      update();
      if (_res == null) return null;
      productShowListModel = productShowListModelFromJson(_res);
      print(productShowListModel?.data);
      update();
    }).onError((error, stackTrace) {
      debugPrint('Error => $error');
      logger.e('StackTrace => $stackTrace');
      update();
    });
  }

  // load more order page
  void loadMoreSaleOrders() async {
    logger.wtf('load more items function called!');
    //if (hasNextPage && !isFirstLoadRunning && !isLoadMoreRunning.value) {
    isLoadMoreRunning.value = true;

    allSaleOrdersPage += 1;

    await fetchCustomerName(allSaleOrdersPage).then((bool? _isFinished) {
      if (_isFinished == null) {
        allSaleOrdersPage -= 1;
      } else if (_isFinished) {
        // This means there is no more data
        // and therefore, we will not send another request
        hasNextPage = false;
      }
    });
    isLoadMoreRunning.value = false;
    // }
  }

  // fetch all sale orders list
  Future<bool?> fetchCustomerName(int _page) async {
    print('========================================');
    print('Function calling');
    return await ApiServices.getMethod(
            feedUrl:
                '${ApiUrls.productListApi}&page=$_page&location_id=${AppStorage.getBusinessDetailsData()?.businessData?.locations.first.id ?? AppStorage.getLoggedUserData()?.staffUser.locationId}&per_page=20')
        .then((_res) {
      if (_res == null) return null;
      final _data = productShowListModelFromJson(_res);
      if (_page > 1 && productShowListModel != null) {
        productShowListModel!.data?.addAll(_data.data!);
      } else {
        productShowListModel = _data;
      }
      update();

      /* fallback end status means is all item finished or not */
      if (productShowListModel?.lastPage != null &&
          _page == productShowListModel?.lastPage) {
        return true;
      }

      return false;
    }).onError((error, stackTrace) {
      debugPrint('Error => $error');
      logger.e('StackTrace => $stackTrace');
      return null;
    });
  }

  void getAllProductsFromStorage({res}) async {
    allCategoriesProductsData = AppStorage.getProductsData(res: res);
    print('get all products from storage');
    print(allCategoriesProductsData?.categories.length);
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

  // initial order page load function
  callFirstOrderPage() async {
    allSaleOrdersPage = 1;
    isFirstLoadRunning = true;
    hasNextPage = true;
    isLoadMoreRunning.value = false;
    await fetchCustomerName(1);
    isFirstLoadRunning = false;
  }

  calculateFinalAmount() {
    finalTotal = 0.00;
    for (int i = 0; i < totalAmount.length; i++) {
      finalTotal = double.parse('${totalAmount[i]}') + finalTotal;
    }
    print('final Total = ${finalTotal}');
  }

  List<String> payTermList() {
    List<String> options = ['Months', 'Days'];
    return options;
  }

  List<String> statusList() {
    List<String> options = ['Final', 'Draft', 'Quotation', 'Proforma'];
    return options;
  }

  List<String> invoiceSchemaList() {
    List<String> options = ['Default', 'Restro'];
    return options;
  }

  TextEditingController payTermCtrl = TextEditingController();
  TextEditingController dateCtrl = TextEditingController();
  String? paytermStatusValue;
  String? statusValue;
  String? invoiceSchemaStatusValue;
  ProductCartController productCtrlCtrlObj = Get.find<ProductCartController>();

  // ///Function to create order:::::
  // sellCreate() async {
  //   // if (orderCtrlObj.singleOrderData?.id == null) {
  //   //   showToast('Reference for update order is missing!');
  //   //   return;
  //   // }
  //
  //   /// Working with 2nd approach
  //   multipartSalePutMethod();
  // }
  //
  // multipartSalePutMethod() async {
  //   // API Method with url
  //
  //   String _url = '${ApiUrls.addSellApi}';
  //   var length = searchProductModel?.length ?? 0;
  //   /*
  //   Approach 2 (Multipart Request simple )
  //   */
  //
  //   Map<String, String> _fields = {};
  //
  //   _fields['location_id[0]'] =
  //       '${AppStorage.getBusinessDetailsData()?.businessData?.locations.first.id ?? AppStorage.getLoggedUserData()?.staffUser.locationId}';
  //   _fields['business_id[0]'] =
  //       '${AppStorage.getBusinessDetailsData()?.businessData?.id ?? AppStorage.getLoggedUserData()?.staffUser.businessId}';
  //   _fields['contact_id[0]'] = '552';
  //   _fields['transaction_date[0]'] = '${dateCtrl.text}';
  //   _fields['invoice_no[0]'] = '';
  //   _fields['status[0]'] = '${statusValue}';
  //   _fields['is_quotation[0]'] = 'true';
  //   _fields['tax_rate_id[0]'] = '13';
  //   _fields['discount_type[0]'] = '${productCtrlCtrlObj.discountType.text}';
  //   _fields['discount_amount[0]'] = '${productCtrlCtrlObj.discoutCtrl.text}';
  //   _fields['sale_note[0]'] = 'created from retail app';
  //   _fields['staff_note[0]'] = 'staff note';
  //   _fields['commission_agent[0]'] = '0';
  //   _fields['shipping_details[0]'] =
  //       '${productCtrlCtrlObj.shippingDetailsCtrl.text}';
  //   _fields['shipping_address[0]'] =
  //       '${productCtrlCtrlObj.shippingAddressCtrl.text}';
  //   _fields['shipping_status[0]'] =
  //       '${productCtrlCtrlObj.shippingStatusCtrl.text}';
  //   _fields['delivered_to[0]'] = '${productCtrlCtrlObj.deliveredTo.text}';
  //   _fields['shipping_charges[0]'] =
  //       '${productCtrlCtrlObj.shippingChargeCtrl.text}';
  //   _fields['packing_charge[0]'] = '0.00';
  //   _fields['exchange_rate[0]'] = '0';
  //   _fields['selling_price_group_id[0]'] = '0';
  //   _fields['pay_term_number[0]'] = '${payTermCtrl.text}';
  //   _fields['pay_term_type[0]'] = '${paytermStatusValue}';
  //   _fields['is_recurring[0]'] = '1';
  //   _fields['recur_interval[0]'] = 'months';
  //   _fields['recur_interval_type[0]'] = '0';
  //   _fields['subscription_repeat_on[0]'] = '0';
  //   _fields['subscription_no[0]'] = 'abc';
  //   _fields['recur_repetitions[0]'] = '20';
  //   _fields['rp_redeemed[0]'] = '1';
  //   _fields['rp_redeemed_amount[0]'] = '13.5';
  //   _fields['types_of_service_id[0]'] = '0.00';
  //   _fields['service_custom_field_1[0]'] = 'abc';
  //   _fields['service_custom_field_2[0]'] = 'abc';
  //   _fields['service_custom_field_3[0]'] = 'abc';
  //   _fields['service_custom_field_4[0]'] = 'abc';
  //   _fields['round_off_amount[0]'] = '0.00';
  //   _fields['table_id[0]'] = '';
  //   _fields['service_staff_id[0]'] = '1';
  //   _fields['change_return[0]'] = '0';
  //
  //   ///products details
  //   if (searchProductModel != null) {
  //     for (int i = 0; i < length; i++) {
  //       if (productQuantityCtrl[i].text.isNotEmpty) {
  //         _fields['products[product_id][$i]'] =
  //             '${searchProductModel?[i].productId}';
  //         _fields['products[variation_id][$i]'] =
  //             '${searchProductModel?[i].variationId}';
  //         _fields['products[quantity][$i]'] = '1';
  //         _fields['products[tax_rate_id][$i]'] = '13';
  //         _fields['products[discount_amount][$i]'] = '0';
  //         _fields['products[discount_type][$i]'] = 'fixed';
  //         _fields['products[sub_unit_id][$i]'] = '0';
  //         _fields['products[note][$i]'] = 'product testing';
  //       }
  //     }
  //   }
  //
  //   ///further fields
  //   _fields['products[unit_price_inc_tax][0]'] = '100';
  //   _fields['products[enable_stock][0]'] = '0';
  //   _fields['products[product_type][0]'] = 'test';
  //   _fields['products[product_unit_id][0]'] = '34';
  //   _fields['products[unit_price][0]'] = '10';
  //   _fields['products[item_tax][0]'] = '13';
  //   _fields['products[tax_id][0]'] = '13';
  //
  //   ///Payments
  //   _fields['payments[amount][0]'] = '100';
  //   _fields['payments[method][0]'] = 'cash';
  //   _fields['payments[account_id][0]'] = '2';
  //   _fields['payments[card_number][0]'] = '';
  //   _fields['payments[card_holder_name][0]'] = '';
  //   _fields['payments[card_transaction_number][0]'] = '';
  //   _fields['payments[card_type][0]'] = '';
  //   _fields['payments[card_month][0]'] = '';
  //   _fields['payments[card_year][0]'] = '';
  //   _fields['payments[card_security][0]'] = '';
  //   _fields['payments[transaction_no_1][0]'] = '';
  //   _fields['payments[transaction_no_2][0]'] = '';
  //   _fields['payments[transaction_no_3][0]'] = '';
  //   _fields['payments[bank_account_number][0]'] = '';
  //   _fields['payments[note][0]'] = '';
  //   _fields['payments[cheque_number][0]'] = '';
  //   logger.i(_fields);
  //
  //   // return await request.send().then((response) async {
  //   //   String result = await response.stream.bytesToString();
  //   return await ApiServices.postMethod(feedUrl: _url, fields: _fields)
  //       .then((response) async {
  //     // logger.i('EndPoint => ${_url}'
  //     //     '\nStatus Code => {response.statusCode}'
  //     //     '\nResponse => $response');
  //
  //     if (response == null) return;
  //     // clearOnOrderPlaceSuccess();
  //     stopProgress();
  //     showToast('Finalize Created Successfully');
  //     Get.to(HomePageRetail());
  //     //await Get.to(() => OrderPlaced());
  //     // Get.offAll(HomePage());
  //   }).onError((error, stackTrace) {
  //     debugPrint('Error => $error');
  //     logger.e('StackTrace => $stackTrace');
  //     return null;
  //   });
  // }

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

    String _url = '${ApiUrls.createOrder}'; //
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
      Get.to(TabsPage());
      //await Get.to(() => OrderPlaced());
      // Get.offAll(HomePage());
    }).onError((error, stackTrace) {
      debugPrint('Error => $error');
      logger.e('StackTrace => $stackTrace');
      return null;
    });
  }

  //// method to submit payment for sell page
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

  ///Function to create sell:::::
  sellCreate() async {
    // if (orderCtrlObj.singleOrderData?.id == null) {
    //   showToast('Reference for update order is missing!');
    //   return;
    // }

    /// Working with 2nd approach
    multipartSellPutMethod();
  }

  multipartSellPutMethod() async {
    // API Method with url

    String _url = '${ApiUrls.createOrder}'; //
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

    _fields['status'] = '${statusValue}';
    _fields['type'] = 'sell';
    _fields['discounttype'] = '${productCtrlCtrlObj.discountType.text}';
    _fields['discount_amount'] = '${productCtrlCtrlObj.discoutCtrl.text}';
    _fields['tax_id'] =
        '${AppStorage.getBusinessDetailsData()?.businessData?.taxNumber1}';
    _fields['final_total'] = '${finalTotal}';
    _fields['exchange_rate'] = '0.00';
    _fields['packing_charge'] = '0.00';
    _fields['packing_charge_type'] = 'fixed';
    _fields['business_id'] =
        '${AppStorage.getBusinessDetailsData()?.businessData?.id ?? AppStorage.getLoggedUserData()?.staffUser.businessId}';
    _fields['location_id'] =
        '${AppStorage.getBusinessDetailsData()?.businessData?.locations.first.id ?? AppStorage.getLoggedUserData()?.staffUser.locationId}';
    _fields['shipping_charges'] =
        '${productCtrlCtrlObj.shippingChargeCtrl.text}';
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
      Get.to(TabsPage());
      //await Get.to(() => OrderPlaced());
      // Get.offAll(HomePage());
    }).onError((error, stackTrace) {
      debugPrint('Error => $error');
      logger.e('StackTrace => $stackTrace');
      return null;
    });
  }

  ListProductsModel? listProductModel;

  /// Showing Product
  Future showProductList({String? pageUrl, String? term}) async {
    await ApiServices.getMethod(
            feedUrl: pageUrl ??
                '${ApiUrls.allProducts}?location_id=${AppStorage.getBusinessDetailsData()?.businessData?.locations.first.id}') //
        .then((_res) {
      update();
      if (_res == null) return null;
      listProductModel = listProductsModelFromJson(_res);
      // var length = searchProductModel?.length ?? 0;
      // for (int i = 0; i < length; i++) {
      //   productQuantityCtrl.add(TextEditingController());
      //   totalAmount.add('0.00');
      // }
      update();
    }).onError((error, stackTrace) {
      debugPrint('Error => $error');
      logger.e('StackTrace => $stackTrace');
      update();
    });
  }
}
