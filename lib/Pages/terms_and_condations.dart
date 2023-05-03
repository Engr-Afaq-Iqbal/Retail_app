import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/const/terms_and_condation.dart';

class TermsAndConditions extends StatelessWidget {
  const TermsAndConditions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
              title('suggestions'.tr),
              des(YOUR_SUGGESTIONS),
              title('consent'.tr),
              des(YOUR_CONSENT),
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
        style: TextStyle(color: Colors.grey, fontSize: 18, fontWeight: FontWeight.bold),
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
