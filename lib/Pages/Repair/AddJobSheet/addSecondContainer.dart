import 'package:bizmodo_emenu/Controllers/RepairController/JobSheetsControllers/JobSheetController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../Theme/colors.dart';
import '../../../../Theme/style.dart';
import '../../../../const/dimensions.dart';
import '../../../Components/textfield.dart';
import '../../../Config/const.dart';
import 'AddJobSheetWidgets/addBrandDialog.dart';
import 'AddJobSheetWidgets/addDeviceDialog.dart';
import 'AddJobSheetWidgets/addDeviceModelDialog.dart';
import 'AddJobSheetWidgets/brandDropDown.dart';
import 'AddJobSheetWidgets/deviceDropDown.dart';
import 'AddJobSheetWidgets/deviceModelDropDown.dart';



class AddSecondContainer extends StatefulWidget {
  const AddSecondContainer({super.key});

  @override
  State<AddSecondContainer> createState() => _AddSecondContainerState();
}

class _AddSecondContainerState extends State<AddSecondContainer> {

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
            //Brand Drop Down
            title(txt: 'Brand:'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: width * 0.70,
                  height: height * 0.05,
                  child: BrandDropDown(),
                ),
                GestureDetector(
                  onTap: (){
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        //title: title != null ? Text(title) : null,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 0),
                        content: AddBrandDialog(),
                      ),
                    );
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
            title(txt: 'Device:*'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: width * 0.70,
                  height: height * 0.05,
                  child: DeviceDropDown(),
                ),
                GestureDetector(
                  onTap: (){
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        //title: title != null ? Text(title) : null,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 0),
                        content: AddDeviceDialog(),
                      ),
                    );
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
            title(txt: 'Device Model:'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: width * 0.70,
                  height: height * 0.05,
                  child: DeviceModelDropDown(),
                ),
                GestureDetector(
                  onTap: (){
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        //title: title != null ? Text(title) : null,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 0),
                        content: AddDeviceModelDialog(),
                      ),
                    );
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
            SizedBox(height: 20,),
            Container(
              width: width,
              height: height * 0.2,
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                  color: kWhiteColor,
                  border: Border.all(color: Theme.of(context).primaryColor),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 5,
                      spreadRadius: 3,
                      color: kHintColor.withOpacity(0.2)
                  )]
              ),
              child:Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Pre Repair Checklist:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
                  SizedBox(height: 10,),
                  Text('N/A = Not Applicable', style: TextStyle(fontSize: 14,),),
                  SizedBox(height: 10,),
                  AppConst.dividerLine(color: kHintColor.withOpacity(0.2)),
                ],
              ),
            ),



            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Mobile
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    title(txt: 'Serial Number:*'),
                    SizedBox(
                      width: width * 0.42,
                      height: height * 0.07,
                      child: AppFormField(
                        isLabel: true,
                        labelText: 'Serial Number',
                        isDense: true,
                        controller: jobSheetCtrl.serialNoCtrl,
                      ),
                    ),
                  ],
                ),

                //Alternate Contact Number
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    title(txt: 'Password:'),
                    SizedBox(
                      width: width * 0.42,
                      height: height * 0.07,
                      child: AppFormField(
                        isLabel: true,
                        labelText: 'Password',
                        isDense: true,
                        controller: jobSheetCtrl.passwordCtrl,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            // SizedBox(height: 10,),
            title(txt: 'Product Configuration:*'),
            SizedBox(
              // width: width * 0.42,
              height: height * 0.07,
              child: AppFormField(
                isLabel: true,
                labelText: 'Product Configuration',
                isDense: true,
                controller: jobSheetCtrl.productConfigCtrl,
              ),
            ),

            title(txt: 'Problem Reported By The Customer:'),
            SizedBox(
              // width: width * 0.42,
              height: height * 0.07,
              child: AppFormField(
                isLabel: true,
                labelText: 'Problem Reported By The Customer',
                isDense: true,
                controller: jobSheetCtrl.productReportedByCustomerCtrl,
              ),
            ),

            title(txt: 'Condition Of The Product:'),
            SizedBox(
              // width: width * 0.42,
              height: height * 0.07,
              child: AppFormField(
                isLabel: true,
                labelText: 'Condition Of The Product',
                isDense: true,
                controller: jobSheetCtrl.conditionOfProductCtrl,
              ),
            ),
          ],
        ),
      ),
    );
  }

}
