import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../Config/utils.dart';
import '../../Models/Dashboard/home_tab.dart';
import '../../Services/api_services.dart';
import '../../Services/api_urls.dart';
import '../../Services/storage_services.dart';

class DashboardController extends GetxController {
  TextEditingController startDateCtrl = TextEditingController();
  TextEditingController endDateCtrl = TextEditingController();
  List<String> namesData = [];
  List<String> names = [
    'Total Sales',
    'Net',
    'Invoice Due',
    'Total Sell Return',
    'Total Purchase',
    'Purchase Due',
    'Total Purchase return',
    'Expense',
  ];

  List<String> iconsNames = [
    'Items',
    'Customer',
    'Create Order',
    'Return',
    'Receipt',
    'Sales',
    'Stock',
    'Customer Visits',
    'Upload'
  ];

  List<IconData> iconList = [
    FontAwesomeIcons.store,
    FontAwesomeIcons.user,
    FontAwesomeIcons.database,
    FontAwesomeIcons.divide,
    FontAwesomeIcons.print,
    FontAwesomeIcons.arrowUpRightDots,
    FontAwesomeIcons.boxesStacked,
    FontAwesomeIcons.personWalking,
    FontAwesomeIcons.upload
  ];

  HomeTabModel? homeTabModel;
  Future fetchDashboardData({
    String? pageUrl,
  }) async {
    await ApiServices.getMethod(
            feedUrl: pageUrl ??
                '${ApiUrls.dashboardDataApi}') //&start=${startDateCtrl.text}&end=${endDateCtrl.text}&location_id=${AppStorage.getBusinessDetailsData()?.businessData?.locations.first.id}
        .then((_res) {
      update();
      print(' not rece');
      if (_res == null) return null;
      print(' receving');

      homeTabModel = homeTabModelFromJson(_res);
      namesData = [
        '${homeTabModel?.totalSell ?? '0.00'}',
        '${homeTabModel?.net ?? '0.00'}',
        '${homeTabModel?.invoiceDue ?? '0.00'}',
        '${homeTabModel?.totalSellReturn ?? '0.00'}',
        '${homeTabModel?.totalPurchase ?? '0.00'}',
        '${homeTabModel?.purchaseDue ?? '0.00'}',
        '${homeTabModel?.totalPurchaseReturn ?? '0.00'}',
        '${homeTabModel?.totalExpense ?? '0.00'}',
      ];
      print(namesData);
      print(' record${_res}');
      update();
    }).onError((error, stackTrace) {
      debugPrint('Error => $error');
      logger.e('StackTrace => $stackTrace');
      update();
    });
  }
}
