import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../Components/custom_circular_button.dart';
import '../../../../Config/const.dart';
import '../../../../Controllers/CRMControllers/LeadsController/leadsController.dart';
import '../../../../Theme/colors.dart';
import '../../../../const/dimensions.dart';
import 'addContactPersonsDetails.dart';

class AddContactPersons extends StatefulWidget {
  const AddContactPersons({super.key});

  @override
  State<AddContactPersons> createState() => _AddContactPersonsState();
}

class _AddContactPersonsState extends State<AddContactPersons> {
  LeadsController leadsCtrl = Get.find<LeadsController>();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
          color: kWhiteColor
      ),
      child: IntrinsicHeight(
        child: Column(
          children: [
            AppConst.dividerLine(color: kHintColor.withOpacity(0.2)),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CustomButton(
                  title: Text('Add contact person 1',style: TextStyle(color: kWhiteColor),),
                  onTap: (){
                    setState(() {
                      if(leadsCtrl.isAddContactPerson1Show == true){
                        leadsCtrl.isAddContactPerson1Show = false;
                      }
                      else if(leadsCtrl.isAddContactPerson1Show == false){
                        leadsCtrl.isAddContactPerson1Show = true;
                      }
                    });
                  },
                  action: Icon( leadsCtrl.isAddContactPerson1Show == true ? Icons.arrow_drop_up : Icons.arrow_drop_down , color: kWhiteColor,),
                ),
              ],
            ),
            if(leadsCtrl.isAddContactPerson1Show)
              AddContactPersonsDetails(
                isContactPerson1: true,
                isContactPerson2: false,
                isContactPerson3: false,
                index: 0,
              ),

            AppConst.dividerLine(color: kHintColor.withOpacity(0.2)),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CustomButton(
                  title: Text('Add contact person 2',style: TextStyle(color: kWhiteColor),),
                  onTap: (){
                    setState(() {
                      if(leadsCtrl.isAddContactPerson2Show == true){
                        leadsCtrl.isAddContactPerson2Show = false;
                      }
                      else if(leadsCtrl.isAddContactPerson2Show == false){
                        leadsCtrl.isAddContactPerson2Show = true;
                      }
                    });
                  },
                  action: Icon( leadsCtrl.isAddContactPerson2Show == true ? Icons.arrow_drop_up : Icons.arrow_drop_down , color: kWhiteColor,),
                ),
              ],
            ),
            if(leadsCtrl.isAddContactPerson2Show)
              AddContactPersonsDetails(
                isContactPerson1: false,
                isContactPerson2: true,
                isContactPerson3: false,
                index: 1,
              ),

            AppConst.dividerLine(color: kHintColor.withOpacity(0.2)),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CustomButton(
                  title: Text('Add contact person 3',style: TextStyle(color: kWhiteColor),),
                  onTap: (){
                    setState(() {
                      if(leadsCtrl.isAddContactPerson3Show == true){
                        leadsCtrl.isAddContactPerson3Show = false;
                      }
                      else if(leadsCtrl.isAddContactPerson3Show == false){
                        leadsCtrl.isAddContactPerson3Show = true;
                      }
                    });
                  },
                  action: Icon( leadsCtrl.isAddContactPerson3Show == true ? Icons.arrow_drop_up : Icons.arrow_drop_down , color: kWhiteColor,),
                ),
              ],
            ),
            if(leadsCtrl.isAddContactPerson3Show)
              AddContactPersonsDetails(
                isContactPerson1: false,
                isContactPerson2: false,
                isContactPerson3: true,
                index: 2,
              ),
          ],
        )
      ),
    );
  }
}
