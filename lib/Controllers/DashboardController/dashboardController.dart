import 'package:bizmodo_emenu/Config/DateTimeFormat.dart';
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
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  List<String> namesData = [];
  List<String> names = [
    'total_sales',
    //'net',
    'invoice_due',
    'total_sale_return',
    // 'total_purchase',
    // 'purchase_due',
    // 'total_purchase_return',
    'expense',
  ];

  List<String> iconsNames = [
    'item',
    'customer',
    'create_order',
    'return',
    'receipt',
    'sale',
    'stock',
    'customer_visits',
    'upload',
    'funds_transfer'
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
    FontAwesomeIcons.upload,
    FontAwesomeIcons.moneyBill
  ];

  HomeTabModel? homeTabModel;
  Future fetchDashboardData({
    String? pageUrl,
  }) async {
    await ApiServices.getMethod(
            feedUrl: pageUrl ??
                '${ApiUrls.dashboardDataApi}?start=${AppFormat.dateYYMMDD(startDate)}&end=${AppFormat.dateYYMMDD(endDate)}&location_id=${AppStorage.getBusinessDetailsData()?.businessData?.locations.first.id}') //&start=${startDateCtrl.text}&end=${endDateCtrl.text}&location_id=${AppStorage.getBusinessDetailsData()?.businessData?.locations.first.id}
        .then((_res) {
      update();
      if (_res == null) return null;

      homeTabModel = homeTabModelFromJson(_res);
      namesData = [
        '${homeTabModel?.totalSell ?? '0.00'}',
        //'${homeTabModel?.net ?? '0.00'}',
        '${homeTabModel?.invoiceDue ?? '0.00'}',
        '${homeTabModel?.totalSellReturn ?? '0.00'}',
        // '${homeTabModel?.totalPurchase ?? '0.00'}',
        // '${homeTabModel?.purchaseDue ?? '0.00'}',
        // '${homeTabModel?.totalPurchaseReturn ?? '0.00'}',
        '${homeTabModel?.totalExpense ?? '0.00'}',
      ];
      print(namesData);
      print(' record${_res}');
      stopProgress();
      update();
    }).onError((error, stackTrace) {
      debugPrint('Error => $error');
      logger.e('StackTrace => $stackTrace');
      update();
    });
  }
}
