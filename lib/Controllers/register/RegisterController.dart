import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../Pages/register/OpenRegisterPage.dart';
import '../../Services/storage_services.dart';
import '../exception_controller.dart';
import '/Config/utils.dart';
import '/Models/business_n_register/BusinessModel.dart';
import '/Models/business_n_register/RegisterRecordModel.dart';
import '/Models/business_n_register/UserRegisterInfoModel.dart';

import '/Services/api_services.dart';
import '/Services/api_urls.dart';

class RegisterController extends GetxController {
  RegisterStatusDataModel? openedRegisterStatus;
  RegisterRecordModel? openedRegisterRecord;

  // Open Register
  final TextEditingController cashInHandCtrl = TextEditingController();
  final TextEditingController businessLocationCtrl = TextEditingController();
  BusinessLocationModel? selectBusinessLocation;

  // Close Register
  final TextEditingController totalCashCtrl = TextEditingController(text: '0');
  final TextEditingController totalCardSlipCtrl =
      TextEditingController(text: '0');
  final TextEditingController totalChequesCtrl =
      TextEditingController(text: '0');
  final TextEditingController closingNoteCtrl = TextEditingController();

  bool isBusinessDetailsDataNotEmpty() {
    return AppStorage.getBusinessDetailsData()?.businessData != null;
  }

  bool isBusinessLocationsIsNotEmpty() {
    if (isBusinessDetailsDataNotEmpty())
      return AppStorage.getBusinessDetailsData()!
          .businessData!
          .locations
          .isNotEmpty;

    return false;
  }

  bool isBusinessLocationsMoreThenOne() {
    if (isBusinessLocationsIsNotEmpty())
      return AppStorage.getBusinessDetailsData()!
              .businessData!
              .locations
              .length >
          1;
    return false;
  }

  checkAndSetRegisterInitialData() {
    if (isBusinessLocationsIsNotEmpty()) {
      selectBusinessLocation =
          AppStorage.getBusinessDetailsData()!.businessData!.locations.first;
      businessLocationCtrl.text =
          '${AppStorage.getBusinessDetailsData()!.businessData!.locations.first.name}';
    }
  }

  Future<bool> openTheRegister() async {
    Map<String, String> _fields = {
      "location_id": '${selectBusinessLocation?.id}',
      "initial_amount": '${cashInHandCtrl.text}',
      "status": "open",
    };
    logger.i(_fields);
    return await ApiServices.postMethod(
            feedUrl: ApiUrls.openRegisterAPI, fields: _fields)
        .then((_res) {
      if (_res == null) return false;
      cashInHandCtrl.clear();
      businessLocationCtrl.clear();
      return true;
    }).onError((error, stackTrace) async {
      debugPrint('Error => $error');
      logger.e('StackTrace => $stackTrace');
      await ExceptionController().exceptionAlert(
        errorMsg: '$error',
        exceptionFormat: ApiServices.methodExceptionFormat(
            'POST', ApiUrls.unitListApi, error, stackTrace),
      );
      return false;
    });
  }

  Future<bool> closeRegister(BuildContext context) async {
    // bool? isSubmitData = await appDialogBox(
    //   context,
    //   dialogTitle: 'Closing Register',
    //   contentPage: ClosingRegisterPage(onlyFields: false),
    // );

    // bool? isSubmitData = await Get.to(
    //   () => ClosingRegisterPage(onlyFields: false),
    // );
    // debugPrint('Close Register Page return data => $isSubmitData');
    // if (isSubmitData == null || !isSubmitData) return false;

    Map<String, String> _closeRegisterFields = {
      'user_id': '${AppStorage.getLoggedUserData()?.staffUser.id}',
      'closing_amount': '${totalCashCtrl.text}',
      'total_card_slips': '${totalCardSlipCtrl.text}',
      'total_cheques': '${totalChequesCtrl.text}',
      'closing_note': '${closingNoteCtrl.text}'
    };

    return await ApiServices.postMethod(
            feedUrl: ApiUrls.closeRegisterAPI, fields: _closeRegisterFields)
        .then((_res) {
      if (_res == null) return false;
      Get.snackbar('Action Successful', 'Register Closed Successfully.');
      totalCashCtrl.text = '0';
      totalCardSlipCtrl.text = '0';
      totalChequesCtrl.text = '0';
      closingNoteCtrl.clear();
      checkAndSetRegisterInitialData();
      Get.offAll(() => OpenRegisterPage());

      return true;
    }).onError((error, stackTrace) async {
      debugPrint('Error => $error');
      logger.e('StackTrace => $stackTrace');
      await ExceptionController().exceptionAlert(
        errorMsg: '$error',
        exceptionFormat: ApiServices.methodExceptionFormat(
            'POST', ApiUrls.unitListApi, error, stackTrace),
      );
      return false;
    });
  }

  Future<bool> fetchRegisterStatus() async {
    return await ApiServices.getMethod(
            feedUrl:
                '${ApiUrls.registersDetailsAPI}?status=open&user_id=${AppStorage.getLoggedUserData()?.staffUser.id}}')
        .then((_res) {
      if (_res == null) return false;
      RegisterStatusModel? _regInfo = registerStatusModelFromJson(_res);
      if (_regInfo.registerStatusDataList.isNotEmpty) {
        openedRegisterStatus = _regInfo.registerStatusDataList.first;
      } else {
        checkAndSetRegisterInitialData();
      }

      return true;
    }).onError((error, stackTrace) async {
      debugPrint('Error => $error');
      logger.e('StackTrace => $stackTrace');
      await ExceptionController().exceptionAlert(
        errorMsg: '$error',
        exceptionFormat: ApiServices.methodExceptionFormat(
            'POST', ApiUrls.unitListApi, error, stackTrace),
      );
      return false;
    });
  }

  Future<bool> fetchRegisterRecord() async {
    return await ApiServices.getMethod(
            feedUrl: ApiUrls.openedRegisterRecordsAPI)
        .then((_res) {
      if (_res == null) return false;
      openedRegisterRecord = registerRecordModelFromJson(_res);
      if (openedRegisterRecord != null) {
        totalCashCtrl.text = '${openedRegisterRecord?.totalPayment ?? 0}';
        totalCardSlipCtrl.text =
            openedRegisterRecord?.registerDetails?.totalCardSlips ?? '';
        totalChequesCtrl.text =
            openedRegisterRecord?.registerDetails?.totalCheques ?? '';
      }
      update();
      // UserRegisterInfoModel? _regInfo = userRegisterDataModelFromJson(_res);
      // if (_regInfo.userRegisterDataList.isNotEmpty) {
      //   openedRegisterInformation = _regInfo.userRegisterDataList.first;
      // } else {
      //   checkAndSetRegisterInitialData();
      // }

      return true;
    }).onError((error, stackTrace) async {
      debugPrint('Error => $error');
      logger.e('StackTrace => $stackTrace');
      await ExceptionController().exceptionAlert(
        errorMsg: '$error',
        exceptionFormat: ApiServices.methodExceptionFormat(
            'POST', ApiUrls.unitListApi, error, stackTrace),
      );
      return false;
    });
  }

  void clear() {
    cashInHandCtrl.clear();
    businessLocationCtrl.clear();
    selectBusinessLocation = null;
    openedRegisterStatus = null;
  }
}
