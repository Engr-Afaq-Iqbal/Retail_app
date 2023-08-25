import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';

import '../../../Components/custom_circular_button.dart';
import '../../../Components/textfield.dart';
import '../../../Config/DateTimeFormat.dart';
import '../../../Config/utils.dart';
import '../../../Controllers/StockTransferController/stockTransferController.dart';
import '../../../Services/storage_services.dart';
import '../../../Theme/colors.dart';
import '../../../Theme/style.dart';

class CreateStockTransfer extends StatefulWidget {
  const CreateStockTransfer({Key? key}) : super(key: key);

  @override
  State<CreateStockTransfer> createState() => _CreateStockTransferState();
}

class _CreateStockTransferState extends State<CreateStockTransfer> {
  StockTransferController stockTranCtrlObj =
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

    stockTranCtrlObj.dateCtrl.text =
        '${AppFormat.dateYYYYMMDDHHMM24(dateTime ?? DateTime.now())}';
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
    stockTranCtrlObj.statusValue = 'Pending';
    stockTranCtrlObj.dateCtrl.text =
        '${AppFormat.dateYYYYMMDDHHMM24(DateTime.now())}';
    stockTranCtrlObj.locationFromCtrl.text =
        '${AppStorage.getBusinessDetailsData()?.businessData?.locations.first.name}';
    //stockTranCtrlObj.checkLocationFromName();
    stockTranCtrlObj.searchProductList(term: '');
    super.initState();
  }

  void dispose() {
    stockTranCtrlObj.finalTotal = 0.00;
    stockTranCtrlObj.totalAmount.clear();
    stockTranCtrlObj.productQuantityCtrl.clear();
    stockTranCtrlObj.searchProductModel.clear();
    stockTranCtrlObj.selectedProducts.clear();
    stockTranCtrlObj.selectedQuantityList.clear();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text('create_stock_transfer'.tr),
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
                          headings(txt: 'date'.tr + ':*'),
                          AppFormField(
                            width: width * 0.44,
                            readOnly: true,
                            controller: stockTranCtrlObj.dateCtrl,
                            labelText: 'select_date'.tr,
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
                          headings(txt: 'status'.tr + ':*'),
                          GetBuilder<StockTransferController>(
                              builder: (StockTransferController stockCtrl) {
                            if (stockCtrl.statusListModel == null) {
                              return progressIndicator();
                            }
                            return DropdownButtonHideUnderline(
                              child: DropdownButton2(
                                isExpanded: true,
                                hint: Align(
                                    alignment: AlignmentDirectional.centerStart,
                                    child: Text(
                                      'please_select'.tr,
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
                                buttonWidth: width * 0.44,
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
                          }),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ///Location From
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          headings(txt: 'location_from'.tr + ':*'),
                          AppFormField(
                            width: width * 0.44,
                            readOnly: true,
                            controller: stockTranCtrlObj.locationFromCtrl,
                            // labelText: 'select_date'.tr,
                            // prefixIcon: Icon(Icons.calendar_month),
                          ),
                        ],
                      ),

                      ///Location to
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          headings(txt: 'location_to'.tr + ':*'),
                          DropdownButtonHideUnderline(
                            child: DropdownButton2(
                              isExpanded: true,
                              hint: Align(
                                  alignment: AlignmentDirectional.centerStart,
                                  child: Text(
                                    'please_select'.tr,
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

                                  stockTranCtrlObj.locationToID =
                                      AppStorage.getBusinessDetailsData()
                                          ?.businessData
                                          ?.locations[stockTransferCtrlObj
                                              .getBusinessLocationItems()
                                              .indexOf(value!)]
                                          .id
                                          .toString();

                                  print(stockTranCtrlObj.locationFromID);
                                });
                              },
                              buttonHeight: height * 0.06,
                              buttonWidth: width * 0.44,
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
                      ),
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
                          // headings(txt: 'Search Products'),
                          // AppFormField(
                          //   controller: stockTranCtrlObj.searchCtrl,
                          //   labelText: 'Search products for stock',
                          //   onEditingComp: () {
                          //     stockTranCtrlObj.searchProductList(
                          //         term: stockTranCtrlObj.searchCtrl.text);
                          //     print(stockTranCtrlObj.searchCtrl.text);
                          //   },
                          // ),

                          Container(
                              height: 40,
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              color: Theme.of(context).colorScheme.primary,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      'product_name'.tr,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              color: kWhiteColor),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Center(
                                      child: Text(
                                        'unit'.tr,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .copyWith(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                color: kWhiteColor),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Center(
                                      child: Text(
                                        'stock'.tr,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .copyWith(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                color: kWhiteColor),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Center(
                                      child: Text(
                                        'qty'.tr,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .copyWith(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                color: kWhiteColor),
                                      ),
                                    ),
                                  ),
                                  // Expanded(
                                  //   flex: 1,
                                  //   child: Center(
                                  //     child: Text(
                                  //       'total'.tr,
                                  //       style: Theme.of(context)
                                  //           .textTheme
                                  //           .titleMedium!
                                  //           .copyWith(
                                  //               fontSize: 12,
                                  //               fontWeight: FontWeight.bold,
                                  //               color: kWhiteColor),
                                  //     ),
                                  //   ),
                                  // ),
                                ],
                              )),

                          // Product5Headings(
                          //   txt1: 'product_name'.tr,
                          //   txt2: 'stock'.tr,
                          //   txt3: 'qty'.tr,
                          //   txt4: 'price'.tr,
                          //   txt5: 'total'.tr,
                          // ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.4,
                            child: GetBuilder<StockTransferController>(builder:
                                (StockTransferController stockTransferCtrl) {
                              if (stockTransferCtrl.searchProductModel ==
                                  null) {
                                return progressIndicator();
                              }
                              return ListView.builder(
                                  padding: EdgeInsetsDirectional.only(
                                      top: 5, bottom: 5, start: 0, end: 0),
                                  physics: ScrollPhysics(),
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  itemCount: stockTransferCtrl
                                      .searchProductModel.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      margin: EdgeInsets.only(
                                        bottom: 5,
                                      ),
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 1),
                                      color: index.isEven
                                          ? kWhiteColor
                                          : Colors.grey.withOpacity(0.1),
                                      child: Column(
                                        children: [
                                          GetBuilder<StockTransferController>(
                                              builder: (StockTransferController
                                                  stocktransfersCtrlObj) {
                                            return Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                //name
                                                Expanded(
                                                  flex: 2,
                                                  child: Text(
                                                    '${stockTransferCtrl.searchProductModel[index].name}',
                                                    style:
                                                        TextStyle(fontSize: 11),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    softWrap: true,
                                                  ),
                                                ),

                                                // Expanded(
                                                //   flex: 1,
                                                //   child: Text(
                                                //     '${stockTransferCtrl.searchProductModel[index].unit}',
                                                //     style:
                                                //         TextStyle(fontSize: 11),
                                                //     overflow:
                                                //         TextOverflow.ellipsis,
                                                //     softWrap: true,
                                                //     textAlign: TextAlign.center,
                                                //   ),
                                                // ),

                                                Container(
                                                  // height:
                                                  //     MediaQuery.of(context).size.height *
                                                  //         0.06,
                                                  //width: MediaQuery.of(context).size.width,
                                                  child:
                                                      DropdownButtonHideUnderline(
                                                    child: DropdownButton2(
                                                      isExpanded: true,
                                                      hint: Align(
                                                          alignment:
                                                              AlignmentDirectional
                                                                  .centerStart,
                                                          child: Text(
                                                            'Select',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 10,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          )),
                                                      items: stocktransfersCtrlObj
                                                          .nestedist[
                                                              index] //unitStatusList()
                                                          .map((String items) {
                                                        return DropdownMenuItem(
                                                          value: items,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        10.0),
                                                            child: Text(
                                                              items,
                                                              style: TextStyle(
                                                                  fontSize: 10),
                                                            ),
                                                          ),
                                                        );
                                                      }).toList(),
                                                      value: stocktransfersCtrlObj
                                                              .unitListStatus[
                                                          index],
                                                      dropdownWidth:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.2,
                                                      dropdownDecoration:
                                                          BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5)),
                                                      dropdownMaxHeight:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.7,
                                                      dropdownPadding:
                                                          EdgeInsets.only(
                                                              left: 5),
                                                      buttonPadding:
                                                          EdgeInsets.only(
                                                              left: 0,
                                                              right: 0),
                                                      onChanged:
                                                          (String? value) {
                                                        setState(() {
                                                          stocktransfersCtrlObj
                                                                  .unitListStatus[
                                                              index] = value!;

                                                          stocktransfersCtrlObj
                                                                      .unitListStatusIds[
                                                                  index] =
                                                              stocktransfersCtrlObj
                                                                  .checkSelectedUnitsIds(
                                                                      unitName:
                                                                          value);

                                                          stocktransfersCtrlObj
                                                                      .totalAmount[
                                                                  index] =
                                                              '${double.parse('${stocktransfersCtrlObj.productQuantityCtrl[index].text.isEmpty ? '0.00' : stocktransfersCtrlObj.productQuantityCtrl[index].text}') * double.parse('${stockTransferCtrl.searchProductModel[index].sellingPrice}') * double.parse(stocktransfersCtrlObj.checkUnitsActualBaseMultiplier(unitName: value) ?? '1.00')}';
                                                          debugPrint(
                                                              stocktransfersCtrlObj
                                                                      .totalAmount[
                                                                  index]);
                                                          debugPrint(
                                                              stocktransfersCtrlObj
                                                                      .unitListStatus[
                                                                  index]);

                                                          stocktransfersCtrlObj
                                                              .calculateFinalAmount();
                                                          stocktransfersCtrlObj
                                                              .update();
                                                        });
                                                      },
                                                      // buttonHeight: 40,
                                                      buttonWidth:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.19,
                                                      // buttonDecoration: BoxDecoration(
                                                      //     color: kWhiteColor,
                                                      //     border: Border.all(
                                                      //         width: 1,
                                                      //         color: Theme.of(context)
                                                      //             .colorScheme
                                                      //             .primary),
                                                      //     borderRadius:
                                                      //         BorderRadius.circular(15)),
                                                      // itemHeight: 40,
                                                      //icon: SizedBox(),
                                                      itemPadding:
                                                          EdgeInsets.zero,
                                                      itemHighlightColor:
                                                          Theme.of(context)
                                                              .colorScheme
                                                              .primary,
                                                    ),
                                                  ),
                                                ),

                                                // Expanded(
                                                //   flex: 1,
                                                //   child: Center(
                                                //     child: Text(
                                                //       AppFormat
                                                //               .doubleToStringUpTo2(
                                                //             '${double.parse(allProdCtrlObj.checkProductStockLocationBasedForOrderCreate(locationId: AppStorage.getBusinessDetailsData()?.businessData?.locations.first.id, index: index) ?? '0.00') / double.parse(allProdCtrlObj.checkUnitsActualBaseMultiplier(unitName: allProdCtrlObj.unitListStatus[index]))}',
                                                //           ) ??
                                                //           '0.00',
                                                //       overflow:
                                                //           TextOverflow.ellipsis,
                                                //       style: TextStyle(
                                                //           fontSize: 10),
                                                //     ),
                                                //   ),
                                                // )

                                                //Stock
                                                Expanded(
                                                  flex: 1,
                                                  child: Center(
                                                    child: Text(
                                                      '${AppFormat.doubleToStringUpTo2(stockTransferCtrl.searchProductModel[index].qtyAvailable) ?? '0.00'}',
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          fontSize: 11),
                                                      textAlign: TextAlign.left,
                                                    ),
                                                  ),
                                                ),

                                                //Quantity
                                                Expanded(
                                                  flex: 1,
                                                  child: AppFormField(
                                                      controller: stockTransferCtrl
                                                              .productQuantityCtrl[
                                                          index],
                                                      padding: EdgeInsets.only(
                                                          right: 5),
                                                      isOutlineBorder: false,
                                                      isColor: index.isEven
                                                          ? kWhiteColor
                                                          : Colors.transparent,
                                                      onChanged: (value) {
                                                        stockTransferCtrl
                                                                    .totalAmount[
                                                                index] =
                                                            '${double.parse('${stockTransferCtrl.productQuantityCtrl[index].text.isEmpty ? '0.00' : stockTransferCtrl.productQuantityCtrl[index].text}') * double.parse('${stockTransferCtrl.searchProductModel[index].sellingPrice.toString()}')}';
                                                        stockTransferCtrl
                                                            .calculateFinalAmount();
                                                        debugPrint(
                                                            'Product Amount');
                                                        debugPrint(
                                                            stockTranCtrlObj
                                                                    .totalAmount[
                                                                index]);
                                                        stockTransferCtrl
                                                            .update();
                                                      }),
                                                ),

                                                // Expanded(
                                                //   flex: 1,
                                                //   child: Center(
                                                //     child: Text(
                                                //       '${AppFormat.doubleToStringUpTo2(stockTransferCtrl.totalAmount[index])}',
                                                //       overflow:
                                                //           TextOverflow.ellipsis,
                                                //       style: TextStyle(
                                                //           fontSize: 11),
                                                //     ),
                                                //   ),
                                                // ),
                                              ],
                                            );
                                          }),
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
                          headings(txt: 'additional_notes'.tr),
                          AppFormField(
                            controller: stockTranCtrlObj.additionalNotes,
                            labelText: 'additional_notes'.tr,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  // headings(
                                  //     txt: 'total_amount'.tr +
                                  //         ': ${stockTranCtrlObj.finalTotal}'),
                                  CustomButton(
                                    title: Text(
                                      'save'.tr,
                                      style: TextStyle(color: kWhiteColor),
                                    ),
                                    onTap: () {
                                      showProgress();
                                      stockTranCtrlObj.addSelectedItemsInList();
                                      stockTranCtrlObj.createStockTransfer();
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
