import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/Components/textfield.dart';
import '/Config/utils.dart';
import '/Controllers/ContactController/ContactController.dart';
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
        elevation: 0,
        centerTitle: true,
        title: Text(
          'customer_details'.tr,
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
                      'customer_information'.tr,
                      style: appBarHeaderStyle,
                    )
                  ],
                ),
                SizedBox(
                  height: h * 0.02,
                ),
                AppFormField(
                  labelText: 'prefix'.tr,
                  readOnly: true,
                  controller: contactCtrl.prefixCtrl,
                ),
                AppFormField(
                  readOnly: true,
                  validator: (String? v) {
                    if (v!.isEmpty) return 'field_required'.tr;
                    return null;
                  },
                  labelText: 'first_name'.tr,
                  controller: contactCtrl.firstNameCtrl,
                ),
                AppFormField(
                  labelText: 'middle_name'.tr,
                  readOnly: true,
                  controller: contactCtrl.middleNameCtrl,
                ),
                AppFormField(
                  labelText: 'last_name'.tr,
                  readOnly: true,
                  controller: contactCtrl.lastNameCtrl,
                ),
                AppFormField(
                  readOnly: true,
                  // validator: (String? v) {
                  //   if (v!.isEmpty) return 'field_required'.tr;
                  //   return null;
                  // },
                  labelText: 'business_name'.tr,
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
                  labelText: 'alternate_contact_number'.tr,
                  controller: contactCtrl.alternateMblNbrNumberCtrl,
                ),
                // street
                AppFormField(
                  readOnly: true,
                  labelText: 'landline'.tr,
                  controller: contactCtrl.landLineCtrl,
                ),
                // villa, building, apartment
                AppFormField(
                  labelText: 'email'.tr,
                  readOnly: true,
                  controller: contactCtrl.emailCtrl,
                ),
                AppFormField(
                  labelText: 'trn'.tr,
                  readOnly: true,
                  controller: contactCtrl.trnCtrl,
                ),
                AppFormField(
                  labelText: 'license_small'.tr,
                  readOnly: true,
                  controller: contactCtrl.licenseCtrl,
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
