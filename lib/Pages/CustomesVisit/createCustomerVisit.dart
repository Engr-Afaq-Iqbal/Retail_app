import 'package:bizmodo_emenu/Components/custom_circular_button.dart';
import 'package:bizmodo_emenu/Controllers/CustomerVisits/CustomerVisitsController.dart';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';

import '../../../Components/textfield.dart';
import '../../../Config/DateTimeFormat.dart';

import '../../../Theme/colors.dart';
import '../../../Theme/style.dart';

class CreateCustomerVisits extends StatefulWidget {
  const CreateCustomerVisits({Key? key}) : super(key: key);

  @override
  State<CreateCustomerVisits> createState() => _CreateCustomerVisitsState();
}

class _CreateCustomerVisitsState extends State<CreateCustomerVisits> {
  CustomerVisitsController customerVisitsCtrlObj =
      Get.find<CustomerVisitsController>();

  Future<void> _showDatePicker() async {
    DateTime? dateTime = await showOmniDateTimePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1600).subtract(const Duration(days: 3652)),
      lastDate: DateTime.now().add(
        const Duration(days: 3652),
      ),
      is24HourMode: false,
      isShowSeconds: false,
      minutesInterval: 1,
      secondsInterval: 1,
      borderRadius: const BorderRadius.all(Radius.circular(16)),
      constraints: const BoxConstraints(
        maxWidth: 350,
        maxHeight: 650,
      ),
      transitionBuilder: (context, anim1, anim2, child) {
        return FadeTransition(
          opacity: anim1.drive(
            Tween(
              begin: 0,
              end: 1,
            ),
          ),
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 200),
      barrierDismissible: true,
      selectableDayPredicate: (dateTime) {
        // Disable 25th Feb 2023
        if (dateTime == DateTime(2023, 2, 25)) {
          return false;
        } else {
          return true;
        }
      },
    );

    customerVisitsCtrlObj.dateCtrl.text = '${AppFormat.dateDDMMYY(dateTime!)}';
    print(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20, top: 20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            headings(txt: 'Add Visit'),
            Divider(),
            SizedBox(
              height: 10,
            ),
            headings(txt: 'Whom you\'ll be visiting?*'),
            GetBuilder<CustomerVisitsController>(
                builder: (CustomerVisitsController creatsVisitsCtrlObj) {
              return Row(
                children: [
                  Expanded(
                    // height: 20,
                    // width: M,
                    child: CheckboxListTile(
                        value: creatsVisitsCtrlObj.valuefirst,
                        onChanged: (bool? value) {
                          setState(() {
                            creatsVisitsCtrlObj.valuefirst = value!;
                            creatsVisitsCtrlObj.valueSecond = false;
                            creatsVisitsCtrlObj.update();
                          });
                        },
                        controlAffinity: ListTileControlAffinity.leading,
                        title: Text(
                          'Contact',
                          style: TextStyle(color: blackColor),
                        )),
                  ),
                  Expanded(
                    // height: 20,
                    // width: 20,
                    child: CheckboxListTile(
                        value: creatsVisitsCtrlObj.valueSecond,
                        onChanged: (bool? value) {
                          setState(() {
                            creatsVisitsCtrlObj.valueSecond = value!;
                            creatsVisitsCtrlObj.valuefirst = false;
                            creatsVisitsCtrlObj.update();
                          });
                        },
                        controlAffinity: ListTileControlAffinity.leading,
                        title: Text(
                          'Other',
                          style: TextStyle(color: blackColor),
                        )),
                  ),
                ],
              );
            }),
            if (customerVisitsCtrlObj.valuefirst == true)
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      headings(txt: 'Contact:'),
                      AppFormField(
                        width: width * 0.885,
                        controller: customerVisitsCtrlObj.contactCtrl,
                        labelText: 'Please Select',
                      ),
                    ],
                  ),
                ],
              ),
            if (customerVisitsCtrlObj.valueSecond == true)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      headings(txt: 'Person/Company:'),
                      AppFormField(
                        width: width * 0.43,
                        readOnly: true,
                        controller: customerVisitsCtrlObj.companyCtrl,
                        labelText: '',
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      headings(txt: 'Visit Address:'),
                      AppFormField(
                        width: width * 0.43,
                        readOnly: true,
                        controller: customerVisitsCtrlObj.visitAddressCtrl,
                        labelText: '',
                      ),
                    ],
                  ),
                ],
              ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    headings(txt: 'Visit On:*'),
                    AppFormField(
                      width: width * 0.43,
                      readOnly: true,
                      controller: customerVisitsCtrlObj.dateCtrl,
                      labelText: 'Select Date',
                      prefixIcon: Icon(Icons.calendar_month),
                      onTap: () {
                        setState(() {
                          _showDatePicker();

                          //_show(context);
                        });
                      },
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    headings(txt: 'Assigned To:*'),
                    DropdownButtonHideUnderline(
                      child: DropdownButton2(
                        isExpanded: true,
                        hint: Align(
                            alignment: AlignmentDirectional.centerStart,
                            child: Text(
                              'Please Select',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                color: txtFieldHintColor,
                              ),
                            )),
                        items: customerVisitsCtrlObj.assignedToList().map((e) {
                          return DropdownMenuItem(value: e, child: Text(e));
                        }).toList(),
                        value: customerVisitsCtrlObj.statusValue,
                        dropdownDirection: DropdownDirection.textDirection,
                        dropdownPadding: EdgeInsets.only(left: 5, right: 5),
                        buttonPadding: EdgeInsets.only(left: 15, right: 15),
                        onChanged: (String? value) {
                          setState(() {
                            customerVisitsCtrlObj.statusValue = value;
                          });
                        },
                        buttonHeight: height * 0.06,
                        buttonWidth: width * 0.43,
                        buttonDecoration: BoxDecoration(
                            border: Border.all(width: 1, color: primaryColor),
                            borderRadius: BorderRadius.circular(15),
                            color: kWhiteColor),
                        itemHeight: 40,
                        itemPadding: EdgeInsets.zero,
                        itemHighlightColor: primaryColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            IntrinsicHeight(
              child: Container(
                width: width,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: kWhiteColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    headings(txt: 'Purpose of visiting:'),
                    AppFormField(
                      controller: customerVisitsCtrlObj.additionalNotes,
                      labelText: '',
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            headings(txt: 'Total Amount: 0.00'),
                            Row(
                              children: [
                                CustomButton(
                                  title: Text(
                                    'Save',
                                    style: TextStyle(color: kWhiteColor),
                                  ),
                                  onTap: () {},
                                  bgColor: primaryColor,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                CustomButton(
                                  title: Text(
                                    'Close',
                                    style: TextStyle(color: kWhiteColor),
                                  ),
                                  onTap: () {
                                    Get.back();
                                  },
                                  bgColor: buttonColor,
                                )
                              ],
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Text headings({required String txt}) {
    return Text(
      txt,
      style: appBarHeaderStyle,
    );
  }
}
