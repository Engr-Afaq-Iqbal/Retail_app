import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../Components/textfield.dart';
import '../../../../Config/const.dart';
import '../../../../Controllers/CRMControllers/LeadsController/leadsController.dart';
import '../../../../Theme/colors.dart';
import '../../../../const/dimensions.dart';

class AddLeadsMoreInfo extends StatefulWidget {
  const AddLeadsMoreInfo({super.key});

  @override
  State<AddLeadsMoreInfo> createState() => _AddLeadsMoreInfoState();
}

class _AddLeadsMoreInfoState extends State<AddLeadsMoreInfo> {
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
          color: kWhiteColor,
          boxShadow: [BoxShadow(
              blurRadius: 5,
              spreadRadius: 3,
              color: kHintColor.withOpacity(0.2)
          )]
      ),
      child: IntrinsicHeight(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Prefix
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    title(txt: 'Tax number:'),
                    SizedBox(
                      width: width * 0.42,
                      height: height * 0.07,
                      child: AppFormField(
                        isLabel: true,
                        labelText: 'Tax number',
                        isDense: true,
                        controller: leadsCtrl.taxNumberCtrl,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            AppConst.dividerLine(color: kHintColor.withOpacity(0.2)),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Address line 1
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    title(txt: 'Address line 1:'),
                    SizedBox(
                      width: width * 0.42,
                      height: height * 0.07,
                      child: AppFormField(
                        isLabel: true,
                        labelText: 'Address line 1',
                        isDense: true,
                        controller: leadsCtrl.addressLine1Ctrl,
                      ),
                    ),
                  ],
                ),

                //Address line 2
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    title(txt: 'Address line 2:'),
                    SizedBox(
                      width: width * 0.42,
                      height: height * 0.07,
                      child: AppFormField(
                        isLabel: true,
                        labelText: 'Address line 2',
                        isDense: true,
                        controller: leadsCtrl.addressLine2Ctrl,
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
                //City
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    title(txt: 'City:'),
                    SizedBox(
                      width: width * 0.42,
                      height: height * 0.07,
                      child: AppFormField(
                        isLabel: true,
                        labelText: 'City',
                        isDense: true,
                        controller: leadsCtrl.cityCtrl,
                      ),
                    ),
                  ],
                ),

                //State
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    title(txt: 'State:'),
                    SizedBox(
                      width: width * 0.42,
                      height: height * 0.07,
                      child: AppFormField(
                        isLabel: true,
                        labelText: 'State',
                        isDense: true,
                        controller: leadsCtrl.stateCtrl,
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
                //Country
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    title(txt: 'Country:'),
                    SizedBox(
                      width: width * 0.42,
                      height: height * 0.07,
                      child: AppFormField(
                        isLabel: true,
                        labelText: 'Country',
                        isDense: true,
                        controller: leadsCtrl.countryCtrl,
                      ),
                    ),
                  ],
                ),

                //Zip Code
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    title(txt: 'Zip Code:'),
                    SizedBox(
                      width: width * 0.42,
                      height: height * 0.07,
                      child: AppFormField(
                        isLabel: true,
                        labelText: 'Zip Code',
                        isDense: true,
                        controller: leadsCtrl.zipCodeCtrl,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            AppConst.dividerLine(color: kHintColor.withOpacity(0.2)),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Emirates ID
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    title(txt: 'Emirates ID:'),
                    SizedBox(
                      width: width * 0.42,
                      height: height * 0.07,
                      child: AppFormField(
                        isLabel: true,
                        labelText: 'Emirates ID',
                        isDense: true,
                        controller: leadsCtrl.emiratedIdCtrl,
                      ),
                    ),
                  ],
                ),

                //Passport No
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    title(txt: 'Passport No :'),
                    SizedBox(
                      width: width * 0.42,
                      height: height * 0.07,
                      child: AppFormField(
                        isLabel: true,
                        labelText: 'Passport No',
                        isDense: true,
                        controller: leadsCtrl.passportNoCtrl,
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
                //Trade License
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    title(txt: 'Trade License:'),
                    SizedBox(
                      width: width * 0.42,
                      height: height * 0.07,
                      child: AppFormField(
                        isLabel: true,
                        labelText: 'Trade License',
                        isDense: true,
                        controller: leadsCtrl.tradeLicenseCtrl,
                      ),
                    ),
                  ],
                ),

                //Custom Field 4
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
                        controller: leadsCtrl.customField4Ctrl,
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
                //Custom Field 5
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    title(txt: 'Custom Field 5:'),
                    SizedBox(
                      width: width * 0.42,
                      height: height * 0.07,
                      child: AppFormField(
                        isLabel: true,
                        labelText: 'Custom Field 5',
                        isDense: true,
                        controller: leadsCtrl.customField5Ctrl,
                      ),
                    ),
                  ],
                ),

                //Custom Field 6
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    title(txt: 'Custom Field 6:'),
                    SizedBox(
                      width: width * 0.42,
                      height: height * 0.07,
                      child: AppFormField(
                        isLabel: true,
                        labelText: 'Custom Field 6',
                        isDense: true,
                        controller: leadsCtrl.customField6Ctrl,
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
                //Custom Field 7
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    title(txt: 'Custom Field 7:'),
                    SizedBox(
                      width: width * 0.42,
                      height: height * 0.07,
                      child: AppFormField(
                        isLabel: true,
                        labelText: 'Custom Field 7',
                        isDense: true,
                        controller: leadsCtrl.customField7Ctrl,
                      ),
                    ),
                  ],
                ),

                //Custom Field 8
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    title(txt: 'Custom Field 8:'),
                    SizedBox(
                      width: width * 0.42,
                      height: height * 0.07,
                      child: AppFormField(
                        isLabel: true,
                        labelText: 'Custom Field 8',
                        isDense: true,
                        controller: leadsCtrl.customField8Ctrl,
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
                //Custom Field 9
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    title(txt: 'Custom Field 9:'),
                    SizedBox(
                      width: width * 0.42,
                      height: height * 0.07,
                      child: AppFormField(
                        isLabel: true,
                        labelText: 'Custom Field 9',
                        isDense: true,
                        controller: leadsCtrl.customField9Ctrl,
                      ),
                    ),
                  ],
                ),

                //Custom Field 10
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    title(txt: 'Custom Field 10:'),
                    SizedBox(
                      width: width * 0.42,
                      height: height * 0.07,
                      child: AppFormField(
                        isLabel: true,
                        labelText: 'Custom Field 10',
                        isDense: true,
                        controller: leadsCtrl.customField10Ctrl,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  title({String? txt}){
    return Text('$txt', style: TextStyle(fontWeight: FontWeight.bold),);
  }
}
