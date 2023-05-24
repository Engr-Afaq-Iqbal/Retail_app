import 'package:bizmodo_emenu/Components/custom_circular_button.dart';
import 'package:bizmodo_emenu/Config/utils.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';

import '../../../Components/textfield.dart';
import '../../../Config/DateTimeFormat.dart';
import '../../../Controllers/StockTransferController/stockTransferController.dart';
import '../../../Theme/colors.dart';
import '../../../Theme/style.dart';
import '../searchStockProducts.dart';

class CreateStockTransfer extends StatefulWidget {
  const CreateStockTransfer({Key? key}) : super(key: key);

  @override
  State<CreateStockTransfer> createState() => _CreateStockTransferState();
}

class _CreateStockTransferState extends State<CreateStockTransfer> {
  StockTransferController stockTranCtrlObj =
      Get.find<StockTransferController>();

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

    stockTranCtrlObj.dateCtrl.text = '${AppFormat.dateDDMMYY(dateTime!)}';
    print(dateTime);
  }

  List<String> getStatusList() {
    // List<String> options = ['Pending', 'In Transit', 'Completed'];
    List<String> options = [];
    if (stockTranCtrlObj.statusListModel != null) {
      for (int i = 0; i < stockTranCtrlObj.statusListModel!.length; i++) {
        options.add('${stockTranCtrlObj.statusListModel?[i].value}');
      }
    }

    return options;
  }

  @override
  void initState() {
    // TODO: implement initState
    stockTranCtrlObj.fetchStatusList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Stock Transfer'),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10, top: 20),
          child: SingleChildScrollView(
            child: GetBuilder<StockTransferController>(
                builder: (StockTransferController stockTransferCtrlObj) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          headings(txt: 'Date:*'),
                          AppFormField(
                            width: width * 0.43,
                            readOnly: true,
                            controller: stockTranCtrlObj.dateCtrl,
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
                              items: getStatusList().map((e) {
                                return DropdownMenuItem(
                                    value: e, child: Text(e));
                              }).toList(),
                              value: stockTransferCtrlObj.statusValue,
                              dropdownDirection:
                                  DropdownDirection.textDirection,
                              dropdownPadding:
                                  EdgeInsets.only(left: 5, right: 5),
                              buttonPadding:
                                  EdgeInsets.only(left: 15, right: 15),
                              onChanged: (String? value) {
                                setState(() {
                                  stockTransferCtrlObj.statusValue = value;
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
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ///Location From
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          headings(txt: 'Location (From):*'),
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
                              items: stockTransferCtrlObj
                                  .getBusinessLocationItems()
                                  .map((e) {
                                return DropdownMenuItem(
                                    value: e, child: Text(e));
                              }).toList(),
                              value:
                                  stockTransferCtrlObj.locationFromStatusValue,
                              dropdownDirection:
                                  DropdownDirection.textDirection,
                              dropdownPadding:
                                  EdgeInsets.only(left: 5, right: 5),
                              buttonPadding:
                                  EdgeInsets.only(left: 15, right: 15),
                              onChanged: (String? value) {
                                setState(() {
                                  stockTransferCtrlObj.locationFromStatusValue =
                                      value;
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

                      ///Location to
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          headings(txt: 'Location (To):*'),
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
                              items: stockTransferCtrlObj
                                  .getBusinessLocationItems()
                                  .map((e) {
                                return DropdownMenuItem(
                                    value: e, child: Text(e));
                              }).toList(),
                              value: stockTransferCtrlObj.locationToStatusValue,
                              dropdownDirection:
                                  DropdownDirection.textDirection,
                              dropdownPadding:
                                  EdgeInsets.only(left: 5, right: 5),
                              buttonPadding:
                                  EdgeInsets.only(left: 15, right: 15),
                              onChanged: (String? value) {
                                setState(() {
                                  stockTransferCtrlObj.locationToStatusValue =
                                      value;
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
                            controller: stockTranCtrlObj.searchCtrl,
                            labelText: 'Search products for stock',
                            onEditingComp: () {
                              stockTranCtrlObj.searchProductList(
                                  term: stockTranCtrlObj.searchCtrl.text);
                              print(stockTranCtrlObj.searchCtrl.text);
                            },
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
                          SearchStockProducts(),
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          headings(txt: 'Additional Notes'),
                          AppFormField(
                            controller: stockTranCtrlObj.additionalNotes,
                            labelText: 'Additional Notes',
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  headings(txt: 'Total Amount: 0.00'),
                                  CustomButton(
                                    title: Text(
                                      'Save',
                                      style: TextStyle(color: kWhiteColor),
                                    ),
                                    onTap: () {
                                      showProgress();
                                      stockTranCtrlObj.createStockTransfer();
                                    },
                                    bgColor: primaryColor,
                                  )
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              );
            }),
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
