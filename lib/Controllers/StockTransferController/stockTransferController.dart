import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../Config/utils.dart';

import '../../Models/NavBarModel.dart';
import '../../Models/ViewStockTransferModel/viewStockTransferModel.dart';

import '../../Pages/Stocks/ViewStockAdjustment/viewStockAdjustment.dart';
import '../../Pages/Stocks/ViewStockTransfer/viewStockTransfer.dart';
import '../../Services/api_services.dart';
import '../../Services/api_urls.dart';
import '../../Services/storage_services.dart';

enum OrderTabsPage {
  ActiveOrders,
  PastOrders,
}

class StockTransferController extends GetxController {
  TextEditingController dateCtrl = TextEditingController();
  TextEditingController searchCtrl = TextEditingController();
  TextEditingController additionalNotes = TextEditingController();
  TextEditingController totalAmountRecCtrl = TextEditingController(text: '0');
  TextEditingController reasonCtrl = TextEditingController();
  int allSaleOrdersPage = 1;
  bool isFirstLoadRunning = true;
  bool hasNextPage = true;
  RxBool isLoadMoreRunning = false.obs;

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

  List<String> getStatusList() {
    List<String> options = ['Pending', 'In Transit', 'Completed'];
    // for (int i = 0;
    // i < widget.listUserCtrlObj!.listuserModel!.data!.length;
    // i++) {
    //   options.add(
    //       '${widget.listUserCtrlObj?.listuserModel?.data?[i].firstName} ${widget.listUserCtrlObj?.listuserModel?.data?[i].lastName == null ? '' : widget.listUserCtrlObj?.listuserModel?.data?[i].lastName}' ??
    //           '');
    // }
    return options;
  }

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
        options.add(AppStorage.getBusinessDetailsData()
                ?.businessData
                ?.locations[i]
                .name ??
            '');
      }
    } else {
      progressIndicator();
    }
    return options;
  }

  ViewStockTransferModel? viewStockTransferMoodel;

  /// Fetching Stock transfer
  Future fetchStockTransfersList({String? pageUrl}) async {
    await ApiServices.getMethod(feedUrl: pageUrl ?? ApiUrls.viewStockTransfer)
        .then((_res) {
      update();
      if (_res == null) return null;
      viewStockTransferMoodel = viewStockTransferModelFromJson(_res);
      update();
    }).onError((error, stackTrace) {
      debugPrint('Error => $error');
      logger.e('StackTrace => $stackTrace');
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
}
