import 'package:bizmodo_emenu/Components/custom_circular_button.dart';
import 'package:bizmodo_emenu/Controllers/RepairController/JobSheetsControllers/JobSheetController.dart';
import 'package:bizmodo_emenu/Theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../Components/textfield.dart';
import '../../../../Theme/style.dart';
import 'brandDropDown.dart';
import 'deviceDropDown.dart';

class AddDeviceModelDialog extends StatefulWidget {
  const AddDeviceModelDialog({Key? key}) : super(key: key);

  @override
  State<AddDeviceModelDialog> createState() => _AddDeviceModelDialogState();
}

class _AddDeviceModelDialogState extends State<AddDeviceModelDialog> {
  JobSheetController jobSheetCtrl = Get.find<JobSheetController>();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      // width: MediaQuery.of(context).size.width * 0.45,
      // height: MediaQuery.of(context).size.height * 0.4,
      padding: EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Add Device Model',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(),
                ),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Icon(
                      Icons.cancel_outlined,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                )
              ],
            ),
            Divider(),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            title(txt: 'Model Name:*'),
            SizedBox(
              width: width ,
              height: height * 0.07,
              child: AppFormField(
                labelText: 'Model Name',
                controller: jobSheetCtrl.modelNameCtrl,
                isDense: true,
              ),
            ),

            title(txt: 'Brand:*'),
            SizedBox(
              width: width * 0.70,
              height: height * 0.05,
              child: BrandDropDown(),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            title(txt: 'Device:*'),
            SizedBox(
              width: width * 0.70,
              height: height * 0.05,
              child: DeviceDropDown(),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            title(txt: 'Repair Checklist:'),
            SizedBox(
              width: width ,
              // height: height * 0.07,
              child: AppFormField(
                labelText:  'Repair Checklist',
                maxLines: 4,
                controller: jobSheetCtrl.repairCheckListCtrl,
                // isDense: true,
              ),
            ),

            Divider(),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
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
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
