import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Components/custom_circular_button.dart';
import '../../../Config/const.dart';
import '../../../Theme/colors.dart';
import '../../../Theme/style.dart';
import '../../../const/dimensions.dart';

class ViewProposal extends StatefulWidget {
  const ViewProposal({super.key});

  @override
  State<ViewProposal> createState() => _ViewProposalState();
}

class _ViewProposalState extends State<ViewProposal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Proposal'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Row(
              children: [
                Text('Proposal sent to ',style: TextStyle(fontSize: 18,),),
                Text('Walk-In',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(15),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radiusSmall, ),
                color: kWhiteColor,
                boxShadow: [BoxShadow(
                    blurRadius: 5,
                    spreadRadius: 3,
                    color: kHintColor.withOpacity(0.2)
                )]
                // border: Border.all(
                //     color: Theme.of(context).colorScheme.primary,
                //     width: 1
                // )
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    title(txt: 'Sent by:'),
                    Row(
                      children: [
                        title(txt: 'Date: '),
                        Text('11/13/2023 11:48'),
                      ],
                    ),
                  ],
                ),
                Text('Haseeb Bin Umer'),
                SizedBox(height: 10,),
                title(txt: 'CC:'),
                Text('testing'),
                SizedBox(height: 10,),
                title(txt: 'BCC:'),
                Text('testing'),
                SizedBox(height: 10,),
                title(txt: 'Subject:'),
                Text('testing'),
                SizedBox(height: 10,),
                title(txt: 'Email Body:'),
                Text('testing'),
                SizedBox(height: 20,),
                AppConst.dividerLine(color: kHintColor.withOpacity(0.2)),
                SizedBox(height: 20,),
                title(txt: 'Attachments:'),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(8),
                  color: kHintColor.withOpacity(0.1),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          title(txt: 'Document'),
                          Image.asset('assets/yt.png',height: 70,width: 60,),
                          Text('YT.png',style: TextStyle(fontSize: 14,color: Theme.of(context).primaryColor),),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          title(txt: 'Action:'),
                          Row(
                            children: [
                              CustomButton(
                                leading: Icon(Icons.download, color: kWhiteColor,size: 20,),
                                title: Text(''),
                                onTap: (){},
                              ),
                              SizedBox(width: 5,),
                              CustomButton(
                                leading: Icon(Icons.delete,color: kWhiteColor,size: 20,),
                                title: Text(''),
                                bgColor: buttonColor,
                                onTap: (){},
                              )
                            ],
                          )

                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(height: 20,),
                AppConst.dividerLine(color: kHintColor.withOpacity(0.2)),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomButton(
                      title: Text('Close',style: TextStyle(color: kWhiteColor),),
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      onTap: (){
                        Get.back();
                      },
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
