import 'package:bizmodo_emenu/Theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Components/bodyHeadingTile.dart';
import '../../../Components/custom_circular_button.dart';
import '../../../Config/const.dart';
import '/Pages/Orders/Components/AmountInfo.dart';
import 'addFollowUp.dart';

class AllLeadsTile extends StatelessWidget {
  AllLeadsTile({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.symmetric(
            horizontal: BorderSide(color: Colors.white, width: 5)),
      ),
      padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Contact Id: 123456',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(fontWeight: FontWeight.bold, color: Colors.black),
              ),

              Text(
                '11/01/2023',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: Theme.of(context).primaryColor),
              ),
            ],
          ),
          BodyHeadingTile(
            heading: 'Name:',
            body: 'Afaq Iqbal',
          ),
          BodyHeadingTile(
            heading: 'Mobile:',
            body: '03077472401',
          ),
          BodyHeadingTile(
            heading: 'Email:',
            body: 'engr.afaqiqbal@gmail.com',
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BodyHeadingTile(
                heading: 'Assigned To:',
                body: 'Haseeb Bin Umer',
              ),

              CustomButton(
                title: Text('Add Follow Up', style: TextStyle(color: kWhiteColor),),
                onTap: (){
                  Get.to(AddFollowUp());
                },
              )
            ],
          ),

          // AppConst.dividerLine(height: 12, width: 1),
        ],
      ),
    );
  }
}
