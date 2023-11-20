import 'package:bizmodo_emenu/Controllers/RepairController/JobSheetsControllers/JobSheetController.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../Theme/colors.dart';

class StatusDropDown extends StatefulWidget {
  const StatusDropDown({super.key});

  @override
  State<StatusDropDown> createState() => _StatusDropDownState();
}

class _StatusDropDownState extends State<StatusDropDown> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return GetBuilder<JobSheetController>(
        builder: (JobSheetController jobSheetCtrl) {
          return DropdownButtonHideUnderline(
            child: DropdownButton2(
              isExpanded: true,
              hint: Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(
                    'please_select'.tr,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  )),
              items: jobSheetCtrl.statusList.map((String items) {
                return DropdownMenuItem(
                  value: items,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(items),
                  ),
                );
              }).toList(),
              value: jobSheetCtrl.statusStatus,
              dropdownWidth: width * 0.5,
              dropdownDecoration:
              BoxDecoration(borderRadius: BorderRadius.circular(5)),
              dropdownMaxHeight: height * 0.7,
              dropdownPadding: EdgeInsets.only(left: 5),
              buttonPadding: EdgeInsets.only(left: 10, right: 10),
              onChanged: (String? value) {
                setState(() {
                  jobSheetCtrl.statusStatus = value;
                });
              },
              buttonHeight: height * 0.07,
              // buttonWidth: width * 0.05,
              buttonDecoration: BoxDecoration(
                  color: kWhiteColor,
                  border: Border.all(
                      width: 1, color: Theme.of(context).colorScheme.primary),
                  borderRadius: BorderRadius.circular(15)),
              itemHeight: 40,
              itemPadding: EdgeInsets.zero,
              itemHighlightColor: Theme.of(context).colorScheme.primary,
            ),
          );
        }
    );
  }
}
