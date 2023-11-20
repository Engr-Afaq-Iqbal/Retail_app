import 'package:bizmodo_emenu/Controllers/RepairController/RepairController/repairController.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Theme/colors.dart';

class Repair extends StatefulWidget {
  const Repair({super.key});

  @override
  State<Repair> createState() => _RepairState();
}

class _RepairState extends State<Repair> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Repair',),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: GetBuilder<RepairController>(
                builder: (RepairController repairCtrl) {
                  return DropdownButtonHideUnderline(
                    child: DropdownButton2(
                      isExpanded: true,
                      hint: Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: Text(
                            'Repair'.tr,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: txtFieldHintColor,
                            ),
                          )),
                      items: repairCtrl
                          .getRepairList()
                          .map((e) {
                        return DropdownMenuItem(
                            value: e, child: Text(e['title']));
                      }).toList(),
                      value: repairCtrl.repairStatus,
                      dropdownDirection: DropdownDirection.textDirection,
                      dropdownPadding: EdgeInsets.only(left: 5, right: 5),
                      buttonPadding: EdgeInsets.only(left: 15, right: 15),
                      onChanged: (dynamic value) {
                        setState(() {
                          // crmCtrl.crmStatus =
                          //     value;
                          // value['action'];
                          Get.to(value['page']);
                        });
                      },
                      dropdownWidth: width * 0.4,
                      buttonHeight: height * 0.06,
                      buttonWidth: width * 0.35,
                      buttonDecoration: BoxDecoration(
                          border: Border.all(
                              width: 1,
                              color: Theme.of(context)
                                  .colorScheme
                                  .primary),
                          borderRadius: BorderRadius.circular(15),
                          color: kWhiteColor),
                      itemHeight: 40,
                      itemPadding: EdgeInsets.zero,
                      itemHighlightColor:
                      Theme.of(context).colorScheme.primary,
                    ),
                  );
                }
            ),
          ),
        ],

        elevation: 0,
      ),
      body: Column(
        children: [
        ],
      ),
    );
  }
}
