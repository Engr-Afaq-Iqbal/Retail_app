import 'dart:convert';

import 'package:bizmodo_emenu/Controllers/OrderController/order_type_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../Stocks/ViewStockAdjustment/viewStockAdjustment.dart';
import '../../Stocks/ViewStockTransfer/viewStockTransfer.dart';
import '/Config/app_config.dart';
import '/Config/enums.dart';
import '/Config/utils.dart';
import '/Controllers/TableSelectionController/table_management_controller.dart';
import '/Models/NavBarModel.dart';
import '/Models/order_type_model/SaleOrderModel.dart';
import '/Models/order_type_model/SellLineModel.dart';
import '/Services/api_services.dart';
import '/Services/api_urls.dart';
import '/Services/storage_services.dart';

enum OrderTabsPage {
  ActiveOrders,
  PastOrders,
}

class OrderController extends GetxController {
  // Order Tabs List (Active Orders and Past Orders)
  static List<NavBarModel> stockTabsList() => [
        NavBarModel(
          identifier: OrderTabsPage.ActiveOrders,
          icon: 'Icons.order',
          label: 'Stock Transfer',
          page: ViewStockTransfer(), //StockTransfer(),
        ),
        NavBarModel(
          identifier: OrderTabsPage.PastOrders,
          icon: 'Icons.order',
          label: 'Stock Adjustment',
          page: ViewStockAdjustment(),
        ),
      ];

  // store all orders record
  SaleOrderModel? allSaleOrders;

  // order screen pagination flags
  int allSaleOrdersPage = 1;
  bool isFirstLoadRunning = true;
  bool hasNextPage = true;
  RxBool isLoadMoreRunning = false.obs;

  // fetch all sale orders list
  Future<bool?> fetchSaleOrders(int _page) async {
    print('========================================');
    print('Function calling');
    return await ApiServices.getMethod(
            feedUrl: '${ApiUrls.allOrders}?page=$_page&per_page=20')
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

      return false;
    }).onError((error, stackTrace) {
      debugPrint('Error => $error');
      logger.e('StackTrace => $stackTrace');
      return null;
    });
  }

  // add order data in all sale orders variables (data receive through socket)
  insertOrderDataInList(_res) {
    // logger.i(_res);

    try {
      List<SaleOrderDataModel> _data = List<SaleOrderDataModel>.from(
          (_res['items'] ?? _res['\u0000*\u0000items'])
              .map((x) => saleOrderDataModelFromJson(x)));
      if (_data.isNotEmpty) {
        allSaleOrders!.saleOrdersData.insertAll(0, _data.toList());
        update();
      }
    } catch (_e) {
      debugPrint(
          'socket event response parsing error -> insertOrderDataInList -> Error => $_e');
    }
  }

  updateOrderDataInList(_res) {
    logger.i(_res);
    List<SellLine> _sellLines =
        List<SellLine>.from(_res.map((x) => SellLine.fromJson(x)));
    if (allSaleOrders != null) {
      for (SellLine _itr in _sellLines) {
        logger.i(
            '----- Before -----\n${allSaleOrders?.saleOrdersData.firstWhereOrNull((_saleOrder) => _saleOrder.id == _itr.transactionId)?.sellLines.firstWhereOrNull((sellLine) => sellLine.id == _itr.id)?.resLineOrderStatus}');

        allSaleOrders?.saleOrdersData
            .firstWhereOrNull(
                (_saleOrder) => _saleOrder.id == _itr.transactionId)
            ?.sellLines
            .firstWhereOrNull((sellLine) => sellLine.id == _itr.id)
          ?..quantity = _itr.quantity
          ..secondaryUnitQuantity = _itr.secondaryUnitQuantity
          ..mfgWastePercent = _itr.mfgWastePercent
          ..mfgIngredientGroupId = _itr.mfgIngredientGroupId
          ..quantityReturned = _itr.quantityReturned
          ..unitPriceBeforeDiscount = _itr.unitPriceBeforeDiscount
          ..unitPrice = _itr.unitPrice
          ..lineDiscountType = _itr.lineDiscountType
          ..lineDiscountAmount = _itr.lineDiscountAmount
          ..unitPriceIncTax = _itr.unitPriceIncTax
          ..itemTax = _itr.itemTax
          ..taxId = _itr.taxId
          ..discountId = _itr.discountId
          ..lotNoLineId = _itr.lotNoLineId
          ..sellLineNote = _itr.sellLineNote
          ..woocommerceLineItemsId = _itr.woocommerceLineItemsId
          ..soLineId = _itr.soLineId
          ..soQuantityInvoiced = _itr.soQuantityInvoiced
          ..resServiceStaffId = _itr.resServiceStaffId
          ..resLineOrderStatus = _itr.resLineOrderStatus
          ..resLineOrderStatusColorValue = _itr.resLineOrderStatusColorValue
          ..parentSellLineId = _itr.parentSellLineId
          ..childrenType = _itr.childrenType
          ..subUnitId = _itr.subUnitId
          ..updatedAt = _itr.updatedAt
          ..product = _itr.product
          ..variations = _itr.variations;

        logger.i(
            '----- After -----\n${allSaleOrders?.saleOrdersData.firstWhereOrNull((_saleOrder) => _saleOrder.id == _itr.transactionId)?.sellLines.firstWhereOrNull((sellLine) => sellLine.id == _itr.id)?.resLineOrderStatus}');
      }
      update();
    }
  }

  // initial order page load function
  callFirstOrderPage() async {
    allSaleOrdersPage = 1;
    isFirstLoadRunning = true;
    hasNextPage = true;
    isLoadMoreRunning.value = false;
    await fetchSaleOrders(1);
    isFirstLoadRunning = false;
  }

  // load more order page
  void loadMoreSaleOrders() async {
    logger.wtf('load more sale orders function called!');
    if (hasNextPage && !isFirstLoadRunning && !isLoadMoreRunning.value) {
      isLoadMoreRunning.value = true;

      allSaleOrdersPage += 1;

      await fetchSaleOrders(allSaleOrdersPage).then((bool? _isFinished) {
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

  // is order cooked or not
  SaleOrderDataModel? singleOrderData;
  bool isItCooked(List<SellLine> orderSellLines, {int? index}) {
    if (index != null)
      return orderSellLines[index].resLineOrderStatus == LineOrderStatus.COOKED;
    return orderSellLines.firstWhereOrNull((sellLine) =>
            sellLine.resLineOrderStatus == LineOrderStatus.COOKED) !=
        null;
  }

  // mark or UnMark all items of an order for update status (cooked, served)
  markUnMarkAllOrder() {
    singleOrderData?.sellLines
        .forEach((element) => element.isSelected = !element.isSelected);
    update();
  }

  // mark and UnMark single item of an order for update status (cooked, served)
  void markUnMarkOrder(SellLine orderSellLine, {int? index}) {
    // --------------------- is item cooked or not condition with popup
    // if (!isItCooked(index: index)) {
    //   showToast('Item is not Cooked yet!');
    //   return;
    // }

    orderSellLine.isSelected = !orderSellLine.isSelected;
    update();
  }

  bool isAnyOrderMarked() {
    return singleOrderData?.sellLines
            .firstWhereOrNull((sellLine) => sellLine.isSelected) !=
        null;
  }

  bool isAllOrderMarkedServed() {
    try {
      return singleOrderData?.sellLines.every((sellLine) =>
              sellLine.resLineOrderStatus == LineOrderStatus.SERVED) ??
          false;
    } catch (_e) {
      return false;
    }
  }

  bool isOrderMarkedServed(int index) {
    try {
      return singleOrderData?.sellLines[index].resLineOrderStatus ==
          LineOrderStatus.SERVED;
    } catch (_e) {
      return false;
    }
  }

  bool _isOrderUpdating = false;
  bool get isOrderUpdating => _isOrderUpdating;
  void set isOrderUpdating(bool val) => this._isOrderUpdating = val;

  void updateOrderStatus(
      {bool isCooked = false,
      bool isServed = false,
      bool isComplete = false}) async {
    // if (!isCooked && !isServed && !isComplete) return;

    print('before return');
    if (singleOrderData == null) return;

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${AppStorage.getUserToken()?.accessToken}'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('${AppConfig.baseUrl}${ApiUrls.markOrdersEndpoint}'));

    int i = 0;
    for (var _itr in singleOrderData!.sellLines) {
      if (_itr.isSelected) {
        /// key to mark sell line/s as cooked
        // request.fields['sell_kitchen_name[$i]'] = '${_itr.id}';

        /// key to mark sell line/s as served
        request.fields['sell_kitchen_cooked[$i]'] = '${_itr.id}';
        i++;
      }
    }

    logger.i(request.fields);

    request.headers.addAll(headers);

    return await request.send().then((http.StreamedResponse _res) async {
      String? result = await _res.stream.bytesToString();
      logger.i(
          'EndPoint => ${ApiUrls.markOrdersEndpoint}\nStatus Code => ${_res.statusCode}\nResponse => $result');

      if (_res.statusCode == 200 || _res.statusCode == 201) {
        final _jd = jsonDecode(result);
        showToast(_jd['msg'] ?? 'Order Successfully Marked.');
        for (int _i = 0; _i < singleOrderData!.sellLines.length; _i++) {
          if (singleOrderData!.sellLines[_i].isSelected) {
            /// update local record to mark sell line/s as cooked
            // singleOrderData!.sellLines[_i] =
            //     singleOrderData!.sellLines[_i].copyWith(resLineOrderStatus: LineOrderStatus.COOKED);

            /// update local record to mark sell line/s as served
            singleOrderData!.sellLines[_i] = singleOrderData!.sellLines[_i]
                .copyWith(resLineOrderStatus: LineOrderStatus.SERVED);
          }
        }
        update();
      }
    }).onError((error, stackTrace) {
      debugPrint('Error => $error');
      logger.e('StackTrace => $stackTrace');
      return null;
    });
  }

  notifyReadyToCheckout() {
    // Invoice Print
  }

  void resetUpdateValues() {
    _isOrderUpdating = false;
    Get.find<TableSelectionController>().isTableSelectionValueUpdated = false;
    Get.find<OrderTypeSelectionController>()
      ..isServiceTypeSelectionValueUpdated = false;
  }
}
