import 'package:bizmodo_emenu/Config/DateTimeFormat.dart';
import 'package:bizmodo_emenu/Controllers/AllKitchenController/allKitchenController.dart';
import 'package:bizmodo_emenu/Controllers/ProductController/all_products_controller.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../Components/custom_circular_button.dart';
import '../../../Components/textfield.dart';
import '../../../Theme/colors.dart';
import '../../../Theme/style.dart';
import '../../Config/utils.dart';
import '../../Controllers/ProductsRetailController/productsRetailsController.dart';
import '../../Controllers/Tax Controller/TaxController.dart';
import '../../Models/ProductsModel/ProductShowListModel.dart';

class ViewProductsPage extends StatefulWidget {
  bool isView;
  ProductShowListModel productModelObjs;
  int index;
  ViewProductsPage({
    Key? key,
    this.isView = false,
    required this.productModelObjs,
    required this.index,
  }) : super(key: key);

  @override
  State<ViewProductsPage> createState() => _ViewProductsPageState();
}

class _ViewProductsPageState extends State<ViewProductsPage> {
  ProductsRetailController productRetailCtrlObj =
      Get.find<ProductsRetailController>();
  AllKitchenController allKitchenCtrlObj = Get.find<AllKitchenController>();
  TaxController taxCtrlObj = Get.find<TaxController>();
  final GlobalKey<FormState> addProductFormKey = GlobalKey<FormState>();

  bool valuefirst = false;
  bool isEdit = false;

  @override
  void initState() {
    ///Fetching the product list
    // productRetailCtrlObj.fetchShowProductList();
    // allKitchenCtrlObj.fetchShowProductList();
    // taxCtrlObj.fetchListTax();
    // productRetailCtrlObj.marginCtrl.text =
    //     '${AppStorage.getBusinessDetailsData()?.businessData?.defaultProfitPercent}';
    // productRetailCtrlObj.taxTypeStatus = 'Exclusive';
    if (widget.productModelObjs.data?[widget.index].enableStock == 1) {
      productRetailCtrlObj.enableProduct = true;
    }
    if (widget.productModelObjs.data?[widget.index].notForSelling == 1) {
      productRetailCtrlObj.notForSelling = true;
    }
    if (widget.productModelObjs.data?[widget.index].woocommerceDisableSync ==
        1) {
      productRetailCtrlObj.disableWooCommerce = true;
    }
    //  if(widget.productModelObjs.data?[widget.index]. )

    // TODO: implement initState
    super.initState();
  }

  void dispose() {
    productRetailCtrlObj.clearAllFields();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('view_products'.tr),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 15, top: 15),
        child: SingleChildScrollView(
          child: Form(
            key: addProductFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ///1st Container
                GetBuilder<AllProductsController>(
                    builder: (AllProductsController prodRtailCtrlObj) {
                  if (prodRtailCtrlObj.productShowListModel == null)
                    return progressIndicator();
                  return IntrinsicHeight(
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              titleWithText(
                                  headingTxt: 'product_name'.tr + ':*',
                                  bodyText: widget.productModelObjs
                                          .data?[widget.index].product ??
                                      ''),
                              titleWithText(
                                  headingTxt: 'sku'.tr + ':',
                                  bodyText: widget.productModelObjs
                                          .data?[widget.index].sku ??
                                      ''),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              titleWithText(
                                  headingTxt: 'Brand:*',
                                  bodyText: widget.productModelObjs
                                          .data?[widget.index].brand ??
                                      '- -'),

                              ///TODO unit id to text
                              titleWithText(
                                  headingTxt: 'unit'.tr + ':*',
                                  bodyText: widget.productModelObjs
                                          .data?[widget.index].unit ??
                                      '- -'),
                            ],
                          ),

                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              titleWithText(
                                  headingTxt: 'category'.tr + ':',
                                  bodyText: widget.productModelObjs
                                          .data?[widget.index].category ??
                                      '- -'),
                              // Expanded(
                              //   child: CheckboxListTile(
                              //       value: productRetailCtrlObj.manageValue,
                              //       onChanged: (bool? value) {
                              //         setState(() {
                              //           productRetailCtrlObj.manageValue =
                              //               value!;
                              //           productRetailCtrlObj.update();
                              //         });
                              //       },
                              //       controlAffinity:
                              //           ListTileControlAffinity.leading,
                              //       title: Text(
                              //         'manage_stock'.tr + '?',
                              //         style: TextStyle(color: blackColor),
                              //       )),
                              // ),
                              // if (widget.productModelObjs?[widget.index!]
                              //         .enableStock ==
                              //     1)
                              titleWithText(
                                  headingTxt: 'alert_quantity'.tr + ':',
                                  bodyText: AppFormat.doubleToStringUpTo2(widget
                                          .productModelObjs
                                          .data?[widget.index]
                                          .alertQuantity) ??
                                      '- -')
                            ],
                          ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   children: [
                          //     titleWithText(
                          //         headingTxt: 'warranty'.tr, bodyText: ''),
                          //     if (widget.productModelObjs.data?[widget.index]
                          //             .productLocations !=
                          //         null)
                          //       titleWithText(
                          //           headingTxt: 'printer'.tr, bodyText: '')
                          //   ],
                          // ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              titleWithText(
                                  headingTxt: 'type_of_product'.tr + ':',
                                  bodyText:
                                      '${widget.productModelObjs.data?[widget.index].type ?? '- -'}'
                                              .capitalizeFirst ??
                                          ''),
                              titleWithText(
                                  headingTxt: 'product_description'.tr + ':',
                                  bodyText:
                                      '${widget.productModelObjs.data?[widget.index].type ?? '- -'}'
                                              .capitalizeFirst ??
                                          ''),
                              // Column(
                              //   crossAxisAlignment: CrossAxisAlignment.start,
                              //   children: [
                              //     headings(txt: 'Device Model:'),
                              //     DropdownButtonHideUnderline(
                              //       child: DropdownButton2(
                              //         isExpanded: true,
                              //         hint: Align(
                              //             alignment:
                              //                 AlignmentDirectional.centerStart,
                              //             child: Text(
                              //               'Please Select',
                              //               style: TextStyle(
                              //                 fontSize: 13,
                              //                 fontWeight: FontWeight.w400,
                              //                 color: txtFieldHintColor,
                              //               ),
                              //             )),
                              //         items: productRetailCtrlObj
                              //             .deviceModelList(prodRtailCtrlObj)
                              //             .map((e) {
                              //           return DropdownMenuItem(
                              //               value: e, child: Text(e));
                              //         }).toList(),
                              //         value:
                              //             productRetailCtrlObj.deviceModelStatus,
                              //         dropdownDirection:
                              //             DropdownDirection.textDirection,
                              //         dropdownPadding:
                              //             EdgeInsets.only(left: 5, right: 5),
                              //         buttonPadding:
                              //             EdgeInsets.only(left: 15, right: 15),
                              //         onChanged: (String? value) {
                              //           setState(() {
                              //             productRetailCtrlObj.deviceModelStatus =
                              //                 value;
                              //           });
                              //         },
                              //         buttonHeight: height * 0.06,
                              //         buttonWidth: width * 0.42,
                              //         buttonDecoration: BoxDecoration(
                              //             border: Border.all(
                              //                 width: 1, color: primaryColor),
                              //             borderRadius: BorderRadius.circular(15),
                              //             color: kWhiteColor),
                              //         itemHeight: 40,
                              //         itemPadding: EdgeInsets.zero,
                              //         itemHighlightColor: primaryColor,
                              //       ),
                              //     ),
                              //   ],
                              // ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),

                          // AppFormField(
                          //   width: width,
                          //   controller: productRetailCtrlObj.productDescCtrl,
                          //   maxLines: 2,
                          // ),
                          headings(txt: 'product_image'.tr + ':'),
                          IntrinsicWidth(
                              child: Container(
                            height: MediaQuery.of(context).size.height * 0.2,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: kHintColor.withOpacity(0.3)),
                            child: (widget.productModelObjs.data?[widget.index]
                                        .imageUrl !=
                                    null)
                                ? Center(
                                    child: Image.network(
                                      widget.productModelObjs
                                              .data?[widget.index].imageUrl ??
                                          '',
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : Center(
                                    child: Icon(
                                      Icons.add,
                                      size: 30,
                                    ),
                                  ),
                          )),
                          // headings(txt: 'product_brocher'.tr + ':'),
                        ],
                      ),
                    ),
                  );
                }),
                SizedBox(
                  height: 15,
                ),

                ///2nd Container
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
                        CheckboxListTile(
                            value: productRetailCtrlObj.enableProduct,
                            onChanged: (bool? value) {
                              setState(() {
                                productRetailCtrlObj.enableProduct = value!;
                                // if (value) {
                                //   productRetailCtrlObj.enableProductID = '1';
                                // } else {
                                //   productRetailCtrlObj.enableProductID = '0';
                                // }

                                productRetailCtrlObj.update();
                              });
                            },
                            controlAffinity: ListTileControlAffinity.leading,
                            dense: true,
                            title: Text(
                              'enable_product'.tr,
                              style: TextStyle(color: blackColor),
                            )),
                        CheckboxListTile(
                            value: productRetailCtrlObj.notForSelling,
                            onChanged: (bool? value) {
                              setState(() {
                                productRetailCtrlObj.notForSelling = value!;
                                // if (value) {
                                //   productRetailCtrlObj.notForSellingID = '1';
                                // } else {
                                //   productRetailCtrlObj.notForSellingID = '0';
                                // }
                                productRetailCtrlObj.update();
                              });
                            },
                            controlAffinity: ListTileControlAffinity.leading,
                            dense: true,
                            title: Text(
                              'not_for_selling'.tr,
                              style: TextStyle(color: blackColor),
                            )),
                        // headings(txt: 'Rack/Row/Position Details:'),
                        // RowRackPosition(),
                        // titleWithText(headingTxt: 'weight'.tr + ':', bodyText: ''),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            if (widget.productModelObjs.data?[widget.index]
                                    .productCustomField1 !=
                                null)
                              titleWithText(
                                  headingTxt: 'custom_field1'.tr + ':',
                                  bodyText: widget
                                          .productModelObjs
                                          .data?[widget.index]
                                          .productCustomField1 ??
                                      '- -'),
                            if (widget.productModelObjs.data?[widget.index]
                                    .productCustomField2 !=
                                null)
                              titleWithText(
                                  headingTxt: 'custom_field2'.tr + ':',
                                  bodyText: widget
                                          .productModelObjs
                                          .data?[widget.index]
                                          .productCustomField2 ??
                                      '- -'),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            if (widget.productModelObjs.data?[widget.index]
                                    .productCustomField3 !=
                                null)
                              titleWithText(
                                  headingTxt: 'custom_field3'.tr + ':',
                                  bodyText: widget
                                          .productModelObjs
                                          .data?[widget.index]
                                          .productCustomField3 ??
                                      '- -'),
                            if (widget.productModelObjs.data?[widget.index]
                                    .productCustomField4 !=
                                null)
                              titleWithText(
                                  headingTxt: 'custom_field4'.tr + ':',
                                  bodyText: widget
                                          .productModelObjs
                                          .data?[widget.index]
                                          .productCustomField4 ??
                                      '- -'),
                          ],
                        ),
                        CheckboxListTile(
                            value: productRetailCtrlObj.disableWooCommerce,
                            onChanged: (bool? value) {
                              setState(() {
                                productRetailCtrlObj.disableWooCommerce =
                                    value!;
                                // if (value) {
                                //   productRetailCtrlObj.disableWooCommerceID =
                                //       '1';
                                // } else {
                                //   productRetailCtrlObj.disableWooCommerceID =
                                //       '0';
                                // }
                                productRetailCtrlObj.update();
                              });
                            },
                            controlAffinity: ListTileControlAffinity.leading,
                            title: Text(
                              'disable_wooCommerce'.tr,
                              style: TextStyle(color: blackColor),
                            )),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),

                ///3rd Container
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            titleWithText(
                                headingTxt: 'applicable_tax'.tr + ':',
                                bodyText: widget.productModelObjs
                                        .data?[widget.index].tax ??
                                    '- -'),
                            titleWithText(
                                headingTxt: 'selling_price_tax_type'.tr + ':',
                                bodyText:
                                    // widget.productModelObjs
                                    //         .data?[widget.index]. ??
                                    '- -'),
                          ],
                        ),
                        // SizedBox(
                        //   height: 15,
                        // ),
                        // GetBuilder<ProductsRetailController>(builder:
                        //     (ProductsRetailController productRetailCtrl) {
                        //   if (productRetailCtrl.showProductListModel == null)
                        //     return progressIndicator();
                        //   return Column(
                        //     crossAxisAlignment: CrossAxisAlignment.start,
                        //     children: [
                        //       headings(txt: 'product_type'.tr + ':*'),
                        //       DropdownButtonHideUnderline(
                        //         child: DropdownButton2(
                        //           isExpanded: true,
                        //           hint: Align(
                        //               alignment:
                        //                   AlignmentDirectional.centerStart,
                        //               child: Text(
                        //                 'please_select'.tr,
                        //                 style: TextStyle(
                        //                   fontSize: 13,
                        //                   fontWeight: FontWeight.w400,
                        //                   color: txtFieldHintColor,
                        //                 ),
                        //               )),
                        //           items: productRetailCtrlObj
                        //               .productTypeList()
                        //               .map((e) {
                        //             return DropdownMenuItem(
                        //                 value: e, child: Text(e));
                        //           }).toList(),
                        //           value: productRetailCtrlObj.productTypeStatus,
                        //           dropdownDirection:
                        //               DropdownDirection.textDirection,
                        //           dropdownPadding:
                        //               EdgeInsets.only(left: 5, right: 5),
                        //           buttonPadding:
                        //               EdgeInsets.only(left: 15, right: 15),
                        //           onChanged: (String? value) {
                        //             setState(() {
                        //               productRetailCtrlObj.productTypeStatus =
                        //                   value;
                        //             });
                        //           },
                        //           buttonHeight: height * 0.06,
                        //           buttonWidth: width * 0.42,
                        //           buttonDecoration: BoxDecoration(
                        //               border: Border.all(
                        //                   width: 1,
                        //                   color: Theme.of(context)
                        //                       .colorScheme
                        //                       .primary),
                        //               borderRadius: BorderRadius.circular(15),
                        //               color: kWhiteColor),
                        //           itemHeight: 40,
                        //           itemPadding: EdgeInsets.zero,
                        //           itemHighlightColor:
                        //               Theme.of(context).colorScheme.primary,
                        //         ),
                        //       ),
                        //     ],
                        //   );
                        // }),

                        SizedBox(
                          height: 15,
                        ),

                        // Container(
                        //   color: newOrderColor,
                        //   width: width,
                        //   padding: EdgeInsets.all(10),
                        //   child: Text(
                        //     'default_purchase_price'.tr,
                        //     style: TextStyle(
                        //       color: kWhiteColor,
                        //       fontSize: 14,
                        //       fontWeight: FontWeight.bold,
                        //     ),
                        //   ),
                        // ),
                        //
                        // Divider(
                        //   color: Theme.of(context).colorScheme.primary,
                        //   height: 0,
                        // ),
                        // SizedBox(
                        //   height: 5,
                        // ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     Column(
                        //       crossAxisAlignment: CrossAxisAlignment.start,
                        //       children: [
                        //         headings(txt: 'exc_tax'.tr + ':*'),
                        //         AppFormField(
                        //           validator: (String? v) {
                        //             if (v!.isEmpty) return 'exc_tax_req'.tr;
                        //             return null;
                        //           },
                        //           width: width * 0.42,
                        //           // onChanged: (value) {
                        //           //   productRetailCtrlObj.excTax(value: value);
                        //           //
                        //           // },
                        //           onChanged: (value) {
                        //             productRetailCtrlObj.defaultSellingPrice(
                        //                 taxCtrlObj: taxCtrlObj);
                        //             productRetailCtrlObj.update();
                        //           },
                        //           controller: productRetailCtrlObj.excTaxCtrl,
                        //         )
                        //       ],
                        //     ),
                        //     Column(
                        //       crossAxisAlignment: CrossAxisAlignment.start,
                        //       children: [
                        //         headings(txt: 'inc_tax' + ':*'),
                        //         AppFormField(
                        //           validator: (String? v) {
                        //             if (v!.isEmpty) return 'inc_tax_req'.tr;
                        //             return null;
                        //           },
                        //           onChanged: (value) {
                        //             productRetailCtrlObj.defaultSellingPrice(
                        //                 taxCtrlObj: taxCtrlObj);
                        //             productRetailCtrlObj.update();
                        //           },
                        //           width: width * 0.42,
                        //           controller: productRetailCtrlObj.incTaxCtrl,
                        //           keyboardType: TextInputType.number,
                        //         )
                        //       ],
                        //     ),
                        //   ],
                        // ),
                        // SizedBox(
                        //   height: 5,
                        // ),
                        // Container(
                        //   color: newOrderColor,
                        //   width: width,
                        //   padding: EdgeInsets.all(10),
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //     children: [
                        //       Text(
                        //         'x Margin(%):',
                        //         style: TextStyle(
                        //           color: kWhiteColor,
                        //           fontSize: 14,
                        //           fontWeight: FontWeight.bold,
                        //         ),
                        //       ),
                        //       Text(
                        //         'default_selling_price'.tr + ':',
                        //         style: TextStyle(
                        //           color: kWhiteColor,
                        //           fontSize: 14,
                        //           fontWeight: FontWeight.bold,
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        // Divider(
                        //   color: Theme.of(context).colorScheme.primary,
                        //   height: 0,
                        // ),
                        // SizedBox(
                        //   height: 5,
                        // ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   crossAxisAlignment: CrossAxisAlignment.end,
                        //   children: [
                        //     Column(
                        //       crossAxisAlignment: CrossAxisAlignment.start,
                        //       children: [
                        //         AppFormField(
                        //           width: width * 0.42,
                        //           controller: productRetailCtrlObj.marginCtrl,
                        //           onChanged: (value) {
                        //             productRetailCtrlObj.defaultSellingPrice(
                        //                 taxCtrlObj: taxCtrlObj);
                        //             productRetailCtrlObj.update();
                        //           },
                        //         )
                        //       ],
                        //     ),
                        //     Column(
                        //       crossAxisAlignment: CrossAxisAlignment.start,
                        //       children: [
                        //         headings(
                        //             txt: (productRetailCtrlObj.taxTypeStatus
                        //                         ?.toLowerCase() ==
                        //                     'exclusive')
                        //                 ? 'Exc. tax:*'
                        //                 : 'Inc. tax:*'),
                        //         AppFormField(
                        //           width: width * 0.42,
                        //           controller: productRetailCtrlObj
                        //               .defaultSellingPriceCtrl,
                        //           keyboardType: TextInputType.number,
                        //           onChanged: (value) {
                        //             productRetailCtrlObj.defaultSellingPrice(
                        //                 value: value, taxCtrlObj: taxCtrlObj);
                        //           },
                        //         )
                        //       ],
                        //     ),
                        //   ],
                        // ),
                        SizedBox(
                          height: 5,
                        ),
                        //TaxDataTable()
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),

                /// Save and Print button
                // IntrinsicHeight(
                //   child: Container(
                //     width: width,
                //     padding: EdgeInsets.all(10),
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(10),
                //       color: kWhiteColor,
                //     ),
                //     child: Column(
                //       crossAxisAlignment: CrossAxisAlignment.center,
                //       children: [
                //         Row(
                //           mainAxisAlignment: MainAxisAlignment.center,
                //           children: [
                //             CustomButton(
                //               title: Text(
                //                 'Save',
                //                 style: TextStyle(color: kWhiteColor),
                //               ),
                //               onTap: () {
                //                 if (!addProductFormKey.currentState!
                //                     .validate()) {
                //                   return;
                //                 } else if (productRetailCtrlObj
                //                     .productNameCtrl.text.isNotEmpty) {
                //                   showProgress();
                //                   productRetailCtrlObj.createNewProduct();
                //                 }
                //               },
                //               bgColor: Theme.of(context).colorScheme.primary,
                //             ),
                //             SizedBox(
                //               width: 5,
                //             ),
                //             CustomButton(
                //               title: Text(
                //                 'Save & Print',
                //                 style: TextStyle(color: kWhiteColor),
                //               ),
                //               onTap: () {
                //                 // Get.back();
                //               },
                //               bgColor: Theme.of(context).colorScheme.primary,
                //             )
                //           ],
                //         )
                //       ],
                //     ),
                //   ),
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column titleWithText({required String headingTxt, required String bodyText}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        headings(txt: headingTxt),
        Text(bodyText),
      ],
    );
  }

  Text headings({required String txt}) {
    return Text(
      txt,
      style: appBarHeaderStyle,
    );
  }
}
