import 'package:bizmodo_emenu/Components/custom_circular_button.dart';
import 'package:flutter/material.dart';

import '../../../../Components/bodyHeadingTile.dart';
import '../../../../Config/const.dart';
import '../../../../Theme/colors.dart';
import '../../../../const/dimensions.dart';

class ViewCampaign extends StatelessWidget {
  const ViewCampaign({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Campaign'),
      ),
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
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
                    children: [
                      BodyHeadingTile(
                        heading: 'Campaign Name:',
                        body: 'test',
                        fontSize: 14,
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
                  SizedBox(height: 10,),
                  BodyHeadingTile(
                    heading: 'Campaign Type:',
                    body: 'Email',
                    fontSize: 14,
                  ),
                  SizedBox(height: 10,),
                  BodyHeadingTile(
                    heading: 'Subject:',
                    body: 'testing',
                    fontSize: 14,
                  ),
                  SizedBox(height: 10,),
                  Text('Email Body:',style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,),),
                  SizedBox(height: 3,),
                  Text('testing',style: TextStyle(fontSize: 14,),),

                  SizedBox(height: 10,),
                  Text('Customers:',style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,),),
                  SizedBox(height: 3,),
                  Text('Walk-in',style: TextStyle(fontSize: 14,),),
                  SizedBox(height: 10,),
                  AppConst.dividerLine(color: kHintColor.withOpacity(0.2)),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      Icon(Icons.edit_outlined,size: 20,),
                      SizedBox(width: 5,),
                      Expanded(child: Text('Haseeb Syed created this campaign on 11/07/2023',softWrap: true,style: TextStyle(fontSize: 14,),)),
                    ],
                  ),
                  SizedBox(height: 25,),
              Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CustomButton(
                        title: Text('Close', style: TextStyle(color: kWhiteColor),),
                        onTap: (){
                        },
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          // SizedBox(height: 10,),
          // Padding(
          //   padding: const EdgeInsets.all(15.0),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.end,
          //     children: [
          //       CustomButton(
          //         title: Text('Close', style: TextStyle(color: kWhiteColor),),
          //         onTap: (){
          //         },
          //       )
          //     ],
          //   ),
          // )
        ],
      ),
    );
  }
}
