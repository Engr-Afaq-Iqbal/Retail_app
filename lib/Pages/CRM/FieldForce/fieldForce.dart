import 'package:bizmodo_emenu/Theme/style.dart';
import 'package:flutter/material.dart';

import '../../../Config/const.dart';
import '../../../Theme/colors.dart';
import '../../../const/dimensions.dart';

class FieldForce extends StatefulWidget {
  const FieldForce({super.key});

  @override
  State<FieldForce> createState() => _FieldForceState();
}

class _FieldForceState extends State<FieldForce> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Field Force'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
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
              ),
              child: Column(
                children: [
                  taskRow(icon: Icons.task_alt_outlined, titleTxt: 'Assigned', bodyTxt: '3', bgColor: partialColor,),

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: AppConst.dividerLine(color: kHintColor.withOpacity(0.2)),
                  ),
                  taskRow(icon: Icons.person_add_alt_outlined, titleTxt: 'Meet with Contact', bodyTxt: '1', bgColor: paidColor),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: AppConst.dividerLine(color: kHintColor.withOpacity(0.2)),
                  ),
                  taskRow(icon: Icons.person_remove_alt_1_outlined, titleTxt: 'Failed', bodyTxt: '0', bgColor: buttonColor),
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
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('My visits',style: TextStyle(fontSize: 20),),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: AppConst.dividerLine(color: kHintColor.withOpacity(0.2)),
                  ),

                  myVisitRow(txt1: '', txt2: 'Contact',txt3: 'Others', fontWeight2: FontWeight.bold, fontWeight3: FontWeight.bold),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: AppConst.dividerLine(color: kHintColor.withOpacity(0.2)),
                  ),
                  myVisitRow(txt1: 'Visits Today', txt2: '0',txt3: '0', fontWeight1: FontWeight.bold,),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: AppConst.dividerLine(color: kHintColor.withOpacity(0.2)),
                  ),
                  myVisitRow(txt1: 'Visits Yesterday', txt2: '0',txt3: '0', fontWeight1: FontWeight.bold,),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: AppConst.dividerLine(color: kHintColor.withOpacity(0.2)),
                  ),
                  myVisitRow(txt1: 'Visits this month', txt2: '0',txt3: '0', fontWeight1: FontWeight.bold,),
                ],
              ),
            ),

            fieldContainers(title1: 'Total visits', body1: '6.00', title2: 'TODAYS TOTAL VISITS', body2: '5.00', icon: Icons.emergency_outlined,themeColor: dueColor ),
            fieldContainers(title1: 'Assigned', body1: '6.00', title2: 'TODAYS ASSIGNED', body2: '0.00', icon: Icons.task_outlined,themeColor: partialColor ),
            fieldContainers(title1: 'Meet with Contact', body1: '1.00', title2: 'TODAYS MEET WITH CONTACT', body2: '0.00', icon: Icons.person_add_alt_outlined,themeColor: primaryColor.withOpacity(0.6) ),
            fieldContainers(title1: 'Failed', body1: '6.00', title2: 'TODAYS FAILED', body2: '0.00', icon: Icons.person_remove_alt_1_outlined,themeColor: buttonColor ),

          ],
        ),
      ),
    );
  }

  Row taskRow({IconData? icon, String? titleTxt, String? bodyTxt, Color? bgColor,}){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            CircleAvatar(
              backgroundColor: bgColor,
              radius: 30,
              child: Icon(
                  icon
              ),
            ),
            SizedBox(width: 10,),
            title(txt: '$titleTxt'),
          ],
        ),
        Text('$bodyTxt',style: TextStyle(fontSize: 18),),
      ],
    );
  }

  Row myVisitRow({String? txt1, String? txt2, String? txt3, FontWeight fontWeight1 = FontWeight.normal,FontWeight fontWeight2 = FontWeight.normal,FontWeight fontWeight3 = FontWeight.normal}){
    return  Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
            flex: 8,
            child: Text('$txt1', style: TextStyle(fontWeight: fontWeight1),)),
        Expanded(
            flex: 4,
            child: Text('$txt2', style: TextStyle(fontWeight: fontWeight2),)),
        Expanded(
            flex: 4,
            child: Text('$txt3',style: TextStyle(fontWeight: fontWeight3),)),
      ],
    );
  }

  Container fieldContainers({String? title1, String? title2, String? body1, String? body2, IconData? icon, Color? themeColor}){
    return Container(
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
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('$title1',style: TextStyle(fontSize: 16),),
                  Text('$body1',style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: themeColor),)
                ],
              ),
              CircleAvatar(
                backgroundColor: themeColor,
                radius: 30,
                child: Icon(
                  icon,
                  size: 30,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: AppConst.dividerLine(color: kHintColor.withOpacity(0.2)),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('$title2',style: TextStyle(fontSize: 16),),
                  Text('$body2',style: TextStyle(fontSize: 20, color: themeColor),)
                ],
              ),
              Row(
                children: [
                  Text('View',style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: themeColor),),
                  Icon(Icons.arrow_forward_outlined, size: 20,color: themeColor,)
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
