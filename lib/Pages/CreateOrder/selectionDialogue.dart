import 'package:bizmodo_emenu/Theme/colors.dart';
import 'package:bizmodo_emenu/Theme/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Components/custom_circular_button.dart';
import '../../Config/utils.dart';
import '../../Controllers/ProductController/all_products_controller.dart';

class SelectionDialogue extends StatefulWidget {
  const SelectionDialogue({Key? key}) : super(key: key);

  @override
  State<SelectionDialogue> createState() => _SelectionDialogueState();
}

class _SelectionDialogueState extends State<SelectionDialogue> {
  final AllProductsController allProdCtrlObj =
      Get.find<AllProductsController>();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.3,
      height: MediaQuery.of(context).size.height * 0.17,
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'choose_options'.tr,
            style: appBarHeaderStyle,
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomButton(
                onTap: () {
                  showProgress();
                  allProdCtrlObj.update();
                  if (allProdCtrlObj.receiptPayment == true) {
                    print('inside add receipt method call');
                    allProdCtrlObj.isPDFView = true;
                    allProdCtrlObj.addReceipt();
                  } else if (allProdCtrlObj.isUpdate == true) {
                    print('->> for Update Order');
                    allProdCtrlObj.isPDFView = true;
                    allProdCtrlObj.addSelectedItemsInList();
                    allProdCtrlObj.updateOrder();
                  } else {
                    allProdCtrlObj.isPDFView = true;
                    allProdCtrlObj.addSelectedItemsInList();
                    print('->> for Create Order');
                    allProdCtrlObj.orderCreate();
                  }
                },
                title: Text(
                  'save'.tr,
                  style: TextStyle(color: kWhiteColor),
                ),
              ),
              CustomButton(
                onTap: () {
                  showProgress();
                  allProdCtrlObj.update();
                  if (allProdCtrlObj.receiptPayment == true) {
                    print('inside add receipt method call');
                    allProdCtrlObj.isPDFView = false;
                    allProdCtrlObj.receiptPayment == true;
                    allProdCtrlObj.addReceipt();
                  } else if (allProdCtrlObj.isUpdate == true) {
                    print('->> for Update Order');
                    allProdCtrlObj.isPDFView = false;
                    allProdCtrlObj.addSelectedItemsInList();
                    allProdCtrlObj.updateOrder();
                  } else {
                    allProdCtrlObj.isPDFView = false;
                    allProdCtrlObj.addSelectedItemsInList();
                    print('->> for Create Order');
                    allProdCtrlObj.orderCreate();
                  }
                },
                title: Text(
                  'saveAndPrint'.tr,
                  style: TextStyle(color: kWhiteColor),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
