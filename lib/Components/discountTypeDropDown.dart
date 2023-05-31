import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Controllers/ProductController/product_cart_controller.dart';
import '../Theme/colors.dart';

class DiscountTypeDropDown extends StatefulWidget {
  DiscountTypeDropDown({
    Key? key,
  }) : super(key: key);

  @override
  State<DiscountTypeDropDown> createState() => _DiscountTypeDropDownState();
}

class _DiscountTypeDropDownState extends State<DiscountTypeDropDown> {
  final ProductCartController productCtrlObj =
      Get.find<ProductCartController>();

  List<String> discountTypesList = [
    'none'.tr,
    'fixed'.tr,
    'percentage'.tr,
  ];
  String? disocuntType;

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Container(
      height: h * 0.06,
      width: w,
      child: DropdownButtonHideUnderline(
        child: DropdownButton2(
          isExpanded: true,
          hint: Align(
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                'none'.tr,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              )),
          items: discountTypesList.map((String items) {
            return DropdownMenuItem(
              value: items,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(items),
              ),
            );
          }).toList(),
          value: disocuntType,
          dropdownWidth: w * 0.5,
          dropdownDecoration:
              BoxDecoration(borderRadius: BorderRadius.circular(5)),
          dropdownMaxHeight: h * 0.7,
          dropdownPadding: EdgeInsets.only(left: 5),
          buttonPadding: EdgeInsets.only(left: 10, right: 10),
          onChanged: (String? value) {
            setState(() {
              disocuntType = value;
              productCtrlObj.discountType.text = value!;
            });
          },
          buttonHeight: 40,
          buttonWidth: w * 0.05,
          buttonDecoration: BoxDecoration(
              color: kWhiteColor,
              border: Border.all(
                  width: 1, color: Theme.of(context).colorScheme.primary),
              borderRadius: BorderRadius.circular(15)),
          itemHeight: 40,
          itemPadding: EdgeInsets.zero,
          itemHighlightColor: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}
