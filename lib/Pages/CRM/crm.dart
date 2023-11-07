import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Controllers/CRMControllers/CRMController/crmController.dart';
import '../../Theme/colors.dart';

class CRM extends StatefulWidget {
  const CRM({super.key});

  @override
  State<CRM> createState() => _CRMState();
}

class _CRMState extends State<CRM> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('CRM',),
        // centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: GetBuilder<CRMController>(
              builder: (CRMController crmCtrl) {
                return DropdownButtonHideUnderline(
                  child: DropdownButton2(
                    isExpanded: true,
                    hint: Align(
                        alignment: AlignmentDirectional.centerStart,
                        child: Text(
                          'CRM'.tr,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: txtFieldHintColor,
                          ),
                        )),
                    items: crmCtrl
                        .getCRMList()
                        .map((e) {
                      return DropdownMenuItem(
                          value: e, child: Text(e['title']));
                    }).toList(),
                    // value: crmCtrl.crmStatus,
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
        //centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
        ],
      ),
    );
  }
}
