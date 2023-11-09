import 'package:bizmodo_emenu/Theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Components/bodyHeadingTile.dart';
import '../../../Components/custom_circular_button.dart';

class AllCampaignsTiles extends StatelessWidget {
  AllCampaignsTiles({Key? key,}) : super(key: key);

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
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // Text(
              //   'Contact Id: 123456',
              //   style: Theme.of(context)
              //       .textTheme
              //       .bodySmall!
              //       .copyWith(fontWeight: FontWeight.bold, color: Colors.black),
              // ),

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
            heading: 'Campaign Name:',
            body: 'test',
          ),
          BodyHeadingTile(
            heading: 'Campaign Type:',
            body: 'Email',
          ),
          BodyHeadingTile(
            heading: 'Created By:',
            body: 'Haseeb Bin Umer',
          ),
          // AppConst.dividerLine(height: 12, width: 1),
        ],
      ),
    );
  }
}
