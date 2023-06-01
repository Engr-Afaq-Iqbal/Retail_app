import 'package:bizmodo_emenu/Config/utils.dart';
import 'package:bizmodo_emenu/Controllers/ContactController/ContactController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/Components/textfield.dart';
import '/Theme/colors.dart';
import '/Theme/style.dart';

class ShowCustomerDetails extends StatefulWidget {
  final String contactApi;
  ShowCustomerDetails({Key? key, required this.contactApi}) : super(key: key);

  @override
  State<ShowCustomerDetails> createState() => _ShowCustomerDetailsState();
}

class _ShowCustomerDetailsState extends State<ShowCustomerDetails> {
  ContactController contactCtrlObj = Get.find<ContactController>();
  @override
  void initState() {
    // TODO: implement initState
    contactCtrlObj.fetchSpecifiedContactList(contactApi: widget.contactApi);
    super.initState();
  }

  void dispose() {
    contactCtrlObj.clearAllContactCtrl();
    contactCtrlObj.getSpecificContactModel = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Customer Details',
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: kWhiteColor,
          //boxShadow: [settingsPageBoxShadow()],
        ),
        child: GetBuilder<ContactController>(
            builder: (ContactController contactCtrl) {
          if (contactCtrl.getSpecificContactModel == null)
            return progressIndicator();
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.person,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    Text(
                      'Customer Information',
                      style: appBarHeaderStyle,
                    )
                  ],
                ),
                SizedBox(
                  height: h * 0.02,
                ),
                AppFormField(
                  labelText: 'Prefix',
                  readOnly: true,
                  controller: contactCtrl.prefixCtrl,
                ),
                AppFormField(
                  readOnly: true,
                  validator: (String? v) {
                    if (v!.isEmpty) return 'field_required'.tr;
                    return null;
                  },
                  labelText: 'First Name',
                  controller: contactCtrl.firstNameCtrl,
                ),
                AppFormField(
                  labelText: 'Middle Name',
                  readOnly: true,
                  controller: contactCtrl.middleNameCtrl,
                ),
                AppFormField(
                  labelText: 'Last Name',
                  readOnly: true,
                  controller: contactCtrl.lastNameCtrl,
                ),
                AppFormField(
                  readOnly: true,
                  // validator: (String? v) {
                  //   if (v!.isEmpty) return 'field_required'.tr;
                  //   return null;
                  // },
                  labelText: 'Business Name',
                  controller: contactCtrl.businessNameCtrl,
                ),
                // mobile phone
                AppFormField(
                  // validator: (String? v) {
                  //   if (v!.isEmpty) return 'field_required'.tr;
                  //   return null;
                  // },
                  readOnly: true,
                  labelText: 'mobile_number'.tr,
                  controller: contactCtrl.mobileNumberCtrl,
                  keyboardType: TextInputType.number,
                ),
                AppFormField(
                  readOnly: true,
                  labelText: 'Alternate Contact Number',
                  controller: contactCtrl.alternateMblNbrNumberCtrl,
                ),
                // street
                AppFormField(
                  readOnly: true,
                  labelText: 'Landline',
                  controller: contactCtrl.landLineCtrl,
                ),
                // villa, building, apartment
                AppFormField(
                  labelText: 'Email',
                  readOnly: true,
                  controller: contactCtrl.emailCtrl,
                ),
                SizedBox(
                  height: h * 0.02,
                ),
                Divider(),
              ],
            ),
          );
        }),
      ),
    );
  }
}
