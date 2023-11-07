import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../Components/textfield.dart';
import '../../../../Controllers/CRMControllers/LeadsController/leadsController.dart';

class AddContactPersonsDetails extends StatefulWidget {
  bool isContactPerson1;
  bool isContactPerson2;
  bool isContactPerson3;
  int index;
  AddContactPersonsDetails({super.key, this.isContactPerson1 = true, required this.isContactPerson2, required this.isContactPerson3, required this.index});

  @override
  State<AddContactPersonsDetails> createState() => _AddContactPersonsDetailsState();
}

class _AddContactPersonsDetailsState extends State<AddContactPersonsDetails> {
  LeadsController leadsCtrl = Get.find<LeadsController>();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Column(
      // key: ValueKey(widget.index),
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
                    controller: leadsCtrl.prefixContact1Ctrl,
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
            //Last name
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
                    controller: leadsCtrl.prefixCtrl,
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
            //Mobile Number
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                title(txt: 'Mobile Number:'),
                SizedBox(
                  width: width * 0.42,
                  height: height * 0.07,
                  child: AppFormField(
                    isLabel: true,
                    labelText: 'Mobile Number',
                    isDense: true,
                    controller: leadsCtrl.prefixCtrl,
                  ),
                ),
              ],
            ),

            //Email
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                title(txt: 'Alternate Contact No:'),
                SizedBox(
                  width: width * 0.42,
                  height: height * 0.07,
                  child: AppFormField(
                    isLabel: true,
                    labelText: 'Alternate Contact No',
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
            //Family Contact Number
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                title(txt: 'Family Contact No:'),
                SizedBox(
                  width: width * 0.42,
                  height: height * 0.07,
                  child: AppFormField(
                    isLabel: true,
                    labelText: 'Family Contact No',
                    isDense: true,
                    controller: leadsCtrl.prefixCtrl,
                  ),
                ),
              ],
            ),

            //Department
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                title(txt: 'Department:'),
                SizedBox(
                  width: width * 0.42,
                  height: height * 0.07,
                  child: AppFormField(
                    isLabel: true,
                    labelText: 'Department',
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
            //Designation
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                title(txt: 'Designation:'),
                SizedBox(
                  width: width * 0.42,
                  height: height * 0.07,
                  child: AppFormField(
                    isLabel: true,
                    labelText: 'Designation',
                    isDense: true,
                    controller: leadsCtrl.prefixCtrl,
                  ),
                ),
              ],
            ),

            //Department
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                title(txt: 'Sales Commission (%):'),
                SizedBox(
                  width: width * 0.42,
                  height: height * 0.07,
                  child: AppFormField(
                    isLabel: true,
                    labelText: 'Sales Commission Percentage (%)',
                    isDense: true,
                    controller: leadsCtrl.firstNameCtrl,
                  ),
                ),
              ],
            ),
          ],
        ),
        Row(
          children: [
            Checkbox(
              value: leadsCtrl.isAllowLogin1,
              onChanged: (bool? value) {
                setState(() {
                  leadsCtrl.isAllowLogin1 = value!;
                });
              },
            ),
            // SizedBox(width: 5,),
            title(txt: 'Allow login'),
          ],
        ),
        if(leadsCtrl.isAllowLogin1)
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Username
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                title(txt: 'Username:*'),
                SizedBox(
                  width: width * 0.42,
                  height: height * 0.07,
                  child: AppFormField(
                    isLabel: true,
                    labelText: 'Username',
                    isDense: true,
                    controller: leadsCtrl.userNameContact1Ctrl,
                  ),
                ),
              ],
            ),

            //Password
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                title(txt: 'Password:*'),
                SizedBox(
                  width: width * 0.42,
                  height: height * 0.07,
                  child: AppFormField(
                    isLabel: true,
                    labelText: 'Password',
                    isDense: true,
                    controller: leadsCtrl.passwordContact1Ctrl,
                  ),
                ),
              ],
            ),
          ],
        ),
        if(leadsCtrl.isAllowLogin1)
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Confirm Password
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                title(txt: 'Confirm Password:*'),
                SizedBox(
                  width: width * 0.42,
                  height: height * 0.07,
                  child: AppFormField(
                    isLabel: true,
                    labelText: 'Confirm Password',
                    isDense: true,
                    controller: leadsCtrl.confirmPasswordContact1Ctrl,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Checkbox(
                  value: leadsCtrl.isActive1,
                  onChanged: (bool? value) {
                    setState(() {
                      leadsCtrl.isActive1 = value!;
                    });
                  },
                ),
                // SizedBox(width: 5,),
                title(txt: 'Is Active?'),
              ],
            ),
          ],
        ),

      ],
    );
  }
  title({String? txt}){
    return Text('$txt', overflow: TextOverflow.ellipsis,style: TextStyle(fontWeight: FontWeight.bold),);
  }
}
