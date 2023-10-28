import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Components/custom_circular_button.dart';
import '../../Config/utils.dart';
import '../../Controllers/ContactController/ContactController.dart';
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
        elevation: 0,
        centerTitle: true,
        title: Text(
          'customer_details'.tr,
        ),
        actions: [
          GetBuilder<ContactController>(
              builder: (ContactController contactCtrl) {
                return CustomButton(
                  onTap: () {
                    if (contactCtrl.isForEdit == true) {
                      contactCtrl.isForEdit = false;
                      contactCtrl.update();
                    } else if (contactCtrl.isForEdit == false) {
                      contactCtrl.isForEdit = true;
                      contactCtrl.update();
                    }
                  },
                  title: Text(
                    contactCtrl.isForEdit == true ? 'edit'.tr : 'view'.tr,
                    style: TextStyle(color: kWhiteColor),
                  ),
                );
              }),
          SizedBox(
            width: 10,
          )
        ],
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
                      readOnly: contactCtrl.isForEdit == true ? true : false,
                      controller: contactCtrl.prefixCtrl,
                    ),
                    AppFormField(
                      readOnly: contactCtrl.isForEdit == true ? true : false,
                      validator: (String? v) {
                        if (v!.isEmpty) return 'field_required'.tr;
                        return null;
                      },
                      labelText: 'first_name'.tr,
                      controller: contactCtrl.firstNameCtrl,
                    ),
                    AppFormField(
                      labelText: 'middle_name'.tr,
                      readOnly: contactCtrl.isForEdit == true ? true : false,
                      controller: contactCtrl.middleNameCtrl,
                    ),
                    AppFormField(
                      labelText: 'last_name'.tr,
                      readOnly: contactCtrl.isForEdit == true ? true : false,
                      controller: contactCtrl.lastNameCtrl,
                    ),
                    AppFormField(
                      readOnly: contactCtrl.isForEdit == true ? true : false,
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
                      readOnly: contactCtrl.isForEdit == true ? true : false,
                      labelText: 'mobile_number'.tr,
                      controller: contactCtrl.mobileNumberCtrl,
                      keyboardType: TextInputType.number,
                    ),
                    AppFormField(
                      readOnly: contactCtrl.isForEdit == true ? true : false,
                      labelText: 'alternate_contact_number'.tr,
                      controller: contactCtrl.alternateMblNbrNumberCtrl,
                    ),
                    // street
                    AppFormField(
                      readOnly: contactCtrl.isForEdit == true ? true : false,
                      labelText: 'landline'.tr,
                      controller: contactCtrl.landLineCtrl,
                    ),
                    // villa, building, apartment
                    AppFormField(
                      labelText: 'email'.tr,
                      readOnly: contactCtrl.isForEdit == true ? true : false,
                      controller: contactCtrl.emailCtrl,
                    ),
                    AppFormField(
                      labelText: 'trn'.tr,
                      readOnly: contactCtrl.isForEdit == true ? true : false,
                      controller: contactCtrl.trnCtrl,
                    ),
                    AppFormField(
                      labelText: 'license_small'.tr,
                      readOnly: contactCtrl.isForEdit == true ? true : false,
                      controller: contactCtrl.licenseCtrl,
                    ),
                    SizedBox(
                      height: h * 0.02,
                    ),
                    // Divider(),
                    if (contactCtrl.isForEdit == false)
                      CustomButton(
                        onTap: () {
                          showProgress();
                          contactCtrl.updateContactCustomer(
                              contactApi: widget.contactApi);
                        },
                        title: Text(
                          'update'.tr,
                          style: TextStyle(color: kWhiteColor),
                        ),
                      )
                  ],
                ),
              );
            }),
      ),
    );
  }
}
