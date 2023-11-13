import 'package:bizmodo_emenu/Components/custom_circular_button.dart';
import 'package:bizmodo_emenu/Controllers/CRMControllers/ContactsLogin/contactsLoginController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Components/textfield.dart';
import '../../../Theme/colors.dart';
import '../../../Theme/style.dart';
import '../../../const/dimensions.dart';
import 'ContactsLoginWidgets/contactsDropDown.dart';

class AddContactsLogin extends StatefulWidget {
  const AddContactsLogin({super.key});

  @override
  State<AddContactsLogin> createState() => _AddContactsLoginState();
}

class _AddContactsLoginState extends State<AddContactsLogin> {
  ContactsLoginController contactsLoginCtrl = Get.find<ContactsLoginController>();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('All Contacts Login'),
      ),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(

          children: [
            Container(
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
              child: Column(
                // key: ValueKey(widget.index),
                crossAxisAlignment: CrossAxisAlignment.start,
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
                              controller: contactsLoginCtrl.prefixContact1Ctrl,
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
                              controller: contactsLoginCtrl.firstNameCtrl,
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
                              controller: contactsLoginCtrl.prefixCtrl,
                            ),
                          ),
                        ],
                      ),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          title(txt: 'Contact:*'),
                          SizedBox(
                            width: width * 0.42,
                            height: height * 0.05,
                            child: ContactsDropDown(),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                              controller: contactsLoginCtrl.firstNameCtrl,
                            ),
                          ),
                        ],
                      ),
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
                              controller: contactsLoginCtrl.prefixCtrl,
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
                      //Alternate COntact no
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
                              controller: contactsLoginCtrl.firstNameCtrl,
                            ),
                          ),
                        ],
                      ),
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
                              controller: contactsLoginCtrl.prefixCtrl,
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
                              controller: contactsLoginCtrl.firstNameCtrl,
                            ),
                          ),
                        ],
                      ),
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
                              controller: contactsLoginCtrl.prefixCtrl,
                            ),
                          ),
                        ],
                      ),


                    ],
                  ),

                  //Sales Comission
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
                          controller: contactsLoginCtrl.firstNameCtrl,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Checkbox(
                        value: contactsLoginCtrl.isActive1,
                        onChanged: (bool? value) {
                          setState(() {
                            contactsLoginCtrl.isActive1 = value!;
                          });
                        },
                      ),
                      // SizedBox(width: 5,),
                      title(txt: 'Is Active?'),
                    ],
                  ),
                  Row(
                    children: [
                      Checkbox(
                        value: contactsLoginCtrl.isAllowLogin1,
                        onChanged: (bool? value) {
                          setState(() {
                            contactsLoginCtrl.isAllowLogin1 = value!;
                          });
                        },
                      ),
                      // SizedBox(width: 5,),
                      title(txt: 'Allow login'),
                    ],
                  ),
                  if(contactsLoginCtrl.isAllowLogin1)
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
                                controller: contactsLoginCtrl.userNameContact1Ctrl,
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
                                controller: contactsLoginCtrl.passwordContact1Ctrl,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  if(contactsLoginCtrl.isAllowLogin1)
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
                                controller: contactsLoginCtrl.confirmPasswordContact1Ctrl,
                              ),
                            ),
                          ],
                        ),

                      ],
                    ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CustomButton(
                        title: Text('Close',style: TextStyle(color: kWhiteColor),),
                        onTap: (){
                          Get.back();
                        },
                      ),
                      SizedBox(width: 10,),
                      CustomButton(
                        title: Text('Save',style: TextStyle(color: kWhiteColor),),
                        onTap: (){},
                      ),
                    ],
                  )

                ],
              ),
            ),
          ],
        ),
      )
    );
  }
}
