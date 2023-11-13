import 'package:bizmodo_emenu/Pages/CRM/Campaigns/AddCampaignWidgets/toDropDown.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../Components/textfield.dart';
import '../../../../Controllers/CRMControllers/CampaignsController/campaignsController.dart';
import '../../../../Theme/colors.dart';
import '../../../../Theme/style.dart';
import '../../../../const/dimensions.dart';
import 'addCampaignTypeDropDown.dart';



class AddCampaignSubClass extends StatefulWidget {
  const AddCampaignSubClass({super.key});

  @override
  State<AddCampaignSubClass> createState() => _AddCampaignSubClassState();
}

class _AddCampaignSubClassState extends State<AddCampaignSubClass> {
  CampaignsController campaignsCtrl = Get.find<CampaignsController>();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
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
      child: IntrinsicHeight(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Campaign Name
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

                //Campaign Type
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    title(txt: 'Campaign Type:*'),
                    SizedBox(
                      width: width * 0.42,
                      height: height * 0.05,
                      child: AddCampaignTypeDropDown(),
                    ),
                  ],
                ),
              ],
            ),

            //To
            title(txt: 'To:*'),
            SizedBox(
              width: width * 0.42,
              height: height * 0.05,
              child: ToDropDown(),
            ),
            SizedBox(height: 10,),

            //Subject
            title(txt: 'Subject:*'),
            SizedBox(
              width: width * 0.85,
              height: height * 0.07,
              child: AppFormField(
                // isLabel: true,
                // labelText: 'Campaign Name',
                isDense: true,
                controller: campaignsCtrl.campaignNameCtrl,
              ),
            ),

            //Email Body
            title(txt: 'Email Body:*'),
            SizedBox(
              width: width * 0.85,
              // height: height * 0.07,
              child: AppFormField(
                // isLabel: true,
                // labelText: 'Campaign Name',
                maxLines: 5,
                // isDense: true,
                controller: campaignsCtrl.campaignNameCtrl,
              ),
            ),

            //Available Tags
            title(txt: 'Available Tags:'),
            SizedBox(height: 25,),

          ],
        ),
      ),
    );
  }

}
