import 'package:bizmodo_emenu/Pages/CRM/Leads/AddLeadsWidgets/sourceDropDown.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../Components/textfield.dart';
import '../../../../Controllers/CRMControllers/LeadsController/leadsController.dart';
import '../../../../Theme/colors.dart';
import '../../../../Theme/style.dart';
import '../../../../const/dimensions.dart';
import '../AddFollowUpWidget/assignedToDropDown.dart';
import 'contactTypeDropDown.dart';
import 'lifeStageDropDown.dart';


class AddLeadsBasicInfo extends StatefulWidget {
  const AddLeadsBasicInfo({super.key});

  @override
  State<AddLeadsBasicInfo> createState() => _AddLeadsBasicInfoState();
}

class _AddLeadsBasicInfoState extends State<AddLeadsBasicInfo> {
  LeadsController leadsCtrl = Get.find<LeadsController>();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
          color: kWhiteColor
      ),
      child: IntrinsicHeight(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Contact type Drop Down
            title(txt: 'Contact type:*'),
            SizedBox(
              // width: width * 0.85,
              height: height * 0.05,
              child: ContactTypeDropDown(),
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Checkbox(
                      value: leadsCtrl.isIndividual,
                      onChanged: (bool? value) {
                        setState(() {
                          leadsCtrl.isIndividual = value!;
                          if(leadsCtrl.isIndividual == true){
                            leadsCtrl.isBusiness = false;
                          }

                        });
                      },
                    ),
                    // SizedBox(width: 5,),
                    title(txt: 'Individual'),
                  ],
                ),

                Row(
                  children: [
                    Checkbox(
                      value: leadsCtrl.isBusiness,
                      onChanged: (bool? value) {
                        setState(() {
                          leadsCtrl.isBusiness = value!;
                          if(leadsCtrl.isBusiness == true){
                            leadsCtrl.isIndividual = false;
                          }

                        });
                      },
                    ),
                    // SizedBox(width: 5,),
                    title(txt: 'Business'),
                  ],
                ),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              children: [
                title(txt: 'Contact ID:'),
                SizedBox(width: 5,),
                Text(
                    '(Leave empty to autogenerate)'
                )
              ],
            ),
            SizedBox(
              // width: width * 0.42,
              height: height * 0.07,
              child: AppFormField(
                isLabel: true,
                labelText: 'Contact ID',
                isDense: true,
                controller: leadsCtrl.contactIdCtrl,

              ),
            ),
            if(leadsCtrl.isIndividual)
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //Prefix
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          title(txt: 'Prefix:'),
                          SizedBox(
                            width: width * 0.42,
                            height: height * 0.07,
                            child: AppFormField(
                              isLabel: true,
                              labelText: 'Mr / Mrs / Miss',
                              isDense: true,
                              controller: leadsCtrl.prefixCtrl,
                            ),
                          ),
                        ],
                      ),

                      //First Name
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          title(txt: 'First Name:*'),
                          SizedBox(
                            width: width * 0.42,
                            height: height * 0.07,
                            child: AppFormField(
                              isLabel: true,
                              labelText: 'First Name',
                              isDense: true,
                              controller: leadsCtrl.firstNameCtrl,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //Middle Name
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          title(txt: 'Middle Name:'),
                          SizedBox(
                            width: width * 0.42,
                            height: height * 0.07,
                            child: AppFormField(
                              isLabel: true,
                              labelText: 'Middle Name',
                              isDense: true,
                              controller: leadsCtrl.middleNameCtrl,
                            ),
                          ),
                        ],
                      ),

                      //Last Name
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          title(txt: 'Last Name:'),
                          SizedBox(
                            width: width * 0.42,
                            height: height * 0.07,
                            child: AppFormField(
                              isLabel: true,
                              labelText: 'Last Name',
                              isDense: true,
                              controller: leadsCtrl.lastNameCtrl,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),

            if(leadsCtrl.isBusiness)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  title(txt: 'Business Name:'),
                  SizedBox(
                    width: width * 0.42,
                    height: height * 0.07,
                    child: AppFormField(
                      isLabel: true,
                      labelText: 'Business Name',
                      isDense: true,
                      controller: leadsCtrl.businessNameCtrl,
                    ),
                  ),
                ],
              ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Mobile
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    title(txt: 'Mobile:*'),
                    SizedBox(
                      width: width * 0.42,
                      height: height * 0.07,
                      child: AppFormField(
                        isLabel: true,
                        labelText: 'Mobile',
                        isDense: true,
                        controller: leadsCtrl.mobileCtrl,
                      ),
                    ),
                  ],
                ),

                //Alternate Contact Number
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    title(txt: 'Alternate Contact No:'),
                    SizedBox(
                      width: width * 0.42,
                      height: height * 0.07,
                      child: AppFormField(
                        isLabel: true,
                        labelText: 'Alternate mobile number',
                        isDense: true,
                        controller: leadsCtrl.alternateContactCtrl,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Landline
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    title(txt: 'Landline:'),
                    SizedBox(
                      width: width * 0.42,
                      height: height * 0.07,
                      child: AppFormField(
                        isLabel: true,
                        labelText: 'Landline',
                        isDense: true,
                        controller: leadsCtrl.landlineCtrl,
                      ),
                    ),
                  ],
                ),

                //Email
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    title(txt: 'Email:'),
                    SizedBox(
                      width: width * 0.42,
                      height: height * 0.07,
                      child: AppFormField(
                        isLabel: true,
                        labelText: 'Email',
                        isDense: true,
                        controller: leadsCtrl.emailCtrl,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Source Drop Down
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    title(txt: 'Source:*'),
                    SizedBox(
                      width: width * 0.42,
                      height: height * 0.05,
                      child: SourceDropDown(),
                    ),
                  ],
                ),
                //LifeStage Category Drop Down
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    title(txt: 'Life Stage:*'),
                    SizedBox(
                      width: width * 0.42,
                      height: height * 0.05,
                      child: LifeStageDropDown(),
                    ),
                  ],
                ),
              ],
            ),

            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if(leadsCtrl.isIndividual)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      title(txt: 'Date of birth:'),
                      SizedBox(
                        width: width * 0.42,
                        height: height * 0.07,
                        child: AppFormField(
                          isLabel: true,
                          labelText: 'Date of birth',
                          controller: leadsCtrl.startDateTimeCtrl,
                          onTap: (){
                            leadsCtrl.showStartDateTimePicker(context);
                          },
                        ),
                      )
                    ],
                  ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    title(txt: 'Assigned to:*'),
                    SizedBox(
                      width: width * 0.42,
                      height: height * 0.05,
                      child: AssignedToDropDown(),
                    ),
                  ],
                ),



              ],
            )

          ],
        ),
      ),
    );
  }

}
