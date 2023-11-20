

import 'package:get/get.dart';

import '../../../Models/NavBarModel.dart';
import '../../../Pages/CRM/Reports/FollowUpsByUser.dart';
import '../../../Pages/CRM/Reports/followUpsByContacts.dart';
import '../../../Pages/CRM/Reports/leadsToCustomers.dart';
enum OrderTabsPage {
  FollowUpsByUser,
  FollowUpsByContact,
  LeadsToCustomerConversion
}

class ReportsController extends GetxController{

  static List<NavBarModel> reportsTabsList() => [
    NavBarModel(
      identifier: OrderTabsPage.FollowUpsByUser,
      icon: 'Icons.order',
      label: 'Follow ups by user',
      page: FollowUpsByUser(), //StockTransfer(),
    ),
    NavBarModel(
      identifier: OrderTabsPage.FollowUpsByContact,
      icon: 'Icons.order',
      label: 'Follow ups by contacts',
      page: FollowUpsByContacts(),
    ),
    NavBarModel(
      identifier: OrderTabsPage.LeadsToCustomerConversion,
      icon: 'Icons.order',
      label: 'Leads to customer conversion',
      page: LeadsToCustomers(),
    ),
  ];
}