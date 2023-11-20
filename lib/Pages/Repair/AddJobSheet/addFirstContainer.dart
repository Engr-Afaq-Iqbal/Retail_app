import 'package:bizmodo_emenu/Controllers/RepairController/JobSheetsControllers/JobSheetController.dart';
import 'package:bizmodo_emenu/Pages/CreateNewCustomer/createNewCustomer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../Components/textfield.dart';
import '../../../../Theme/colors.dart';
import '../../../../Theme/style.dart';
import '../../../../const/dimensions.dart';
import 'AddJobSheetWidgets/businessLocDropDown.dart';



class AddFirstContainer extends StatefulWidget {
  const AddFirstContainer({super.key});

  @override
  State<AddFirstContainer> createState() => _AddFirstContainerState();
}

class _AddFirstContainerState extends State<AddFirstContainer> {

  JobSheetController jobSheetCtrl = Get.find<JobSheetController>();
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
            //Business Location Drop Down
            title(txt: 'Business Location:*'),
            SizedBox(
              // width: width * 0.85,
              height: height * 0.05,
              child: BusinessLocDropDown(),
            ),
            SizedBox(height: 10,),
            title(txt: 'Customer:*'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: width * 0.70,
                  height: height * 0.05,
                  child: BusinessLocDropDown(),
                ),
                GestureDetector(
                  onTap: (){
                    Get.to(CreateNewCustomer());
                  },
                  child: CircleAvatar(
                    backgroundColor: Theme.of(context).primaryColor,
                    child: Icon(
                      Icons.add, color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 10,),
            title(txt: 'Service type:*'),
            Row(
              children: [
                IntrinsicWidth(
                  child: RadioListTile(
                    title: Text('Carry in'),
                    value: 'carryIn',
                    toggleable: true,
                    groupValue: jobSheetCtrl.serviceCarryIn,
                    onChanged: (value) {
                      setState(() {
                        jobSheetCtrl.serviceCarryIn = value;
                      });
                    },
                  ),
                ),
                IntrinsicWidth(
                  child: RadioListTile(
                    title: Text('Pick Up'),
                    value: 'pickUp',
                    toggleable: true,
                    groupValue: jobSheetCtrl.servicePickUp,
                    onChanged: (value) {
                      setState(() {
                        jobSheetCtrl.servicePickUp = value;
                        print(value);
                      });
                    },
                  ),
                ),
              ],
            ),
            RadioListTile(
              title: Text('On site'),
              toggleable: true,
              value: 'onSite',
              groupValue: jobSheetCtrl.serviceOnSite,
              onChanged: (value) {
                setState(() {
                  jobSheetCtrl.serviceOnSite = value;
                });
              },
            ),
            if(jobSheetCtrl.serviceOnSite == 'onSite' || jobSheetCtrl.servicePickUp == 'pickUp')
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10,),
                title(txt: 'Pick up/On site address:'),
                SizedBox(
                  width: width * 0.85,
                  // height: height * 0.07,
                  child: AppFormField(
                    isLabel: true,
                    labelText: 'Pick up/On site address',
                    // isDense: true,
                    maxLines: 4,
                    controller: jobSheetCtrl.pickUpOnSiteAddressCtrl,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

}
