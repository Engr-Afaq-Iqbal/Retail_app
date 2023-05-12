import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Components/custom_circular_button.dart';
import '../../Components/textfield.dart';
import '../../Controllers/ContactController/ContactController.dart';
import '../../Controllers/ProductController/product_cart_controller.dart';
import '../../Theme/colors.dart';

class ShippingCharge extends StatefulWidget {
  const ShippingCharge({Key? key}) : super(key: key);

  @override
  State<ShippingCharge> createState() => _ShippingChargeState();
}

class _ShippingChargeState extends State<ShippingCharge> {
  final ProductCartController productCtrlObj =
      Get.find<ProductCartController>();
  final ContactController contactCtrlObj = Get.find<ContactController>();

  List<String> shippingStatusList = [
    'ordered'.tr,
    'packed'.tr,
    'shipped'.tr,
    'delivered'.tr,
    'cancelled'.tr
  ];
  String? shippingStatus;

  @override
  void initState() {
    // TODO: implement initState

    productCtrlObj.shippingDetailsCtrl.text =
        '${contactCtrlObj.cityCtrl.text} ${contactCtrlObj.streetCtrl.text} ${contactCtrlObj.villaBuildingApartmentCtrl.text}';
    productCtrlObj.shippingAddressCtrl.text = contactCtrlObj.addressCtrl.text;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.45,
        // height: double.infinity,
        // constraints: BoxConstraints(
        //   maxHeight: ,
        // ),
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'shipping'.tr,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(),
                  ),
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Icon(
                        Icons.cancel_outlined,
                        color: primaryColor,
                      ),
                    ),
                  )
                ],
              ),
              Divider(),
              Text(
                'shipping_details'.tr,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              AppFormField(
                //width: MediaQuery.of(context).size.width * 0.21,
                isLabel: false,
                // isDense: false,
                labelText: 'shipping_details'.tr,
                controller: productCtrlObj.shippingDetailsCtrl,
              ),
              Text(
                'shipping_address'.tr,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              AppFormField(
                //width: MediaQuery.of(context).size.width * 0.21,
                isLabel: false,
                // isDense: false,
                labelText: 'shipping_address'.tr,
                controller: productCtrlObj.shippingAddressCtrl,
              ),
              Text(
                'shipping_charge'.tr,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              AppFormField(
                // width: MediaQuery.of(context).size.width * 0.21,
                isLabel: false,
                // isDense: false,
                labelText: 'shipping_charge'.tr,
                controller: productCtrlObj.shippingChargeCtrl,
              ),
              Text(
                'shipping_status'.tr,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.06,
                width: MediaQuery.of(context).size.width,
                child: DropdownButtonHideUnderline(
                  child: DropdownButton2(
                    isExpanded: true,
                    hint: Align(
                        alignment: AlignmentDirectional.centerStart,
                        child: Text(
                          'please_select'.tr,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.w500),
                        )),
                    items: shippingStatusList.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(items),
                        ),
                      );
                    }).toList(),
                    value: shippingStatus,
                    dropdownWidth: MediaQuery.of(context).size.width * 0.5,
                    dropdownDecoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(5)),
                    dropdownMaxHeight: MediaQuery.of(context).size.height * 0.7,
                    dropdownPadding: EdgeInsets.only(left: 5),
                    buttonPadding: EdgeInsets.only(left: 10, right: 10),
                    onChanged: (String? value) {
                      setState(() {
                        shippingStatus = value;
                        productCtrlObj.discountType.text = value!;
                      });
                    },
                    buttonHeight: 40,
                    buttonWidth: MediaQuery.of(context).size.width * 0.05,
                    buttonDecoration: BoxDecoration(
                        color: kWhiteColor,
                        border: Border.all(width: 1, color: primaryColor),
                        borderRadius: BorderRadius.circular(15)),
                    itemHeight: 40,
                    itemPadding: EdgeInsets.zero,
                    itemHighlightColor: primaryColor,
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Text(
                'delivered_to'.tr,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              AppFormField(
                //width: MediaQuery.of(context).size.width * 0.2,
                isLabel: false,
                //isDense: false,
                labelText: 'delivered_to'.tr,
                controller: productCtrlObj.deliveredTo,
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    // padding: EdgeInsets.only(
                    //     top: MediaQuery.of(context).size.height * 0.02),
                    //width: MediaQuery.of(context).size.width * 0.05,
                    child: CustomButton(
                        onTap: () {
                          setState(() {});
                          Get.back();
                        },
                        btnTxt: 'close'.tr,
                        bgColor: primaryColor,
                        borderRadius: 10),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
