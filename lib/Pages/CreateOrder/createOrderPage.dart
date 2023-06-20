import 'package:bizmodo_emenu/Components/custom_circular_button.dart';
import 'package:bizmodo_emenu/Config/utils.dart';
import 'package:bizmodo_emenu/Pages/checkout/check_out.dart';
import 'package:bizmodo_emenu/Theme/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../Components/productHeadings.dart';
import '../../Components/textfield.dart';
import '../../Config/DateTimeFormat.dart';
import '../../Controllers/ContactController/ContactController.dart';
import '../../Controllers/ProductController/all_products_controller.dart';
import '../../Theme/colors.dart';

class CreateOrderPage extends StatefulWidget {
  const CreateOrderPage({Key? key}) : super(key: key);

  @override
  State<CreateOrderPage> createState() => _CreateOrderPageState();
}

class _CreateOrderPageState extends State<CreateOrderPage> {
  ContactController contactCtrlObjj = Get.find<ContactController>();
  bool cannotSupply = false;
  AllProductsController allProdCtrlObj = Get.find<AllProductsController>();

  @override
  void initState() {
    allProdCtrlObj.searchProductList(term: '');
    super.initState();
  }

  void dispose() {
    allProdCtrlObj.finalTotal = 0.00;
    allProdCtrlObj.totalAmount.clear();
    allProdCtrlObj.productQuantityCtrl.clear();
    allProdCtrlObj.searchProductModel = null;

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Order'),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text('Customer Name:'),
                    SizedBox(
                      width: 40,
                    ),
                    Text(
                      '${contactCtrlObjj.nameCtrl.text} (${contactCtrlObjj.contactId})',
                      style: appBarHeaderStyle,
                    ),
                    // Expanded(
                    //   child: CheckboxListTile(
                    //       value: cannotSupply,
                    //       onChanged: (bool? value) {
                    //         setState(() {
                    //           cannotSupply = value!;
                    //           //customerVisitsCtrlObj.update();
                    //         });
                    //       },
                    //       controlAffinity: ListTileControlAffinity.leading,
                    //       title: Text(
                    //         'Cannot Supply',
                    //         style: TextStyle(color: blackColor),
                    //       )),
                    // ),
                  ],
                ),
                // Center(
                //   child: Text(
                //     '${contactCtrlObjj.nameCtrl.text} (${contactCtrlObjj.contactId})',
                //     style: appBarHeaderStyle,
                //   ),
                // ),
                SizedBox(
                  height: 10,
                ),
                ProductHeadings(
                  txt1: 'Product Name',
                  txt2: 'Unit',
                  txt3: 'QTY',
                ),
                // SearchProducts(),
                Container(
                  height: MediaQuery.of(context).size.height * 0.67,
                  child: GetBuilder<AllProductsController>(
                      builder: (AllProductsController allProdCtrlObj) {
                    if (allProdCtrlObj.searchProductModel == null) {
                      return progressIndicator();
                    }
                    return ListView.builder(
                        padding: EdgeInsetsDirectional.only(
                            top: 5, bottom: 5, start: 10, end: 10),
                        physics: BouncingScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: allProdCtrlObj.searchProductModel?.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.only(
                              bottom: 5,
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            color: index.isEven
                                ? kWhiteColor
                                : Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withOpacity(0.1),
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
                                        '${allProdCtrlObj.searchProductModel?[index].name}',
                                        overflow: TextOverflow.ellipsis,
                                        softWrap: true,
                                      ),
                                    ),
                                    //unit
                                    Expanded(
                                      flex: 1,
                                      child: Center(
                                        child: Text(
                                          '${allProdCtrlObj.searchProductModel?[index].unit}',
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),

                                    //Quantity
                                    Expanded(
                                      flex: 1,
                                      child: AppFormField(
                                          controller: allProdCtrlObj
                                              .productQuantityCtrl[index],
                                          padding: EdgeInsets.only(right: 5),
                                          isOutlineBorder: false,
                                          isColor: index.isEven
                                              ? kWhiteColor
                                              : Colors.transparent,
                                          onChanged: (value) {
                                            if (allProdCtrlObj
                                                    .productQuantityCtrl[index]
                                                    .text
                                                    .isNotEmpty &&
                                                allProdCtrlObj
                                                        .productQuantityCtrl[
                                                            index]
                                                        .text !=
                                                    '0') {
                                              allProdCtrlObj
                                                      .totalAmount[index] =
                                                  '${double.parse('${allProdCtrlObj.productQuantityCtrl[index].text}') * double.parse('${allProdCtrlObj.searchProductModel?[index].sellingPrice.toString()}')}';
                                              allProdCtrlObj
                                                  .calculateFinalAmount();
                                              debugPrint('Product Amount');
                                              debugPrint(allProdCtrlObj
                                                  .totalAmount[index]);
                                              allProdCtrlObj.update();
                                            }
                                          }),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        });
                  }),
                ),

                Center(
                  child: Text(
                    'Total (AED) = ${AppFormat.doubleToStringUpTo2('${allProdCtrlObj.finalTotal}')}',
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                CustomButton(
                    onTap: () {
                      //showProgress();
                      Get.to(CheckOutPage());
                      // allProdCtrlObj.orderCreate();
                    },
                    title: Text(
                      'Finalize Order',
                      style: TextStyle(color: kWhiteColor),
                    ),
                    bgColor: Theme.of(context).colorScheme.primary)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
