import 'package:bizmodo_emenu/Controllers/CRMControllers/CampaignsController/campaignsController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Components/textfield.dart';
import '../../../Theme/style.dart';

class AddCampaigns extends StatefulWidget {
  const AddCampaigns({super.key});

  @override
  State<AddCampaigns> createState() => _AddCampaignsState();
}

class _AddCampaignsState extends State<AddCampaigns> {
  CampaignsController campaignsCtrl = Get.find<CampaignsController>();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Campaigns'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Prefix
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    title(txt: 'Campaign Name:*'),
                    SizedBox(
                      width: width * 0.42,
                      height: height * 0.07,
                      child: AppFormField(
                        isLabel: true,
                        labelText: 'Campaign Name',
                        isDense: true,
                         controller: campaignsCtrl.campaignNameCtrl,
                      ),
                    ),
                  ],
                ),

                //First Name
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    title(txt: 'Campaign Type:*'),
                    SizedBox(
                      width: width * 0.42,
                      height: height * 0.07,
                      child: AppFormField(
                        isLabel: true,
                        labelText: 'First Name',
                        isDense: true,
                        controller: campaignsCtrl.campaignNameCtrl,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
