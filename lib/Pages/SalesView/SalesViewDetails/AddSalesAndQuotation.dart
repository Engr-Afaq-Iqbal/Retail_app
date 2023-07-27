import 'package:bizmodo_emenu/Controllers/AllSalesController/allSalesController.dart';
import 'package:bizmodo_emenu/Pages/PrintDesign/pdfGenerate.dart';
import 'package:bizmodo_emenu/Pages/PrintDesign/pos_print_layout.dart';
import 'package:bizmodo_emenu/Pages/SalesView/paymentDetails.dart';
import 'package:bizmodo_emenu/Pages/SalesView/shippingCharge.dart';
import 'package:bizmodo_emenu/Pages/print_page.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';

import '../../../Components/custom_circular_button.dart';
import '../../../Components/p4Headings.dart';
import '../../../Components/textfield.dart';
import '../../../Config/DateTimeFormat.dart';
import '../../../Config/utils.dart';
import '../../../Controllers/ProductController/PaymentController.dart';
import '../../../Controllers/ProductController/all_products_controller.dart';
import '../../../Theme/colors.dart';
import '../../../Theme/style.dart';

import '../../../const/dimensions.dart';
import '../../CreateOrder/selectionDialogue.dart';
import '../../checkout/check_out.dart';
import '../discount.dart';

class AddSalesAndQuotation extends StatefulWidget {
  final bool? isSale;
  AddSalesAndQuotation({Key? key, this.isSale = false}) : super(key: key);

  @override
  State<AddSalesAndQuotation> createState() => _AddSalesAndQuotationState();
}

class _AddSalesAndQuotationState extends State<AddSalesAndQuotation> {
  AllSalesController allSalesCtrlObj = Get.find<AllSalesController>();
  AllProductsController allProdCtrlObj = Get.find<AllProductsController>();
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

    allProdCtrlObj.dateCtrl.text =
        '${AppFormat.dateDDMMYY(dateTime ?? DateTime.now())}';
    print(dateTime);
  }

  @override
  void initState() {
    // TODO: implement initState
    allSalesCtrlObj.dateCtrl.text = '${AppFormat.dateDDMMYY(DateTime.now())}';
    allSalesCtrlObj.salesAndQuotStatus = widget.isSale ?? false;
    // allProdCtrlObj.searchProductList(term: '');
    allProdCtrlObj.fetchAllProducts();
    allProdCtrlObj.finalTotal = 0.00;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: widget.isSale == false
            ? Text('add_sale'.tr)
            : Text('add_quotation'.tr),
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
                // headings(txt: 'Add Sale'),
                // Divider(),
                SizedBox(
                  height: 10,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Column(
                    //   crossAxisAlignment: CrossAxisAlignment.start,
                    //   children: [
                    //     headings(txt: 'Pay term:'),
                    //     Row(
                    //       crossAxisAlignment: CrossAxisAlignment.start,
                    //       children: [
                    //         AppFormField(
                    //           controller: allProdCtrlObj.payTermCtrl,
                    //           labelText: '',
                    //           width: width * 0.15,
                    //         ),
                    //         SizedBox(
                    //           width: 2,
                    //         ),
                    //         DropdownButtonHideUnderline(
                    //           child: DropdownButton2(
                    //             isExpanded: true,
                    //             hint: Align(
                    //                 alignment: AlignmentDirectional.centerStart,
                    //                 child: Text(
                    //                   'Select',
                    //                   style: TextStyle(
                    //                     fontSize: 13,
                    //                     fontWeight: FontWeight.w400,
                    //                     color: txtFieldHintColor,
                    //                   ),
                    //                 )),
                    //             items: allProdCtrlObj.payTermList().map((e) {
                    //               return DropdownMenuItem(
                    //                   value: e, child: Text(e));
                    //             }).toList(),
                    //             value: allProdCtrlObj.paytermStatusValue,
                    //             dropdownDirection:
                    //                 DropdownDirection.textDirection,
                    //             dropdownPadding:
                    //                 EdgeInsets.only(left: 5, right: 5),
                    //             buttonPadding:
                    //                 EdgeInsets.only(left: 15, right: 15),
                    //             onChanged: (String? value) {
                    //               setState(() {
                    //                 allProdCtrlObj.paytermStatusValue = value;
                    //               });
                    //             },
                    //             buttonHeight: height * 0.06,
                    //             buttonWidth: width * 0.26,
                    //             buttonDecoration: BoxDecoration(
                    //                 border: Border.all(
                    //                     width: 1,
                    //                     color: Theme.of(context)
                    //                         .colorScheme
                    //                         .primary),
                    //                 borderRadius: BorderRadius.circular(15),
                    //                 color: kWhiteColor),
                    //             itemHeight: 40,
                    //             itemPadding: EdgeInsets.zero,
                    //             itemHighlightColor:
                    //                 Theme.of(context).colorScheme.primary,
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //   ],
                    // ),
                    if (widget.isSale == false)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          headings(txt: 'status'.tr + ':*'),
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
                              items: allProdCtrlObj.statusList().map((e) {
                                return DropdownMenuItem(
                                    value: e, child: Text(e));
                              }).toList(),
                              value: allProdCtrlObj.statusValue,
                              dropdownDirection:
                                  DropdownDirection.textDirection,
                              dropdownPadding:
                                  EdgeInsets.only(left: 5, right: 5),
                              buttonPadding:
                                  EdgeInsets.only(left: 15, right: 15),
                              onChanged: (String? value) {
                                setState(() {
                                  allProdCtrlObj.statusValue = value;
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
                      ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        headings(txt: 'sale_date'.tr + ':'),
                        AppFormField(
                          width: width * 0.43,
                          readOnly: true,
                          controller: allSalesCtrlObj.dateCtrl,
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
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Column(
                    //   crossAxisAlignment: CrossAxisAlignment.start,
                    //   children: [
                    //     headings(txt: 'Invoice Schema:'),
                    //     DropdownButtonHideUnderline(
                    //       child: DropdownButton2(
                    //         isExpanded: true,
                    //         hint: Align(
                    //             alignment: AlignmentDirectional.centerStart,
                    //             child: Text(
                    //               'Please Select',
                    //               style: TextStyle(
                    //                 fontSize: 13,
                    //                 fontWeight: FontWeight.w400,
                    //                 color: txtFieldHintColor,
                    //               ),
                    //             )),
                    //         items: allProdCtrlObj.invoiceSchemaList().map((e) {
                    //           return DropdownMenuItem(value: e, child: Text(e));
                    //         }).toList(),
                    //         value: allProdCtrlObj.invoiceSchemaStatusValue,
                    //         dropdownDirection: DropdownDirection.textDirection,
                    //         dropdownPadding: EdgeInsets.only(left: 5, right: 5),
                    //         buttonPadding: EdgeInsets.only(left: 15, right: 15),
                    //         onChanged: (String? value) {
                    //           setState(() {
                    //             allProdCtrlObj.invoiceSchemaStatusValue = value;
                    //           });
                    //         },
                    //         buttonHeight: height * 0.06,
                    //         buttonWidth: width * 0.43,
                    //         buttonDecoration: BoxDecoration(
                    //             border: Border.all(
                    //                 width: 1,
                    //                 color:
                    //                     Theme.of(context).colorScheme.primary),
                    //             borderRadius: BorderRadius.circular(15),
                    //             color: kWhiteColor),
                    //         itemHeight: 40,
                    //         itemPadding: EdgeInsets.zero,
                    //         itemHighlightColor:
                    //             Theme.of(context).colorScheme.primary,
                    //       ),
                    //     ),
                    //   ],
                    // ),
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
                        // headings(txt: 'Search Products'),
                        // AppFormField(
                        //   controller: allSalesCtrlObj.searchCtrl,
                        //   labelText: 'Search products for stock',
                        // ),
                        Product4Headings(
                          txt1: 'product_name'.tr,
                          txt2: 'qty'.tr,
                          txt3: 'price'.tr,
                          txt4: 'total'.tr,
                        ),
                        // SearchSaleProducts(),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.45,
                          child: GetBuilder<AllProductsController>(
                              builder: (AllProductsController allProdCtrlObj) {
                            if (allProdCtrlObj.listProductsModel == null) {
                              return progressIndicator();
                            }
                            print(allProdCtrlObj.productModelObjs.length);
                            return ListView.builder(
                                padding: EdgeInsetsDirectional.only(
                                    top: 5, bottom: 5, start: 10, end: 10),
                                physics: ScrollPhysics(),
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount:
                                    allProdCtrlObj.productModelObjs.length,
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
                                                '${allProdCtrlObj.productModelObjs[index].name}',
                                                overflow: TextOverflow.ellipsis,
                                                softWrap: true,
                                              ),
                                            ),

                                            //Quantity
                                            Expanded(
                                              flex: 1,
                                              child: AppFormField(
                                                  controller: allProdCtrlObj
                                                          .productQuantityCtrl[
                                                      index],
                                                  padding:
                                                      EdgeInsets.only(right: 5),
                                                  isOutlineBorder: false,
                                                  isColor: index.isEven
                                                      ? kWhiteColor
                                                      : Colors.transparent,
                                                  onChanged: (value) {
                                                    //multiplying quantity with product amount

                                                    allProdCtrlObj.totalAmount[
                                                            index] =
                                                        '${double.parse('${allProdCtrlObj.productQuantityCtrl[index].text.isEmpty ? '0.00' : allProdCtrlObj.productQuantityCtrl[index].text}') * double.parse('${allProdCtrlObj.productModelObjs[index].productVariations?.first.variations?.first.sellPriceIncTax}')}';
                                                    allProdCtrlObj
                                                        .calculateFinalAmount();
                                                    debugPrint(
                                                        'Product Amount');
                                                    debugPrint(allProdCtrlObj
                                                        .totalAmount[index]);
                                                    allProdCtrlObj.update();
                                                  }),
                                            ),
                                            //unit
                                            Expanded(
                                              flex: 1,
                                              child: Center(
                                                child: Text(
                                                  '${AppFormat.doubleToStringUpTo2(allProdCtrlObj.productModelObjs[index].productVariations?.first.variations?.first.sellPriceIncTax)}',
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Center(
                                                child: Text(
                                                  '${allProdCtrlObj.totalAmount[index]}',
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
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomButton(
                              title: Text(
                                'discount'.tr,
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
                                'shipping'.tr,
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
                            if (widget.isSale == false)
                              SizedBox(
                                width: 5,
                              ),
                            if (widget.isSale == false)
                              CustomButton(
                                title: Text(
                                  'pay'.tr,
                                  style: TextStyle(color: kWhiteColor),
                                ),
                                onTap: () {
                                  allProdCtrlObj.isDirectCheckout = false;
                                  allProdCtrlObj.update();
                                  Get.to(CheckOutPage(
                                    isReceipt: false,
                                  ));
                                  // showDialog(
                                  //   context: context,
                                  //   builder: (context) => AlertDialog(
                                  //     //title: title != null ? Text(title) : null,
                                  //     contentPadding:
                                  //         const EdgeInsets.symmetric(
                                  //             vertical: 15, horizontal: 0),
                                  //     content: PaymentFields(),
                                  //   ),
                                  // );
                                },
                              ),
                          ],
                        ),
                        CustomButton(
                          title: Text(
                            'credit'.tr,
                            style: TextStyle(color: kWhiteColor),
                          ),
                          onTap: () {
                            allProdCtrlObj.isDirectCheckout = true;
                            Get.dialog(Dialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.radiusSmall)),
                              insetPadding:
                                  EdgeInsets.all(Dimensions.paddingSizeSmall),
                              child: SelectionDialogue(),
                            ));
                            // allProdCtrlObj.update();
                            // allProdCtrlObj.addSelectedItemsInList();
                            // allProdCtrlObj.orderCreate();
                          },
                          bgColor: Theme.of(context).colorScheme.primary,
                        ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //     CustomButton(
                        //       title: Text(
                        //         'Save',
                        //         style: TextStyle(color: kWhiteColor),
                        //       ),
                        //       onTap: () {
                        //         allProdCtrlObj.update();
                        //         allProdCtrlObj.addSelectedItemsInList();
                        //         allProdCtrlObj.orderCreate();
                        //       },
                        //       bgColor: Theme.of(context).colorScheme.primary,
                        //     ),
                        //     SizedBox(
                        //       width: 5,
                        //     ),
                        //     CustomButton(
                        //       title: Text(
                        //         'Save & Print',
                        //         style: TextStyle(color: kWhiteColor),
                        //       ),
                        //       onTap: () {
                        //         allProdCtrlObj.isPDFView = false;
                        //         allProdCtrlObj.addSelectedItemsInList();
                        //         allProdCtrlObj.orderCreate();
                        //         // Get.back();
                        //       },
                        //       bgColor: Theme.of(context).colorScheme.primary,
                        //     )
                        //   ],
                        // )
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
