import 'package:bizmodo_emenu/Components/custom_circular_button.dart';
import 'package:bizmodo_emenu/Controllers/RepairController/JobSheetsControllers/JobSheetController.dart';
import 'package:bizmodo_emenu/Theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../Components/textfield.dart';
import '../../../../Theme/style.dart';

class AddBrandDialog extends StatefulWidget {
  const AddBrandDialog({Key? key}) : super(key: key);

  @override
  State<AddBrandDialog> createState() => _AddBrandDialogState();
}

class _AddBrandDialogState extends State<AddBrandDialog> {
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
                  'Add Brand',
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
            title(txt: 'Brand name:*'),
            SizedBox(
              width: width ,
              height: height * 0.07,
              child: AppFormField(
                labelText: 'Brand name',
                controller: jobSheetCtrl.brandNameCtrl,
                isDense: true,
              ),
            ),

            title(txt: 'Short description:*'),
            SizedBox(
              width: width ,
              height: height * 0.07,
              child: AppFormField(
                labelText:  'Short description',
                controller: jobSheetCtrl.shortDescriptionCtrl,
                isDense: true,
              ),
            ),

            Row(
              children: [
                Checkbox(
                  value: jobSheetCtrl.useForRepair,
                  onChanged: (bool? value) {
                    setState(() {
                      jobSheetCtrl.useForRepair = value!;
                    });
                  },
                ),
                // SizedBox(width: 5,),
                title(txt: 'Use for Repair?'),
              ],
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
