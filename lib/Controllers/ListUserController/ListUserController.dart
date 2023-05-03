import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/Services/api_services.dart';
import '/Services/api_urls.dart';
import '../../Config/utils.dart';
import '../../Models/ListUserModel/ListUserModel.dart';
import '../../Services/storage_services.dart';
import '../AuthController/auth_controller.dart';

class ListUserController extends GetxController {
  //AllPrinterController allPrinterCtrlObj =  Get.find<AllPrinterController>();

  ListUserModel? listuserModel;
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

  /// Fetching All Printers List
  Future fetchListUsers({String? pageUrl}) async {
    await ApiServices.getMethod(feedUrl: pageUrl ?? ApiUrls.listUsersAPI)
        .then((_res) {
      update();
      if (_res == null) return null;
      listuserModel = listUserModelFromJson(_res);
      update();
    }).onError((error, stackTrace) {
      debugPrint('Error => $error');
      logger.e('StackTrace => $stackTrace');
      update();
    });
  }

  ///Change Password
  Future changePassword({String? pageUrl}) async {
    Map<String, String> fields = {
      'current_password': currentPasswordCtrl.text,
      'new_password': newPasswordCtrl.text,
    };

    String? response = await ApiServices.postMethod(
            feedUrl: pageUrl ?? ApiUrls.changePasswordAPI, fields: fields)
        .then((_res) {
      update();
      if (_res == null) return null;
      showToast('Password Update Successfully');
      Get.find<AuthController>().logout();
      debugPrint('Response::::');
      debugPrint(_res);
      update();
    }).onError((error, stackTrace) {
      debugPrint('Error => $error');
      logger.e('StackTrace => $stackTrace');
      update();
    });
    return true;
  }

  functionStoreValue() {
    dobCtrl.text = AppStorage.getLoggedUserData()?.staffUser.dob ?? '- -';
    genderCtrl.text = AppStorage.getLoggedUserData()?.staffUser.gender ?? '';
    martialStatusCtrl.text =
        AppStorage.getLoggedUserData()?.staffUser.maritalStatus ?? '';
    socialMediaCtrl.text =
        AppStorage.getLoggedUserData()?.staffUser.socialMedia1 ?? '';
    bloodGroupCtrl.text =
        AppStorage.getLoggedUserData()?.staffUser.bloodGroup ?? '';
    socialMedia2Ctrl.text =
        AppStorage.getLoggedUserData()?.staffUser.socialMedia2 ?? '';
    mobileNbrCtrl.text =
        AppStorage.getLoggedUserData()?.staffUser.contactNo ?? '';
    alternativeMobileNbrCtrl.text =
        AppStorage.getLoggedUserData()?.staffUser.contactNumber ?? '';
    familyContactNbrCtrl.text =
        AppStorage.getLoggedUserData()?.staffUser.familyNumber ?? '';
    idProofNameCtrl.text =
        AppStorage.getLoggedUserData()?.staffUser.idProofName ?? '';
    idProofNbrCtrl.text =
        AppStorage.getLoggedUserData()?.staffUser.idProofNumber ?? '';
    faceBookLinkCtrl.text =
        AppStorage.getLoggedUserData()?.staffUser.fbLink ?? '';
    twitterLinkCtrl.text =
        AppStorage.getLoggedUserData()?.staffUser.twitterLink ?? '';
    customField1Ctrl.text =
        AppStorage.getLoggedUserData()?.staffUser.customField1 ?? '';
    customField2Ctrl.text =
        AppStorage.getLoggedUserData()?.staffUser.customField2 ?? '';
    customField3Ctrl.text =
        AppStorage.getLoggedUserData()?.staffUser.customField3 ?? '';
    customField4Ctrl.text =
        AppStorage.getLoggedUserData()?.staffUser.customField4 ?? '';
    permanentAddressCtrl.text =
        AppStorage.getLoggedUserData()?.staffUser.permanentAddress ?? '';
    currentAddressCtrl.text =
        AppStorage.getLoggedUserData()?.staffUser.currentAddress ?? '';
  }
}
