import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Components/custom_circular_button.dart';
import '../../../Components/textfield.dart';
import '../../../Controllers/ProductController/product_cart_controller.dart';
import '../../../Theme/colors.dart';

class PackingCharges extends StatefulWidget {
  bool isDelivery;
  PackingCharges({Key? key, this.isDelivery = false}) : super(key: key);

  @override
  State<PackingCharges> createState() => _PackingChargesState();
}

class _PackingChargesState extends State<PackingCharges> {
  final ProductCartController productCtrlObj =
      Get.find<ProductCartController>();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.45,
      height: MediaQuery.of(context).size.height * 0.32,
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.isDelivery == true ? 'delivery'.tr : 'take-away'.tr,
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
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              )
            ],
          ),
          Divider(),
          Text(
            'packing_charge'.tr,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          AppFormField(
            isLabel: false,
            //isDense: false,
            labelText: 'packing_charge'.tr,
            controller: productCtrlObj.packingChargeCtrl,
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                padding: EdgeInsets.only(top: 20),
                width: MediaQuery.of(context).size.width * 0.25,
                child: CustomButton(
                    onTap: () {
                      Get.back();
                    },
                    btnTxt: 'close'.tr,
                    bgColor: Theme.of(context).colorScheme.primary,
                    borderRadius: 10),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
