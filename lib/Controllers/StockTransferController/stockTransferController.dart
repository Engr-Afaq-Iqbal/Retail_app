import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '/Models/ViewStockTransferModel/statusListModel.dart';
import '../../Config/app_config.dart';
import '../../Config/utils.dart';
import '../../Models/NavBarModel.dart';
import '../../Models/ProductsModel/SearchProductModel.dart';
import '../../Models/ViewStockAdjustmentModel/viewStockAdjusmentModel.dart';
import '../../Models/ViewStockTransferModel/viewStockTransferModel.dart';
import '../../Pages/Stocks/ViewStockAdjustment/viewStockAdjustment.dart';
import '../../Pages/Stocks/ViewStockTransfer/viewStockTransfer.dart';
import '../../Services/api_services.dart';
import '../../Services/api_urls.dart';
import '../../Services/storage_services.dart';
import '../ProductController/all_products_controller.dart';
import '../exception_controller.dart';

enum OrderTabsPage {
  ActiveOrders,
  PastOrders,
}

class StockTransferController extends GetxController {
  String? statusValue;
  String? updateStatusValue;
  String? adjustmentTypeStatus;
  // String? locationFromStatusValue;
  String? locationToStatusValue;
  String? locationFromID;
  String? locationToID;
  TextEditingController dateCtrl = TextEditingController();
  TextEditingController searchCtrl = TextEditingController();
  TextEditingController additionalNotes = TextEditingController();
  TextEditingController totalAmountRecCtrl = TextEditingController(text: '0');
  TextEditingController reasonCtrl = TextEditingController();
  TextEditingController productNameCtrl = TextEditingController();
  List<TextEditingController> qtyCtrl = [];
  TextEditingController priceCtrl = TextEditingController();
  TextEditingController totalCtrl = TextEditingController();
  TextEditingController remarksCtrl = TextEditingController();
  TextEditingController locationFromCtrl = TextEditingController();
  List<TextEditingController> productQuantityCtrl = [];
  List<String> totalAmount = [];
  double finalTotal = 0.00;
//stock adjustment controllers
  TextEditingController additionalNotesCtrl = TextEditingController();
  String? statusAdjustmentTypeValue;
  //ending
  int allSaleOrdersPage = 1;
  bool isFirstLoadRunning = true;
  bool hasNextPage = true;
  RxBool isLoadMoreRunning = false.obs;

  AllProductsController allProdCtrl = Get.find<AllProductsController>();

  static List<NavBarModel> stockTabsList() => [
        NavBarModel(
          identifier: OrderTabsPage.ActiveOrders,
          icon: 'Icons.order',
          label: 'stock_transfer'.tr,
          page: ViewStockTransfer(), //StockTransfer(),
        ),
        NavBarModel(
          identifier: OrderTabsPage.PastOrders,
          icon: 'Icons.order',
          label: 'stock_ adjustment'.tr,
          page: ViewStockAdjustment(),
        ),
      ];

  List<String> stockSearchHeader = [
    'Product',
    'Sub Location',
    'Quantity',
    'Unit Price',
    'Subtotal',
    'Remarks',
    'Delete'
  ];

  List<String> stockViewHeader = [
    'Date',
    'Reference No',
    'Location (From)',
    'Location (To)',
    'Status',
    'Shipping Charges',
    'Total Amount',
    'Additional Notes',
    'Action',
  ];

  List<String> getAdjustmentTypeList() {
    List<String> options = ['Normal', 'Abnormal'];
    // for (int i = 0;
    // i < widget.listUserCtrlObj!.listuserModel!.data!.length;
    // i++) {
    //   options.add(
    //       '${widget.listUserCtrlObj?.listuserModel?.data?[i].firstName} ${widget.listUserCtrlObj?.listuserModel?.data?[i].lastName == null ? '' : widget.listUserCtrlObj?.listuserModel?.data?[i].lastName}' ??
    //           '');
    // }
    return options;
  }

  ///function to get Business Locations
  List<String> getBusinessLocationItems() {
    List<String> options = [];
    if (AppStorage.getBusinessDetailsData()?.businessData?.locations != null) {
      for (int i = 0;
          i <
              AppStorage.getBusinessDetailsData()!
                  .businessData!
                  .locations
                  .length;
          i++) {
        options.add(
            '${AppStorage.getBusinessDetailsData()?.businessData?.locations[i].name}');
      }
    } else {
      progressIndicator();
    }
    return options;
  }

  ViewStockTransferModel? viewStockTransferMoodel;

  /// Fetching Stock transfer
  Future fetchStockTransfersList({String? pageUrl}) async {
    await ApiServices.getMethod(
            feedUrl: pageUrl ??
                '${ApiUrls.viewStockTransfer}?per_page=20') //location_id=${AppStorage.getBusinessDetailsData()?.businessData?.locations.first.id}&
        .then((_res) {
      update();
      if (_res == null) return null;
      viewStockTransferMoodel = viewStockTransferModelFromJson(_res);
      update();
    }).onError((error, stackTrace) async {
      debugPrint('Error => $error');
      logger.e('StackTrace => $stackTrace');
      await ExceptionController().exceptionAlert(
        errorMsg: '$error',
        exceptionFormat: ApiServices.methodExceptionFormat(
            'POST', ApiUrls.viewStockTransfer, error, stackTrace),
      );
      update();
    });
  }

  List<StatusListModel>? statusListModel;

  /// Fetching Status
  Future fetchStatusList({String? pageUrl}) async {
    await ApiServices.getMethod(feedUrl: pageUrl ?? ApiUrls.statusStockTransfer)
        .then((_res) {
      update();
      if (_res == null) return null;
      statusListModel = statusListModelFromJson(_res);
      update();
    }).onError((error, stackTrace) async {
      debugPrint('Error => $error');
      logger.e('StackTrace => $stackTrace');
      await ExceptionController().exceptionAlert(
        errorMsg: '$error',
        exceptionFormat: ApiServices.methodExceptionFormat(
            'POST', ApiUrls.statusStockTransfer, error, stackTrace),
      );
      update();
    });
  }

  // load more order page
  // void loadMoreSaleOrders() async {
  //   logger.wtf('load more sale orders function called!');
  //   if (hasNextPage && !isFirstLoadRunning && !isLoadMoreRunning.value) {
  //     isLoadMoreRunning.value = true;
  //
  //     allSaleOrdersPage += 1;
  //
  //     await fetchSaleOrders(allSaleOrdersPage).then((bool? _isFinished) {
  //       if (_isFinished == null) {
  //         allSaleOrdersPage -= 1;
  //       } else if (_isFinished) {
  //         // This means there is no more data
  //         // and therefore, we will not send another request
  //         hasNextPage = false;
  //       }
  //     });
  //     isLoadMoreRunning.value = false;
  //   }
  // }

  // Future<bool?> fetchSaleOrders(int _page) async {
  //   print('========================================');
  //   print('Function calling');
  //   return await ApiServices.getMethod(
  //           feedUrl: '${ApiUrls.viewStockTransfer}?page=$_page&per_page=20')
  //       .then((_res) {
  //     if (_res == null) return null;
  //     final _data = saleOrderModelFromJson(_res);
  //     if (_page > 1 && allSaleOrders != null) {
  //       allSaleOrders!.saleOrdersData.addAll(_data.saleOrdersData);
  //     } else {
  //       allSaleOrders = _data;
  //     }
  //     update();
  //
  //     /* fallback end status means is all item finished or not */
  //     if (allSaleOrders?.meta?.lastPage != null &&
  //         _page == allSaleOrders?.meta?.lastPage) {
  //       return true;
  //     }
  //
  //     return false;
  //   }).onError((error, stackTrace) {
  //     debugPrint('Error => $error');
  //     logger.e('StackTrace => $stackTrace');
  //     return null;
  //   });
  // }

  // initial order page load function
  // callFirstOrderPage() async {
  //   allSaleOrdersPage = 1;
  //   isFirstLoadRunning = true;
  //   hasNextPage = true;
  //   isLoadMoreRunning.value = false;
  //   await fetchSaleOrders(1);
  //   isFirstLoadRunning = false;
  // }

  List<SearchProductModel> searchProductModel = [];
  // List<SearchProductModel>? searchProductModelFinal;

  /// Searching Product
  Future searchProductList({String? pageUrl, String? term}) async {
    await ApiServices.getMethod(
            feedUrl: pageUrl ??
                '${ApiUrls.searchProductListApi}?location_id=${AppStorage.getBusinessDetailsData()?.businessData?.locations.first.id}&term=${term}') //
        .then((_res) {
      update();
      if (_res == null) return null;
      searchProductModel = searchProductModelFromJson(_res);
      for (int i = 0; i < searchProductModel.length; i++) {
        productQuantityCtrl.add(TextEditingController());
        unitListStatusIds.add(searchProductModel[i].unitId.toString());
        unitListStatus.add(checkUnits(product: searchProductModel[i]));
        nestedist.add(
            addingSpecifiedUnitsInList(product: searchProductModel[i]) ?? '');

        totalAmount.add('0.00');
      }
      update();
    }).onError((error, stackTrace) async {
      debugPrint('Error => $error');
      logger.e('StackTrace => $stackTrace');
      await ExceptionController().exceptionAlert(
        errorMsg: '$error',
        exceptionFormat: ApiServices.methodExceptionFormat(
            'POST', ApiUrls.searchProductListApi, error, stackTrace),
      );
      update();
    });
  }

  List<SearchProductModel> selectedProducts = [];
  List<String> selectedQuantityList = [];
  List<String> selectedUnitsList = [];

  addSelectedItemsInList() {
    for (int i = 0; i < searchProductModel.length; i++) {
      if (productQuantityCtrl[i].text.isNotEmpty &&
          productQuantityCtrl[i].text != '0') {
        selectedProducts.add(searchProductModel[i]);
        selectedQuantityList.add(productQuantityCtrl[i].text);
        selectedUnitsList.add(unitListStatusIds[i]);
      }
    }
    print(selectedQuantityList);
  }

  calculateFinalAmount() {
    finalTotal = 0.00;
    for (int i = 0; i < totalAmount.length; i++) {
      finalTotal = double.parse('${totalAmount[i]}') + finalTotal;
    }
    print('final Total = ${finalTotal}');
  }

  checkStatusName({
    String? statusValue,
  }) {
    return statusListModel
        ?.firstWhereOrNull((i) => i.key == statusValue)
        ?.value;
  }

  checkStatusKeyName({
    String? statusValue,
  }) {
    return statusListModel
        ?.firstWhereOrNull((i) => i.value == statusValue)
        ?.key;
  }

  // checkLocationFromName({
  //   String? statusValue,
  // }) {
  //   return statusListModel
  //       ?.firstWhereOrNull((i) =>
  //           i.value ==
  //           AppStorage.getBusinessDetailsData()
  //               ?.businessData
  //               ?.locations
  //               .first
  //               .id)
  //       ?.key;
  // }

  createStockTransfer() async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${AppStorage.getUserToken()?.accessToken}'
    };
    var request = http.MultipartRequest('POST',
        Uri.parse('${AppConfig.baseUrl}${ApiUrls.createStockTransferApi}'));

    request.fields['location_id'] =
        '${AppStorage.getBusinessDetailsData()?.businessData?.locations.first.id}';
    request.fields['transaction_date'] = '${dateCtrl.text}';
    request.fields['ref_no'] = '';
    request.fields['status'] =
        '${checkStatusKeyName(statusValue: statusValue ?? 'Pending')}';
    request.fields['transfer_location_id'] = '${locationToID}';

    request.fields['final_total'] = '${finalTotal}';
    request.fields['shipping_charges'] = '0';
    request.fields['additional_notes'] = '${additionalNotes.text}';

    for (int i = 0; i < selectedProducts.length; i++) {
      if (selectedQuantityList.isNotEmpty) {
        request.fields['kitchen_id[$i]'] = '1';
        request.fields['product_id[$i]'] = '${selectedProducts[i].productId}';
        request.fields['variation_id[$i]'] =
            '${selectedProducts[i].variationId}';
        request.fields['enable_stock[$i]'] = '1';
        request.fields['quantity[$i]'] = '${selectedQuantityList[i]}';
        //   request.fields['base_unit_multiplier[$i]'] = '0';
        // request.fields['product_unit_id[$i]'] = '${allProdCtrlObj.searchProductModel?[i].}';
        // request.fields['sub_unit_id[$i]'] = '51';
        request.fields['product_unit_id[$i]'] = '${selectedUnitsList[i]}';
        request.fields['sub_unit_id[$i]'] = '${selectedUnitsList[i]}';
        request.fields['unit_price[$i]'] =
            '${selectedProducts[i].sellingPrice}';
        //request.fields['price[$i]'] = '${searchProductModel?[i].sellingPrice}';
        request.fields['remarks[$i]'] = '';
      }
    }

    logger.i(request.fields);

    request.headers.addAll(headers);

    return await request.send().then((http.StreamedResponse response) async {
      String result = await response.stream.bytesToString();
      logger.i('EndPoint => ${request.url}'
          '\nStatus Code => ${response.statusCode}'
          '\nResponse => $result');

      if (response.statusCode == 200 || response.statusCode == 201) {
        print(' successful');
        stopProgress();
        clearAllFields();
        Get.close(1);
      } else {
        final jd = jsonDecode(result);

        showToast(jd["message"]);

        return null;
      }
    }).onError((error, stackTrace) async {
      debugPrint('Error => $error');
      logger.e('StackTrace => $stackTrace');
      await ExceptionController().exceptionAlert(
        errorMsg: '$error',
        exceptionFormat: ApiServices.methodExceptionFormat(
            'POST', ApiUrls.createStockTransferApi, error, stackTrace),
      );
      return null;
    });
  }

  // updateStockTransfer({StockTransferData? stockTransferData}) async {
  //   Map<String, String> headers = {
  //     'Content-Type': 'application/json',
  //     'Accept': 'application/json',
  //     'Authorization': 'Bearer ${AppStorage.getUserToken()?.accessToken}'
  //   };
  //   var request = http.MultipartRequest(
  //       'POST',
  //       Uri.parse(
  //           '${AppConfig.baseUrl}${ApiUrls.updateStockTransferApi}${stockTransferData?.id}'));
  //
  //   request.fields['transaction_date'] =
  //       '${stockTransferData?.transactionDate}';
  //   request.fields['ref_no'] = '${stockTransferData?.refNo}';
  //   request.fields['status'] = 'completed';
  //   request.fields['shipping_charges'] =
  //       '${stockTransferData?.shippingCharges}';
  //   request.fields['additional_notes'] =
  //       '${stockTransferData?.additionalNotes}';
  //   request.fields['final_total'] = '${stockTransferData?.finalTotal}';
  //
  //   // for (int i = 0; i < selectedProducts.length; i++) {
  //   //
  //   //     request.fields['transaction_sell_lines_id[$i]'] = '';
  //   //     request.fields['product_id[$i]'] = '';
  //   //     request.fields['variation_id[$i]'] = '';
  //   //     request.fields['enable_stock[$i]'] = '';
  //   //     request.fields['quantity[$i]'] = '';
  //   //     request.fields['base_unit_multiplier[$i]'] = '';
  //   //     request.fields['product_unit_id[$i]'] = '';
  //   //     request.fields['sub_unit_id[$i]'] = '';
  //   //     request.fields['unit_price[$i]'] = '';
  //   //     request.fields['price[$i]'] = '';
  //   //     request.fields['remarks[$i]'] = '';
  //   //
  //   // }
  //
  //   logger.i(request.fields);
  //
  //   request.headers.addAll(headers);
  //
  //   return await request.send().then((http.StreamedResponse response) async {
  //     String result = await response.stream.bytesToString();
  //     logger.i('EndPoint => ${request.url}'
  //         '\nStatus Code => ${response.statusCode}'
  //         '\nResponse => $result');
  //
  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       print('successful');
  //       stopProgress();
  //       clearAllFields();
  //     } else {
  //       final jd = jsonDecode(result);
  //
  //       showToast(jd["message"]);
  //
  //       return null;
  //     }
  //   }).onError((error, stackTrace) async {
  //     debugPrint('Error => $error');
  //     logger.e('StackTrace => $stackTrace');
  //     await ExceptionController().exceptionAlert(
  //       errorMsg: '$error',
  //       exceptionFormat: ApiServices.methodExceptionFormat(
  //           'POST', ApiUrls.createStockTransferApi, error, stackTrace),
  //     );
  //     return null;
  //   });
  // }

  List<SearchProductModel> searchProductModelFinal = [];
  List<SearchProductModel>? listForStockAdjustment;

  /// Searching Product
  // Future searchProductList({String? pageUrl, String? term}) async {
  //   return await ApiServices.getMethod(
  //           feedUrl: pageUrl ??
  //               '${ApiUrls.searchProductListApi}?location_id${AppStorage.getBusinessDetailsData()?.businessData?.locations.first.id}=&term=${term}')
  //       .then((_res) {
  //     update();
  //     if (_res == null) return null;
  //     searchProductModel = searchProductModelFromJson(_res);
  //     update();
  //     return searchProductModel;
  //   }).onError((error, stackTrace) {
  //     debugPrint('Error => $error');
  //     logger.e('StackTrace => $stackTrace');
  //     function();
  //     update();
  //     return null;
  //   });
  // }

  List<TextEditingController> productNameeCtrl = [];

  ViewStockAdjustmentModel? viewStockAdjustmentModel;

  /// Fetching Stock Adjustment
  Future fetchStockAdjustmentList({String? pageUrl}) async {
    await ApiServices.getMethod(feedUrl: pageUrl ?? ApiUrls.viewStockAdjustment)
        .then((_res) {
      update();
      if (_res == null) return null;
      viewStockAdjustmentModel = viewStockAdjustmentModelFromJson(_res);
      update();
    }).onError((error, stackTrace) async {
      debugPrint('Error => $error');
      logger.e('StackTrace => $stackTrace');
      await ExceptionController().exceptionAlert(
        errorMsg: '$error',
        exceptionFormat: ApiServices.methodExceptionFormat(
            'POST', ApiUrls.viewStockAdjustment, error, stackTrace),
      );
      update();
    });
  }

  createStockAdjustment(/*{required bool isCheckout}*/) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${AppStorage.getUserToken()?.accessToken}'
    };
    var request = http.MultipartRequest('POST',
        Uri.parse('${AppConfig.baseUrl}${ApiUrls.createStockAdjustmentApi}'));

    request.fields['location_id'] =
        '${AppStorage.getBusinessDetailsData()?.businessData?.locations.first.id ?? AppStorage.getLoggedUserData()?.staffUser.locationId}';
    request.fields['transaction_date'] = '${dateCtrl.text}';
    request.fields['ref_no'] = '';
    request.fields['adjustment_type'] =
        '${adjustmentTypeStatus?.toLowerCase() ?? 'normal'}';
    request.fields['final_total'] = '${finalTotal}';
    request.fields['total_amount_recovered'] = '${totalAmountRecCtrl.text}';
    request.fields['additional_notes'] = '${reasonCtrl.text}';

    for (int i = 0; i < selectedProducts.length; i++) {
      if (selectedQuantityList.isNotEmpty) {
        request.fields['kitchen_id[$i]'] = '1';
        request.fields['product_id[$i]'] = '${selectedProducts[i].productId}';
        request.fields['variation_id[$i]'] =
            '${selectedProducts[i].variationId}';
        request.fields['enable_stock[$i]'] = '1';
        request.fields['quantity[$i]'] = '${selectedQuantityList[i]}';
        //   request.fields['base_unit_multiplier[$i]'] = '0';
        // request.fields['product_unit_id[$i]'] = '${allProdCtrlObj.searchProductModel?[i].}';
        // request.fields['sub_unit_id[$i]'] = '51';
        request.fields['unit_price[$i]'] =
            '${selectedProducts[i].sellingPrice}';
        //request.fields['price[$i]'] = '${searchProductModel?[i].sellingPrice}';
        request.fields['remarks[$i]'] = '';
      }
    }
    logger.i(request.fields);

    request.headers.addAll(headers);

    return await request.send().then((http.StreamedResponse response) async {
      String result = await response.stream.bytesToString();
      logger.i('EndPoint => ${request.url}'
          '\nStatus Code => ${response.statusCode}'
          '\nResponse => $result');

      if (response.statusCode == 200 || response.statusCode == 201) {
        debugPrint('successful');
        stopProgress();
        clearAllFields();
        Get.close(1);
      } else {
        final jd = jsonDecode(result);

        showToast(jd["message"]);

        return null;
      }
    }).onError((error, stackTrace) async {
      debugPrint('Error => $error');
      logger.e('StackTrace => $stackTrace');
      await ExceptionController().exceptionAlert(
        errorMsg: '$error',
        exceptionFormat: ApiServices.methodExceptionFormat(
            'POST', ApiUrls.createStockAdjustmentApi, error, stackTrace),
      );
      return null;
    });
  }

  Future updateStockStatus({
    String? id,
  }) async {
    Map<String, String> _field = {
      "status":
          '${checkStatusKeyName(statusValue: updateStatusValue ?? 'Pending')}',
    };

    return await ApiServices.postMethod(
            feedUrl: '${ApiUrls.updateStockTransferStatusApi}$id',
            fields: _field)
        .then((_res) {
      if (_res == null) return null;

      stopProgress();
      updateStatusValue = null;
      Get.close(1);
      return true;
    }).onError((error, stackTrace) async {
      debugPrint('Error => $error');
      logger.e('StackTrace => $stackTrace');
      await ExceptionController().exceptionAlert(
        errorMsg: '$error',
        exceptionFormat: ApiServices.methodExceptionFormat(
            'POST', ApiUrls.updateStockTransferStatusApi, error, stackTrace),
      );
      throw '$error';
    });
  }

  clearAllFields() {
    selectedProducts.clear();
    selectedQuantityList.clear();
    productQuantityCtrl.clear();
    searchProductModel.clear();
    locationFromCtrl.clear();
    statusValue = null;
    locationFromID = null;
    locationToID = null;
    locationToStatusValue = null;
    additionalNotes.clear();
    finalTotal = 0.00;
    totalAmount.clear();
    adjustmentTypeStatus = null;
    totalAmountRecCtrl.clear();
    reasonCtrl.clear();
  }

  /// Units Calculations

  List<List<String>> nestedist = [];
  List<String> unitListStatus = [];
  List<String> unitListStatusIds = [];

  checkSelectedUnitsIds({
    String? unitName,
  }) {
    return Get.find<AllProductsController>()
        .unitListModel
        ?.data
        ?.firstWhereOrNull((i) => i.shortName == unitName)
        ?.id
        .toString();
  }

  checkUnitsActualBaseMultiplier({
    String? unitName,
  }) {
    return Get.find<AllProductsController>()
            .unitListModel
            ?.data
            ?.firstWhereOrNull((i) => i.shortName == unitName)
            ?.baseUnitMultiplier ??
        '1.00';
  }

  checkUnits({
    SearchProductModel? product,
  }) {
    return Get.find<AllProductsController>()
        .unitListModel
        ?.data
        ?.firstWhereOrNull((i) => i.id == product?.unitId)
        ?.shortName;
  }

  addingSpecifiedUnitsInList({
    SearchProductModel? product,
  }) {
    List<String> names = [];
    // names.add('Pieces');
    // names.add('Plate');
    names.add(checkUnits(product: product));
    for (int i = 0; i < allProdCtrl.unitListModel!.data!.length; i++) {
      // if (unitListModel?.data?[i].baseUnitId == product?.unitId)
      if (allProdCtrl.unitListModel?.data?[i].baseUnitId != null) {
        if (product?.unitId == allProdCtrl.unitListModel?.data?[i].baseUnitId) {
          names.add(allProdCtrl.unitListModel?.data?[i].shortName ?? '');
        }
      }
    }

    return names;
    // return unitListModel?.data
    //     ?.firstWhereOrNull((i) => i.id == product?.unitId)
    //     ?.actualName;
  }
}
