import 'package:bizmodo_emenu/Components/custom_circular_button.dart';
import 'package:bizmodo_emenu/Controllers/CRMControllers/LeadsController/leadsController.dart';
import 'package:bizmodo_emenu/Pages/CRM/Leads/AddLeadsWidgets/addContactPersons.dart';
import 'package:bizmodo_emenu/Pages/CRM/Leads/AddLeadsWidgets/addLeadsBasicInfo.dart';
import 'package:bizmodo_emenu/Theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'AddLeadsWidgets/addLeadsMoreInfo.dart';



class AddLeads extends StatefulWidget {
  const AddLeads({super.key});

  @override
  State<AddLeads> createState() => _AddLeadsState();
}

class _AddLeadsState extends State<AddLeads> {
  LeadsController leadsCtrl = Get.find<LeadsController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Leads'),
      ),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          children: [
            AddLeadsBasicInfo(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomButton(
                  title: Text('More Information',style: TextStyle(color: kWhiteColor),),
                  onTap: (){
                    setState(() {
                      if(leadsCtrl.isMoreShow == true){
                        leadsCtrl.isMoreShow = false;
                      }
                      else if(leadsCtrl.isMoreShow == false){
                        leadsCtrl.isMoreShow = true;
                      }
                    });
                  },
                  action: Icon( leadsCtrl.isMoreShow == true ? Icons.arrow_drop_up : Icons.arrow_drop_down , color: kWhiteColor,),
                ),
              ],
            ),

            if(leadsCtrl.isMoreShow == true)
            AddLeadsMoreInfo(),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomButton(
                  title: Text('Add Contact Persons',style: TextStyle(color: kWhiteColor),),
                  onTap: (){
                    setState(() {
                      if(leadsCtrl.isAddContactPersonsShow == true){
                        leadsCtrl.isAddContactPersonsShow = false;
                      }
                      else if(leadsCtrl.isAddContactPersonsShow == false){
                        leadsCtrl.isAddContactPersonsShow = true;
                        leadsCtrl.isAddContactPerson1Show = true;
                      }
                    });
                  },
                  action: Icon( leadsCtrl.isAddContactPersonsShow == true ? Icons.arrow_drop_up : Icons.arrow_drop_down , color: kWhiteColor,),
                ),
              ],
            ),

            if(leadsCtrl.isAddContactPersonsShow == true)
              AddContactPersons(),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomButton(
                  title: Text('Save', style: TextStyle(color: kWhiteColor),),
                  onTap: (){
                    Get.back();
                  },
                ),
                SizedBox(width: 10,),
                CustomButton(
                  title: Text('Close', style: TextStyle(color: kWhiteColor),),
                  onTap: (){
                    Get.back();
                  },
                )
              ],
            ),
            SizedBox(height: 15,),
          ],
        ),
      ),
    );
  }
}
