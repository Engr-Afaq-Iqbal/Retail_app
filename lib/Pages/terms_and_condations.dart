import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/const/terms_and_condation.dart';

class TermsAndConditions extends StatelessWidget {
  const TermsAndConditions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          'terms'.tr,
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              title('general_terms'.tr),
              des(GENERALTERMS),
              title('license'.tr),
              des(LICENSE),
              title('definitions'.tr),
              des(DEFINITIONS_AND_KEY_TERMS),
              title('restrictions'.tr),
              des(RESTRICTIONS),
              title('payment'.tr),
              des(PAYMENT),
              title('RETURN AND REFUND POLICY'),
              des(RETURN_AND_REFUND_POLICY),
              title('suggestions'.tr),
              des(YOUR_SUGGESTIONS),
              title('consent'.tr),
              des(YOUR_CONSENT),
              title('LINKS TO OTHER WEBSITES'),
              des(LINKS_TO_OTHER_WEBSITES),
              title('COOKIES'),
              des(COOKIES),
              title('CHANGES TO OUR TERMS & CONDITIONS'),
              des(CHANGES_TO_OUR_TERMS_CONDITIONS),
              title('MODIFICATIONS TO OUR WEBSITE/APP'),
              des(MODIFICATIONS_TO_OUR_WEBSITE),
              title('UPDATES TO OUR WEBSITE/APP'),
              des(UPDATES_TO_OUR_WEBSITE),
              title('THIRD-PARTY SERVICES'),
              des(THIRD_PARTY_SERVICES),
              title('TERM AND TERMINATION'),
              des(TERM_AND_TERMINATION),
              title('COPYRIGHT INFRINGEMENT NOTICE'),
              des(COPYRIGHT_INFRINGEMENT_NOTICE),
              title('INDEMNIFICATION'),
              des(INDEMNIFICATION),
              title('NO WARRANTIES'),
              des(NO_WARRANTIES),
              title('LIMITATION OF LIABILITY'),
              des(LIMITATION_OF_LIABILITY),
              title('SEVERABILITY'),
              des(SEVERABILITY),
              title('WAIVER'),
              des(WAIVER),
              title('AMENDMENTS TO THIS AGREEMENT'),
              des(AMENDMENTS_TO_THIS_AGREEMENT),
              title('ENTIRE AGREEMENT'),
              des(ENTIRE_AGREEMENT),
              title('UPDATES TO OUR TERMS'),
              des(UPDATES_TO_OUR_TERMS),
              title('INTELLECTUAL PROPERTY'),
              des(INTELLECTUAL_PROPERTY),
              title('AGREEMENT TO ARBITRATE'),
              des(AGREEMENT_TO_ARBITRATE),
              title('NOTICE OF DISPUTE'),
              des(NOTICE_OF_DISPUTE),
              title('BINDING ARBITRATION'),
              des(BINDING_ARBITRATION),
              title('SUBMISSIONS AND PRIVACY'),
              des(SUBMISSIONS_AND_PRIVACY),
              title('PROMOTIONS'),
              des(PROMOTIONS),
              title('TYPOGRAPHICAL ERRORS'),
              des(TYPOGRAPHICALERRORS),
              title('MISCELLANEOUS'),
              des(MISCELLANEOUS),
              title('DISCLAIMER'),
              des(DISCLAIMER),
              title('CONTACT US'),
              des(CONTACTUS),
            ],
          ),
        ),
      ),
    );
  }

  Widget title(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Text(
        title,
        style: TextStyle(
            color: Colors.grey, fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget des(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        text,
        style: TextStyle(fontSize: 13),
      ),
    );
  }
}
