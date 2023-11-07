import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';

import '../../../Config/DateTimeFormat.dart';

class LeadsController extends GetxController{
  TextEditingController titleCtrl = TextEditingController();

  //Add Leads variables
  bool isIndividual = false;
  bool isBusiness = false;
  bool isMoreShow = false;
  bool isAddContactPersonsShow = false;
  bool isAddContactPerson1Show = true;
  bool isAddContactPerson2Show = false;
  bool isAddContactPerson3Show = false;
  bool isActive1 = true;
  bool isAllowLogin1 = false;
  String? statusContactType;
  String? statusSource;
  String? statusLifeStage;
  TextEditingController prefixCtrl = TextEditingController();
  TextEditingController firstNameCtrl = TextEditingController();
  TextEditingController middleNameCtrl = TextEditingController();
  TextEditingController lastNameCtrl = TextEditingController();
  TextEditingController contactIdCtrl = TextEditingController();
  TextEditingController mobileCtrl = TextEditingController();
  TextEditingController alternateContactCtrl = TextEditingController();
  TextEditingController landlineCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController businessNameCtrl = TextEditingController();
  TextEditingController dobCtrl = TextEditingController();


  // List<TextEditingController> prefixContact1Ctrl = [];
  TextEditingController prefixContact1Ctrl = TextEditingController();
  TextEditingController firstNameContact1Ctrl = TextEditingController();
  TextEditingController lastNameContact1Ctrl = TextEditingController();
  TextEditingController emailContact1Ctrl = TextEditingController();
  TextEditingController mobileContact1Ctrl = TextEditingController();
  TextEditingController altMobileContact1Ctrl = TextEditingController();
  TextEditingController familyContact1Ctrl = TextEditingController();
  TextEditingController departmentContact1Ctrl = TextEditingController();
  TextEditingController designationContact1Ctrl = TextEditingController();
  TextEditingController salesContact1Ctrl = TextEditingController();
  TextEditingController userNameContact1Ctrl = TextEditingController();
  TextEditingController passwordContact1Ctrl = TextEditingController();
  TextEditingController confirmPasswordContact1Ctrl = TextEditingController();

  //More Information Block variable
  TextEditingController taxNumberCtrl = TextEditingController();
  TextEditingController addressLine1Ctrl = TextEditingController();
  TextEditingController addressLine2Ctrl = TextEditingController();
  TextEditingController cityCtrl = TextEditingController();
  TextEditingController stateCtrl = TextEditingController();
  TextEditingController countryCtrl = TextEditingController();
  TextEditingController zipCodeCtrl = TextEditingController();
  TextEditingController emiratedIdCtrl = TextEditingController();
  TextEditingController passportNoCtrl = TextEditingController();
  TextEditingController tradeLicenseCtrl = TextEditingController();
  TextEditingController customField4Ctrl = TextEditingController();
  TextEditingController customField5Ctrl = TextEditingController();
  TextEditingController customField6Ctrl = TextEditingController();
  TextEditingController customField7Ctrl = TextEditingController();
  TextEditingController customField8Ctrl = TextEditingController();
  TextEditingController customField9Ctrl = TextEditingController();
  TextEditingController customField10Ctrl = TextEditingController();





  List<String> contactTypeLsit = [
    'Leads',
  ];

  List<String> sourceList = [];
  List<String> lifeStageList = [];


  //Add Follow Up variables
  bool isNotificationChecked = false;
  bool isSms = false;
  bool isEmail = false;
  String? customerLeadStatus;
  String? statusAddFollowUp;
  String? statusFollowUp;
  String? statusFollowUpCategory;
  String? statusAssignedTo;
  String? statusNotifyBefore;
  TextEditingController startDateTimeCtrl = TextEditingController();
  TextEditingController endDateTimeCtrl = TextEditingController();
  TextEditingController descCtrl = TextEditingController();

  List<String> customerLeadLists = [
    'Afaq Iqbal',
    'Mr Afaq',
    'Mr Samar Sohail',
  ];

  List<String> followUpCategorylist = [
  ];

  List<String> assignedToList = [
  ];

  List<String> notifyBeforeList = [
    'Minute',
    'Hour',
    'Day'
  ];

  List<String> statusAddFollowUpList = [
    'Scheduled',
    'Open',
    'Cancelled',
    'Completed'
  ];

  List<String> followUpTypeList = [
    'Call',
    'Sms',
    'Meeting',
    'Email'
  ];

  Future<void> showStartDateTimePicker(BuildContext context) async {
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

    startDateTimeCtrl.text = '${AppFormat.dateDDMMYYWithOutComma(dateTime ?? DateTime.now())}';
    debugPrint('Start Date time ${startDateTimeCtrl.text}');
  }



  Future<void> showEndDateTimePicker(BuildContext context) async {
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
    endDateTimeCtrl.text = '${AppFormat.dateDDMMYYWithOutComma(dateTime ?? DateTime.now())}';
    debugPrint('End Date time ${startDateTimeCtrl.text}');
  }

  Future<void> showDateTimePicker(BuildContext context) async {
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

    dobCtrl.text = '${AppFormat.dateDDMMYYWithOutComma(dateTime ?? DateTime.now())}';
    debugPrint('DOB Date time -> ${dobCtrl.text}');
  }

}