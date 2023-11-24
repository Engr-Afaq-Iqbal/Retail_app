import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Theme/colors.dart';
import '../../../const/dimensions.dart';
import 'RepairSettingsOptions/SettingDeviceModels/settingDeviceModel.dart';
import 'RepairSettingsOptions/SettingDevices/settingDevices.dart';
import 'RepairSettingsOptions/SettingRepairSettings/settingsRepairSettings.dart';
import 'RepairSettingsOptions/SettingStatus/settingStatus.dart';
import 'RepairSettingsOptions/SettingsJobSheetPdfLabel/SettingsJobSheetPdfLabel.dart';

class RepairSettings extends StatefulWidget {
  const RepairSettings({super.key});

  @override
  State<RepairSettings> createState() => _RepairSettingsState();
}

class _RepairSettingsState extends State<RepairSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            GestureDetector(
                onTap: (){
                  Get.to(SettingStatus());
                },
                child: settingsContainer(icon: Icons.check_circle, titleTxt: 'Status', bgColor: partialColor,)),
            GestureDetector(
                onTap: (){
                  Get.to(SettingDevices());
                },
                child: settingsContainer(icon: Icons.monitor_outlined, titleTxt: 'Devices', bgColor: dueColor,)),
            GestureDetector(
                onTap: (){
                  Get.to(SettingDeviceModel());
                },
                child: settingsContainer(icon: Icons.perm_device_info, titleTxt: 'Device Models', bgColor: paidColor,)),
            GestureDetector(
                onTap: (){
                  Get.to(SettingsRepairSettings());
                },
                child: settingsContainer(icon: Icons.settings_suggest, titleTxt: 'Repair Settings', bgColor: buttonColor,)),
            GestureDetector(
                onTap: (){
                  Get.to(SettingsJobSheetPdfLabel());
                },
                child: settingsContainer(icon: Icons.picture_as_pdf_outlined, titleTxt: 'Jobsheet PDF & Label', bgColor: Theme.of(context).primaryColor,)),


          ],
        ),
      ),
    );
  }

  Container settingsContainer({IconData? icon, String? titleTxt, String? bodyTxt, Color? bgColor,}){
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.radiusSmall, ),
          color: kWhiteColor,
          boxShadow: [BoxShadow(
              blurRadius: 5,
              spreadRadius: 3,
              color: kHintColor.withOpacity(0.2)
          )]
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: bgColor,
                    radius: 25,
                    child: Icon(
                        icon
                    ),
                  ),
                  SizedBox(width: 15,),
                  Text('$titleTxt',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                ],
              ),
              Icon(Icons.arrow_forward_ios_outlined, color: bgColor,)
            ],
          )

        ],
      ),
    );
  }
}
