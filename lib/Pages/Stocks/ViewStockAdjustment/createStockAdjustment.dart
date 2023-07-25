import 'package:bizmodo_emenu/Components/custom_circular_button.dart';
import 'package:bizmodo_emenu/Config/utils.dart';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';

import '../../../Components/productHeadings.dart';
import '../../../Components/textfield.dart';
import '../../../Config/DateTimeFormat.dart';
import '../../../Controllers/ProductController/all_products_controller.dart';
import '../../../Controllers/StockTransferController/stockTransferController.dart';
import '../../../Theme/colors.dart';
import '../../../Theme/style.dart';

class CreateStockAdjustment extends StatefulWidget {
  const CreateStockAdjustment({Key? key}) : super(key: key);

  @override
  State<CreateStockAdjustment> createState() => _CreateStockAdjustmentState();
}

class _CreateStockAdjustmentState extends State<CreateStockAdjustment> {
  StockTransferController stockTransferCtrlObj =
      Get.find<StockTransferController>();
  // AllProductsController allProdCtrlObj = Get.find<AllProductsController>();

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

    stockTransferCtrlObj.dateCtrl.text = '${AppFormat.dateDDMMYY(dateTime!)}';
    print(dateTime);
  }

  void dispose() {
    stockTransferCtrlObj.searchCtrl.clear();
    stockTransferCtrlObj.finalTotal = 0.00;
    stockTransferCtrlObj.totalAmount.clear();
    stockTransferCtrlObj.productQuantityCtrl.clear();
    stockTransferCtrlObj.searchProductModel.clear();

    super.dispose();
  }

  @override
  void initState() {
    stockTransferCtrlObj.searchProductList(term: '');
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text('Create Stock Adjustment'),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Padding(
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
                          controller: stockTransferCtrlObj.dateCtrl,
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
                                return DropdownMenuItem(
                                    value: e, child: Text(e));
                              }).toList(),
                              value: stockAdjustmentCtrl.adjustmentTypeStatus,
                              dropdownDirection:
                                  DropdownDirection.textDirection,
                              dropdownPadding:
                                  EdgeInsets.only(left: 5, right: 5),
                              buttonPadding:
                                  EdgeInsets.only(left: 15, right: 15),
                              onChanged: (String? value) {
                                setState(() {
                                  stockAdjustmentCtrl.adjustmentTypeStatus =
                                      value;
                                });
                              },
                              buttonHeight: height * 0.06,
                              buttonWidth: width * 0.43,
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
                        ProductHeadings(
                          txt1: 'Product Name',
                          txt2: 'QTY',
                          txt3: 'Price',
                          txt4: 'Total',
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.4,
                          child: GetBuilder<StockTransferController>(builder:
                              (StockTransferController stockTransferCtrl) {
                            if (stockTransferCtrlObj.searchProductModel ==
                                    null &&
                                stockTransferCtrlObj.searchProductModel == []) {
                              return progressIndicator();
                            }
                            return ListView.builder(
                                padding: EdgeInsetsDirectional.only(
                                    top: 5, bottom: 5, start: 10, end: 10),
                                physics: ScrollPhysics(),
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount: stockTransferCtrlObj
                                    .searchProductModel.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: EdgeInsets.only(
                                      bottom: 5,
                                    ),
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 5),
                                    color: index.isEven
                                        ? kWhiteColor
                                        : Colors.grey.withOpacity(0.1),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            //name
                                            Expanded(
                                              flex: 2,
                                              child: Text(
                                                '${stockTransferCtrlObj.searchProductModel[index].name}',
                                                overflow: TextOverflow.ellipsis,
                                                softWrap: true,
                                              ),
                                            ),

                                            //Quantity
                                            Expanded(
                                              flex: 1,
                                              child: AppFormField(
                                                  controller: stockTransferCtrl
                                                          .productQuantityCtrl[
                                                      index],
                                                  padding:
                                                      EdgeInsets.only(right: 5),
                                                  isOutlineBorder: false,
                                                  isColor: index.isEven
                                                      ? kWhiteColor
                                                      : Colors.transparent,
                                                  onChanged: (value) {
                                                    stockTransferCtrl
                                                                .totalAmount[
                                                            index] =
                                                        '${double.parse('${stockTransferCtrlObj.productQuantityCtrl[index].text.isEmpty ? '0.00' : stockTransferCtrlObj.productQuantityCtrl[index].text}') * double.parse('${stockTransferCtrlObj.searchProductModel[index].sellingPrice.toString()}')}';
                                                    stockTransferCtrl
                                                        .calculateFinalAmount();
                                                    debugPrint(
                                                        'Product Amount');
                                                    debugPrint(stockTransferCtrl
                                                        .totalAmount[index]);
                                                    stockTransferCtrl.update();
                                                  }),
                                            ),
                                            //unit
                                            Expanded(
                                              flex: 1,
                                              child: Center(
                                                child: Text(
                                                  '${AppFormat.doubleToStringUpTo2(stockTransferCtrlObj.searchProductModel[index].sellingPrice)}',
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Center(
                                                child: Text(
                                                  '${stockTransferCtrl.totalAmount[index]}',
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                });
                          }),
                        ),
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
                          controller: stockTransferCtrlObj.totalAmountRecCtrl,
                        ),
                        headings(txt: 'Reason:'),
                        AppFormField(
                          controller: stockTransferCtrlObj.reasonCtrl,
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
                                    stockTransferCtrlObj
                                        .addSelectedItemsInList();
                                    stockTransferCtrlObj
                                        .createStockAdjustment();
                                  },
                                  bgColor:
                                      Theme.of(context).colorScheme.primary,
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
