import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../Components/custom_circular_button.dart';
import '../../../../../Components/textfield.dart';
import '../../../../../Controllers/RepairController/RepairSettingsController/repairSettingsController.dart';
import '../../../../../Theme/colors.dart';
import '../../../../../Theme/style.dart';
import '../../../../../const/dimensions.dart';

class AddSettingStatus extends StatefulWidget {
  const AddSettingStatus({super.key});

  @override
  State<AddSettingStatus> createState() => _AddSettingStatusState();
}

class _AddSettingStatusState extends State<AddSettingStatus> {
  RepairSettingsController repairSetCtrl = Get.find<RepairSettingsController>();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Status'),
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

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            title(txt: 'Status Name:*'),
                            SizedBox(
                              width: width * 0.42,
                              height: height * 0.07,
                              child: AppFormField(
                                isLabel: true,
                                labelText: 'Status Name',
                                isDense: true,
                                controller: repairSetCtrl.statusNameCtrl,
                              ),
                            ),
                          ],
                        ),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            title(txt: 'Color:'),
                            SizedBox(
                              width: width * 0.42,
                              height: height * 0.07,
                              child: AppFormField(
                                isLabel: true,
                                labelText: 'Color',
                                isDense: true,
                                controller: repairSetCtrl.colorCtrl,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            title(txt: 'Sort Order:'),
                            SizedBox(
                              width: width * 0.42,
                              height: height * 0.07,
                              child: AppFormField(
                                isLabel: true,
                                labelText: 'Sort Order',
                                isDense: true,
                                controller: repairSetCtrl.sortOrderCtrl,
                              ),
                            ),
                          ],
                        ),

                        Row(
                          children: [
                            Checkbox(
                              value: repairSetCtrl.isMarkStatusAsComplete,
                              onChanged: (bool? value) {
                                setState(() {
                                  repairSetCtrl.isMarkStatusAsComplete = value!;
                                });
                              },
                            ),
                            // SizedBox(width: 5,),
                            Text('Mark this status\nas complete', softWrap: true,maxLines: 2,overflow: TextOverflow.ellipsis,),
                          ],
                        ),
                      ],
                    ),

                    title(txt: 'SMS Template:'),
                    SizedBox(
                      // width: width * 0.42,
                      // height: height * 0.07,
                      child: AppFormField(
                        isLabel: true,
                        labelText: 'SMS Template',
                        // isDense: true,
                        maxLines: 3,
                        controller: repairSetCtrl.smsTemplateCtrl,
                      ),
                    ),
                    title(txt: 'Email Subject:'),
                    SizedBox(
                      // width: width * 0.42,
                      height: height * 0.07,
                      child: AppFormField(
                        isLabel: true,
                        labelText: 'Email Subject',
                        isDense: true,
                        controller: repairSetCtrl.emailSubjectCtrl,
                      ),
                    ),

                    title(txt: 'Email Body:'),
                    SizedBox(
                      // width: width * 0.42,
                      // height: height * 0.07,
                      child: AppFormField(
                        isLabel: true,
                        labelText: 'Email Body',
                        // isDense: true,
                        maxLines: 3,
                        controller: repairSetCtrl.emailBodyCtrl,
                      ),
                    ),
                    title(txt: 'Available Tags:'),
                    SizedBox(height: 30,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CustomButton(
                          title: Text('Save',style: TextStyle(color: kWhiteColor),),
                          bgColor: Theme.of(context).primaryColor,
                          onTap: (){},
                        ),
                        SizedBox(width: 10,),
                        CustomButton(
                          title: Text('Close',style: TextStyle(color: kWhiteColor),),
                          bgColor: buttonColor,
                          onTap: (){
                            Get.back();
                          },
                        )
                      ],
                    )

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
