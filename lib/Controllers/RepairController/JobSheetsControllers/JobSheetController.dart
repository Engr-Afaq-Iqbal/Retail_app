

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';

import '../../../Config/DateTimeFormat.dart';
import '../../../Models/NavBarModel.dart';
import '../../../Pages/Repair/JobSheet/pendingJobSheet.dart';

enum JobSheetsTabPage {
  Pending,
  Completed,
}


class JobSheetController extends GetxController{

  ScrollController? jobSheetScrollCtrl;
  String? statusBusinessLoc;
  String? statusBrand;
  String? statusServiceStaff;
  String? statusStatus;
  String? statusDevice;
  String? statusDeviceModel;
  String? statusJobSheet;
  String? serviceCarryIn;
  String? servicePickUp;
  String? serviceOnSite;
  bool useForRepair = false;
  bool smsValue = false;
  bool emailValue = false;
  TextEditingController pickUpOnSiteAddressCtrl = TextEditingController();
  TextEditingController brandNameCtrl = TextEditingController();
  TextEditingController shortDescriptionCtrl = TextEditingController();
  TextEditingController deviceCtrl = TextEditingController();
  TextEditingController descriptionCtrl = TextEditingController();
  TextEditingController modelNameCtrl = TextEditingController();
  TextEditingController repairCheckListCtrl = TextEditingController();
  TextEditingController serialNoCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();
  TextEditingController productConfigCtrl = TextEditingController();
  TextEditingController conditionOfProductCtrl = TextEditingController();
  TextEditingController productReportedByCustomerCtrl = TextEditingController();
  TextEditingController commentOfTechnicianCtrl = TextEditingController();
  TextEditingController dueDateCtrl = TextEditingController();
  TextEditingController documentCtrl = TextEditingController();
  TextEditingController customField1Ctrl = TextEditingController();
  TextEditingController customField2Ctrl = TextEditingController();
  TextEditingController customField3Ctrl = TextEditingController();
  TextEditingController customField4Ctrl = TextEditingController();
  TextEditingController customField5Ctrl = TextEditingController();


  static List<NavBarModel> viewJobSheetTabsList() => [
    NavBarModel(
      identifier: JobSheetsTabPage.Pending,
      icon: 'Icons.order',
      label: 'Pending',
      page: PendingJobSheet(status: 'Pending',),
    ),
    NavBarModel(
      identifier: JobSheetsTabPage.Completed,
      icon: 'Icons.order',
      label: 'Completed',
      page: PendingJobSheet(status: 'Completed',),
    ),
  ];

  List<String> businessLocList = [
    'Restaurant',
    'Store',
    'Afaq'
  ];

  List<String> customersList = [
    'Walk-In',
  ];

  List<String> brandList = [
    'brand',
  ];

  List<String> deviceList = [
    'device',
  ];

  List<String> deviceModelList = [
    'model',
  ];

  List<String> serviceStaffList = [
    'Mike Driver',
  ];

  List<String> statusList = [
    'In Progress',
  ];


  Future<void> showDatePicker(context) async {
    DateTime? dateTime = await showOmniDateTimePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1600).subtract(const Duration(days: 3652)),
      lastDate: DateTime.now().add(
        const Duration(days: 3652),
      ),
      is24HourMode: false,
      isShowSeconds: false,
      minutesInterval: 1,
      secondsInterval: 1,
      borderRadius: const BorderRadius.all(Radius.circular(16)),
      constraints: const BoxConstraints(
        maxWidth: 350,
        maxHeight: 650,
      ),
      transitionBuilder: (context, anim1, anim2, child) {
        return FadeTransition(
          opacity: anim1.drive(
            Tween(
              begin: 0,
              end: 1,
            ),
          ),
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 200),
      barrierDismissible: true,
      selectableDayPredicate: (dateTime) {
        // Disable 25th Feb 2023
        if (dateTime == DateTime(2023, 2, 25)) {
          return false;
        } else {
          return true;
        }
      },
    );

    dueDateCtrl.text = '${AppFormat.dateDDMMYY(dateTime!)}';
    print(dateTime);
  }

}