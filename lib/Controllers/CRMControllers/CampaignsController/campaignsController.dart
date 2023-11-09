import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CampaignsController extends GetxController{
  //Add Campaigns variables
  String? statusAddCampaignType;
  String? statusTo;
  TextEditingController campaignNameCtrl = TextEditingController();

  List<String> addCampaignTypeList =[
    'Sms',
    'Email',
  ];

  List<String> toList =[
    'Customers',
    'Leads',
    'Transaction activity',
    'Contact',
  ];



}