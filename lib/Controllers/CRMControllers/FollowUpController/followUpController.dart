

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../Models/NavBarModel.dart';
import '../../../Pages/CRM/FollowUp/followUps.dart';
import '../../../Pages/CRM/FollowUp/recurringFollowUps.dart';


enum FollowUpsTabPage {
  FollowUps,
  RecurringFollowUp,
}


class FollowUpController extends GetxController{

  ScrollController? followUpTabScrollCtrl;
  static List<NavBarModel> viewFollowUpsTabsList() => [
    NavBarModel(
      identifier: FollowUpsTabPage.FollowUps,
      icon: 'Icons.order',
      label: 'Follow Ups',
      page: FollowUps(), //StockTransfer(),
    ),
    NavBarModel(
      identifier: FollowUpsTabPage.RecurringFollowUp,
      icon: 'Icons.order',
      label: 'Recurring Follow Up',
      page: RecurringFollowUps(),
    ),
  ];
}