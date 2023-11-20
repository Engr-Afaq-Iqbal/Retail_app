import 'package:bizmodo_emenu/Components/custom_circular_button.dart';
import 'package:bizmodo_emenu/Controllers/RepairController/JobSheetsControllers/JobSheetController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../Theme/colors.dart';
import '../../../../Theme/style.dart';
import '../../../../const/dimensions.dart';
import '../../../Components/textfield.dart';
import '../../../Config/const.dart';
import '../../CRM/Leads/AddFollowUpWidget/statusDropDown.dart';
import 'AddJobSheetWidgets/serviceStaffDropDown.dart';



class AddThirdContainer extends StatefulWidget {
  const AddThirdContainer({super.key});

  @override
  State<AddThirdContainer> createState() => _AddThirdContainerState();
}

class _AddThirdContainerState extends State<AddThirdContainer> {

  JobSheetController jobSheetCtrl = Get.find<JobSheetController>();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10,),
            //Brand Drop Down
            title(txt: 'Assign Operator/Technician:'),
            SizedBox(
              // width: width * 0.70,
              height: height * 0.05,
              child: ServiceStaffDropDown(),
            ),
            SizedBox(height: 10,),
            title(txt: 'Comment by technician:'),
            SizedBox(
              // width: width * 0.42,
              // height: height * 0.07,
              child: AppFormField(
                isLabel: true,
                labelText: 'Comment by technician',
                // isDense: true,
                maxLines: 3,
                controller: jobSheetCtrl.commentOfTechnicianCtrl,
              ),
            ),


            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    title(txt: 'Estimated Cost:'),
                    SizedBox(
                      width: width * 0.42,
                      height: height * 0.07,
                      child: AppFormField(
                        isLabel: true,
                        labelText: 'Estimated Cost',
                        isDense: true,
                        controller: jobSheetCtrl.commentOfTechnicianCtrl,
                      ),
                    ),
                  ],
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    title(txt: 'Status:*'),
                    SizedBox(
                      width: width * 0.42,
                      height: height * 0.05,
                      child: StatusDropDown(),
                    ),
                  ],
                )
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    title(txt: 'Document:'),
                    SizedBox(
                      width: width * 0.42,
                      height: height * 0.07,
                      child: AppFormField(
                        isLabel: true,
                        labelText: 'Document',
                        isDense: true,
                        controller: jobSheetCtrl.documentCtrl,
                      ),
                    ),
                  ],
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    title(txt: 'Due Date:'),
                    SizedBox(
                      width: width * 0.42,
                      height: height * 0.07,
                      child: AppFormField(
                        isLabel: true,
                        labelText: 'Due Date',
                        isDense: true,
                        readOnly: true,
                        onTap: (){
                          jobSheetCtrl.showDatePicker(context);
                        },
                        controller: jobSheetCtrl.dueDateCtrl,
                      ),
                    ),
                  ],
                )
              ],
            ),
            title(txt: 'Send notification:'),

            Row(
              children: [
                Row(
                  children: [
                    Checkbox(
                      value: jobSheetCtrl.smsValue,
                      onChanged: (bool? value) {
                        setState(() {
                          jobSheetCtrl.smsValue = value!;
                        });
                      },
                    ),
                    // SizedBox(width: 5,),
                    title(txt: 'Sms'),
                  ],
                ),
                SizedBox(width: 20,),
                Row(
                  children: [
                    Checkbox(
                      value: jobSheetCtrl.emailValue,
                      onChanged: (bool? value) {
                        setState(() {
                          jobSheetCtrl.emailValue = value!;
                        });
                      },
                    ),
                    // SizedBox(width: 5,),
                    title(txt: 'Email'),
                  ],
                ),
              ],
            ),
            SizedBox(height: 15,),
            AppConst.dividerLine(color: kHintColor.withOpacity(0.2)),
            SizedBox(height: 15,),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    title(txt: 'Custom Field 1:'),
                    SizedBox(
                      width: width * 0.42,
                      height: height * 0.07,
                      child: AppFormField(
                        isLabel: true,
                        labelText: 'Custom Field 1',
                        isDense: true,
                        controller: jobSheetCtrl.customField1Ctrl,
                      ),
                    ),
                  ],
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    title(txt: 'Custom Field 2:'),
                    SizedBox(
                      width: width * 0.42,
                      height: height * 0.07,
                      child: AppFormField(
                        isLabel: true,
                        labelText: 'Custom Field 2',
                        isDense: true,
                        controller: jobSheetCtrl.customField2Ctrl,
                      ),
                    ),
                  ],
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    title(txt: 'Custom Field 3:'),
                    SizedBox(
                      width: width * 0.42,
                      height: height * 0.07,
                      child: AppFormField(
                        isLabel: true,
                        labelText: 'Custom Field 3',
                        isDense: true,
                        controller: jobSheetCtrl.customField3Ctrl,
                      ),
                    ),
                  ],
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    title(txt: 'Custom Field 4:'),
                    SizedBox(
                      width: width * 0.42,
                      height: height * 0.07,
                      child: AppFormField(
                        isLabel: true,
                        labelText: 'Custom Field 4',
                        isDense: true,
                        controller: jobSheetCtrl.customField4Ctrl,
                      ),
                    ),
                  ],
                )
              ],
            ),

            title(txt: 'Custom Field 5:'),
            SizedBox(
              width: width * 0.42,
              height: height * 0.07,
              child: AppFormField(
                isLabel: true,
                labelText: 'Custom Field 5',
                isDense: true,
                controller: jobSheetCtrl.customField5Ctrl,
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              CustomButton(
                title: Text('Save and add parts', style: TextStyle(color: kWhiteColor),),
                onTap: (){},
              ),
              SizedBox(width: 10,),
              CustomButton(
                title: Text('Save', style: TextStyle(color: kWhiteColor),),
                onTap: (){},
              ),
            ],),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomButton(
                  title: Text('Save and upload docs', style: TextStyle(color: kWhiteColor),),
                  onTap: (){},
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }

}
