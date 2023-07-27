import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../exception_controller.dart';
import '/Config/utils.dart';
import '/Models/BookingModels/bookingListModel.dart';
import '/Services/api_services.dart';
import '/Services/api_urls.dart';
import '../../Services/storage_services.dart';
import '../ProductController/product_cart_controller.dart';

class BookingController extends GetxController {
  TextEditingController controller = TextEditingController();
  TextEditingController dateTimeController =
      TextEditingController(text: 'select_date_range'.tr);
  String? tableIDName;
  String? serviceStaff;
  bool secondMethod = false;

  BookingListModel? bookingListModelObj;
  TextEditingController startDateCtrl = TextEditingController();
  TextEditingController endDateCtrl = TextEditingController();
  TextEditingController bookingNoteCtrl = TextEditingController();
  TextEditingController noOfPersonsCtrl = TextEditingController();
  TextEditingController serviceStaffCtrl = TextEditingController();
  TextEditingController selectStartDateCtrl = TextEditingController();
  TextEditingController autoEndDateCtrl = TextEditingController();
  TextEditingController selectStartTimeCtrl = TextEditingController();
  TextEditingController autoEndTimeCtrl = TextEditingController();
  TextEditingController searchCustomerCtrl = TextEditingController();
  TextEditingController contactIdCtrl = TextEditingController();
  int? tableId;
  final ProductCartController prodCartCtrlObj =
      Get.find<ProductCartController>();

  ///View All Booking List
  Future fetchBookingList() async {
    await ApiServices.getMethod(feedUrl: '${ApiUrls.bookingListAPI}')
        .then((_res) {
      if (_res == null) return null;
      bookingListModelObj = bookingListModelFromJson(_res);
      update();
    }).onError((error, stackTrace) async {
      debugPrint('Error => $error');
      logger.e('StackTrace => $stackTrace');
      await ExceptionController().exceptionAlert(
        errorMsg: '$error',
        exceptionFormat: ApiServices.methodExceptionFormat(
            'POST', ApiUrls.unitListApi, error, stackTrace),
      );
    });
  }

  Future createNewBooking() async {
    Map<String, String> _field = {
      "contact_id": '${contactIdCtrl.text}',
      //'${Get.find<RegisterController>().openedRegisterStatus?.locationId}',
      "waiter_id": '${AppStorage.getLoggedUserData()?.staffUser.id}',
      "table_id": '${tableId}',
      "correspondent_id":
          '${AppStorage.getLoggedUserData()?.staffUser.crmContactId}',
      "business_id":
          '${AppStorage.getBusinessDetailsData()?.businessData?.id ?? AppStorage.getLoggedUserData()?.staffUser.businessId}',
      "location_id":
          '${AppStorage.getBusinessDetailsData()?.businessData?.locations.first.id ?? AppStorage.getLoggedUserData()?.staffUser.locationId}',
      "booking_start": '${startDateCtrl.text}',
      "booking_end": '${endDateCtrl.text}',
      "created_by": '${serviceStaffCtrl.text}',
      "booking_status": 'booked',
      "booking_note": '${bookingNoteCtrl.text}',
      "no_of_person": '${noOfPersonsCtrl.text}',
    };

    return await ApiServices.postMethod(
            feedUrl: ApiUrls.createNewBookingAPI, fields: _field)
        .then((_res) {
      if (_res == null) return null;

      return true;
    }).onError((error, stackTrace) async {
      debugPrint('Error => $error');
      logger.e('StackTrace => $stackTrace');
      await ExceptionController().exceptionAlert(
        errorMsg: '$error',
        exceptionFormat: ApiServices.methodExceptionFormat(
            'POST', ApiUrls.unitListApi, error, stackTrace),
      );
      throw '$error';
    });
  }

  clearAllCtrl() {
    startDateCtrl.clear();
    endDateCtrl.clear();
    serviceStaffCtrl.clear();
    bookingNoteCtrl.clear();
    noOfPersonsCtrl.clear();
    tableId = null;
    tableIDName = null;
    serviceStaff = null;
    dateTimeController.text = 'select_date_range'.tr;
  }

  List<DateTime> dateList() {
    List<DateTime> dateList = [];
    for (int i = 0; i <= 14; i++) {
      var date = DateTime.now().add(Duration(days: i));
      dateList.add(date);
    }
    return dateList;
  }
}
