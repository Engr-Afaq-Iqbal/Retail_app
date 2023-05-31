import 'package:bizmodo_emenu/Config/utils.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Components/custom_circular_button.dart';
import '../../Components/textfield.dart';
import '../../Controllers/ContactController/ContactController.dart';
import '../../Controllers/ListUserController/ListUserController.dart';
import '../../Theme/colors.dart';

class CreateNewCustomer extends StatefulWidget {
  const CreateNewCustomer({Key? key}) : super(key: key);

  @override
  State<CreateNewCustomer> createState() => _CreateNewCustomerState();
}

class _CreateNewCustomerState extends State<CreateNewCustomer> {
  final ContactController contactCtrlObj = Get.find<ContactController>();
  ListUserController listUserCtrl = Get.find<ListUserController>();
  final GlobalKey<FormState> createContactFormKey = GlobalKey<FormState>();
  @override
  void initState() {
    listUserCtrl.fetchListUsers();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'create_new_customer'.tr,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Form(
            key: createContactFormKey,
            child: Column(
              children: [
                GetBuilder<ContactController>(
                    builder: (ContactController contactCtrl) {
                  return Row(
                    children: [
                      Expanded(
                        // height: 20,
                        // width: M,
                        child: CheckboxListTile(
                            value: contactCtrl.indiviualYes,
                            onChanged: (bool? value) {
                              setState(() {
                                contactCtrl.indiviualYes = value!;
                                contactCtrl.businessYes = false;
                                contactCtrl.businessNameCtrl.clear();
                                contactCtrl.update();
                              });
                            },
                            controlAffinity: ListTileControlAffinity.leading,
                            title: Text(
                              'Individual',
                              style: TextStyle(color: blackColor),
                            )),
                      ),
                      Expanded(
                        // height: 20,
                        // width: 20,
                        child: CheckboxListTile(
                            value: contactCtrl.businessYes,
                            onChanged: (bool? value) {
                              setState(() {
                                contactCtrl.businessYes = value!;
                                contactCtrl.indiviualYes = false;
                                contactCtrl.prefixCtrl.clear();
                                contactCtrl.firstNameCtrl.clear();
                                contactCtrl.middleNameCtrl.clear();
                                contactCtrl.lastNameCtrl.clear();
                                contactCtrl.update();
                              });
                            },
                            controlAffinity: ListTileControlAffinity.leading,
                            title: Text(
                              'Business',
                              style: TextStyle(color: blackColor),
                            )),
                      ),
                    ],
                  );
                }),
                if (contactCtrlObj.indiviualYes == true)
                  Column(
                    children: [
                      AppFormField(
                        fontWeight: false,
                        labelText: 'Prefix',
                        controller: contactCtrlObj.prefixCtrl,
                      ),
                      AppFormField(
                        fontWeight: false,
                        validator: (String? v) {
                          if (v!.isEmpty) return 'field_required'.tr;
                          return null;
                        },
                        labelText: 'First Name',
                        controller: contactCtrlObj.firstNameCtrl,
                      ),
                      AppFormField(
                        fontWeight: false,
                        labelText: 'Middle Name',
                        controller: contactCtrlObj.middleNameCtrl,
                      ),
                      AppFormField(
                        fontWeight: false,
                        labelText: 'Last Name',
                        controller: contactCtrlObj.lastNameCtrl,
                      ),
                    ],
                  ),

                if (contactCtrlObj.businessYes == true)
                  // Business name
                  AppFormField(
                    fontWeight: false,
                    validator: (String? v) {
                      if (v!.isEmpty) return 'field_required'.tr;
                      return null;
                    },
                    labelText: 'Business Name',
                    controller: contactCtrlObj.businessNameCtrl,
                  ),
                // mobile phone
                AppFormField(
                  fontWeight: false,
                  validator: (String? v) {
                    if (v!.isEmpty) return 'field_required'.tr;
                    return null;
                  },
                  labelText: 'mobile_number'.tr,
                  controller: contactCtrlObj.mobileNumberCtrl,
                  keyboardType: TextInputType.number,
                ),
                // city
                AppFormField(
                  fontWeight: false,
                  readOnly: true,
                  labelText: 'Alternate Contact Number',
                  controller: contactCtrlObj.alternateMblNbrNumberCtrl,
                ),
                // street
                AppFormField(
                  fontWeight: false,
                  labelText: 'Landline',
                  controller: contactCtrlObj.landLineCtrl,
                ),
                // villa, building, apartment
                AppFormField(
                  fontWeight: false,
                  labelText: 'Email',
                  controller: contactCtrlObj.emailCtrl,
                ),

                GetBuilder<ListUserController>(
                    builder: (ListUserController listUserCtrll) {
                  if (listUserCtrll.listuserModel != null)
                    return DropdownButtonHideUnderline(
                      child: DropdownButton2(
                        isExpanded: true,
                        hint: Align(
                            alignment: AlignmentDirectional.centerStart,
                            child: Text(
                              'Assigned To',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                color: txtFieldHintColor,
                              ),
                            )),
                        items: contactCtrlObj
                            .assignedToList(listUserCtrll)
                            .map((e) {
                          return DropdownMenuItem(
                              value: e,
                              child: Text(
                                e,
                                style: TextStyle(fontSize: 14),
                              ));
                        }).toList(),
                        value: contactCtrlObj.statusValue,
                        dropdownDirection: DropdownDirection.textDirection,
                        dropdownMaxHeight:
                            MediaQuery.of(context).size.height * 0.2,
                        dropdownPadding: EdgeInsets.only(left: 5, right: 5),
                        buttonPadding: EdgeInsets.only(left: 15, right: 15),
                        onChanged: (String? value) {
                          setState(() {
                            contactCtrlObj.statusValue = value;
                          });
                        },
                        // buttonHeight: height * 0.06,
                        // buttonWidth: width * 0.43,
                        buttonDecoration: BoxDecoration(
                            border: Border.all(
                                width: 1,
                                color: Theme.of(context).colorScheme.primary),
                            borderRadius: BorderRadius.circular(15),
                            color: kWhiteColor),
                        itemHeight: 40,
                        itemPadding: EdgeInsets.zero,
                        itemHighlightColor:
                            Theme.of(context).colorScheme.primary,
                      ),
                    );
                  else
                    return progressIndicator();
                }),

                SizedBox(
                  height: 30,
                ),
                CustomButton(
                  margin: const EdgeInsets.all(5),
                  onTap: () async {
                    if (!createContactFormKey.currentState!.validate()) {
                      return;
                    } else {
                      showProgress();
                      await contactCtrlObj.createContactForRetailApp();
                    }
                  },
                  btnTxt: 'submit'.tr,
                  bgColor: Theme.of(context).colorScheme.primary,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
