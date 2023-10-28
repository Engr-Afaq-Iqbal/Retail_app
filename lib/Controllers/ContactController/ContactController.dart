import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Models/ContactsModel/getSpecifiedContactModel.dart';
import '../ListUserController/ListUserController.dart';
import '../exception_controller.dart';
import '/Config/const.dart';
import '/Models/order_type_model/create_contact_response_model.dart';
import '/Models/order_type_model/customer_contact_model.dart';
import '/Services/api_services.dart';
import '/Services/api_urls.dart';
import '../../Config/utils.dart';
import '../OrderController/order_type_controller.dart';

class ContactController extends GetxController {
  final OrderTypeSelectionController orderTypeSelectionCtrlObj =
      Get.find<OrderTypeSelectionController>();
  TextEditingController customerNameCtrl = TextEditingController();
  TextEditingController searchCustomerCtrl = TextEditingController();
  TextEditingController nameCtrl = TextEditingController();
  TextEditingController customLabelCtrl = TextEditingController();
  TextEditingController cityCtrl = TextEditingController();
  TextEditingController streetCtrl = TextEditingController();
  TextEditingController villaBuildingApartmentCtrl = TextEditingController();
  TextEditingController addressCtrl = TextEditingController();

  ///to view customer
  TextEditingController currentPasswordCtrl = TextEditingController();
  TextEditingController newPasswordCtrl = TextEditingController();
  TextEditingController confirmPasswordCtrl = TextEditingController();
  TextEditingController dobCtrl = TextEditingController();
  TextEditingController genderCtrl = TextEditingController();
  TextEditingController martialStatusCtrl = TextEditingController();
  TextEditingController socialMediaCtrl = TextEditingController();
  TextEditingController bloodGroupCtrl = TextEditingController();
  TextEditingController socialMedia2Ctrl = TextEditingController();
  TextEditingController mobileNbrCtrl = TextEditingController();
  TextEditingController alternativeMobileNbrCtrl = TextEditingController();
  TextEditingController familyContactNbrCtrl = TextEditingController();
  TextEditingController idProofNameCtrl = TextEditingController();
  TextEditingController idProofNbrCtrl = TextEditingController();
  TextEditingController faceBookLinkCtrl = TextEditingController();
  TextEditingController twitterLinkCtrl = TextEditingController();
  TextEditingController customField1Ctrl = TextEditingController();
  TextEditingController customField2Ctrl = TextEditingController();
  TextEditingController customField3Ctrl = TextEditingController();
  TextEditingController customField4Ctrl = TextEditingController();
  TextEditingController permanentAddressCtrl = TextEditingController();
  TextEditingController currentAddressCtrl = TextEditingController();
  String? id;
  bool isForEdit = true;


  File? image;
  File? image2;

  ///end

  // customer screen pagination flags
  int allSaleOrdersPage = 1;
  bool isFirstLoadRunning = true;
  bool hasNextPage = true;
  RxBool isLoadMoreRunning = false.obs;

  // Contact ID getter and setter (set walk in customer id as default and against null value)
  String _contactId = AppValues.walkInCustomerID;
  String get contactId => _contactId;
  void set contactId(String? id) =>
      _contactId = id ?? AppValues.walkInCustomerID;

  ///Retail app fields starting here
  bool indiviualYes = false;
  bool businessYes = false;
  bool isDisable = false;
  String? statusValue;
  TextEditingController prefixCtrl = TextEditingController();
  TextEditingController firstNameCtrl = TextEditingController();
  TextEditingController middleNameCtrl = TextEditingController();
  TextEditingController lastNameCtrl = TextEditingController();
  TextEditingController businessNameCtrl = TextEditingController();
  TextEditingController mobileNumberCtrl = TextEditingController();
  TextEditingController alternateMblNbrNumberCtrl = TextEditingController();
  TextEditingController landLineCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController trnCtrl = TextEditingController();
  TextEditingController licenseCtrl = TextEditingController();

  ///Ending

  // Customer Search
  ContactModel? customerContacts;
  Future<ContactModel?> fetchCustomerInfo(
    String? searchFieldCtrlValue,
  ) async {
    return await ApiServices.getMethod(
      feedUrl:
          '${ApiUrls.contactApi}?type=customer&name=$searchFieldCtrlValue&mobile_num=$searchFieldCtrlValue&biz_name=$searchFieldCtrlValue',
    ).then((_res) {
      if (_res == null) return null;
      customerContacts = contactModelFromJson(_res);
      update();
      return customerContacts;
    }).onError((error, stackTrace) {
      debugPrint('Error => $error');
      debugPrint('StackTrace => $stackTrace');
      throw '$error';
    });
  }

  Future<ContactModel?> fetchCustomerList(int? per_page) async {
    return await ApiServices.getMethod(
      feedUrl: '${ApiUrls.contactApi}?type=customer&per_page=$per_page',
    ).then((_res) {
      if (_res == null) return null;
      customerContacts = contactModelFromJson(_res);
      update();
      return customerContacts;
    }).onError((error, stackTrace) {
      debugPrint('Error => $error');
      debugPrint('StackTrace => $stackTrace');
      throw '$error';
    });
  }

  // fetch all sale orders list
  Future<bool?> fetchCustomerName(int _page) async {
    print('========================================');
    print('Function calling');
    return await ApiServices.getMethod(
            feedUrl: '${ApiUrls.contactApi}?type=customer&page=$_page')
        .then((_res) {
      if (_res == null) return null;
      final _data = contactModelFromJson(_res);
      if (_page > 1 && customerContacts != null) {
        customerContacts!.contactDataList.addAll(_data.contactDataList);
      } else {
        customerContacts = _data;
      }
      update();

      /* fallback end status means is all item finished or not */
      if (customerContacts?.meta?.lastPage != null &&
          _page == customerContacts?.meta?.lastPage) {
        return true;
      }

      return false;
    }).onError((error, stackTrace) {
      debugPrint('Error => $error');
      logger.e('StackTrace => $stackTrace');
      return null;
    });
  }

  // load more order page
  void loadMoreSaleOrders() async {
    logger.wtf('load more customers function called!');
    //if (hasNextPage && !isFirstLoadRunning && !isLoadMoreRunning.value) {
    isLoadMoreRunning.value = true;

    allSaleOrdersPage += 1;

    await fetchCustomerName(allSaleOrdersPage).then((bool? _isFinished) {
      if (_isFinished == null) {
        allSaleOrdersPage -= 1;
      } else if (_isFinished) {
        // This means there is no more data
        // and therefore, we will not send another request
        hasNextPage = false;
      }
    });
    isLoadMoreRunning.value = false;
    // }
  }

  // Create Customer
  Future<bool?> createContact() async {
    Map<String, String> _field = {
      "type": "customer",
      "first_name": "${nameCtrl.text}",
      "mobile": "${mobileNumberCtrl.text}",
    };
    // _field["supplier_business_name"] = "est";
    // _field["prefix"] = "odio";
    // _field["middle_name"] = "ut";
    // _field["last_name"] = "quo";
    // _field["pay_term_number"] = '3';
    // _field["pay_term_type"] = "months";
    // _field["landline"] = "5487-8454-4145";
    // _field["alternate_number"] = "841847541222";

    /// TODO: Service type ke configuration abhi set krni han because id change able hy or name be.

    if (orderTypeSelectionCtrlObj.selectedOrderType?.name == 'Take-Away') {
      // if (orderTypeSelectionCtrlObj.orderTypes.indexWhere(
      //         (orderType) => orderType == orderTypeSelectionCtrlObj.selectedOrderType.value) ==
      //     1) {
      _field["custom_field1"] = customLabelCtrl.text;
    } else if (orderTypeSelectionCtrlObj.selectedOrderType?.name ==
        'Delivery') {
      // } else if (orderTypeSelectionCtrlObj.orderTypes.indexWhere(
      //         (orderType) => orderType == orderTypeSelectionCtrlObj.selectedOrderType.value) ==
      //     2) {
      _field["city"] = cityCtrl.text;
      _field["address_line_1"] =
          "${streetCtrl.text}${streetCtrl.text.isNotEmpty ? ', ' : ''}${villaBuildingApartmentCtrl.text}";
      // _field["address_line_2"] = "corrupti";
      // _field["state"] = "blanditiis";
      // _field["country"] = "atque";
      // _field["zip_code"] = "occaecati";
      _field["shipping_address"] = addressCtrl.text;
    }
    // _field["customer_group_id"] = "fuga";
    // _field["contact_id"] = "reprehenderit";
    // _field["dob"] = "2000-06-13";
    // _field["custom_field2"] = "rerum";
    // _field["custom_field3"] = "dolorum";
    // _field["custom_field4"] = "sint";
    // _field["email"] = "quibusdam";
    // _field["position"] = "et";
    // _field["opening_balance"] = 0;
    // _field["source_id"] = 10;
    // _field["life_stage_id"] = 19;
    // _field["assigned_to"] = [];
    return await ApiServices.postMethod(
            feedUrl: ApiUrls.contactApi, fields: _field)
        .then((_res) {
      if (_res == null) return null;
      contactId = createContactResponseModelFromJson(_res).data.contactId;
      return true;
    }).onError((error, stackTrace) {
      debugPrint('Error => $error');
      debugPrint('StackTrace => $stackTrace');
      throw '$error';
    });
  }

  // Create Customer
  Future<bool?> createContactForRetailApp() async {
    Map<String, String> _field = {
      "type": "customer",
      "first_name": "${firstNameCtrl.text}",
      "mobile": "${mobileNumberCtrl.text}",
    };
    _field["supplier_business_name"] = "${businessNameCtrl.text}";
    _field["prefix"] = "${prefixCtrl.text}";
    _field["middle_name"] = "${middleNameCtrl.text}";
    _field["last_name"] = "${lastNameCtrl.text}";
    // _field["pay_term_number"] = '7';
    // _field["pay_term_type"] = "months";
    _field["landline"] = "${landLineCtrl.text}";
    _field["alternate_number"] = "${alternateMblNbrNumberCtrl.text}";
    _field["email"] = "${emailCtrl.text}";
    _field["assigned_to"] = "${statusValue}";

    // _field["customer_group_id"] = "fuga";
    // _field["contact_id"] = "reprehenderit";
    // _field["dob"] = "2000-06-13";
    // _field["custom_field2"] = "rerum";
    // _field["custom_field3"] = "dolorum";
    // _field["custom_field4"] = "sint";
    //
    // _field["position"] = "et";
    // _field["opening_balance"] = 0;
    // _field["source_id"] = 10;
    // _field["life_stage_id"] = 19;
    //
    return await ApiServices.postMethod(
            feedUrl: ApiUrls.contactApi, fields: _field)
        .then((_res) {
      if (_res == null) return null;
      stopProgress();
      clearAllContactCtrl();
      Get.back();
      contactId = createContactResponseModelFromJson(_res).data.contactId;
      return true;
    }).onError((error, stackTrace) {
      debugPrint('Error => $error');
      debugPrint('StackTrace => $stackTrace');
      throw '$error';
    });
  }

  updateContactCustomer({required String contactApi}) async {
    // Map<String, String> _fieldForFile = {};
    //
    // _fieldForFile['trade_license'] = '${image?.path}';
    // _fieldForFile['tax_certificate'] = '${image2?.path}';

    Map<String, String> _field = {
      "type": "customer",
      "first_name": "${firstNameCtrl.text}",
      "mobile": "${mobileNumberCtrl.text}",
    };
    _field["supplier_business_name"] = "${businessNameCtrl.text}";
    // _field["prefix"] = "${prefixCtrl.text}";
    // _field["middle_name"] = "${middleNameCtrl.text}";
    _field["last_name"] = "${lastNameCtrl.text}";
    // _field["pay_term_number"] = '7';
    // _field["pay_term_type"] = "months";
    _field["landline"] = "${landLineCtrl.text}";
    _field["alternate_number"] = "${alternateMblNbrNumberCtrl.text}";
    _field["tax_number"] = "${trnCtrl.text}";
    _field["custom_field1"] = "${licenseCtrl.text}";
    _field["email"] = "${emailCtrl.text}";

    // _field["assigned_to"] = "${statusValue}";

    // _field["customer_group_id"] = "fuga";
    // _field["contact_id"] = "reprehenderit";
    // _field["dob"] = "2000-06-13";
    // _field["custom_field2"] = "rerum";
    // _field["custom_field3"] = "dolorum";
    // _field["custom_field4"] = "sint";
    //
    // _field["position"] = "et";
    // _field["opening_balance"] = 0;
    // _field["source_id"] = 10;
    // _field["life_stage_id"] = 19;
    //
    logger.i(_field);
    // logger.i(_fieldForFile);
    return await ApiServices.postMultiPartQuery(
      feedUrl: '${ApiUrls.updateContactApi}${contactApi}',
      fields: _field,
    ) //files: _fieldForFile
        .then((res) {
      logger.i(res);
      if (res == null) {
        print('Returning null');
        return null;
      }
      showToast('Customer updated successfully');
      stopProgress();
      clearAllContactCtrl();
      Get.back();
      // contactId = createContactResponseModelFromJson(_res).data.id.toString();
      return true;
    }).onError((error, stackTrace) async {
      debugPrint('Error => $error');
      debugPrint('StackTrace => $stackTrace');
      logger.e('StackTrace => $stackTrace');
      await ExceptionController().exceptionAlert(
        errorMsg: '$error',
        exceptionFormat: ApiServices.methodExceptionFormat(
            'POST', ApiUrls.updateContactApi, error, stackTrace),
      );
      throw '$error';
    });
  }

  clearAllContactCtrl() {
    customerNameCtrl.clear();
    nameCtrl.clear();
    mobileNumberCtrl.clear();
    indiviualYes = false;
    businessYes = false;
    statusValue = null;
    prefixCtrl.clear();
    firstNameCtrl.clear();
    middleNameCtrl.clear();
    lastNameCtrl.clear();
    businessNameCtrl.clear();
    mobileNumberCtrl.clear();
    alternateMblNbrNumberCtrl.clear();
    landLineCtrl.clear();
    emailCtrl.clear();
  }

  // initial order page load function
  callFirstOrderPage() async {
    allSaleOrdersPage = 1;
    isFirstLoadRunning = true;
    hasNextPage = true;
    isLoadMoreRunning.value = false;
    await fetchCustomerName(1);
    isFirstLoadRunning = false;
  }

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

  GetSpecificContactModel? getSpecificContactModel;

  /// Fetching Specified Contact
  Future fetchSpecifiedContactList(
      {String? pageUrl, required String contactApi}) async {
    await ApiServices.getMethod(
            feedUrl: pageUrl ??
                '${ApiUrls.getSpecifiedContactApi}${contactApi}') //&global_search=$global_search
        .then((_res) {
      update();
      if (_res == null) return null;
      getSpecificContactModel = getSpecificContactModelFromJson(_res);
      functionStoreValue(getSpecificContactModel);
      update();
    }).onError((error, stackTrace) {
      debugPrint('Error => $error');
      logger.e('StackTrace => $stackTrace');
      update();
    });
  }

  functionStoreValue(GetSpecificContactModel? getSpecificContactModel) {
    prefixCtrl.text = getSpecificContactModel?.data?.first.prefix ?? '';
    firstNameCtrl.text = getSpecificContactModel?.data?.first.firstName ?? '';
    middleNameCtrl.text = getSpecificContactModel?.data?.first.middleName ?? '';
    lastNameCtrl.text = getSpecificContactModel?.data?.first.lastName ?? '';
    businessNameCtrl.text =
        getSpecificContactModel?.data?.first.supplierBusinessName ?? '';
    mobileNumberCtrl.text = getSpecificContactModel?.data?.first.mobile ?? '';
    alternateMblNbrNumberCtrl.text =
        getSpecificContactModel?.data?.first.alternateNumber ?? '';
    landLineCtrl.text = getSpecificContactModel?.data?.first.landline ?? '';
    emailCtrl.text = getSpecificContactModel?.data?.first.email ?? '';
    licenseCtrl.text = getSpecificContactModel?.data?.first.customField1 ?? '';
    trnCtrl.text = getSpecificContactModel?.data?.first.taxNumber ?? '';
  }
}
