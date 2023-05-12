import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../Models/NavBarModel.dart';
import '../../Pages/Orders/Controller/OrderController.dart';
import '../../Pages/SalesView/ListQuotations/listQuotations.dart';
import '../../Pages/SalesView/SalesViewDetails/SalesView.dart';

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
}
