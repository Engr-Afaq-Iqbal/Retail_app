import 'dart:io';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';

import '../../../Components/custom_circular_button.dart';
import '../../../Components/textfield.dart';
import '../../../Config/DateTimeFormat.dart';
import '../../../Theme/colors.dart';
import '../../../Theme/style.dart';
import '../../Config/utils.dart';
import '../../Controllers/ProductsRetailController/productsRetailsController.dart';
import 'RowRackPosition.dart';
import 'TaxDataTable.dart';

class AddProductsPage extends StatefulWidget {
  AddProductsPage({
    Key? key,
  }) : super(key: key);

  @override
  State<AddProductsPage> createState() => _AddProductsPageState();
}

class _AddProductsPageState extends State<AddProductsPage> {
  ProductsRetailController productRetailCtrlObj =
      Get.find<ProductsRetailController>();
  bool valuefirst = false;
  File? image;
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
          this.image = imageTemporary;
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

  File? broucher;
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
          this.broucher = imageTemporary;
        });
      } else {
        return showToast("No Image picked");
      }
    } on PlatformException catch (ex) {
      print('Failed to pick Image: $ex');
    }
  }

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

    productRetailCtrlObj.dateCtrl.text = '${AppFormat.dateDDMMYY(dateTime!)}';
    print(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Add new product'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 15, top: 15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///1st Container
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
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              headings(txt: 'Product Name:*'),
                              AppFormField(
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
                                        'Please Select',
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w400,
                                          color: txtFieldHintColor,
                                        ),
                                      )),
                                  items: productRetailCtrlObj
                                      .barCodeTypeList()
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
                                    });
                                  },
                                  buttonHeight: height * 0.06,
                                  buttonWidth: width * 0.42,
                                  buttonDecoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1, color: primaryColor),
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
                              headings(txt: 'Unit:*'),
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
                                  items:
                                      productRetailCtrlObj.unitList().map((e) {
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
                                      productRetailCtrlObj.unitStatus = value;
                                    });
                                  },
                                  buttonHeight: height * 0.06,
                                  buttonWidth: width * 0.42,
                                  buttonDecoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1, color: primaryColor),
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
                      headings(txt: 'Category:'),
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
                          items: productRetailCtrlObj.categoryList().map((e) {
                            return DropdownMenuItem(value: e, child: Text(e));
                          }).toList(),
                          value: productRetailCtrlObj.categoryStatus,
                          dropdownDirection: DropdownDirection.textDirection,
                          dropdownPadding: EdgeInsets.only(left: 5, right: 5),
                          buttonPadding: EdgeInsets.only(left: 15, right: 15),
                          onChanged: (String? value) {
                            setState(() {
                              productRetailCtrlObj.categoryStatus = value;
                            });
                          },
                          buttonHeight: height * 0.06,
                          buttonWidth: width * 0.42,
                          buttonDecoration: BoxDecoration(
                              border: Border.all(width: 1, color: primaryColor),
                              borderRadius: BorderRadius.circular(15),
                              color: kWhiteColor),
                          itemHeight: 40,
                          itemPadding: EdgeInsets.zero,
                          itemHighlightColor: primaryColor,
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
                                    productRetailCtrlObj.manageValue = value!;
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
                                        productRetailCtrlObj.productNameCtrl),
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
                                        'Please Select',
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w400,
                                          color: txtFieldHintColor,
                                        ),
                                      )),
                                  items: productRetailCtrlObj
                                      .warrantyList()
                                      .map((e) {
                                    return DropdownMenuItem(
                                        value: e, child: Text(e));
                                  }).toList(),
                                  value: productRetailCtrlObj.warrantyStatus,
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
                                    });
                                  },
                                  buttonHeight: height * 0.06,
                                  buttonWidth: width * 0.42,
                                  buttonDecoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1, color: primaryColor),
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
                              headings(txt: 'Printer:*'),
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
                                      .printersList()
                                      .map((e) {
                                    return DropdownMenuItem(
                                        value: e, child: Text(e));
                                  }).toList(),
                                  value: productRetailCtrlObj.printerStatus,
                                  dropdownDirection:
                                      DropdownDirection.textDirection,
                                  dropdownPadding:
                                      EdgeInsets.only(left: 5, right: 5),
                                  buttonPadding:
                                      EdgeInsets.only(left: 15, right: 15),
                                  onChanged: (String? value) {
                                    setState(() {
                                      productRetailCtrlObj.printerStatus =
                                          value;
                                    });
                                  },
                                  buttonHeight: height * 0.06,
                                  buttonWidth: width * 0.42,
                                  buttonDecoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1, color: primaryColor),
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
                                      .typeofProductList()
                                      .map((e) {
                                    return DropdownMenuItem(
                                        value: e, child: Text(e));
                                  }).toList(),
                                  value:
                                      productRetailCtrlObj.typeOfProductStatus,
                                  dropdownDirection:
                                      DropdownDirection.textDirection,
                                  dropdownPadding:
                                      EdgeInsets.only(left: 5, right: 5),
                                  buttonPadding:
                                      EdgeInsets.only(left: 15, right: 15),
                                  onChanged: (String? value) {
                                    setState(() {
                                      productRetailCtrlObj.typeOfProductStatus =
                                          value;
                                    });
                                  },
                                  buttonHeight: height * 0.06,
                                  buttonWidth: width * 0.42,
                                  buttonDecoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1, color: primaryColor),
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
                              headings(txt: 'Device Model:'),
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
                                      .deviceModelList()
                                      .map((e) {
                                    return DropdownMenuItem(
                                        value: e, child: Text(e));
                                  }).toList(),
                                  value: productRetailCtrlObj.deviceModelStatus,
                                  dropdownDirection:
                                      DropdownDirection.textDirection,
                                  dropdownPadding:
                                      EdgeInsets.only(left: 5, right: 5),
                                  buttonPadding:
                                      EdgeInsets.only(left: 15, right: 15),
                                  onChanged: (String? value) {
                                    setState(() {
                                      productRetailCtrlObj.deviceModelStatus =
                                          value;
                                    });
                                  },
                                  buttonHeight: height * 0.06,
                                  buttonWidth: width * 0.42,
                                  buttonDecoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1, color: primaryColor),
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
                      headings(txt: 'Product Description:'),
                      AppFormField(
                        width: width,
                        controller: productRetailCtrlObj.productDescCtrl,
                        maxLines: 3,
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
                          child: (image != null)
                              ? Center(
                                  child: Image.file(
                                    image!,
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
              ),
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
                              productRetailCtrlObj.update();
                            });
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                          dense: true,
                          title: Text(
                            'Not for selling',
                            style: TextStyle(color: blackColor),
                          )),
                      headings(txt: 'Rack/Row/Position Details:'),
                      RowRackPosition(),
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
                              productRetailCtrlObj.disableWooCommerce = value!;
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
                          Column(
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
                                      .applicableTaxList()
                                      .map((e) {
                                    return DropdownMenuItem(
                                        value: e, child: Text(e));
                                  }).toList(),
                                  value:
                                      productRetailCtrlObj.applicableTaxStatus,
                                  dropdownDirection:
                                      DropdownDirection.textDirection,
                                  dropdownPadding:
                                      EdgeInsets.only(left: 5, right: 5),
                                  buttonPadding:
                                      EdgeInsets.only(left: 15, right: 15),
                                  onChanged: (String? value) {
                                    setState(() {
                                      productRetailCtrlObj.applicableTaxStatus =
                                          value;
                                    });
                                  },
                                  buttonHeight: height * 0.06,
                                  buttonWidth: width * 0.42,
                                  buttonDecoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1, color: primaryColor),
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
                                    });
                                  },
                                  buttonHeight: height * 0.06,
                                  buttonWidth: width * 0.42,
                                  buttonDecoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1, color: primaryColor),
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
                      headings(txt: 'Product Type:*'),
                      AppFormField(
                          width: width,
                          controller: productRetailCtrlObj.productTypeCtrl),
                      TaxDataTable()
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
