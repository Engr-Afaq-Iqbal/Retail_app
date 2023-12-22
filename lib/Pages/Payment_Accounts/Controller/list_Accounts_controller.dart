import 'dart:convert';

import 'package:bizmodo_emenu/Pages/Payment_Accounts/View/ListofAccounts_tabs/account_types.dart';
import 'package:bizmodo_emenu/Services/api_urls.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'dart:io';
import '../../../Config/utils.dart';
import '../../../Models/NavBarModel.dart';
import '../../../Models/PaymentAccounts/list_accounts_model.dart';
import '../../../Services/api_services.dart';
import '../View/ListofAccounts_tabs/accounts.dart';
enum listAccountsTabsPage {
  accounts,
  accountTypes,
}
class ListAccountsController extends GetxController {
  final accountData = ListAccountsModel().obs;
  String? dropdownValue1 ;
  String? dropdownValue2 ;
  var textField1Controller = TextEditingController().obs;
  var textField2Controller = TextEditingController().obs;
  var selectedDate = DateTime.now().obs;
  var selectedFile = Rx<File?>(null);
  var dropdownItems1 = <String>[].obs;
  var dropdownItems2 = <String>[].obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchAccounts();
  }

  static List<NavBarModel> AccountsTabsList() => [
    NavBarModel(
      identifier: listAccountsTabsPage.accounts,
      icon: 'Icons.order',
      label: 'accounts'.tr,
      page: Accounts(), //StockTransfer(),
    ),
    NavBarModel(
      identifier: listAccountsTabsPage.accountTypes,
      icon: 'Icons.order',
      label: 'account_types'.tr,
      page: AccountTypes(),
    ),
  ];
  Future<void> fetchAccounts() async {
    try {
      final _res = await ApiServices.getMethod(feedUrl: ApiUrls.listOfAccountsAPI);

      if (_res == null) {
        throw Exception('Failed to load accounts');
      }

      accountData.value = ListAccountsModel.fromJson(json.decode(_res));

      if (accountData.value.data != null) {
        List<String> nameAtIndex = [];
        for (var itr in accountData.value.data!) {
          nameAtIndex.add(itr.name ?? '');
        }

        dropdownItems1.assignAll([...nameAtIndex]);
        dropdownItems2.assignAll([...nameAtIndex]);
      }
    } catch (error, stackTrace) {
      debugPrint('Error => $error');
      logger.e('StackTrace => $stackTrace');
      throw Exception('Failed to load accounts');
    }
  }

}