import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../Config/utils.dart';
import '../../Models/AllSalesModel/specifiedSellModel.dart';
import '../../Models/NavBarModel.dart';
import '../../Models/order_type_model/SaleOrderModel.dart';
import '../../Pages/SalesView/ListQuotations/listQuotations.dart';
import '../../Pages/SalesView/SalesViewDetails/SalesView.dart';
import '../../Services/api_services.dart';
import '../../Services/api_urls.dart';
import '../ContactController/ContactController.dart';

enum SalesTabsPage {
  Sales,
  Quotation,
}

class AllSalesController extends GetxController {
  String? paymentStatusValue;
  String? paymentAccountStatusValue;
  bool salesAndQuotStatus = false;
  TextEditingController searchCtrl = TextEditingController();
  TextEditingController dateCtrl = TextEditingController();
  TextEditingController productNameCtrl = TextEditingController();
  TextEditingController qtyCtrl = TextEditingController();
  TextEditingController priceCtrl = TextEditingController();
  TextEditingController totalCtrl = TextEditingController();
  TextEditingController remarksCtrl = TextEditingController();
  TextEditingController searchReceiptCtrl = TextEditingController();
  final ContactController contactCtrlObj = Get.find<ContactController>();
  // order screen pagination flags
  int allSaleOrdersPage = 1;
  bool isFirstLoadRunning = true;
  bool hasNextPage = true;
  RxBool isLoadMoreRunning = false.obs;

  static List<NavBarModel> stockTabsList() => [
        NavBarModel(
          identifier: SalesTabsPage.Sales,
          icon: 'Icons.order',
          label: 'All Sales',
          page: SalesView(), //StockTransfer(),
        ),
        NavBarModel(
          identifier: SalesTabsPage.Quotation,
          icon: 'Icons.order',
          label: 'List Quotations',
          page: ListQuotations(),
        ),
      ];

  List<String> getPaymentMethodsItems() {
    List<String> options = [
      'Advance',
      'Cash',
      'Visa',
      'Free',
      'Online Payment'
    ];
    // for (int i = 0;
    // i < widget.listUserCtrlObj!.listuserModel!.data!.length;
    // i++) {
    //   options.add(
    //       '${widget.listUserCtrlObj?.listuserModel?.data?[i].firstName} ${widget.listUserCtrlObj?.listuserModel?.data?[i].lastName == null ? '' : widget.listUserCtrlObj?.listuserModel?.data?[i].lastName}' ??
    //           '');
    // }
    return options;
  }

  List<String> getPaymentAccountsLists() {
    List<String> options = [
      'ADCB',
      'ENDB',
      'Free Complementary',
      'Cash Collect',
      'ADIB'
    ];
    // for (int i = 0;
    // i < widget.listUserCtrlObj!.listuserModel!.data!.length;
    // i++) {
    //   options.add(
    //       '${widget.listUserCtrlObj?.listuserModel?.data?[i].firstName} ${widget.listUserCtrlObj?.listuserModel?.data?[i].lastName == null ? '' : widget.listUserCtrlObj?.listuserModel?.data?[i].lastName}' ??
    //           '');
    // }
    return options;
  }

  List<String> salesSearchHeader = [
    'Product',
    'Quantity',
    'Unit Price',
    'Discount',
    'Tax',
    'Price Inc. Tax',
    'Warranty',
    'Subtotal'
  ];

  //AllSalesModel? allSalesModel;

  // /// Fetching Sales Return List
  // Future fetchAllSalesList({
  //   String? pageUrl,
  // }) async {
  //   await ApiServices.getMethod(feedUrl: pageUrl ?? '${ApiUrls.allSalesApi}')
  //       .then((_res) {
  //     update();
  //     if (_res == null) return null;
  //     allSalesModel = allSalesModelFromJson(_res);
  //     update();
  //   }).onError((error, stackTrace) {
  //     debugPrint('Error => $error');
  //     logger.e('StackTrace => $stackTrace');
  //     update();
  //   });
  // }

  // load more order page
  void loadMoreSaleOrders() async {
    logger.wtf('load more sale orders function called!');
    if (hasNextPage && !isFirstLoadRunning) {
      isLoadMoreRunning.value = true;

      allSaleOrdersPage += 1;

      await fetchAllSalesList(allSaleOrdersPage).then((bool? _isFinished) {
        if (_isFinished == null) {
          allSaleOrdersPage -= 1;
        } else if (_isFinished) {
          // This means there is no more data
          // and therefore, we will not send another request
          hasNextPage = false;
        }
      });
      isLoadMoreRunning.value = false;
    }
  }

  SaleOrderModel? allSaleOrders;
  // fetch all sale orders list
  Future<bool?> fetchAllSalesList(int _page,
      {String global_search = ''}) async {
    print('========================================');
    print('Function calling');
    return await ApiServices.getMethod(
            feedUrl:
                '${ApiUrls.allOrders}?page=$_page&per_page=20&global_search=${global_search}')
        .then((_res) {
      if (_res == null) return null;
      final _data = saleOrderModelFromJson(_res);
      if (_page > 1 && allSaleOrders != null) {
        allSaleOrders!.saleOrdersData.addAll(_data.saleOrdersData);
      } else {
        allSaleOrders = _data;
      }
      stopProgress();
      //Get.close(1);
      update();

      /* fallback end status means is all item finished or not */
      if (allSaleOrders?.meta?.lastPage != null &&
          _page == allSaleOrders?.meta?.lastPage) {
        return true;
      }

      return false;
    }).onError((error, stackTrace) {
      debugPrint('Error => $error');
      logger.e('StackTrace => $stackTrace');
      return null;
    });
  }

  // initial order page load function
  callFirstOrderPage() async {
    allSaleOrdersPage = 1;
    isFirstLoadRunning = true;
    hasNextPage = true;
    isLoadMoreRunning.value = false;
    await fetchAllSalesList(1);
    isFirstLoadRunning = false;
  }

  SpecifiedSellModel? salesOrderModel;

  /// Fetching list of Quotations
  Future fetchSellDetails({
    String? pageUrl,
    String? id,
  }) async {
    await ApiServices.getMethod(feedUrl: pageUrl ?? '${ApiUrls.allOrders}/$id')
        .then((_res) {
      update();
      if (_res == null) return null;
      salesOrderModel = specifiedSellModelFromJson(_res);
      update();
    }).onError((error, stackTrace) {
      debugPrint('Error => $error');
      logger.e('StackTrace => $stackTrace');
      update();
    });
  }

  callFirstOrderPageForReceipt() async {
    allSaleOrdersPage = 1;
    isFirstLoadRunning = true;
    hasNextPage = true;
    isLoadMoreRunning.value = false;
    await fetchAllReceiptsList(1);
    isFirstLoadRunning = false;
  }

  Future<bool?> fetchAllReceiptsList(
    int _page,
  ) async {
    print('========================================');
    print('Function calling');
    return await ApiServices.getMethod(
            feedUrl:
                '${ApiUrls.allOrders}?page=$_page&per_page=20&global_search=${contactCtrlObj.nameCtrl.text.isNotEmpty ? contactCtrlObj.nameCtrl.text : ''}')
        .then((_res) {
      if (_res == null) return null;
      final _data = saleOrderModelFromJson(_res);
      if (_page > 1 && allSaleOrders != null) {
        allSaleOrders!.saleOrdersData.addAll(_data.saleOrdersData);
      } else {
        allSaleOrders = _data;
      }
      update();

      /* fallback end status means is all item finished or not */
      if (allSaleOrders?.meta?.lastPage != null &&
          _page == allSaleOrders?.meta?.lastPage) {
        return true;
      }
      stopProgress();

      return false;
    }).onError((error, stackTrace) {
      debugPrint('Error => $error');
      logger.e('StackTrace => $stackTrace');
      return null;
    });
  }

  ///Function to create Sells:::::
  // orderCreate() async {
  //   // if (orderCtrlObj.singleOrderData?.id == null) {
  //   //   showToast('Reference for update order is missing!');
  //   //   return;
  //   // }
  //
  //   /// Working with 2nd approach
  //   multipartPutMethod();
  // }
  //
  // multipartPutMethod() async {
  //   // API Method with url
  //   // PaymentController _paymentCtrlObj = Get.find<PaymentController>();
  //   String _url = '${ApiUrls.createOrder}';
  //   //var length = searchProductModel?.length ?? 0;
  //   /*
  //   Approach 2 (Multipart Request simple )
  //   */
  //
  //   Map<String, String> _fields = {};
  //   // _fields['business_id'] =
  //   //     '${AppStorage.getBusinessDetailsData()?.businessData?.id ?? AppStorage.getLoggedUserData()?.staffUser.businessId}';
  //   _fields['location_id'] =
  //       '${AppStorage.getBusinessDetailsData()?.businessData?.locations.first.id ?? AppStorage.getLoggedUserData()?.staffUser.locationId}';
  //   _fields['contact_id'] = '${contactCtrlObj.id}';
  //   _fields['transaction_date'] = '${DateTime.now()}';
  //   // _fields['invoice_no'] = '13';
  //   _fields['status'] = 'final';
  //   _fields['is_quotation'] = '${salesAndQuotStatus}';
  //   _fields['service_staff_id'] =
  //       '${AppStorage.getLoggedUserData()?.staffUser.id}';
  //
  //   _fields['discount_type'] = 'fixed';
  //   _fields['discount_amount'] = '0';
  //
  //   _fields['tax_rate_id'] = '13';
  //   _fields['sale_note'] = '';
  //
  //   _fields['created_by'] = '${AppStorage.getLoggedUserData()?.staffUser.id}';
  //
  //   _fields['type'] = 'sell';
  //
  //   _fields['final_total'] = '${finalTotal}';
  //   _fields['exchange_rate'] = '0.00';
  //   _fields['packing_charge'] = '0.00';
  //   _fields['packing_charge_type'] = 'fixed';
  //   _fields['shipping_charges'] = '0';
  //   _fields['is_suspend'] = '0';
  //   _fields['total_before_tax'] = '0.00';
  //   // request.fields['discount_type'] = 'Fixed';
  //   _fields['tax_amount'] = '0.00';
  //   _fields['discount_amount'] = '0.00';
  //   if (searchProductModel != null)
  //     for (int i = 0; i < length; i++) {
  //       if (productQuantityCtrl[i].text.isNotEmpty) {
  //         _fields['product_id[$i]'] = '${searchProductModel?[i].productId}';
  //         _fields['variation_id[$i]'] = '${searchProductModel?[i].variationId}';
  //         _fields['quantity[$i]'] = '${productQuantityCtrl[i].text}';
  //         _fields['line_discount_type[$i]'] = 'fixed';
  //         _fields['unit_price_before_discount[$i]'] = '0.00';
  //         _fields['unit_price[$i]'] = '0.00';
  //         _fields['unit_price_inc_tax[$i]'] = '0.00';
  //         _fields['item_tax[$i]'] = '0.00';
  //       }
  //     }
  //
  //   // if (_paymentCtrlObj.totalPayingAmount() == 0) {
  //   //   _fields['payment_status'] = 'due';
  //   // } else {
  //   //   _fields['payment_status'] =
  //   //       _paymentCtrlObj.totalPayingAmount() < double.parse('${finalTotal}')
  //   //           ? 'partial'
  //   //           : 'paid';
  //   // }
  //   // // for order suspend = due, cash = paid / partial,
  //   //
  //   // // Get.find<PaymentController>().fieldsForCheckout(request);
  //   // /// OR
  //   // for (int checkoutIndex = 0;
  //   //     checkoutIndex < _paymentCtrlObj.paymentWidgetList.length;
  //   //     checkoutIndex++) {
  //   //   _fields['amount[$checkoutIndex]'] =
  //   //       '${_paymentCtrlObj.paymentWidgetList[checkoutIndex].amountCtrl.text}';
  //   //   _fields['method[$checkoutIndex]'] =
  //   //       '${_paymentCtrlObj.paymentWidgetList[checkoutIndex].selectedPaymentOption?.paymentMethod}';
  //   //   _fields['account_id[$checkoutIndex]'] =
  //   //       '${_paymentCtrlObj.paymentWidgetList[checkoutIndex].selectedPaymentOption?.account?.id}';
  //   //   _fields['card_type[$checkoutIndex]'] = 'credit'; // debit
  //   //
  //   //   if (_paymentCtrlObj.isSelectedPaymentOptionCheque(index: checkoutIndex)) {
  //   //     _fields['cheque_number[$checkoutIndex]'] =
  //   //         '${_paymentCtrlObj.paymentWidgetList[checkoutIndex].checkNoCtrl.text}';
  //   //   } else if (!_paymentCtrlObj.isSelectedPaymentOptionCash(
  //   //       index: checkoutIndex)) {
  //   //     _fields['transaction_no_1[$checkoutIndex]'] =
  //   //         '${_paymentCtrlObj.paymentWidgetList[checkoutIndex].transactionNoCtrl.text}';
  //   //   }
  //   //
  //   //   _fields['note[$checkoutIndex]'] =
  //   //       '${_paymentCtrlObj.paymentWidgetList[checkoutIndex].paymentNoteCtrl.text}';
  //   // }
  //
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
  //     print('Sells created successfully');
  //     showToast('Sells Created Successfully');
  //     Get.close(2);
  //     //await Get.to(() => OrderPlaced());
  //     // Get.offAll(HomePage());
  //   }).onError((error, stackTrace) {
  //     debugPrint('Error => $error');
  //     logger.e('StackTrace => $stackTrace');
  //     return null;
  //   });
  // }
}
