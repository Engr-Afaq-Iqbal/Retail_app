import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';

import '/Components/textfield.dart';
import '/Controllers/AllSalesController/allSalesController.dart';
import '/Models/PaymentMethodModel/paymentMethodModel.dart';
import '/Theme/colors.dart';
import '../../Config/DateTimeFormat.dart';
import '../../Theme/style.dart';

class PaymentFields extends StatefulWidget {
  final bool isFirst;
  // final List<PaymentAccount> enabledPaymentOptions;
  PaymentFields({this.isFirst = false, Key? key}) : super(key: key);

  @override
  State<PaymentFields> createState() => _PaymentFieldsState();
}

class _PaymentFieldsState extends State<PaymentFields> {
  final AllSalesController allSalesCtrlObj = Get.find<AllSalesController>();
  PaymentAccount? selectedPaymentOption;

  final TextEditingController amountCtrl = TextEditingController();

  final TextEditingController transactionNoCtrl = TextEditingController();

  final TextEditingController checkNoCtrl = TextEditingController();

  final TextEditingController paymentNoteCtrl = TextEditingController();

  TextEditingController dateCtrl = TextEditingController();

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

    dateCtrl.text = '${AppFormat.dateDDMMYY(dateTime!)}';
    print(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        //width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: strikeThroughColor?.withOpacity(0.1),
        ),

        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  headings(txt: 'Advance Balance: 456.99'),
                  SizedBox(
                    height: 15,
                  ),
                  headings(txt: 'Amount:*'),
                  AppFormField(
                    padding: EdgeInsets.only(bottom: 5),
                    labelText: 'amount'.tr,
                    title: 'amount'.tr + ': *',
                    controller: amountCtrl,
                    keyboardType: TextInputType.number,
                  ),
                  headings(txt: 'Paid On:*'),
                  AppFormField(
                    //   width: width * 0.43,
                    readOnly: true,
                    controller: dateCtrl,
                    labelText: 'Select Date',
                    prefixIcon: Icon(Icons.calendar_month),
                    onTap: () {
                      setState(() {
                        _showDatePicker();
                        //_show(context);
                      });
                    },
                  ),
                  headings(txt: 'Payment Method:*'),
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
                      items: allSalesCtrlObj.getPaymentMethodsItems().map((e) {
                        return DropdownMenuItem(value: e, child: Text(e));
                      }).toList(),
                      value: allSalesCtrlObj.paymentStatusValue,
                      dropdownDirection: DropdownDirection.textDirection,
                      dropdownPadding: EdgeInsets.only(left: 5, right: 5),
                      buttonPadding: EdgeInsets.only(left: 15, right: 15),
                      onChanged: (String? value) {
                        setState(() {
                          allSalesCtrlObj.paymentStatusValue = value;
                        });
                      },
                      // buttonHeight: height * 0.06,
                      // buttonWidth: width * 0.43,
                      buttonDecoration: BoxDecoration(
                          border: Border.all(
                              width: 1,
                              color: Theme.of(context).colorScheme.primary),
                          borderRadius: BorderRadius.circular(15),
                          color: kWhiteColor),
                      itemHeight: 40,
                      itemPadding: EdgeInsets.zero,
                      itemHighlightColor: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  headings(txt: 'Payment Account:'),
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
                      items: allSalesCtrlObj.getPaymentAccountsLists().map((e) {
                        return DropdownMenuItem(value: e, child: Text(e));
                      }).toList(),
                      value: allSalesCtrlObj.paymentAccountStatusValue,
                      dropdownDirection: DropdownDirection.textDirection,
                      dropdownPadding: EdgeInsets.only(left: 5, right: 5),
                      buttonPadding: EdgeInsets.only(left: 15, right: 15),
                      onChanged: (String? value) {
                        setState(() {
                          allSalesCtrlObj.paymentAccountStatusValue = value;
                        });
                      },
                      // buttonHeight: height * 0.06,
                      // buttonWidth: width * 0.43,
                      buttonDecoration: BoxDecoration(
                          border: Border.all(
                              width: 1,
                              color: Theme.of(context).colorScheme.primary),
                          borderRadius: BorderRadius.circular(15),
                          color: kWhiteColor),
                      itemHeight: 40,
                      itemPadding: EdgeInsets.zero,
                      itemHighlightColor: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  headings(txt: 'Payment Note:'),
                  AppFormField(
                    padding: EdgeInsets.only(bottom: 5),
                    labelText: 'payment_note'.tr,
                    title: 'payment_note'.tr + ': *',
                    maxLines: 2,
                    controller: paymentNoteCtrl,
                  ),
                ],
              ),
            ),
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
