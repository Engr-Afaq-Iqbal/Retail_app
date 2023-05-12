import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Components/custom_circular_button.dart';
import '../../Components/discountTypeDropDown.dart';
import '../../Components/textfield.dart';
import '../../Controllers/ProductController/product_cart_controller.dart';
import '../../Theme/colors.dart';

class Discount extends StatefulWidget {
  const Discount({Key? key}) : super(key: key);

  @override
  State<Discount> createState() => _DiscountState();
}

class _DiscountState extends State<Discount> {
  final ProductCartController productCtrlCtrlObj =
      Get.find<ProductCartController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: MediaQuery.of(context).size.width * 0.45,
      // height: MediaQuery.of(context).size.height * 0.4,
      padding: EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'discount'.tr,
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
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Text(
              'edit_discount'.tr,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Text(
              '${'discount_type'.tr}:* ',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(),
            ),
            DiscountTypeDropDown(),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Text(
              '${'discount_amount'.tr}:* ',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(),
            ),
            Container(
              // width: MediaQuery.of(context).size.width * 0.2,
              child: AppFormField(
                isLabel: false,
                labelText: 'discount_amount'.tr,
                controller: productCtrlCtrlObj.discoutCtrl,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: EdgeInsets.only(top: 20),
                  child: CustomButton(
                      onTap: () {
                        if ('Percentage' ==
                            productCtrlCtrlObj.discountType.text) {
                          productCtrlCtrlObj.totalDiscountPercentage();
                          print('percentage');
                          productCtrlCtrlObj.update();
                        } else if (productCtrlCtrlObj.discountType.text ==
                            'Fixed') {
                          print('Fixed');
                          productCtrlCtrlObj.update();
                        }

                        Get.back();
                      },
                      btnTxt: 'update'.tr,
                      bgColor: primaryColor,
                      borderRadius: 10),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  padding: EdgeInsets.only(top: 20),
                  child: CustomButton(
                      onTap: () {
                        setState(() {
                          productCtrlCtrlObj.clearController();
                        });

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
    );
  }
}
