import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../Components/custom_circular_button.dart';
import '../../Components/textfield.dart';
import '../../Config/utils.dart';
import '../../Controllers/ContactController/ContactController.dart';
import '../../Controllers/ListUserController/ListUserController.dart';
import '../../Theme/colors.dart';
import '../../Theme/style.dart';

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
    contactCtrlObj.clearAllContactCtrl();

    // TODO: implement initState
    super.initState();
  }

  Future trnImage() async {
    try {
      //final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      final XFile? image =
      await ImagePicker().pickImage(source: ImageSource.gallery);
      int? fileSizeInBytes = await image?.length();
      double fileSizeInKB = fileSizeInBytes! / 1024;
      double fileSizeInMB = fileSizeInKB / 1024;
      print('size ${fileSizeInMB}');
      print(fileSizeInMB);
      if (image != null && fileSizeInMB <= 1) {
        final imageTemporary = File(image.path);
        setState(() {
          contactCtrlObj.image = imageTemporary;
        });
      } else if (fileSizeInMB > 1) {
        return showToast("File size is greater than 1MB");
      } else {
        return showToast('no_image_picked'.tr);
      }
    } on PlatformException catch (ex) {
      print('Failed to pick Image: $ex');
    }
  }

  Future licenseImage() async {
    try {
      //final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      final XFile? image =
      await ImagePicker().pickImage(source: ImageSource.gallery);
      int? fileSizeInBytes = await image?.length();
      double fileSizeInKB = fileSizeInBytes! / 1024;
      double fileSizeInMB = fileSizeInKB / 1024;
      print('size ${fileSizeInMB}');
      print(fileSizeInMB);
      if (image != null && fileSizeInMB <= 1) {
        final imageTemporary = File(image.path);
        setState(() {
          contactCtrlObj.image2 = imageTemporary;
        });
      } else if (fileSizeInMB > 1) {
        return showToast("File size is greater than 1MB");
      } else {
        return showToast('no_image_picked'.tr);
      }
    } on PlatformException catch (ex) {
      print('Failed to pick Image: $ex');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
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
              crossAxisAlignment: CrossAxisAlignment.start,
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
                                  'individual'.tr,
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
                                  'business'.tr,
                                  style: TextStyle(color: blackColor),
                                )),
                          ),
                        ],
                      );
                    }),
                if (contactCtrlObj.businessYes == true)
                // Business name
                  AppFormField(
                    fontWeight: false,
                    validator: (String? v) {
                      if (v!.isEmpty) return 'field_required'.tr;
                      return null;
                    },
                    labelText: 'business_name'.tr,
                    controller: contactCtrlObj.businessNameCtrl,
                  ),
                if (contactCtrlObj.indiviualYes == true ||
                    contactCtrlObj.businessYes == true)
                  AppFormField(
                    fontWeight: false,
                    validator: (String? v) {
                      if (v!.isEmpty) return 'field_required'.tr;
                      return null;
                    },
                    labelText: contactCtrlObj.businessYes == true
                        ? 'person_name'.tr
                        : 'first_name'.tr,
                    controller: contactCtrlObj.firstNameCtrl,
                  ),
                if (contactCtrlObj.indiviualYes == true)
                  Column(
                    children: [
                      // AppFormField(
                      //   fontWeight: false,
                      //   labelText: 'prefix'.tr,
                      //   controller: contactCtrlObj.prefixCtrl,
                      // ),

                      // AppFormField(
                      //   fontWeight: false,
                      //   labelText: 'middle_name'.tr,
                      //   controller: contactCtrlObj.middleNameCtrl,
                      // ),
                      AppFormField(
                        fontWeight: false,
                        labelText: 'last_name'.tr,
                        controller: contactCtrlObj.lastNameCtrl,
                      ),
                    ],
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
                  labelText: 'alternate_contact_number'.tr,
                  controller: contactCtrlObj.alternateMblNbrNumberCtrl,
                  keyboardType: TextInputType.number,
                ),
                // street
                AppFormField(
                  fontWeight: false,
                  labelText: 'landline'.tr,
                  controller: contactCtrlObj.landLineCtrl,
                  keyboardType: TextInputType.number,
                ),
                // villa, building, apartment
                AppFormField(
                  fontWeight: false,
                  labelText: 'email'.tr,
                  controller: contactCtrlObj.emailCtrl,
                ),
                //
                // GetBuilder<ListUserController>(
                //     builder: (ListUserController listUserCtrll) {
                //   if (listUserCtrll.listuserModel != null)
                //     return DropdownButtonHideUnderline(
                //       child: DropdownButton2(
                //         isExpanded: true,
                //         hint: Align(
                //             alignment: AlignmentDirectional.centerStart,
                //             child: Text(
                //               'assigned_to'.tr,
                //               style: TextStyle(
                //                 fontSize: 13,
                //                 fontWeight: FontWeight.w400,
                //                 color: txtFieldHintColor,
                //               ),
                //             )),
                //         items: contactCtrlObj
                //             .assignedToList(listUserCtrll)
                //             .map((e) {
                //           return DropdownMenuItem(
                //               value: e,
                //               child: Text(
                //                 e,
                //                 style: TextStyle(fontSize: 14),
                //               ));
                //         }).toList(),
                //         value: contactCtrlObj.statusValue,
                //         dropdownDirection: DropdownDirection.textDirection,
                //         dropdownMaxHeight:
                //             MediaQuery.of(context).size.height * 0.2,
                //         dropdownPadding: EdgeInsets.only(left: 5, right: 5),
                //         buttonPadding: EdgeInsets.only(left: 15, right: 15),
                //         onChanged: (String? value) {
                //           setState(() {
                //             contactCtrlObj.statusValue = value;
                //           });
                //         },
                //         // buttonHeight: height * 0.06,
                //         // buttonWidth: width * 0.43,
                //         buttonDecoration: BoxDecoration(
                //             border: Border.all(
                //                 width: 1,
                //                 color: Theme.of(context).colorScheme.primary),
                //             borderRadius: BorderRadius.circular(15),
                //             color: kWhiteColor),
                //         itemHeight: 40,
                //         itemPadding: EdgeInsets.zero,
                //         itemHighlightColor:
                //             Theme.of(context).colorScheme.primary,
                //       ),
                //     );
                //   else
                //     return progressIndicator();
                // }),
                // SizedBox(
                //   height: 20,
                // ),

                AppFormField(
                  fontWeight: false,
                  labelText: 'trn'.tr,
                  controller: contactCtrlObj.trnCtrl,
                  keyboardType: TextInputType.number,
                ),
                Text(
                  'trn_upload'.tr,
                  style: appBarHeaderStyle,
                ),
                GestureDetector(
                  onTap: () {
                    trnImage();
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.16,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: kHintColor.withOpacity(0.3)),
                    child: (contactCtrlObj.image != null)
                        ? Center(
                      child: Image.file(
                        contactCtrlObj.image!,
                        fit: BoxFit.contain,
                      ),
                    )
                        : Center(
                      child: Icon(
                        Icons.add,
                        size: 30,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                AppFormField(
                  fontWeight: false,
                  labelText: 'license_small'.tr,
                  controller: contactCtrlObj.licenseCtrl,
                ),
                Text(
                  'license_upload'.tr,
                  style: appBarHeaderStyle,
                ),
                GestureDetector(
                  onTap: () {
                    licenseImage();
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.16,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: kHintColor.withOpacity(0.3)),
                    child: (contactCtrlObj.image2 != null)
                        ? Center(
                      child: Image.file(
                        contactCtrlObj.image2!,
                        fit: BoxFit.contain,
                      ),
                    )
                        : Center(
                      child: Icon(
                        Icons.add,
                        size: 30,
                      ),
                    ),
                  ),
                ),
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
