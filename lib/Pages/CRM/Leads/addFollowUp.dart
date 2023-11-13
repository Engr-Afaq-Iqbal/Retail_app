import 'package:bizmodo_emenu/Components/custom_circular_button.dart';
import 'package:bizmodo_emenu/Pages/CRM/Leads/AddFollowUpWidget/assignedToDropDown.dart';
import 'package:bizmodo_emenu/Pages/CRM/Leads/AddFollowUpWidget/notifyBeforeDropDown.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Components/textfield.dart';
import '../../../Config/DateTimeFormat.dart';
import '../../../Controllers/CRMControllers/LeadsController/leadsController.dart';
import '../../../Theme/colors.dart';
import '../../../const/dimensions.dart';
import 'AddFollowUpWidget/customerLeadDropDown.dart';
import 'AddFollowUpWidget/followUpCategoryDropDown.dart';
import 'AddFollowUpWidget/followUpDropDown.dart';
import 'AddFollowUpWidget/statusDropDown.dart';

class AddFollowUp extends StatefulWidget {
  const AddFollowUp({super.key});

  @override
  State<AddFollowUp> createState() => _AddFollowUpState();
}

class _AddFollowUpState extends State<AddFollowUp> {
  LeadsController leadsCtrl = Get.find<LeadsController>();

  @override
  void initState() {
    // TODO: implement initState
    leadsCtrl.startDateTimeCtrl.text = '${AppFormat.dateDDMMYYWithOutComma(DateTime.now())}';
    leadsCtrl.endDateTimeCtrl.text = '${AppFormat.dateDDMMYYWithOutComma(DateTime.now())}';
    leadsCtrl.statusNotifyBefore = leadsCtrl.notifyBeforeList.first;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Add Follow Up'),
        ),
        body: Container(
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.all(15),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
              color: kWhiteColor,
              boxShadow: [BoxShadow(
                  blurRadius: 5,
                  spreadRadius: 3,
                  color: kHintColor.withOpacity(0.2)
              )]
          ),
          child: IntrinsicHeight(
            child: SingleChildScrollView(
              physics: ScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //Title
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          title(txt: 'Title:*'),
                          SizedBox(
                            width: width * 0.42,
                            height: height * 0.07,
                            child: AppFormField(

                              isDense: true,
                              controller: leadsCtrl.titleCtrl,
                            ),
                          ),
                        ],
                      ),

                      //Customer/Leads
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          title(txt: 'Customer/Lead:*'),
                          SizedBox(
                            width: width * 0.42,
                            height: height * 0.05,
                            child: CustomerLeadDropDown(),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //Status
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          title(txt: 'Status:'),
                          SizedBox(
                            width: width * 0.42,
                            height: height * 0.05,
                            child: StatusDropDown(),
                          ),
                        ],
                      ),

                      //Start Date and time
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          title(txt: 'Start Datetime:*'),
                          SizedBox(
                            width: width * 0.42,
                            height: height * 0.07,
                            child: AppFormField(
                                controller: leadsCtrl.startDateTimeCtrl,
                              onTap: (){
                                  leadsCtrl.showStartDateTimePicker(context);
                              },
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  //End Date and Time
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      title(txt: 'End Datetime:*'),
                      SizedBox(
                        width: width * 0.42,
                        height: height * 0.07,
                        child: AppFormField(
                          controller: leadsCtrl.endDateTimeCtrl,
                          onTap: (){
                            leadsCtrl.showEndDateTimePicker(context);
                          },
                        ),
                      )
                    ],
                  ),
                  //Description
                  title(txt: 'Description:'),
                  AppFormField(
                    maxLines: 3,
                    controller: leadsCtrl.descCtrl,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //Follow Up Type Drop Down
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          title(txt: 'Follow Up Type:*'),
                          SizedBox(
                            width: width * 0.42,
                            height: height * 0.05,
                            child: FollowUpDropDown(),
                          ),
                        ],
                      ),
                      //Follow Up Category Drop Down
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          title(txt: 'Follow Up Category:*'),
                          SizedBox(
                            width: width * 0.42,
                            height: height * 0.05,
                            child: FollowUpCategoryDropDown(),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),
                  title(txt: 'Assigned to:'),
                  SizedBox(
                    width: width * 0.42,
                    height: height * 0.05,
                    child: AssignedToDropDown(),
                  ),

                  Row(
                    children: [
                      Checkbox(
                        value: leadsCtrl.isNotificationChecked,
                        onChanged: (bool? value) {
                          setState(() {
                            leadsCtrl.isNotificationChecked = value!;
                          });
                        },
                      ),
                      // SizedBox(width: 5,),
                      title(txt: 'Send Notification'),
                    ],
                  ),

                  if(leadsCtrl.isNotificationChecked)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        title(txt: 'Notify Via:*'),
                        Row(
                          children: [
                            Row(
                              children: [
                                Checkbox(
                                  value: leadsCtrl.isSms,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      leadsCtrl.isSms = value!;
                                    });
                                  },
                                ),
                                // SizedBox(width: 5,),
                                title(txt: 'Sms'),
                              ],
                            ),

                            Row(
                              children: [
                                Checkbox(
                                  value: leadsCtrl.isEmail,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      leadsCtrl.isEmail = value!;
                                    });
                                  },
                                ),
                                // SizedBox(width: 5,),
                                title(txt: 'Email'),
                              ],
                            ),
                          ],
                        ),
                        title(txt: 'Notify Before:*'),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: width * 0.42,
                              height: height * 0.07,
                              child: AppFormField(

                                isDense: true,
                                controller: leadsCtrl.titleCtrl,
                              ),
                            ),

                            SizedBox(
                              width: width * 0.42,
                              height: height * 0.05,
                              child: NotifyBeforeDropDown(),
                            ),

                          ],
                        )

                      ],
                    ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CustomButton(
                        title: Text('Close',style: TextStyle(color: kWhiteColor),),
                        onTap: () => Get.back(),
                      ),
                      SizedBox(width: 10,),
                      CustomButton(
                        title: Text('Save',style: TextStyle(color: kWhiteColor),),
                        onTap: (){
                          Get.back();
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  title({String? txt}){
    return Text('$txt', style: TextStyle(fontWeight: FontWeight.bold),);
  }
}
