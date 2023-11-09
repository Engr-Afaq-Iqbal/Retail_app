import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContactsLoginController extends GetxController{

  bool isActive1 = true;
  bool isAllowLogin1 = false;
  String? contactsListStatus;
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
  TextEditingController prefixContact1Ctrl = TextEditingController();
  TextEditingController lastNameContact1Ctrl = TextEditingController();
  TextEditingController userNameContact1Ctrl = TextEditingController();
  TextEditingController passwordContact1Ctrl = TextEditingController();
  TextEditingController confirmPasswordContact1Ctrl = TextEditingController();


  List<String> contactsList = [
    'Afaq Iqbal',
    'Mr Afaq',
    'Mr Samar Sohail',
  ];
}