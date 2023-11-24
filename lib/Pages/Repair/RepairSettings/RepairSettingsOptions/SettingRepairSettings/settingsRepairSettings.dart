import 'package:bizmodo_emenu/Components/custom_circular_button.dart';
import 'package:bizmodo_emenu/Controllers/RepairController/RepairSettingsController/repairSettingsController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../Components/textfield.dart';
import '../../../../../Theme/colors.dart';
import '../../../../../Theme/style.dart';
import '../../../../../const/dimensions.dart';
import 'defaultJobSheetStatusDropDown.dart';

class SettingsRepairSettings extends StatefulWidget {
  const SettingsRepairSettings({super.key});

  @override
  State<SettingsRepairSettings> createState() => _SettingsRepairSettingsState();
}

class _SettingsRepairSettingsState extends State<SettingsRepairSettings> {
  RepairSettingsController repairSetCtrl = Get.find<RepairSettingsController>();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('Repair Settings'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(15),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                  color: kWhiteColor,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 5,
                      spreadRadius: 3,
                      color: kHintColor.withOpacity(0.2)
                  ),
                  ]
              ),
              child: IntrinsicHeight(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //Business Location Drop Down
                    title(txt: 'Default Job Sheet Status:'),

                    SizedBox(
                      // width: width * 0.85,
                      height: height * 0.05,
                      child: DefaultJobSheetStatusDropDown(),
                    ),
                    SizedBox(height: 10,),

                    title(txt: 'Job sheet number prefix:'),
                    SizedBox(
                      // width: width * 0.42,
                      height: height * 0.07,
                      child: AppFormField(
                        isLabel: true,
                        labelText: 'Job sheet number prefix',
                        isDense: true,
                        controller: repairSetCtrl.jobSheetNoPrefixCtrl,
                      ),
                    ),
                    title(txt: 'Default repair checklist:'),
                    SizedBox(
                      // width: width * 0.42,
                      // height: height * 0.07,
                      child: AppFormField(
                        // isDense: true,
                        maxLines: 2,
                        controller: repairSetCtrl.defaultRepairChecklistCtrl,
                      ),
                    ),

                    title(txt: 'Product Configuration:'),
                    SizedBox(
                      // width: width * 0.42,
                      // height: height * 0.07,
                      child: AppFormField(
                        // isDense: true,
                        maxLines: 2,
                        controller: repairSetCtrl.productConfigurationCtrl,
                      ),
                    ),

                    title(txt: 'Problem Reported By The Customer:'),
                    SizedBox(
                      // width: width * 0.42,
                      // height: height * 0.07,
                      child: AppFormField(
                        // isDense: true,
                        maxLines: 2,
                        controller: repairSetCtrl.problemReportedByCustomerCtrl,
                      ),
                    ),

                    title(txt: 'Condition Of The Product:'),
                    SizedBox(
                      // width: width * 0.42,
                      // height: height * 0.07,
                      child: AppFormField(
                        // isDense: true,
                        maxLines: 2,
                        controller: repairSetCtrl.conditionOfTheProductCtrl,
                      ),
                    ),

                    title(txt: 'Repair terms & conditions::'),
                    SizedBox(
                      // width: width * 0.42,
                      // height: height * 0.07,
                      child: AppFormField(
                        // isDense: true,
                        maxLines: 5,
                        controller: repairSetCtrl.repairTermsConditionsCtrl,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(15),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                  color: kWhiteColor,
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 5,
                        spreadRadius: 3,
                        color: kHintColor.withOpacity(0.2)
                    ),
                  ]
              ),
              child: IntrinsicHeight(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    title(txt: 'Label for job sheet custom field 1:'),
                    SizedBox(
                      // width: width * 0.42,
                      height: height * 0.07,
                      child: AppFormField(
                        isDense: true,
                        controller: repairSetCtrl.labelJobSheetCustomField1Ctrl,
                      ),
                    ),

                    title(txt: 'Label for job sheet custom field 2:'),
                    SizedBox(
                      // width: width * 0.42,
                      height: height * 0.07,
                      child: AppFormField(
                        isDense: true,
                        controller: repairSetCtrl.labelJobSheetCustomField2Ctrl,
                      ),
                    ),

                    title(txt: 'Label for job sheet custom field 3:'),
                    SizedBox(
                      // width: width * 0.42,
                      height: height * 0.07,
                      child: AppFormField(
                        isDense: true,
                        controller: repairSetCtrl.labelJobSheetCustomField3Ctrl,
                      ),
                    ),

                    title(txt: 'Label for job sheet custom field 4:'),
                    SizedBox(
                      // width: width * 0.42,
                      height: height * 0.07,
                      child: AppFormField(
                        isDense: true,
                        controller: repairSetCtrl.labelJobSheetCustomField4Ctrl,
                      ),
                    ),

                    title(txt: 'Label for job sheet custom field 5:'),
                    SizedBox(
                      // width: width * 0.42,
                      height: height * 0.07,
                      child: AppFormField(
                        isDense: true,
                        controller: repairSetCtrl.labelJobSheetCustomField5Ctrl,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CustomButton(
                          title: Text('Update',style: TextStyle(color: kWhiteColor),),
                          bgColor: buttonColor,
                          onTap: (){},
                        )
                      ],
                    )


                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
