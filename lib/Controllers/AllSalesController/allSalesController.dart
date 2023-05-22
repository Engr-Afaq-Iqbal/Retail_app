import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../Config/utils.dart';
import '../../Models/AllSalesModel/allSalesModel.dart';
import '../../Models/NavBarModel.dart';
import '../../Models/order_type_model/SaleOrderModel.dart';
import '../../Pages/SalesView/ListQuotations/listQuotations.dart';
import '../../Pages/SalesView/SalesViewDetails/SalesView.dart';
import '../../Services/api_services.dart';
import '../../Services/api_urls.dart';

enum SalesTabsPage {
  Sales,
  Quotation,
}

class AllSalesController extends GetxController {
  String? paytermStatusValue;
  String? statusValue;
  String? invoiceSchemaStatusValue;
  String? paymentStatusValue;
  String? paymentAccountStatusValue;
  TextEditingController searchCtrl = TextEditingController();
  TextEditingController dateCtrl = TextEditingController();
  TextEditingController productNameCtrl = TextEditingController();
  TextEditingController qtyCtrl = TextEditingController();
  TextEditingController priceCtrl = TextEditingController();
  TextEditingController totalCtrl = TextEditingController();
  TextEditingController remarksCtrl = TextEditingController();
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

  List<String> payTermList() {
    List<String> options = ['Months', 'Days'];
    // for (int i = 0;
    // i < widget.listUserCtrlObj!.listuserModel!.data!.length;
    // i++) {
    //   options.add(
    //       '${widget.listUserCtrlObj?.listuserModel?.data?[i].firstName} ${widget.listUserCtrlObj?.listuserModel?.data?[i].lastName == null ? '' : widget.listUserCtrlObj?.listuserModel?.data?[i].lastName}' ??
    //           '');
    // }
    return options;
  }

  List<String> statusList() {
    List<String> options = ['Final', 'Draft', 'Quotation', 'Proforma'];
    // for (int i = 0;
    // i < widget.listUserCtrlObj!.listuserModel!.data!.length;
    // i++) {
    //   options.add(
    //       '${widget.listUserCtrlObj?.listuserModel?.data?[i].firstName} ${widget.listUserCtrlObj?.listuserModel?.data?[i].lastName == null ? '' : widget.listUserCtrlObj?.listuserModel?.data?[i].lastName}' ??
    //           '');
    // }
    return options;
  }

  List<String> invoiceSchemaList() {
    List<String> options = ['Default', 'Restro'];
    // for (int i = 0;
    // i < widget.listUserCtrlObj!.listuserModel!.data!.length;
    // i++) {
    //   options.add(
    //       '${widget.listUserCtrlObj?.listuserModel?.data?[i].firstName} ${widget.listUserCtrlObj?.listuserModel?.data?[i].lastName == null ? '' : widget.listUserCtrlObj?.listuserModel?.data?[i].lastName}' ??
    //           '');
    // }
    return options;
  }

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

  AllSalesModel? allSalesModel;

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
  Future<bool?> fetchAllSalesList(int _page) async {
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

  // initial order page load function
  callFirstOrderPage() async {
    allSaleOrdersPage = 1;
    isFirstLoadRunning = true;
    hasNextPage = true;
    isLoadMoreRunning.value = false;
    await fetchAllSalesList(1);
    isFirstLoadRunning = false;
  }
}
