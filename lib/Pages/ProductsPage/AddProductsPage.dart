import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '/Controllers/AllKitchenController/allKitchenController.dart';
import '../../../Components/custom_circular_button.dart';
import '../../../Components/textfield.dart';
import '../../../Theme/colors.dart';
import '../../../Theme/style.dart';
import '../../Config/utils.dart';
import '../../Controllers/ProductsRetailController/productsRetailsController.dart';
import '../../Controllers/Tax Controller/TaxController.dart';
import '../../Models/ProductsModel/ProductModel.dart';
import '../../Services/storage_services.dart';

class AddProductsPage extends StatefulWidget {
  bool isView;
  List<ProductModel>? productModelObjs;
  int? index;
  AddProductsPage({
    Key? key,
    this.isView = false,
    this.productModelObjs,
    this.index,
  }) : super(key: key);

  @override
  State<AddProductsPage> createState() => _AddProductsPageState();
}

class _AddProductsPageState extends State<AddProductsPage> {
  ProductsRetailController productRetailCtrlObj =
      Get.find<ProductsRetailController>();
  AllKitchenController allKitchenCtrlObj = Get.find<AllKitchenController>();
  TaxController taxCtrlObj = Get.find<TaxController>();
  final GlobalKey<FormState> addProductFormKey = GlobalKey<FormState>();

  bool valuefirst = false;
  bool isEdit = false;

  String frontPath = 'No file chosen';
  Future pickContactImage() async {
    try {
      //final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      final XFile? image =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      int? fileSizeInBytes = await image?.length();
      double fileSizeInKB = fileSizeInBytes! / 1024;
      double fileSizeInMB = fileSizeInKB / 1024;
      print('size ${fileSizeInMB}');
      print(fileSizeInMB);
      if (image != null && fileSizeInMB <= 1) {
        final imageTemporary = File(image.path);
        frontPath = image.path;
        setState(() {
          productRetailCtrlObj.image = imageTemporary;
        });
      } else if (fileSizeInMB > 1) {
        return showToast("File size is greater than 1MB");
      } else {
        return showToast("No Image picked");
      }
    } on PlatformException catch (ex) {
      print('Failed to pick Image: $ex');
    }
  }

  String imagePath = 'No file chosen';

  Future pickBroucherImage() async {
    try {
      //final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      final XFile? broucher =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (broucher != null) {
        final imageTemporary = File(broucher.path);
        imagePath = broucher.path;
        setState(() {
          productRetailCtrlObj.broucher = imageTemporary;
        });
      } else {
        return showToast("No Image picked");
      }
    } on PlatformException catch (ex) {
      print('Failed to pick Image: $ex');
    }
  }

  @override
  void initState() {
    ///Fetching the product list
    productRetailCtrlObj.fetchShowProductList();
    allKitchenCtrlObj.fetchShowProductList();
    taxCtrlObj.fetchListTax();
    productRetailCtrlObj.marginCtrl.text =
        '${AppStorage.getBusinessDetailsData()?.businessData?.defaultProfitPercent}';
    productRetailCtrlObj.taxTypeStatus = 'Exclusive';
    // TODO: implement initState
    if (widget.isView == true) {
      productRetailCtrlObj.productNameCtrl.text =
          widget.productModelObjs?[widget.index!].name ?? '';
      productRetailCtrlObj.productSKUCtrl.text =
          widget.productModelObjs?[widget.index!].sku ?? '';
      productRetailCtrlObj.barCodeHintStatus =
          widget.productModelObjs?[widget.index!].barcodeType ?? '';

      productRetailCtrlObj.alertQtyCtrl.text =
          widget.productModelObjs?[widget.index!].alertQuantity ?? '';
      productRetailCtrlObj.productDescCtrl.text =
          widget.productModelObjs?[widget.index!].productDescription ?? '';
      productRetailCtrlObj.weightCtrl.text =
          widget.productModelObjs?[widget.index!].weight ?? '';
      productRetailCtrlObj.customField1Ctrl.text =
          widget.productModelObjs?[widget.index!].productCustomField1 ?? '';
      productRetailCtrlObj.customField2Ctrl.text =
          widget.productModelObjs?[widget.index!].productCustomField2 ?? '';
      productRetailCtrlObj.customField3Ctrl.text =
          widget.productModelObjs?[widget.index!].productCustomField3 ?? '';
      productRetailCtrlObj.customField4Ctrl.text =
          widget.productModelObjs?[widget.index!].productCustomField4 ?? '';
      productRetailCtrlObj.productTypeCtrl.text =
          widget.productModelObjs?[widget.index!].type ?? '';
    }
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
        title: Text('Add new product'),
        actions: [
          if (widget.isView == true)
            CustomButton(
              title: Text(
                'Edit',
                style: TextStyle(color: kWhiteColor),
              ),
              onTap: () {
                setState(() {
                  isEdit = true;
                });
              },
            ),
          SizedBox(
            width: 15,
          ),
        ],
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
                GetBuilder<ProductsRetailController>(
                    builder: (ProductsRetailController prodRtailCtrlObj) {
                  if (prodRtailCtrlObj.showProductListModel == null)
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
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  headings(txt: 'Product Name:*'),
                                  AppFormField(
                                      validator: (String? v) {
                                        if (v!.isEmpty)
                                          return 'Product Name Required';
                                        return null;
                                      },
                                      readOnly:
                                          widget.isView == true ? true : false,
                                      width: width * 0.42,
                                      controller:
                                          productRetailCtrlObj.productNameCtrl)
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  headings(txt: 'SKU:'),
                                  AppFormField(
                                      width: width * 0.42,
                                      controller:
                                          productRetailCtrlObj.productSKUCtrl)
                                ],
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  headings(txt: 'Barcode Type:*'),
                                  DropdownButtonHideUnderline(
                                    child: DropdownButton2(
                                      isExpanded: true,
                                      hint: Align(
                                          alignment:
                                              AlignmentDirectional.centerStart,
                                          child: Text(
                                            prodRtailCtrlObj.barCodeHintStatus,
                                            style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w400,
                                              color: txtFieldHintColor,
                                            ),
                                          )),
                                      items: productRetailCtrlObj
                                          .barCodeTypeList(productRetailCtrlObj)
                                          .map((e) {
                                        return DropdownMenuItem(
                                            value: e, child: Text(e));
                                      }).toList(),
                                      value: productRetailCtrlObj.barCodeStatus,
                                      dropdownDirection:
                                          DropdownDirection.textDirection,
                                      dropdownPadding:
                                          EdgeInsets.only(left: 5, right: 5),
                                      buttonPadding:
                                          EdgeInsets.only(left: 15, right: 15),
                                      onChanged: (String? value) {
                                        setState(() {
                                          productRetailCtrlObj.barCodeStatus =
                                              value;
                                          productRetailCtrlObj.barCodeKey =
                                              productRetailCtrlObj
                                                  .showProductListModel
                                                  ?.barcodeTypes?[
                                                      productRetailCtrlObj
                                                          .barCodeTypeList(
                                                              productRetailCtrlObj)
                                                          .indexOf(value!)]
                                                  .key;
                                        });
                                      },
                                      buttonHeight: height * 0.06,
                                      buttonWidth: width * 0.42,
                                      buttonDecoration: BoxDecoration(
                                          border: Border.all(
                                              width: 1,
                                              color: Theme.of(context)
                                                  .primaryColor),
                                          borderRadius:
                                              BorderRadius.circular(15),
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
                                  headings(txt: 'Unit:*'),
                                  DropdownButtonHideUnderline(
                                    child: DropdownButton2(
                                      isExpanded: true,
                                      hint: Align(
                                          alignment:
                                              AlignmentDirectional.centerStart,
                                          child: Text(
                                            prodRtailCtrlObj.unitStatusHint,
                                            style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w400,
                                              color: txtFieldHintColor,
                                            ),
                                          )),
                                      items: productRetailCtrlObj
                                          .unitList(
                                              prodRtailCtrlObj,
                                              widget.index,
                                              widget.productModelObjs)
                                          .map((e) {
                                        return DropdownMenuItem(
                                            value: e, child: Text(e));
                                      }).toList(),
                                      value: productRetailCtrlObj.unitStatus,
                                      dropdownDirection:
                                          DropdownDirection.textDirection,
                                      dropdownPadding:
                                          EdgeInsets.only(left: 5, right: 5),
                                      buttonPadding:
                                          EdgeInsets.only(left: 15, right: 15),
                                      onChanged: (String? value) {
                                        setState(() {
                                          productRetailCtrlObj.unitStatus =
                                              value;
                                          productRetailCtrlObj.unitID =
                                              productRetailCtrlObj
                                                  .showProductListModel
                                                  ?.units?[productRetailCtrlObj
                                                      .unitList(
                                                          productRetailCtrlObj,
                                                          widget.index,
                                                          widget
                                                              .productModelObjs)
                                                      .indexOf(value!)]
                                                  .id
                                                  .toString();
                                        });
                                      },
                                      buttonHeight: height * 0.06,
                                      buttonWidth: width * 0.42,
                                      buttonDecoration: BoxDecoration(
                                          border: Border.all(
                                              width: 1,
                                              color: Theme.of(context)
                                                  .primaryColor),
                                          borderRadius:
                                              BorderRadius.circular(15),
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
                            height: 15,
                          ),
                          headings(txt: 'Category:'),
                          DropdownButtonHideUnderline(
                            child: DropdownButton2(
                              isExpanded: true,
                              hint: Align(
                                  alignment: AlignmentDirectional.centerStart,
                                  child: Text(
                                    prodRtailCtrlObj.categoriesHintStatus,
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                      color: txtFieldHintColor,
                                    ),
                                  )),
                              items: productRetailCtrlObj
                                  .categoryList(prodRtailCtrlObj, widget.index,
                                      widget.productModelObjs)
                                  .map((e) {
                                return DropdownMenuItem(
                                    value: e, child: Text(e));
                              }).toList(),
                              value: productRetailCtrlObj.categoryStatus,
                              dropdownDirection:
                                  DropdownDirection.textDirection,
                              dropdownPadding:
                                  EdgeInsets.only(left: 5, right: 5),
                              buttonPadding:
                                  EdgeInsets.only(left: 15, right: 15),
                              dropdownMaxHeight: height * 0.4,
                              onChanged: (String? value) {
                                setState(() {
                                  productRetailCtrlObj.categoryStatus = value;
                                  productRetailCtrlObj.categoryID =
                                      productRetailCtrlObj
                                          .showProductListModel
                                          ?.categories?[productRetailCtrlObj
                                              .categoryList(
                                                  productRetailCtrlObj,
                                                  widget.index,
                                                  widget.productModelObjs)
                                              .indexOf(value!)]
                                          .id
                                          .toString();
                                });
                              },
                              buttonHeight: height * 0.06,
                              //  buttonWidth: width * 0.42,
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
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: CheckboxListTile(
                                    value: productRetailCtrlObj.manageValue,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        productRetailCtrlObj.manageValue =
                                            value!;
                                        productRetailCtrlObj.update();
                                      });
                                    },
                                    controlAffinity:
                                        ListTileControlAffinity.leading,
                                    title: Text(
                                      'Manage Stock?',
                                      style: TextStyle(color: blackColor),
                                    )),
                              ),
                              if (productRetailCtrlObj.manageValue == true)
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    headings(txt: 'Alert quantity:'),
                                    AppFormField(
                                        width: width * 0.42,
                                        controller:
                                            productRetailCtrlObj.alertQtyCtrl),
                                  ],
                                )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  headings(txt: 'Warranty:*'),
                                  DropdownButtonHideUnderline(
                                    child: DropdownButton2(
                                      isExpanded: true,
                                      hint: Align(
                                          alignment:
                                              AlignmentDirectional.centerStart,
                                          child: Text(
                                            prodRtailCtrlObj.warrantyHintStatus,
                                            style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w400,
                                              color: txtFieldHintColor,
                                            ),
                                          )),
                                      items: productRetailCtrlObj
                                          .warrantyList(
                                              prodRtailCtrlObj,
                                              widget.index,
                                              widget.productModelObjs)
                                          .map((e) {
                                        return DropdownMenuItem(
                                            value: e, child: Text(e));
                                      }).toList(),
                                      value:
                                          productRetailCtrlObj.warrantyStatus,
                                      dropdownDirection:
                                          DropdownDirection.textDirection,
                                      dropdownPadding:
                                          EdgeInsets.only(left: 5, right: 5),
                                      buttonPadding:
                                          EdgeInsets.only(left: 15, right: 15),
                                      onChanged: (String? value) {
                                        setState(() {
                                          productRetailCtrlObj.warrantyStatus =
                                              value;

                                          productRetailCtrlObj.warrantyID =
                                              productRetailCtrlObj
                                                  .showProductListModel
                                                  ?.warranties?[productRetailCtrlObj
                                                      .warrantyList(
                                                          productRetailCtrlObj,
                                                          widget.index,
                                                          widget
                                                              .productModelObjs)
                                                      .indexOf(value!)]
                                                  .id
                                                  .toString();
                                        });
                                      },
                                      buttonHeight: height * 0.06,
                                      buttonWidth: width * 0.42,
                                      buttonDecoration: BoxDecoration(
                                          border: Border.all(
                                              width: 1,
                                              color: Theme.of(context)
                                                  .primaryColor),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          color: kWhiteColor),
                                      itemHeight: 40,
                                      itemPadding: EdgeInsets.zero,
                                      itemHighlightColor:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                  ),
                                ],
                              ),
                              GetBuilder<AllKitchenController>(builder:
                                  (AllKitchenController allKitchenCtrl) {
                                if (allKitchenCtrl.allKitchenModel == null)
                                  return progressIndicator();
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    headings(txt: 'Printer:*'),
                                    DropdownButtonHideUnderline(
                                      child: DropdownButton2(
                                        isExpanded: true,
                                        hint: Align(
                                            alignment: AlignmentDirectional
                                                .centerStart,
                                            child: Text(
                                              'Please Select',
                                              style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w400,
                                                color: txtFieldHintColor,
                                              ),
                                            )),
                                        items: allKitchenCtrl
                                            .printersList(allKitchenCtrl)
                                            .map((e) {
                                          return DropdownMenuItem(
                                              value: e, child: Text(e));
                                        }).toList(),
                                        value:
                                            productRetailCtrlObj.printerStatus,
                                        dropdownDirection:
                                            DropdownDirection.textDirection,
                                        dropdownPadding:
                                            EdgeInsets.only(left: 5, right: 5),
                                        buttonPadding: EdgeInsets.only(
                                            left: 15, right: 15),
                                        onChanged: (String? value) {
                                          setState(() {
                                            productRetailCtrlObj.printerStatus =
                                                value;
                                            productRetailCtrlObj.printerID =
                                                allKitchenCtrl
                                                    .allKitchenModel
                                                    ?.kitchens?[allKitchenCtrl
                                                        .printersList(
                                                            allKitchenCtrl)
                                                        .indexOf(value!)]
                                                    .id
                                                    .toString();
                                          });
                                        },
                                        buttonHeight: height * 0.06,
                                        buttonWidth: width * 0.42,
                                        buttonDecoration: BoxDecoration(
                                            border: Border.all(
                                                width: 1,
                                                color: Theme.of(context)
                                                    .primaryColor),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            color: kWhiteColor),
                                        itemHeight: 40,
                                        itemPadding: EdgeInsets.zero,
                                        itemHighlightColor: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                    ),
                                  ],
                                );
                              }),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  headings(txt: 'Type of product:'),
                                  DropdownButtonHideUnderline(
                                    child: DropdownButton2(
                                      isExpanded: true,
                                      hint: Align(
                                          alignment:
                                              AlignmentDirectional.centerStart,
                                          child: Text(
                                            'Please Select',
                                            style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w400,
                                              color: txtFieldHintColor,
                                            ),
                                          )),
                                      items: productRetailCtrlObj
                                          .typeofProductList(
                                              prodRtailCtrlObj,
                                              widget.index,
                                              widget.productModelObjs)
                                          .map((e) {
                                        return DropdownMenuItem(
                                            value: e, child: Text(e));
                                      }).toList(),
                                      value: productRetailCtrlObj
                                          .typeOfProductStatus,
                                      dropdownDirection:
                                          DropdownDirection.textDirection,
                                      dropdownPadding:
                                          EdgeInsets.only(left: 5, right: 5),
                                      buttonPadding:
                                          EdgeInsets.only(left: 15, right: 15),
                                      onChanged: (String? value) {
                                        setState(() {
                                          productRetailCtrlObj
                                              .typeOfProductStatus = value;
                                          productRetailCtrlObj.typeOfProductID =
                                              productRetailCtrlObj
                                                  .showProductListModel
                                                  ?.typeOfProducts?[
                                                      productRetailCtrlObj
                                                          .typeofProductList(
                                                              productRetailCtrlObj,
                                                              widget.index,
                                                              widget
                                                                  .productModelObjs)
                                                          .indexOf(value!)]
                                                  .id
                                                  .toString();
                                        });
                                      },
                                      buttonHeight: height * 0.06,
                                      buttonWidth: width * 0.42,
                                      buttonDecoration: BoxDecoration(
                                          border: Border.all(
                                              width: 1,
                                              color: Theme.of(context)
                                                  .primaryColor),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          color: kWhiteColor),
                                      itemHeight: 40,
                                      itemPadding: EdgeInsets.zero,
                                      itemHighlightColor:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                  ),
                                ],
                              ),
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
                            height: 15,
                          ),
                          headings(txt: 'Product Description:'),
                          AppFormField(
                            width: width,
                            controller: productRetailCtrlObj.productDescCtrl,
                            maxLines: 2,
                          ),
                          headings(txt: 'Product Image:'),
                          GestureDetector(
                            onTap: () {
                              pickContactImage();
                            },
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.2,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: kHintColor.withOpacity(0.3)),
                              child: (productRetailCtrlObj.image != null)
                                  ? Center(
                                      child: Image.file(
                                        productRetailCtrlObj.image!,
                                        fit: BoxFit.contain,
                                      ),
                                    )
                                  : Center(
                                      child: Icon(
                                        Icons.add,
                                        size: 30,
                                      ),
                                    ),
                            ),
                          ),
                          headings(txt: 'Product brochure:'),
                          Row(
                            children: [
                              CustomButton(
                                title: Text(
                                  'Choose File',
                                  style: TextStyle(color: kWhiteColor),
                                ),
                                height: 20,
                                borderRadius: 5,
                                onTap: () {
                                  pickBroucherImage();
                                },
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                frontPath,
                                softWrap: true,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
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
                                if (value) {
                                  productRetailCtrlObj.enableProductID = '1';
                                } else {
                                  productRetailCtrlObj.enableProductID = '0';
                                }

                                productRetailCtrlObj.update();
                              });
                            },
                            controlAffinity: ListTileControlAffinity.leading,
                            dense: true,
                            title: Text(
                              'Enable Product description, IMEI or Serial Number',
                              style: TextStyle(color: blackColor),
                            )),
                        CheckboxListTile(
                            value: productRetailCtrlObj.notForSelling,
                            onChanged: (bool? value) {
                              setState(() {
                                productRetailCtrlObj.notForSelling = value!;
                                if (value) {
                                  productRetailCtrlObj.notForSellingID = '1';
                                } else {
                                  productRetailCtrlObj.notForSellingID = '0';
                                }
                                productRetailCtrlObj.update();
                              });
                            },
                            controlAffinity: ListTileControlAffinity.leading,
                            dense: true,
                            title: Text(
                              'Not for selling',
                              style: TextStyle(color: blackColor),
                            )),
                        // headings(txt: 'Rack/Row/Position Details:'),
                        // RowRackPosition(),
                        headings(txt: 'Weight:'),
                        AppFormField(
                            width: width,
                            controller: productRetailCtrlObj.weightCtrl),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                headings(txt: 'Custom Field 1:'),
                                AppFormField(
                                    width: width * 0.42,
                                    controller:
                                        productRetailCtrlObj.customField1Ctrl)
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                headings(txt: 'Custom Field 2:'),
                                AppFormField(
                                    width: width * 0.42,
                                    controller:
                                        productRetailCtrlObj.customField2Ctrl)
                              ],
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                headings(txt: 'Custom Field 3:'),
                                AppFormField(
                                    width: width * 0.42,
                                    controller:
                                        productRetailCtrlObj.customField3Ctrl)
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                headings(txt: 'Custom Field 4:'),
                                AppFormField(
                                    width: width * 0.42,
                                    controller:
                                        productRetailCtrlObj.customField4Ctrl)
                              ],
                            ),
                          ],
                        ),
                        CheckboxListTile(
                            value: productRetailCtrlObj.disableWooCommerce,
                            onChanged: (bool? value) {
                              setState(() {
                                productRetailCtrlObj.disableWooCommerce =
                                    value!;
                                if (value) {
                                  productRetailCtrlObj.disableWooCommerceID =
                                      '1';
                                } else {
                                  productRetailCtrlObj.disableWooCommerceID =
                                      '0';
                                }
                                productRetailCtrlObj.update();
                              });
                            },
                            controlAffinity: ListTileControlAffinity.leading,
                            title: Text(
                              'Disable Woocommerce Sync',
                              style: TextStyle(color: blackColor),
                            )),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
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
                            GetBuilder<TaxController>(
                                builder: (TaxController taxCtrl) {
                              if (taxCtrl.listTaxModel == null)
                                return progressIndicator();
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  headings(txt: 'Applicable Tax:'),
                                  DropdownButtonHideUnderline(
                                    child: DropdownButton2(
                                      isExpanded: true,
                                      hint: Align(
                                          alignment:
                                              AlignmentDirectional.centerStart,
                                          child: Text(
                                            'Please Select',
                                            style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w400,
                                              color: txtFieldHintColor,
                                            ),
                                          )),
                                      items: productRetailCtrlObj
                                          .applicableTaxList(taxCtrl)
                                          .map((e) {
                                        return DropdownMenuItem(
                                            value: e, child: Text(e));
                                      }).toList(),
                                      value: productRetailCtrlObj
                                          .applicableTaxStatus,
                                      dropdownDirection:
                                          DropdownDirection.textDirection,
                                      dropdownPadding:
                                          EdgeInsets.only(left: 5, right: 5),
                                      buttonPadding:
                                          EdgeInsets.only(left: 15, right: 15),
                                      onChanged: (String? value) {
                                        setState(() {
                                          productRetailCtrlObj
                                              .applicableTaxStatus = value;
                                          productRetailCtrlObj.applicableTaxId =
                                              taxCtrl
                                                  .listTaxModel
                                                  ?.data?[productRetailCtrlObj
                                                      .applicableTaxList(
                                                          taxCtrl)
                                                      .indexOf(value!)]
                                                  .id
                                                  .toString();
                                          productRetailCtrlObj.addVatInInctax(
                                              taxCtrlObj: taxCtrl);
                                          productRetailCtrlObj
                                              .defaultSellingPrice(
                                                  taxCtrlObj: taxCtrlObj);
                                          productRetailCtrlObj.update();
                                        });
                                      },
                                      buttonHeight: height * 0.06,
                                      buttonWidth: width * 0.42,
                                      buttonDecoration: BoxDecoration(
                                          border: Border.all(
                                              width: 1,
                                              color: Theme.of(context)
                                                  .primaryColor),
                                          borderRadius:
                                              BorderRadius.circular(15),
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
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                headings(txt: 'Selling Price Tax Type:'),
                                DropdownButtonHideUnderline(
                                  child: DropdownButton2(
                                    isExpanded: true,
                                    hint: Align(
                                        alignment:
                                            AlignmentDirectional.centerStart,
                                        child: Text(
                                          'Please Select',
                                          style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w400,
                                            color: txtFieldHintColor,
                                          ),
                                        )),
                                    items: productRetailCtrlObj
                                        .taxTypeList()
                                        .map((e) {
                                      return DropdownMenuItem(
                                          value: e, child: Text(e));
                                    }).toList(),
                                    value: productRetailCtrlObj.taxTypeStatus,
                                    dropdownDirection:
                                        DropdownDirection.textDirection,
                                    dropdownPadding:
                                        EdgeInsets.only(left: 5, right: 5),
                                    buttonPadding:
                                        EdgeInsets.only(left: 15, right: 15),
                                    onChanged: (String? value) {
                                      setState(() {
                                        productRetailCtrlObj.taxTypeStatus =
                                            value;
                                        productRetailCtrlObj
                                            .defaultSellingPrice(
                                                taxCtrlObj: taxCtrlObj);
                                        productRetailCtrlObj.update();
                                      });
                                    },
                                    buttonHeight: height * 0.06,
                                    buttonWidth: width * 0.42,
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
                          height: 15,
                        ),
                        GetBuilder<ProductsRetailController>(builder:
                            (ProductsRetailController productRetailCtrl) {
                          if (productRetailCtrl.showProductListModel == null)
                            return progressIndicator();
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              headings(txt: 'Product Type:*'),
                              DropdownButtonHideUnderline(
                                child: DropdownButton2(
                                  isExpanded: true,
                                  hint: Align(
                                      alignment:
                                          AlignmentDirectional.centerStart,
                                      child: Text(
                                        'Please Select',
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w400,
                                          color: txtFieldHintColor,
                                        ),
                                      )),
                                  items: productRetailCtrlObj
                                      .productTypeList()
                                      .map((e) {
                                    return DropdownMenuItem(
                                        value: e, child: Text(e));
                                  }).toList(),
                                  value: productRetailCtrlObj.productTypeStatus,
                                  dropdownDirection:
                                      DropdownDirection.textDirection,
                                  dropdownPadding:
                                      EdgeInsets.only(left: 5, right: 5),
                                  buttonPadding:
                                      EdgeInsets.only(left: 15, right: 15),
                                  onChanged: (String? value) {
                                    setState(() {
                                      productRetailCtrlObj.productTypeStatus =
                                          value;
                                    });
                                  },
                                  buttonHeight: height * 0.06,
                                  buttonWidth: width * 0.42,
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

                        SizedBox(
                          height: 15,
                        ),

                        Container(
                          color: newOrderColor,
                          width: width,
                          padding: EdgeInsets.all(10),
                          child: Text(
                            'Default Purchase Price',
                            style: TextStyle(
                              color: kWhiteColor,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        Divider(
                          color: Theme.of(context).colorScheme.primary,
                          height: 0,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                headings(txt: 'Exc. tax:*'),
                                AppFormField(
                                  validator: (String? v) {
                                    if (v!.isEmpty) return 'Exc. tax required';
                                    return null;
                                  },
                                  width: width * 0.42,
                                  // onChanged: (value) {
                                  //   productRetailCtrlObj.excTax(value: value);
                                  //
                                  // },
                                  onChanged: (value) {
                                    productRetailCtrlObj.defaultSellingPrice(
                                        taxCtrlObj: taxCtrlObj);
                                    productRetailCtrlObj.update();
                                  },
                                  controller: productRetailCtrlObj.excTaxCtrl,
                                )
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                headings(txt: 'Inc. tax:*'),
                                AppFormField(
                                  validator: (String? v) {
                                    if (v!.isEmpty) return 'Inc. tax required';
                                    return null;
                                  },
                                  onChanged: (value) {
                                    productRetailCtrlObj.defaultSellingPrice(
                                        taxCtrlObj: taxCtrlObj);
                                    productRetailCtrlObj.update();
                                  },
                                  width: width * 0.42,
                                  controller: productRetailCtrlObj.incTaxCtrl,
                                  keyboardType: TextInputType.number,
                                )
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          color: newOrderColor,
                          width: width,
                          padding: EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'x Margin(%):',
                                style: TextStyle(
                                  color: kWhiteColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Default Selling Price:',
                                style: TextStyle(
                                  color: kWhiteColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          color: Theme.of(context).colorScheme.primary,
                          height: 0,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppFormField(
                                  validator: (String? v) {
                                    if (v!.isEmpty) return 'Exc. tax required';
                                    return null;
                                  },
                                  width: width * 0.42,
                                  controller: productRetailCtrlObj.marginCtrl,
                                  onChanged: (value) {
                                    productRetailCtrlObj.defaultSellingPrice(
                                        taxCtrlObj: taxCtrlObj);
                                    productRetailCtrlObj.update();
                                  },
                                )
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                headings(
                                    txt: (productRetailCtrlObj.taxTypeStatus
                                                ?.toLowerCase() ==
                                            'exclusive')
                                        ? 'Exc. tax:*'
                                        : 'Inc. tax:*'),
                                AppFormField(
                                  width: width * 0.42,
                                  controller: productRetailCtrlObj
                                      .defaultSellingPriceCtrl,
                                  keyboardType: TextInputType.number,
                                  onChanged: (value) {
                                    productRetailCtrlObj.defaultSellingPrice(
                                        value: value, taxCtrlObj: taxCtrlObj);
                                  },
                                )
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          color: newOrderColor,
                          width: width,
                          padding: EdgeInsets.all(10),
                          child: Text(
                            'Product image',
                            style: TextStyle(
                              color: kWhiteColor,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        Divider(
                          color: Theme.of(context).colorScheme.primary,
                          height: 0,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        headings(txt: 'Product image:'),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            CustomButton(
                              title: Text(
                                'Choose File',
                                style: TextStyle(color: kWhiteColor),
                              ),
                              height: 20,
                              borderRadius: 5,
                              onTap: () {
                                pickContactImage();
                              },
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              'No file choosen',
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        //TaxDataTable()
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
                                'Save',
                                style: TextStyle(color: kWhiteColor),
                              ),
                              onTap: () {
                                if (!addProductFormKey.currentState!
                                    .validate()) {
                                  return;
                                } else if (productRetailCtrlObj
                                    .productNameCtrl.text.isNotEmpty) {
                                  showProgress();
                                  productRetailCtrlObj.addProduct();
                                }
                              },
                              bgColor: Theme.of(context).colorScheme.primary,
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
                                // Get.back();
                              },
                              bgColor: Theme.of(context).colorScheme.primary,
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
