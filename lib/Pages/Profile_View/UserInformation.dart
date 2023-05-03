import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/Components/textfield.dart';
import '/Theme/colors.dart';
import '/Theme/style.dart';
import '../../Controllers/ListUserController/ListUserController.dart';

class UserInformation extends StatefulWidget {
  const UserInformation({Key? key}) : super(key: key);

  @override
  State<UserInformation> createState() => _UserInformationState();
}

class _UserInformationState extends State<UserInformation> {
  TextEditingController ctrl = TextEditingController();
  ListUserController userInfoCtrlObj = Get.find<ListUserController>();
  @override
  void initState() {
    // TODO: implement initState
    userInfoCtrlObj.functionStoreValue();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    bool isScreenWide = MediaQuery.of(context).size.width >= 1200;
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: kWhiteColor,
        //boxShadow: [settingsPageBoxShadow()],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: h * 0.02,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.person,
                color: primaryColor,
              ),
              Text(
                'user_information'.tr,
                style: appBarHeaderStyle,
              )
            ],
          ),

          SizedBox(
            height: h * 0.02,
          ),
          Text(
            'more_information'.tr,
            style: appBarHeaderStyle,
          ),
          SizedBox(
            height: h * 0.01,
          ),

          ///Profile Information
          AppFormField(
            readOnly: true,
            // labelText: AppStorage.getLoggedUserData()?.staffUser.dob ?? '- -',
            labelText: 'dob'.tr,
            controller: userInfoCtrlObj.dobCtrl,
            onTap: () {},
          ),
          AppFormField(
            readOnly: true,
            labelText: 'gender'
                .tr, //AppStorage.getLoggedUserData()?.staffUser.gender ?? '',
            // title: 'gender'.tr,
            controller: userInfoCtrlObj.genderCtrl,
            onTap: () {},
          ),
          AppFormField(
            readOnly: true,
            // labelText:
            //     AppStorage.getLoggedUserData()?.staffUser.maritalStatus ?? '',
            labelText: 'martial_status'.tr,
            controller: userInfoCtrlObj.martialStatusCtrl,
            onTap: () {},
          ),

          AppFormField(
            readOnly: true,
            // labelText:
            //     AppStorage.getLoggedUserData()?.staffUser.bloodGroup ?? '',
            labelText: 'blood_group'.tr,
            controller: userInfoCtrlObj.bloodGroupCtrl,
            onTap: () {},
          ),

          AppFormField(
            readOnly: true,
            // labelText:
            //     AppStorage.getLoggedUserData()?.staffUser.socialMedia1 ?? '',
            labelText: 'social_media'.tr,
            controller: userInfoCtrlObj.socialMediaCtrl,
            onTap: () {},
          ),
          AppFormField(
            readOnly: true,
            // labelText:
            //     AppStorage.getLoggedUserData()?.staffUser.socialMedia2 ?? '',
            labelText: 'social_media2'.tr,
            controller: userInfoCtrlObj.socialMedia2Ctrl,
            onTap: () {},
          ),
          AppFormField(
            readOnly: true,
            // labelText:
            //     AppStorage.getLoggedUserData()?.staffUser.contactNo ?? '',
            labelText: 'mobile_number'.tr,
            controller: userInfoCtrlObj.mobileNbrCtrl,
            onTap: () {},
          ),

          AppFormField(
            readOnly: true,
            // labelText:
            //     AppStorage.getLoggedUserData()?.staffUser.contactNumber ?? '',
            labelText: 'alternate_contact_number'.tr,
            controller: userInfoCtrlObj.alternativeMobileNbrCtrl,
            onTap: () {},
          ),

          AppFormField(
            readOnly: true,
            // labelText:
            //     AppStorage.getLoggedUserData()?.staffUser.familyNumber ?? '',
            labelText: 'family_contact_number'.tr,
            controller: userInfoCtrlObj.familyContactNbrCtrl,
            onTap: () {},
          ),
          AppFormField(
            readOnly: true,
            // labelText:
            //     AppStorage.getLoggedUserData()?.staffUser.idProofName ?? '',
            labelText: 'id_proof_name'.tr,
            controller: userInfoCtrlObj.idProofNameCtrl,
            onTap: () {},
          ),

          AppFormField(
            readOnly: true,
            // labelText:
            //     AppStorage.getLoggedUserData()?.staffUser.idProofNumber ?? '',
            labelText: 'id_proof_number'.tr,
            controller: userInfoCtrlObj.idProofNbrCtrl,
            onTap: () {},
          ),

          AppFormField(
            readOnly: true,
            // labelText: AppStorage.getLoggedUserData()?.staffUser.fbLink ?? '',
            labelText: 'facebook_link'.tr,
            controller: userInfoCtrlObj.faceBookLinkCtrl,
            onTap: () {},
          ),
          AppFormField(
            readOnly: true,
            // labelText:
            //     AppStorage.getLoggedUserData()?.staffUser.twitterLink ?? '',
            labelText: 'twitter_link'.tr,
            controller: userInfoCtrlObj.twitterLinkCtrl,
            onTap: () {},
          ),
          AppFormField(
            readOnly: true,
            // labelText:
            //     AppStorage.getLoggedUserData()?.staffUser.customField1 ?? '',
            labelText: 'custom_field1'.tr,
            controller: userInfoCtrlObj.customField1Ctrl,
            onTap: () {},
          ),

          AppFormField(
            readOnly: true,
            // labelText:
            //     AppStorage.getLoggedUserData()?.staffUser.customField2 ?? '',
            labelText: 'custom_field2'.tr,
            controller: userInfoCtrlObj.customField2Ctrl,
            onTap: () {},
          ),
          AppFormField(
            readOnly: true,
            // labelText:
            //     AppStorage.getLoggedUserData()?.staffUser.customField3 ?? '',
            labelText: 'custom_field3'.tr,
            controller: userInfoCtrlObj.customField3Ctrl,
            onTap: () {},
          ),

          AppFormField(
            readOnly: true,
            // labelText:
            //     AppStorage.getLoggedUserData()?.staffUser.customField4 ?? '',
            labelText: 'custom_field4'.tr,
            controller: userInfoCtrlObj.customField4Ctrl,
            onTap: () {},
          ),

          // Divider(
          //   color: Colors.grey,
          // ),
          // SizedBox(
          //   height: h * 0.01,
          // ),
          AppFormField(
            readOnly: true,
            // labelText:
            //     AppStorage.getLoggedUserData()?.staffUser.permanentAddress ?? '',
            labelText: 'permanent_address'.tr,
            controller: userInfoCtrlObj.permanentAddressCtrl,
            onTap: () {},
          ),

          AppFormField(
            readOnly: true,
            // labelText:
            //     AppStorage.getLoggedUserData()?.staffUser.currentAddress ?? '',
            labelText: 'current_address'.tr,
            controller: userInfoCtrlObj.currentAddressCtrl,
            onTap: () {},
          ),
          SizedBox(
            height: h * 0.02,
          ),
          Divider(),
          // SizedBox(
          //   height: h * 0.02,
          // ),
          // Text(
          //   'bank_details'.tr,
          //   style: appBarHeaderStyle,
          // ),
          // SizedBox(
          //   height: h * 0.02,
          // ),
          // Row(
          //   children: [
          //     Expanded(
          //       child: dataStyle(
          //           header: 'account_holder_name'.tr,
          //           details:
          //               '${AppStorage.getLoggedUserData()?.staffUser.bankDetails?.accountHolderName ?? '- -'}'),
          //     ),
          //     Expanded(
          //       child: dataStyle(
          //           header: 'bank_name'.tr,
          //           details:
          //               '${AppStorage.getLoggedUserData()?.staffUser.bankDetails?.bankName ?? '- -'}'),
          //     ),
          //     Expanded(
          //       child: dataStyle(
          //           header: 'branch'.tr,
          //           details:
          //               '${AppStorage.getLoggedUserData()?.staffUser.bankDetails?.branch ?? '- -'}'),
          //     )
          //   ],
          // ),
          // SizedBox(
          //   height: h * 0.02,
          // ),
          // Row(
          //   children: [
          //     Expanded(
          //       child: dataStyle(
          //           header: 'account_number'.tr,
          //           details:
          //               '${AppStorage.getLoggedUserData()?.staffUser.bankDetails?.accountNumber ?? '- -'}'),
          //     ),
          //     Expanded(
          //       child: dataStyle(
          //           header: 'bank_identifier_code'.tr,
          //           details:
          //               '${AppStorage.getLoggedUserData()?.staffUser.bankDetails?.bankCode ?? '- -'}'),
          //     ),
          //     Expanded(
          //       child: dataStyle(
          //           header: 'tax_payer_id'.tr,
          //           details:
          //               '${AppStorage.getLoggedUserData()?.staffUser.bankDetails?.taxPayerId ?? '- -'}'),
          //     )
          //   ],
          // ),
          // SizedBox(
          //   height: h * 0.02,
          // ),
          // Divider(),
          // SizedBox(
          //   height: h * 0.02,
          // ),
          // Text(
          //   'hrm_details'.tr,
          //   style: appBarHeaderStyle,
          // ),
          // SizedBox(
          //   height: h * 0.02,
          // ),
          // dataStyle(
          //     header: 'department'.tr,
          //     details:
          //         AppStorage.getLoggedUserData()?.staffUser.crmDepartment ??
          //             ''),
          // dataStyle(
          //     header: 'designation'.tr,
          //     details:
          //         AppStorage.getLoggedUserData()?.staffUser.crmDesignation ??
          //             ''),
          // dataStyle(
          //     header: 'basic_salary'.tr,
          //     details:
          //         AppStorage.getLoggedUserData()?.staffUser.essentialsSalary ??
          //             ''),
          // dataStyle(
          //     header: 'pay_cycle'.tr,
          //     details: AppStorage.getLoggedUserData()
          //             ?.staffUser
          //             .essentialsPayCycle ??
          //         ''),
          // dataStyle(header: 'primary_work_location'.tr, details: 'Nill'),
        ],
      ),
    );
  }

  Row dataStyle({required String header, required String details}) {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 1,
          child: Text(
            header + ': ',
            // overflow: TextOverflow.ellipsis,
            // softWrap: true,
            style: TextStyle(
                fontWeight: FontWeight.w600,
                color: blackColor.withOpacity(0.7)),
          ),
        ),
        Expanded(
          child: Text(
            details,
            overflow: TextOverflow.ellipsis,
            softWrap: true,
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
        SizedBox(
          width: 100,
        ),
      ],
    );
  }
}
