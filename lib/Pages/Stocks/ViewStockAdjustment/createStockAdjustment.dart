import 'package:bizmodo_emenu/Components/custom_circular_button.dart';
import 'package:bizmodo_emenu/Config/utils.dart';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';

import '../../../Components/textfield.dart';
import '../../../Config/DateTimeFormat.dart';
import '../../../Controllers/StockTransferController/stockTransferController.dart';
import '../../../Models/ProductsModel/SearchProductModel.dart';
import '../../../Theme/colors.dart';
import '../../../Theme/style.dart';
import '../searchStockProducts.dart';

class CreateStockAdjustment extends StatefulWidget {
  const CreateStockAdjustment({Key? key}) : super(key: key);

  @override
  State<CreateStockAdjustment> createState() => _CreateStockAdjustmentState();
}

class _CreateStockAdjustmentState extends State<CreateStockAdjustment> {
  StockTransferController stockAdjustmentCtrlObj =
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

    stockAdjustmentCtrlObj.dateCtrl.text = '${AppFormat.dateDDMMYY(dateTime!)}';
    print(dateTime);
  }

  void dispose() {
    stockAdjustmentCtrlObj.searchCtrl.clear();
    stockAdjustmentCtrlObj.listForStockAdjustment?.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Stock Adjustment'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20, top: 20),
        child: SingleChildScrollView(
          child: Column(
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
                        controller: stockAdjustmentCtrlObj.dateCtrl,
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
                  GetBuilder<StockTransferController>(
                      builder: (StockTransferController stockAdjustmentCtrl) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        headings(txt: 'Adjustment Type:*'),
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
                            items: stockAdjustmentCtrl
                                .getAdjustmentTypeList()
                                .map((e) {
                              return DropdownMenuItem(value: e, child: Text(e));
                            }).toList(),
                            value: stockAdjustmentCtrl.statusValue,
                            dropdownDirection: DropdownDirection.textDirection,
                            dropdownPadding: EdgeInsets.only(left: 5, right: 5),
                            buttonPadding: EdgeInsets.only(left: 15, right: 15),
                            onChanged: (String? value) {
                              setState(() {
                                stockAdjustmentCtrl.statusValue = value;
                              });
                            },
                            buttonHeight: height * 0.06,
                            buttonWidth: width * 0.43,
                            buttonDecoration: BoxDecoration(
                                border: Border.all(
                                    width: 1,
                                    color:
                                        Theme.of(context).colorScheme.primary),
                                borderRadius: BorderRadius.circular(15),
                                color: kWhiteColor),
                            itemHeight: 40,
                            itemPadding: EdgeInsets.zero,
                            itemHighlightColor:
                                Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ],
                    );
                  }),
                ],
              ),
              SizedBox(
                height: 5,
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
                      // AppFormField(
                      //   controller: stockAdjustmentCtrlObj.additionalNotesCtrl,
                      //   labelText: 'Search products for stock',
                      // ),
                      TypeAheadField<SearchProductModel>(
                          textFieldConfiguration: TextFieldConfiguration(
                              controller: stockAdjustmentCtrlObj.searchCtrl,
                              autofocus: true,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: blackColor,
                              ),
                              decoration: InputDecoration(
                                  border: OutlineInputBorder())),
                          suggestionsCallback: (pattern) async {
                            return await stockAdjustmentCtrlObj
                                .searchProductList(term: pattern);
                          },
                          itemBuilder: (context, suggestion) {
                            return ListTile(
                              title: Text(
                                  '${suggestion.name} ${suggestion.subSku}' ??
                                      ''),
                            );
                          },
                          onSuggestionSelected: (suggestion) {
                            stockAdjustmentCtrlObj.listForStockAdjustment
                                ?.add(suggestion);
                            // Navigator.of(context).push(MaterialPageRoute(
                            //     builder: (context) =>
                            //         ProductPage(product: suggestion)));
                          },
                          errorBuilder: (context, error) => Text('$error',
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.error))),
                      Container(
                        height: 50,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        color: Theme.of(context).colorScheme.primary,
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
                      headings(txt: 'Total amount recovered:'),
                      AppFormField(
                        controller: stockAdjustmentCtrlObj.totalAmountRecCtrl,
                      ),
                      headings(txt: 'Reason:'),
                      AppFormField(
                        controller: stockAdjustmentCtrlObj.reasonCtrl,
                        labelText: 'Reason',
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              CustomButton(
                                title: Text(
                                  'Save',
                                  style: TextStyle(color: kWhiteColor),
                                ),
                                onTap: () {
                                  showProgress();
                                  stockAdjustmentCtrlObj
                                      .createStockAdjustment();
                                },
                                bgColor: Theme.of(context).colorScheme.primary,
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
