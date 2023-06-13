import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Theme/style.dart';
import '/Components/textfield.dart';

import '/Controllers/ProductController/PaymentController.dart';
import '/Models/PaymentMethodModel/paymentMethodModel.dart';
import '/Theme/colors.dart';

class PaymentFields extends StatelessWidget {
  final bool isFirst;
  final List<PaymentAccount> enabledPaymentOptions;
  PaymentFields(
      {this.isFirst = false, required this.enabledPaymentOptions, Key? key})
      : super(key: key);

//   @override
//   State<PaymentFields> createState() => _PaymentFieldsState();
// }
//
// class _PaymentFieldsState extends State<PaymentFields> {
  // final OrderTypeSelectionController orderCtrl =
  //     Get.find<OrderTypeSelectionController>();
  final PaymentController paymentCtrlObj = Get.find<PaymentController>();

  PaymentAccount? selectedPaymentOption;

  final TextEditingController amountCtrl = TextEditingController();
  final TextEditingController transactionNoCtrl = TextEditingController();
  final TextEditingController checkNoCtrl = TextEditingController();
  final TextEditingController paymentNoteCtrl = TextEditingController();
  TextEditingController paymentMethidCtrl = TextEditingController();

  // @override
  // void initState() {
  //   super.initState();
  //
  //   enabledPaymentOptions = paymentCtrlObj.getAllowedPayments();
  //   // if (enabledPaymentOptions.isNotEmpty)
  //   // selectedPaymentOption = paymentCtrlObj.getCashOrFirstAllowedPayment();
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      key: key,
      //width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: strikeThroughColor?.withOpacity(0.1),
      ),

      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // SingleSelectionChip2(
                //   paddingValue: 0,
                //   chipsDataList: getBusinessPayments(),
                //   valueChanged: (int v) {
                //     orderCtrl.contactId = null;
                //     orderCtrl.selectedPaymentType.value = '$v';
                //     // if (orderCtrl.selectedPaymentType.value == '0') {
                //     //   setState(() {});
                //     //print(orderCtrl.selectedPaymentType.value);
                //     // orderCtrl.contactId = AppConfig.walkInCustomerID;
                //     // // Get.to(() => TableSelectionPage());
                //     // print(orderCtrl.selectedOrderType.value);
                //     // Get.find<AllProductsController>().currentPageSection.value =
                //     //     OrderProcessScreen.TableSelectionPage;
                //     //}
                //     // if (orderCtrl.selectedPaymentType.value == '1') {
                //     //   print(orderCtrl.selectedPaymentType.value);
                //     //   setState(() {});
                //     //   // print(orderCtrl.selectedOrderType.value);
                //     //   // Get.find<AllProductsController>().currentPageSection.value =
                //     //   //     OrderProcessScreen.CartPage;
                //     // }
                //     // if (orderCtrl.selectedPaymentType.value == '2') {
                //     //   setState(() {});
                //     //   // Get.find<AllProductsController>().currentPageSection.value =
                //     //   //     OrderProcessScreen.CartPage;
                //     // }
                //     // if (orderCtrl.selectedPaymentType.value == '3') {
                //     //   setState(() {});
                //     // }
                //   },
                // ),
                AppFormField(
                  padding: EdgeInsets.only(bottom: 5),
                  labelText: 'amount'.tr,
                  title: 'amount'.tr + ': *',
                  controller: amountCtrl,
                  keyboardType: TextInputType.number,
                  // onChanged: (_) {
                  //   paymentCtrlObj.addOrUpdatePaymentFieldsInformation(
                  //       // {
                  //       //   'payment_method': value,
                  //       // },
                  //       );
                  // },
                ),

                if (!isFirst)
                  StatefulBuilder(
                    builder: (context, StateSetter setState) {
                      return Column(
                        children: [
                          Container(
                            width: double.infinity,
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton2(
                                isExpanded: true,
                                items: enabledPaymentOptions.map((e) {
                                  return DropdownMenuItem(
                                    value: e,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5),
                                      child: Text('${e.paymentMethodName}'),
                                    ),
                                  );
                                }).toList(),
                                value: selectedPaymentOption,
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black87,
                                ),
                                dropdownPadding:
                                    EdgeInsets.symmetric(horizontal: 10),
                                onChanged: (PaymentAccount? value) {
                                  setState(() {
                                    selectedPaymentOption = value;
                                    print(selectedPaymentOption
                                        ?.paymentMethodName);
                                    paymentCtrlObj.paymentMethodCtrl.text =
                                        selectedPaymentOption
                                                ?.paymentMethodName ??
                                            '';
                                  });
                                  // paymentCtrlObj
                                  //     .addOrUpdatePaymentFieldsInformation(
                                  //         // {
                                  //         //   'payment_method': value,
                                  //         // },
                                  //         );
                                },
                                buttonDecoration:
                                    AppStyles.outlineBorderDecoration(),
                                dropdownDecoration:
                                    AppStyles.outlineBorderDecoration(),
                                itemPadding: EdgeInsets.zero,
                                itemHighlightColor: primaryColor,
                                hint: Text(
                                  'Payment Method',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xFFA8ADB7),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 5),
                          if (paymentCtrlObj.isSelectedPaymentOptionCheque(
                              key: key))
                            AppFormField(
                              padding: EdgeInsets.only(bottom: 5),
                              labelText: 'cheque_no'.tr,
                              title: 'cheque_no'.tr + ': *',
                              controller: checkNoCtrl,
                              // onChanged: (_) {
                              //   paymentCtrlObj
                              //       .addOrUpdatePaymentFieldsInformation(
                              //           // {
                              //           //   'payment_method': value,
                              //           // },
                              //           );
                              // },
                            )
                          else if (!paymentCtrlObj.isSelectedPaymentOptionCash(
                              key: key))
                            AppFormField(
                              padding: EdgeInsets.only(bottom: 5),
                              labelText: 'transaction_no.'.tr,
                              title: 'transaction_no.'.tr + ': *',
                              controller: transactionNoCtrl,
                              // onChanged: (_) {
                              //   paymentCtrlObj
                              //       .addOrUpdatePaymentFieldsInformation(
                              //           // {
                              //           //   'payment_method': value,
                              //           // },
                              //           );
                              // },
                            ),
                        ],
                      );
                    },
                  ),

                AppFormField(
                  padding: EdgeInsets.only(bottom: 5),
                  labelText: 'payment_note'.tr,
                  title: 'payment_note'.tr + ': *',
                  maxLines: 2,
                  controller: paymentNoteCtrl,
                  // onChanged: (_) {
                  //   paymentCtrlObj.addOrUpdatePaymentFieldsInformation(
                  //       // {
                  //       //   'payment_method': value,
                  //       // },
                  //       );
                  // },
                ),
              ],
            ),
          ),
          if (isFirst == false)
            Positioned(
              top: 2.5,
              right: 2.5,
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {
                    debugPrint('payment widget');
                    // debugPrint('index for delete => ${index}');
                    debugPrint('Key for delete => ${key}');
                    paymentCtrlObj.removePaymentWidget(key: key);
                  },
                  child: Icon(Icons.clear),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
