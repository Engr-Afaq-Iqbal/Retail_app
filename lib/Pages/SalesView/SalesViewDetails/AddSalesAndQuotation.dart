import 'package:bizmodo_emenu/Controllers/AllSalesController/allSalesController.dart';
import 'package:bizmodo_emenu/Pages/SalesView/paymentDetails.dart';
import 'package:bizmodo_emenu/Pages/SalesView/shippingCharge.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';

import '../../../Components/custom_circular_button.dart';
import '../../../Components/textfield.dart';
import '../../../Config/DateTimeFormat.dart';
import '../../../Theme/colors.dart';
import '../../../Theme/style.dart';

import '../discount.dart';
import '../SearchSaleProducts.dart';

class AddSalesAndQuotation extends StatefulWidget {
  bool? isSale;
  AddSalesAndQuotation({Key? key, this.isSale = true}) : super(key: key);

  @override
  State<AddSalesAndQuotation> createState() => _AddSalesAndQuotationState();
}

class _AddSalesAndQuotationState extends State<AddSalesAndQuotation> {
  AllSalesController allSalesCtrlObj = Get.find<AllSalesController>();
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

    allSalesCtrlObj.dateCtrl.text = '${AppFormat.dateDDMMYY(dateTime!)}';
    print(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: widget.isSale == true ? Text('Add Sale') : Text('Add Quotation'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20, top: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              headings(txt: 'Add Sale'),
              Divider(),
              SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      headings(txt: 'Pay term:'),
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
                          items: allSalesCtrlObj.payTermList().map((e) {
                            return DropdownMenuItem(value: e, child: Text(e));
                          }).toList(),
                          value: allSalesCtrlObj.paytermStatusValue,
                          dropdownDirection: DropdownDirection.textDirection,
                          dropdownPadding: EdgeInsets.only(left: 5, right: 5),
                          buttonPadding: EdgeInsets.only(left: 15, right: 15),
                          onChanged: (String? value) {
                            setState(() {
                              allSalesCtrlObj.paytermStatusValue = value;
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      headings(txt: 'Sale Date:'),
                      AppFormField(
                        width: width * 0.43,
                        readOnly: true,
                        controller: allSalesCtrlObj.dateCtrl,
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
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (widget.isSale == true)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        headings(txt: 'Status:*'),
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
                            items: allSalesCtrlObj.statusList().map((e) {
                              return DropdownMenuItem(value: e, child: Text(e));
                            }).toList(),
                            value: allSalesCtrlObj.statusValue,
                            dropdownDirection: DropdownDirection.textDirection,
                            dropdownPadding: EdgeInsets.only(left: 5, right: 5),
                            buttonPadding: EdgeInsets.only(left: 15, right: 15),
                            onChanged: (String? value) {
                              setState(() {
                                allSalesCtrlObj.statusValue = value;
                              });
                            },
                            buttonHeight: height * 0.06,
                            buttonWidth: width * 0.43,
                            buttonDecoration: BoxDecoration(
                                border:
                                    Border.all(width: 1, color: primaryColor),
                                borderRadius: BorderRadius.circular(15),
                                color: kWhiteColor),
                            itemHeight: 40,
                            itemPadding: EdgeInsets.zero,
                            itemHighlightColor: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      headings(txt: 'Invoice Schema:'),
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
                          items: allSalesCtrlObj.invoiceSchemaList().map((e) {
                            return DropdownMenuItem(value: e, child: Text(e));
                          }).toList(),
                          value: allSalesCtrlObj.invoiceSchemaStatusValue,
                          dropdownDirection: DropdownDirection.textDirection,
                          dropdownPadding: EdgeInsets.only(left: 5, right: 5),
                          buttonPadding: EdgeInsets.only(left: 15, right: 15),
                          onChanged: (String? value) {
                            setState(() {
                              allSalesCtrlObj.invoiceSchemaStatusValue = value;
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
                      headings(txt: 'Search Products'),
                      AppFormField(
                        controller: allSalesCtrlObj.searchCtrl,
                        labelText: 'Search products for stock',
                      ),
                      Container(
                        height: 50,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        color: primaryColor,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 3,
                              child: Text(
                                'Product Name',
                                style: TextStyle(color: kWhiteColor),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                'QTY',
                                style: TextStyle(color: kWhiteColor),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                'Price',
                                style: TextStyle(color: kWhiteColor),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                'Total',
                                style: TextStyle(color: kWhiteColor),
                              ),
                            )
                          ],
                        ),
                      ),
                      SearchSaleProducts(),
                    ],
                  ),
                ),
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomButton(
                            title: Text(
                              'Discount',
                              style: TextStyle(color: kWhiteColor),
                            ),
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  //title: title != null ? Text(title) : null,
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 15, horizontal: 0),
                                  content: Discount(),
                                ),
                              );
                            },
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          CustomButton(
                            title: Text(
                              'Shipping',
                              style: TextStyle(color: kWhiteColor),
                            ),
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  //title: title != null ? Text(title) : null,
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 15, horizontal: 0),
                                  content: ShippingCharge(),
                                ),
                              );
                            },
                          ),
                          if (widget.isSale == true)
                            SizedBox(
                              width: 5,
                            ),
                          if (widget.isSale == true)
                            CustomButton(
                              title: Text(
                                'Checkout',
                                style: TextStyle(color: kWhiteColor),
                              ),
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    //title: title != null ? Text(title) : null,
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 15, horizontal: 0),
                                    content: PaymentFields(),
                                  ),
                                );
                              },
                            ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
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
                              'Save & Print',
                              style: TextStyle(color: kWhiteColor),
                            ),
                            onTap: () {
                              Get.back();
                            },
                            bgColor: primaryColor,
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
