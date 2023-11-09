import 'package:bizmodo_emenu/Components/custom_circular_button.dart';
import 'package:bizmodo_emenu/Pages/CRM/Campaigns/AddCampaignWidgets/AddCampaignSubClass.dart';
import 'package:bizmodo_emenu/Theme/colors.dart';
import 'package:flutter/material.dart';

class AddCampaigns extends StatefulWidget {
  const AddCampaigns({super.key});

  @override
  State<AddCampaigns> createState() => _AddCampaignsState();
}

class _AddCampaignsState extends State<AddCampaigns> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Campaigns'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            AddCampaignSubClass(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CustomButton(
                  leading: Icon(Icons.email_outlined, color: kWhiteColor,),
                  title: Text('Send Notification', style: TextStyle(color: kWhiteColor)),
                  bgColor: dueColor,
                  onTap: (){},
                ),
                SizedBox(width: 10,),
                CustomButton(
                  leading: Icon(Icons.drafts_outlined, color: kWhiteColor,),
                  title: Text('Draft', style: TextStyle(color: kWhiteColor)),
                  onTap: (){},
                ),
                SizedBox(width: 15,),
              ],
            )
          ],
        ),
      ),
    );
  }
}
