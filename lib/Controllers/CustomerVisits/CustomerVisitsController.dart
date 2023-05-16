import 'package:bizmodo_emenu/Controllers/ContactController/ContactController.dart';
import 'package:bizmodo_emenu/Controllers/ListUserController/ListUserController.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../Config/utils.dart';
import '../../Models/CustomerVisits/customerVisitListModel.dart';
import '../../Services/api_services.dart';
import '../../Services/api_urls.dart';
import '../../Services/storage_services.dart';
import 'package:http/http.dart' as http;

class CustomerVisitsController extends GetxController {
  bool valuefirst = false;
  bool valueSecond = false;
  bool meetYes = true;
  bool meetNo = false;
  String? statusValue;
  String? contactStatusValue;
  TextEditingController meetNoReason = TextEditingController();
  TextEditingController dateCtrl = TextEditingController();
  TextEditingController searchCtrl = TextEditingController();
  TextEditingController purposeOfVisitingCtrl = TextEditingController();
  TextEditingController contactCtrl = TextEditingController();
  TextEditingController visitAddressCtrl = TextEditingController();
  TextEditingController companyCtrl = TextEditingController();
  TextEditingController discussionCtrl = TextEditingController();
  TextEditingController meetWithCtrl = TextEditingController();
  TextEditingController mobileNbrCtrl = TextEditingController();
  TextEditingController designationCtrl = TextEditingController();
  List<String> assignedToList(ListUserController listUserCtrl) {
    List<String> options = [];
    if (listUserCtrl.listuserModel != null) {
      for (int i = 0; i < listUserCtrl.listuserModel!.data!.length; i++) {
        options.add(
            '${listUserCtrl.listuserModel?.data?[i].firstName} ${listUserCtrl.listuserModel?.data?[i].lastName == null ? '' : listUserCtrl.listuserModel?.data?[i].lastName}');
      }
      return options;
    } else {
      progressIndicator();
    }
    return options;
  }

  List<String> contactList(ContactController contactCtrl) {
    List<String> options = [];
    if (contactCtrl.customerContacts != null) {
      for (int i = 0;
          i < contactCtrl.customerContacts!.contactDataList.length;
          i++) {
        options.add(
            '${contactCtrl.customerContacts?.contactDataList[i].firstName} ${contactCtrl.customerContacts?.contactDataList[i].lastName == null ? '' : contactCtrl.customerContacts?.contactDataList[i].lastName} ${contactCtrl.customerContacts?.contactDataList[i].contactId}');
      }
      return options;
    } else {
      progressIndicator();
    }
    return options;
  }

  List<String> customersMeeteaders = [
    '#',
    'Meet with',
    'Mobile No.',
    'Designation',
  ];

  CustomerVisitsListModel? customerVisitsListModel;

  /// Fetching Stock Adjustment
  Future fetchCustomerVisitsList({String? pageUrl}) async {
    await ApiServices.getMethod(feedUrl: pageUrl ?? ApiUrls.viewCustomerVisits)
        .then((_res) {
      update();
      if (_res == null) return null;
      customerVisitsListModel = customerVisitsListModelFromJson(_res);
      update();
    }).onError((error, stackTrace) {
      debugPrint('Error => $error');
      logger.e('StackTrace => $stackTrace');
      update();
    });
  }

  Future<bool?> createCustomerVisits() async {
    Map<String, String> _field = {
      "visiting": "1",
      "contact_id": "793",
      "company": "${companyCtrl.text}",
      "visiting_address": "${visitAddressCtrl.text}",
      "user_id": "65",
      "visit_on": "${dateCtrl.text}",
      "purpose_of_visiting": "${purposeOfVisitingCtrl.text}"
    };

    return await ApiServices.postMethod(
            feedUrl: ApiUrls.createCustomerVisits, fields: _field)
        .then((_res) {
      if (_res == null) return null;
      stopProgress();
      clearAllFields();
      Get.back();
      print('Create Customer: ');
      print(_res);
      return true;
    }).onError((error, stackTrace) {
      debugPrint('Error => $error');
      logger.e('StackTrace => $stackTrace');
      throw '$error';
    });
  }

  Future<bool?> updateCustomerVisits() async {
    Map<String, String> _field = {
      "visiting": "1",
      "contact_id": "793",
      "company": "${companyCtrl.text}",
      "visiting_address": "${visitAddressCtrl.text}",
      "user_id": "65",
      "visit_on": "${dateCtrl.text}",
      "purpose_of_visiting": "${purposeOfVisitingCtrl.text}"
    };

    return await ApiServices.postMethod(
            feedUrl: ApiUrls.createCustomerVisits, fields: _field)
        .then((_res) {
      if (_res == null) return null;
      stopProgress();
      clearAllFields();
      Get.back();
      print('Create Customer: ');
      print(_res);
      return true;
    }).onError((error, stackTrace) {
      debugPrint('Error => $error');
      logger.e('StackTrace => $stackTrace');
      throw '$error';
    });
  }

  ///
  Future deleteCustomerVisitsList({String? pageUrl, String? id}) async {
    await ApiServices.getMethod(
            feedUrl: pageUrl ?? '${ApiUrls.deleteCustomerVisits}$id')
        .then((_res) {
      update();
      if (_res == null) return null;
      print('Customer visit deleted successfully');
      update();
    }).onError((error, stackTrace) {
      debugPrint('Error => $error');
      logger.e('StackTrace => $stackTrace');
      update();
    });
  }

  clearAllFields() {
    dateCtrl.clear();
    visitAddressCtrl.clear();
    statusValue = null;
    companyCtrl.clear();
    contactStatusValue = null;
    purposeOfVisitingCtrl.clear();
    valuefirst = false;
    valueSecond = false;
  }
}
