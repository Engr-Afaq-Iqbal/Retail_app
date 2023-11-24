
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../Models/NavBarModel.dart';
import '../../../Pages/Repair/ListInvoices/pendingListInvoice.dart';

enum InvoicesTabPage {
  Pending,
  Completed,
}

class ListInvoicesController extends GetxController{

  ScrollController? listInvoicesTabScrollCtrl;
  static List<NavBarModel> listInvoicesTabsList() => [
    NavBarModel(
      identifier: InvoicesTabPage.Pending,
      icon: 'Icons.order',
      label: 'Pending',
      page: PendingListInvoice(status: 'Pending',),
    ),
    NavBarModel(
      identifier: InvoicesTabPage.Completed,
      icon: 'Icons.order',
      label: 'Completed',
      page: PendingListInvoice(status: 'Completed',),
    ),
  ];
}