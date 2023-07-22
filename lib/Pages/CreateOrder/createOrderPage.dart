import 'package:bizmodo_emenu/Components/custom_circular_button.dart';
import 'package:bizmodo_emenu/Config/utils.dart';
import 'package:bizmodo_emenu/Controllers/ProductController/PaymentController.dart';
import 'package:bizmodo_emenu/Pages/CreateOrder/selectionDialogue.dart';
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
import '../../const/dimensions.dart';
import '../SalesView/discount.dart';
import '../Tabs/View/TabsPage.dart';

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
    // allProdCtrlObj.searchProductList(term: '');
    // allProdCtrlObj.fetchAllProducts();
    // allProdCtrlObj.fetchSpecificUnit();
    // allProductsCtrl.showingallItems(allProductsCtrl);
    allProdCtrlObj.productQuantityCtrl.clear();
    allProdCtrlObj.selectedProducts.clear();
    allProdCtrlObj.fetchAllProducts();
    allProdCtrlObj.finalTotal = 0.00;

    super.initState();
  }

  void dispose() {
    allProdCtrlObj.finalTotal = 0.00;
    allProdCtrlObj.totalAmount.clear();
    allProdCtrlObj.selectedQuantityList.clear();
    allProdCtrlObj.selectedProducts.clear();
    allProdCtrlObj.productQuantityCtrl.clear();
    allProdCtrlObj.listProductsModel = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Order'),
        leading: AppStyles.backButton(onTap: () {
          Get.offAll(TabsPage());
        }),
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
                      overflow: TextOverflow.ellipsis,
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
                    if (allProdCtrlObj.listProductsModel == null) {
                      return progressIndicator();
                    }
                    return ListView.builder(
                        padding: EdgeInsetsDirectional.only(
                            top: 5, bottom: 5, start: 10, end: 10),
                        physics: BouncingScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: allProdCtrlObj.productModelObjs.length,
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
                                        '${allProdCtrlObj.productModelObjs[index].name}',
                                        overflow: TextOverflow.ellipsis,
                                        softWrap: true,
                                      ),
                                    ),
                                    //unit
                                    Expanded(
                                      flex: 1,
                                      child: Center(
                                        child: Text(
                                          '${allProdCtrlObj.productModelObjs[index].sku}',
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),

                                    // Quantity
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
                                          // onEditingComp: (){
                                          //
                                          // },
                                          onChanged: (value) {
                                            // if (allProdCtrlObj
                                            //         .productQuantityCtrl[index]
                                            //         .text
                                            //         .isNotEmpty &&
                                            //     allProdCtrlObj
                                            //             .productQuantityCtrl[
                                            //                 index]
                                            //             .text !=
                                            // '0') {
                                            allProdCtrlObj.totalAmount[index] =
                                                '${double.parse('${allProdCtrlObj.productQuantityCtrl[index].text.isEmpty ? '0.00' : allProdCtrlObj.productQuantityCtrl[index].text}') * double.parse('${allProdCtrlObj.productModelObjs[index].productVariations?.first.variations?.first.sellPriceIncTax}')}';
                                            allProdCtrlObj
                                                .calculateFinalAmount();
                                            debugPrint('Product Amount');
                                            debugPrint(allProdCtrlObj
                                                .totalAmount[index]);
                                            allProdCtrlObj.update();
                                            // }
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomButton(
                      title: Text(
                        'Discount',
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
                    CustomButton(
                        onTap: () {
                          allProdCtrlObj.isDirectCheckout = true;
                          allProdCtrlObj.update();
                          Get.dialog(Dialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    Dimensions.radiusSmall)),
                            insetPadding:
                                EdgeInsets.all(Dimensions.paddingSizeSmall),
                            child: SelectionDialogue(),
                          ));
                        },
                        title: Text(
                          'Credit',
                          style: TextStyle(color: kWhiteColor),
                        ),
                        bgColor: Theme.of(context).colorScheme.primary),
                    CustomButton(
                        onTap: () {
                          //showProgress();
                          allProdCtrlObj.isDirectCheckout = false;
                          allProdCtrlObj.update();
                          // Get.find<PaymentController>()
                          //     .paymentWidgetList[0]
                          //     .amountCtrl
                          //     .clear();
                          // Get.find<PaymentController>()
                          //         .paymentWidgetList[0]
                          //         .amountCtrl
                          //         .text =
                          //     '${AppFormat.doubleToStringUpTo2('${allProdCtrlObj.finalTotal}')}';
                          // Get.find<PaymentController>().update();
                          Get.to(CheckOutPage(
                            isReceipt: false,
                          ));
                          // allProdCtrlObj.orderCreate();
                        },
                        title: Text(
                          'Pay',
                          style: TextStyle(color: kWhiteColor),
                        ),
                        bgColor: Theme.of(context).colorScheme.primary)
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
