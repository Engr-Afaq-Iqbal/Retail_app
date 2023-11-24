import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class RepairSettingsController extends GetxController{

  bool isShowCustomer = false;
  bool isShowClientId = false;
  bool isEmiratesId = false;
  bool isPassportNo = false;
  bool isTradeLicense = false;
  bool isCustomField4 = false;
  bool isCustomerName = false;
  bool isCustomerAddress = false;
  bool isCustomerPhone = false;
  bool isCustomerEmail = false;
  bool isAlternatePhone = false;
  bool isSalesPerson = false;
  bool isBarcode = false;
  bool isStatus = false;
  bool isDueDate = false;
  bool isTechnician = false;
  bool isProblem = false;
  bool isImei = false;
  bool isBrand = false;
  bool isLocation = false;
  bool isPassword = false;
  bool isMarkStatusAsComplete = false;


  String? statusDefaultJobSheet;
  TextEditingController jobSheetNoPrefixCtrl = TextEditingController();
  TextEditingController defaultRepairChecklistCtrl = TextEditingController();
  TextEditingController productConfigurationCtrl = TextEditingController();
  TextEditingController conditionOfTheProductCtrl = TextEditingController();
  TextEditingController problemReportedByCustomerCtrl = TextEditingController();
  TextEditingController repairTermsConditionsCtrl = TextEditingController();
  TextEditingController labelJobSheetCustomField1Ctrl = TextEditingController();
  TextEditingController labelJobSheetCustomField2Ctrl = TextEditingController();
  TextEditingController labelJobSheetCustomField3Ctrl = TextEditingController();
  TextEditingController labelJobSheetCustomField4Ctrl = TextEditingController();
  TextEditingController labelJobSheetCustomField5Ctrl = TextEditingController();


  TextEditingController customerLabelCtrl = TextEditingController();
  TextEditingController clientIdLabelCtrl = TextEditingController();
  TextEditingController clientTaxNumberLabelCtrl = TextEditingController();
  TextEditingController labelWidthCtrl = TextEditingController(text: '75');
  TextEditingController labelHeightCtrl = TextEditingController(text: '50');


  TextEditingController statusNameCtrl = TextEditingController();
  TextEditingController colorCtrl = TextEditingController();
  TextEditingController sortOrderCtrl = TextEditingController();
  TextEditingController smsTemplateCtrl = TextEditingController();
  TextEditingController emailSubjectCtrl = TextEditingController();
  TextEditingController emailBodyCtrl = TextEditingController();




  List<String> defaultJobSheetList = [
    'test',
  ];
}