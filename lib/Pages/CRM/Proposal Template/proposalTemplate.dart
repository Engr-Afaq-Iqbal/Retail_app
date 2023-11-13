import 'package:bizmodo_emenu/Components/custom_circular_button.dart';
import 'package:bizmodo_emenu/Pages/CRM/Proposal%20Template/viewProposalTemplate.dart';
import 'package:bizmodo_emenu/Theme/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Config/const.dart';
import '../../../Theme/colors.dart';
import '../../../const/dimensions.dart';
import 'createProposalTemplate.dart';


class ProposalTemplate extends StatefulWidget {
  const ProposalTemplate({super.key});

  @override
  State<ProposalTemplate> createState() => _ProposalTemplateState();
}

class _ProposalTemplateState extends State<ProposalTemplate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Proposal Templates'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton.small(
          child: Icon(Icons.add),
          backgroundColor:
          Theme.of(context).colorScheme.primary.withOpacity(0.5),
          onPressed: () {
            Get.to(CreateProposalTemplate(title: 'Create Proposal template',));
          }),
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(15),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radiusSmall, ),
                color: kWhiteColor,
              border: Border.all(
                color: Theme.of(context).colorScheme.primary,
                width: 1
              )
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                title(txt: 'testing'),
                SizedBox(height: 20,),
                AppConst.dividerLine(color: kHintColor.withOpacity(0.2)),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomButton(
                      title: Text('Edit',style: TextStyle(color: kWhiteColor),),
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      onTap: (){},
                    ),
                    CustomButton(
                      title: Text('View',style: TextStyle(color: kWhiteColor),),
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      onTap: (){
                        Get.to(ViewProposalTemplate());
                      },
                    ),
                    CustomButton(
                      title: Text('Send',style: TextStyle(color: kWhiteColor),),
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      onTap: (){},
                    )
                  ],
                )
            ],),
          )
        ],
      ),
    );
  }
}
