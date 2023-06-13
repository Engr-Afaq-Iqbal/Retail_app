// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:printing/printing.dart';
//
// import '../../Config/DateTimeFormat.dart';
// import '../../Config/const.dart';
// import '/Components/textfield.dart';
//
// import '/Controllers/register/RegisterController.dart';
// import '/Models/business_n_register/RegisterRecordModel.dart';
// import '/Theme/colors.dart';
//
// class ClosingRegisterPage extends StatelessWidget {
//   final bool onlyFields;
//   final bool bar;
//   final bool? pathSettingsPage;
//   ClosingRegisterPage(
//       {this.onlyFields = false,
//       Key? key,
//       this.bar = true,
//       this.pathSettingsPage = false})
//       : super(key: key);
//
//   final GlobalKey<FormState> registerCloseFormKey = GlobalKey<FormState>();
//
//   /// TODO: need to reconfigure this page regarding null operators.
//
//   @override
//   Widget build(BuildContext context) {
//     double w = MediaQuery.of(context).size.width;
//     double h = MediaQuery.of(context).size.height;
//
//     return Scaffold(
//       appBar: AppBar(
//         bottom: bar ? appBarBottomLine() : null,
//         title: Text('closing_register'.tr),
//         automaticallyImplyLeading: bar ? true : false,
//         centerTitle: false,
//         backgroundColor: bar ? kWhiteColor : Colors.transparent,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(20),
//         physics: BouncingScrollPhysics(),
//         child: GetBuilder<RegisterController>(initState: (_) {
//           Get.find<RegisterController>().fetchRegisterRecord();
//         }, builder: (RegisterController regCtrlObj) {
//           RegisterRecordModel? openedRegRec = regCtrlObj.openedRegisterRecord;
//           return Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               // Closing Register Data
//               // Html.fromDom(
//               //   document:
//               //       htmlparser.parse('${openedRegRec?.dataHtml?.html}'),
//               //   // style: {
//               //   //   'modal-dialog': Style(
//               //   //     alignment: Alignment.center,
//               //   //     // display: flex;  justify-content: center; align-items: center
//               //   //     textAlign: TextAlign.center,
//               //   //   )
//               //   // },
//               // ),
//
//               // Html(data: '${openedRegRec?.dataHtml?.html}'),
//
//               if (!onlyFields && openedRegRec != null)
//                 Padding(
//                   padding: EdgeInsets.only(
//                     left: pathSettingsPage == true ? w * 0.05 : w * 0.15,
//                     right: pathSettingsPage == true ? w * 0.05 : w * 0.15,
//                   ),
//                   child: Container(
//                     //height: h,
//                     width: w * 0.6,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(10),
//                       color: Colors.white,
//                       boxShadow: [settingsPageBoxShadow()],
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.all(15.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           registerFieldTitle(
//                             context,
//                             '${'current_register'.tr} ( ${openedRegRec.registerDetails?.openTime} - ${DateTime.now()} )',
//                             textAlign: TextAlign.center,
//                           ),
//                           SizedBox(height: h * 0.02),
//                           Divider(height: 1),
//                           SizedBox(height: h * 0.02),
//                           registerPaymentMethodTable(
//                             FontWeight.bold,
//                             paymentMethod: 'payment_method'.tr,
//                             sales: 'sale'.tr,
//                             expense: 'expense'.tr,
//
//                             bgColor: primaryColor,
//                             txtColor: Colors.white,
//                           ),
//                           Divider(height: 1),
//                           registerPaymentMethodTable(
//                             FontWeight.w400,
//                             paymentMethod: '${'cash_in_hand'.tr}:',
//                             sales: double.parse(
//                                     openedRegRec.registerDetails!.cashInHand!)
//                                 .toStringAsFixed(2),
//                             expense: '',
//
//                           ),
//                           if (openedRegRec.paymentTypes?.cash != null)
//                             registerPaymentMethodTable(
//                               FontWeight.w400,
//                               paymentMethod: '${'cash_payment'.tr}:',
//                               sales: AppFormat.doubleToStringUpTo2(openedRegRec
//                                       .registerDetails!.totalCash!) ??
//                                   '',
//                               expense: double.parse(openedRegRec
//                                       .registerDetails!.totalExpense!)
//                                   .toStringAsFixed(2),
//
//                             ),
//                           if (openedRegRec.paymentTypes!.cheque != null)
//                             registerPaymentMethodTable(
//                               FontWeight.w400,
//                               paymentMethod: '${'cheque_payment'.tr}:',
//                               sales: double.parse(openedRegRec
//                                       .registerDetails!.totalCheque!)
//                                   .toStringAsFixed(2),
//                               expense: double.parse(openedRegRec
//                                       .registerDetails!.totalCardExpense!)
//                                   .toStringAsFixed(2),
//
//                             ),
//                           if (openedRegRec.paymentTypes!.card != null)
//                             registerPaymentMethodTable(
//                               FontWeight.w400,
//                               paymentMethod: '${'card_payment'.tr}:',
//                               sales: double.parse(
//                                       openedRegRec.registerDetails!.totalCard!)
//                                   .toStringAsFixed(2),
//                               expense: double.parse(openedRegRec
//                                       .registerDetails!.totalCardExpense!)
//                                   .toStringAsFixed(2),
//
//                             ),
//
//                           if (openedRegRec.paymentTypes!.bankTransfer != null)
//                             registerPaymentMethodTable(
//                               FontWeight.w400,
//                                 paymentMethod: '${'bank_transfer'.tr}:',
//                                 sales: double.parse(openedRegRec
//                                         .registerDetails!.totalBankTransfer!)
//                                     .toStringAsFixed(2),
//                                 expense: double.parse(openedRegRec
//                                         .registerDetails!
//                                         .totalBankTransferExpense!)
//                                     .toStringAsFixed(2),
//                                 ),
//
//                           registerPaymentMethodTable(
//                             FontWeight.w400,
//                               paymentMethod: '${'advance_payment'.tr}:',
//                               sales: double.parse(openedRegRec
//                                       .registerDetails!.totalAdvance!)
//                                   .toStringAsFixed(2),
//                               expense: double.parse(openedRegRec
//                                       .registerDetails!.totalAdvanceExpense!)
//                                   .toStringAsFixed(2),
//
//                           ),
//                           if (openedRegRec.paymentTypes!.customPay1 != null)
//                             registerPaymentMethodTable(
//                               FontWeight.w400,
//                                 paymentMethod:
//                                     openedRegRec.paymentTypes!.customPay1! +
//                                         ':',
//                                 sales: double.parse(openedRegRec
//                                         .registerDetails!.totalCustomPay1!)
//                                     .toStringAsFixed(2),
//                                 expense: double.parse(openedRegRec
//                                         .registerDetails!
//                                         .totalCustomPay1Expense!)
//                                     .toStringAsFixed(2),
//
//                             ),
//                           if (openedRegRec.paymentTypes!.customPay2 != null)
//                             registerPaymentMethodTable(
//                               FontWeight.w400,
//                                 paymentMethod:
//                                     openedRegRec.paymentTypes!.customPay2,
//                                 sales: double.parse(openedRegRec
//                                         .registerDetails!.totalCustomPay2!)
//                                     .toStringAsFixed(2),
//                                 expense: double.parse(openedRegRec
//                                         .registerDetails!
//                                         .totalCustomPay2Expense!)
//                                     .toStringAsFixed(2),
//
//                             ),
//                           if (openedRegRec.paymentTypes!.customPay3 != null)
//                             registerPaymentMethodTable(
//                               FontWeight.w400,
//                                 paymentMethod:
//                                     openedRegRec.paymentTypes!.customPay3,
//                                 sales: double.parse(openedRegRec
//                                         .registerDetails!.totalCustomPay3!)
//                                     .toStringAsFixed(2),
//                                 expense: double.parse(openedRegRec
//                                         .registerDetails!
//                                         .totalCustomPay3Expense!)
//                                     .toStringAsFixed(2),
//
//                             ),
//                           if (openedRegRec.paymentTypes!.customPay4 != null)
//                             registerPaymentMethodTable(
//                               FontWeight.w400,
//                                 paymentMethod:
//                                     openedRegRec.paymentTypes!.customPay4,
//                                 sales: double.parse(openedRegRec
//                                         .registerDetails!.totalCustomPay4!)
//                                     .toStringAsFixed(2),
//                                 expense: double.parse(openedRegRec
//                                         .registerDetails!
//                                         .totalCustomPay4Expense!)
//                                     .toStringAsFixed(2),
//
//                             ),
//                           if (openedRegRec.paymentTypes!.customPay5 != null)
//                             registerPaymentMethodTable(
//                               FontWeight.w400,
//                                 paymentMethod:
//                                     openedRegRec.paymentTypes!.customPay5,
//                                 sales: double.parse(openedRegRec
//                                         .registerDetails!.totalCustomPay5!)
//                                     .toStringAsFixed(2),
//                                 expense: double.parse(openedRegRec
//                                         .registerDetails!
//                                         .totalCustomPay5Expense!)
//                                     .toStringAsFixed(2),
//
//                             ),
//                           if (openedRegRec.paymentTypes!.customPay6 != null)
//                             registerPaymentMethodTable(
//                               FontWeight.w400,
//                                 paymentMethod:
//                                     openedRegRec.paymentTypes!.customPay6,
//                                 sales: double.parse(openedRegRec
//                                         .registerDetails!.totalCustomPay6!)
//                                     .toStringAsFixed(2),
//                                 expense: double.parse(openedRegRec
//                                         .registerDetails!
//                                         .totalCustomPay6Expense!)
//                                     .toStringAsFixed(2),
//
//                             ),
//                           if (openedRegRec.paymentTypes!.customPay7 != null)
//                             registerPaymentMethodTable(
//                                 FontWeight.w400,
//                                 paymentMethod:
//                                     openedRegRec.paymentTypes!.customPay7,
//                                 sales: double.parse(openedRegRec
//                                         .registerDetails!.totalCustomPay7!)
//                                     .toStringAsFixed(2),
//                                 expense: double.parse(openedRegRec
//                                         .registerDetails!
//                                         .totalCustomPay7Expense!)
//                                     .toStringAsFixed(2),
//                                 ),
//                           // ...List.generate(
//                           //     openedRegRec!.paymentTypes!.card!.length,
//                           //         (index) {
//                           //           PaymentTypesModel _item =
//                           //       openedRegRec!.paymentTypes!;
//                           //       return registerPaymentMethodTable(
//                           //         paymentMethod: '${_item.customPay1}',
//                           //         sales: '${_item.card}',
//                           //         expense: '${_item.cash}',
//                           //         FontWeight.w400,
//                           //       );
//                           //     }),
//                           SizedBox(
//                             height: h * 0.02,
//                           ),
//                           Divider(height: 0.2, color: Colors.black),
//                           SizedBox(
//                             height: h * 0.03,
//                           ),
//
//                           registerPaymentMethodTable(
//                               FontWeight.w400,
//                               paymentMethod: 'description'.tr,
//                               sales: '',
//                               expense: 'amount'.tr,
//
//                               bgColor: primaryColor,
//                               txtColor: Colors.white),
//                           Divider(height: 1),
//
//                           registerPaymentMethodTable(
//                             FontWeight.w400,
//                               paymentMethod: '${'total_sales'.tr}:',
//                               sales: '',
//                               expense: double.parse(
//                                       openedRegRec.registerDetails!.totalSale!)
//                                   .toStringAsFixed(2),
//                              ),
//                           registerPaymentMethodTable(
//                             FontWeight.w400,
//                             paymentMethod: '${'total_refund'.tr}:',
//                             sales: '',
//                             expense: double.parse(
//                                     openedRegRec.registerDetails!.totalRefund!)
//                                 .toStringAsFixed(2),
//
//                             bgColor: Colors.grey.withOpacity(0.1),
//                           ),
//                           registerPaymentMethodTable(
//                             FontWeight.w400,
//                               paymentMethod: '${'total_payment'.tr}:',
//                               sales: '',
//                               expense: double.parse(
//                                       openedRegRec.totalPayment.toString())
//                                   .toStringAsFixed(2),
//                               ),
//                           registerPaymentMethodTable(
//                             FontWeight.w400,
//                             paymentMethod: '${'credit_sales'.tr}:',
//                             sales: '',
//                             expense:
//                                 double.parse(openedRegRec.creditSale.toString())
//                                     .toStringAsFixed(2),
//                             bgColor: Colors.grey.withOpacity(0.1),
//                           ),
//
//                           if (openedRegRec.details?.transactionDetails
//                                       ?.totalSales !=
//                                   null &&
//                               openedRegRec.details?.transactionDetails
//                                       ?.totalSales !=
//                                   0.0)
//                             registerPaymentMethodTable(
//                               FontWeight.w400,
//                               paymentMethod: '${'total_sales'.tr}:',
//                               sales: '',
//                               expense: double.parse(openedRegRec
//                                       .details!.transactionDetails!.totalSales!)
//                                   .toStringAsFixed(2),
//
//                             ),
//                           if (openedRegRec.registerDetails?.totalExpense !=
//                               null)
//                             registerPaymentMethodTable(
//                               FontWeight.w400,
//                               paymentMethod: '${'total_expense'.tr}:',
//                               sales: '',
//                               expense: double.parse(openedRegRec
//                                       .registerDetails!.totalExpense!)
//                                   .toStringAsFixed(2),
//
//                               bgColor: Colors.grey.withOpacity(0.1),
//                             ),
//
//                           /// TODO: Total Purchase
//                           if (openedRegRec.totalPurchase != null)
//                             registerPaymentMethodTable(
//                               FontWeight.w400,
//                               paymentMethod: '${'total_purchase_paid'.tr}:',
//                               sales: '',
//                               expense: '${openedRegRec.totalPurchase}',
//
//                             ),
//
//                           SizedBox(height: h * 0.02),
//
//                           Divider(height: 0.2, color: Colors.black),
//                           SizedBox(height: h * 0.03),
//                           //SizedBox(height: h * 0.03,),
//                           // Product List
//                           registerFieldTitle(
//                             context,
//                             'details_of_products_sold'.tr,
//                           ),
//                           SizedBox(height: h * 0.03),
//                           registerRecordTable(
//                             FontWeight.w400,
//                             srN: '#',
//                             text1: 'sku'.tr,
//                             mainTxt: 'product'.tr,
//                             text3: 'quantity'.tr,
//                             text4: 'total_amount'.tr,
//                             bgColor: primaryColor,
//                             txtColor: Colors.white,
//                           ),
//                           Divider(height: 1),
//                           ...List.generate(
//                               openedRegRec.details!.productDetails.length,
//                               (index) {
//                             ProductDetailsModel _item =
//                                 openedRegRec.details!.productDetails[index];
//                             return registerRecordTable(
//                               FontWeight.w400,
//                               srN: '${index + 1}',
//                               text1: '${_item.sku}',
//                               mainTxt: '${_item.productName}',
//                               text3: '${_item.totalQuantity}',
//                               text4: '${_item.totalAmount}',
//
//                             );
//                           }),
//                           SizedBox(height: h * 0.02),
//                           Divider(height: 0.2, color: Colors.black),
//                           // SizedBox(height: h * 0.03,),
//
//                           if (openedRegRec
//                                   .details?.transactionDetails?.totalSales !=
//                               null)
//                             registerRecordTable(
//                               FontWeight.w600,
//                               srN: '#',
//                               text1: '',
//                               mainTxt: '',
//                               text3: '${totalQuantities(regCtrlObj)}',
//                               text4:
//                                   "${AppFormat.doubleToStringUpTo2(openedRegRec.details?.transactionDetails?.totalSales)}",
//
//                               bgColor: Colors.grey.withOpacity(0.1),
//                               txtColor: Colors.black,
//                             ),
//
//                           if (openedRegRec
//                                   .details?.transactionDetails?.totalTax !=
//                               null)
//                             registerRecordTable(
//                               FontWeight.w600,
//                               srN: '',
//                               text1: '',
//                               mainTxt: '${'order_tax'.tr}: (+)',
//                               text3: '',
//                               text4:
//                                   "${AppFormat.doubleToStringUpTo2(openedRegRec.details?.transactionDetails?.totalTax)}",
//
//                               mainTextAlign: TextAlign.right,
//                               mainTextDirection: TextDirection.ltr,
//                               bgColor: Colors.white,
//                               txtColor: Colors.black,
//                             ),
//                           if (openedRegRec
//                                   .details?.transactionDetails?.totalDiscount !=
//                               null)
//                             registerRecordTable(
//                               FontWeight.w600,
//                               srN: '',
//                               text1: '',
//                               mainTxt: '${'discount_tax'.tr}: (-) ',
//                               text3: '',
//                               text4:
//                                   "${AppFormat.doubleToStringUpTo2(openedRegRec.details?.transactionDetails?.totalDiscount)}",
//
//                               mainTextAlign: TextAlign.right,
//                               mainTextDirection: TextDirection.ltr,
//                               bgColor: Colors.grey.withOpacity(0.1),
//                               txtColor: Colors.black,
//                             ),
//                           registerRecordTable(
//                             FontWeight.w600,
//                             srN: '',
//                             text1: '',
//                             mainTxt: '${'grand_total'.tr}: ',
//                             text3: '',
//                             text4:
//                                 '${calculateGrandTotal(openedRegRec.details?.transactionDetails)}',
//
//                             mainTextAlign: TextAlign.right,
//                             mainTextDirection: TextDirection.ltr,
//                             bgColor: Colors.white,
//                             txtColor: Colors.black,
//                           ),
//                           // SizedBox(height: h * 0.02,),
//                           Divider(height: 0.2, color: Colors.black),
//                           SizedBox(height: h * 0.03),
//
//                           // Details of products Sold (By Brand)
//                           registerFieldTitle(
//                             context,
//                             'details_of_products_sold_byBrand'.tr,
//                           ),
//                           SizedBox(height: h * 0.03),
//                           registerRecordTable(
//                             FontWeight.w600,
//                             srN: '#',
//                             mainTxt: 'brands'.tr,
//                             text3: 'quantity'.tr,
//                             text4: 'total_amount'.tr,
//
//                             bgColor: primaryColor,
//                             txtColor: Colors.white,
//                           ),
//                           ...List.generate(
//                               openedRegRec.details!.productDetailsByBrand
//                                   .length, (index) {
//                             ProductDetailsByBrandModel _item = openedRegRec
//                                 .details!.productDetailsByBrand[index];
//                             return registerRecordTable(
//                               FontWeight.w400,
//                               srN: '${index + 1}',
//                               mainTxt: '${_item.brandName}',
//                               text3: '${_item.totalQuantity}',
//                               text4: '${_item.totalAmount}',
//
//                             );
//                           }),
//                           SizedBox(height: h * 0.02),
//                           Divider(height: 0.2, color: Colors.black),
//
//                           if (openedRegRec
//                               .details!.productDetailsByBrand.isNotEmpty)
//                             registerRecordTable(
//                               FontWeight.w600,
//                               srN: '#',
//                               mainTxt: '',
//                               text3: '${totalQuantities(regCtrlObj)}',
//                               text4: double.parse(openedRegRec.details!
//                                       .productDetailsByBrand[0].totalAmount
//                                       .toString())
//                                   .toStringAsFixed(2),
//
//                               bgColor: Colors.grey.withOpacity(0.1),
//                               txtColor: Colors.black,
//                             ),
//
//                           // if (openedRegRec
//                           //         .details?.transactionDetails?.totalTax !=
//                           //     null)
//                           //   registerRecordTable(
//                           //     srN: '',
//                           //     mainTxt: '',
//                           //     text3: '${'order_tax'.tr}: (+) ',
//                           //     text4:
//                           //         '${AppFormat.doubleToStringUpTo2(openedRegRec.details?.transactionDetails?.totalTax)}',
//                           //     FontWeight.w600,
//                           //     bgColor: Colors.white,
//                           //     txtColor: Colors.black,
//                           //   ),
//                           // if (openedRegRec
//                           //         .details?.transactionDetails?.totalDiscount !=
//                           //     null)
//                           //   registerRecordTable(
//                           //     srN: '',
//                           //     mainTxt: '',
//                           //     text3: '${'discount_tax'.tr}: (-) ',
//                           //     text4:
//                           //         '${AppFormat.doubleToStringUpTo2(openedRegRec.details?.transactionDetails?.totalDiscount)}',
//                           //     FontWeight.w600,
//                           //     bgColor: Colors.grey.withOpacity(0.1),
//                           //     txtColor: Colors.black,
//                           //   ),
//
//                           registerRecordTable(
//                             srN: '',
//                             mainTxt: '',
//                             text3: '${'grand_total'.tr}: ',
//                             text4:
//                                 '${calculateGrandTotal(openedRegRec.details?.transactionDetails)}',
//                             FontWeight.w600,
//                             bgColor: Colors.white,
//                             txtColor: Colors.black,
//                           ),
//
//                           Divider(height: 0.2, color: Colors.black),
//                           SizedBox(height: h * 0.03),
//
//                           // Type of Service Details
//                           registerFieldTitle(
//                             context,
//                             'types_of_service_details'.tr,
//                           ),
//                           SizedBox(height: h * 0.03),
//                           registerRecordTable(
//                             srN: '#',
//                             mainTxt: 'types_of_service'.tr,
//                             text3: '',
//                             text4: 'total_amount'.tr,
//                             FontWeight.w600,
//                             bgColor: primaryColor,
//                             txtColor: Colors.white,
//                           ),
//                           ...List.generate(
//                               openedRegRec.details!.typesOfServiceDetails
//                                   .length, (index) {
//                             TypeOfServiceDetailsModel _item = openedRegRec
//                                 .details!.typesOfServiceDetails[index];
//                             return registerRecordTable(
//                               srN: '${index + 1}',
//                               mainTxt: '${_item.typeOfService}',
//                               text3: '',
//                               text4: '${_item.totalAmount}',
//                               FontWeight.w400,
//                             );
//                           }),
//                           SizedBox(height: h * 0.02),
//                           Divider(height: 0.2, color: Colors.black),
//                           registerRecordTable(
//                             srN: '#',
//                             mainTxt: '',
//                             text3: '${'grand_total'.tr}: ',
//                             text4:
//                                 '${calculateGrandTotal(openedRegRec.details?.transactionDetails)}',
//                             FontWeight.w600,
//                             bgColor: Colors.grey.withOpacity(0.1),
//                             txtColor: Colors.black,
//                           ),
//                           Divider(height: 0.2, color: Colors.black),
//                           SizedBox(height: h * 0.03),
//                           Form(
//                             key: registerCloseFormKey,
//                             child: Wrap(
//                               crossAxisAlignment: WrapCrossAlignment.center,
//                               // alignment: WrapAlignment.spaceBetween,
//                               // runAlignment: WrapAlignment.spaceBetween,
//                               runSpacing: 20,
//                               spacing: 20,
//                               children: [
//                                 AppFormField(
//                                   width: w * 0.2,
//                                   controller: regCtrlObj.totalCashCtrl,
//                                   validator: (String? v) {
//                                     if (v!.isEmpty)
//                                       return "* ${'total_cash_required'.tr}";
//                                     return null;
//                                   },
//                                   labelText: 'total_cash'.tr,
//                                   title: 'total_cash'.tr,
//                                   keyboardType: TextInputType.number,
//                                 ),
//                                 AppFormField(
//                                   width: w * 0.2,
//                                   controller: regCtrlObj.totalCardSlipCtrl,
//                                   validator: (String? v) {
//                                     if (v!.isEmpty)
//                                       return "* ${'total_card_slips_required'.tr}";
//                                     return null;
//                                   },
//                                   labelText: 'total_card_slips'.tr,
//                                   title: 'total_card_slips'.tr,
//                                   keyboardType: TextInputType.number,
//                                 ),
//                                 AppFormField(
//                                   width: w * 0.2,
//                                   controller: regCtrlObj.totalChequesCtrl,
//                                   validator: (String? v) {
//                                     if (v!.isEmpty)
//                                       return "* ${'total_cheques_required'.tr}";
//                                     return null;
//                                   },
//                                   labelText: 'total_cheques'.tr,
//                                   title: 'total_cheques'.tr,
//                                   keyboardType: TextInputType.number,
//                                 ),
//                               ],
//                             ),
//                           ),
//                           AppFormField(
//                             width: w * 0.7,
//                             controller: regCtrlObj.closingNoteCtrl,
//                             maxLines: 3,
//                             labelText: 'closing_note'.tr,
//                             title: 'closing_note'.tr,
//                             keyboardType: TextInputType.multiline,
//                           ),
//                           // Closing Register Button
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               CustomButton(
//                                 padding: const EdgeInsets.all(20),
//                                 bgColor: Theme.of(context).primaryColor,
//                                 btnTxt: 'print'.tr,
//                                 onTap: () async {
//                                   // Navigator.push(
//                                   //     context,
//                                   //     MaterialPageRoute(
//                                   //         builder: (_) => RegisterPrintData(
//                                   //             dataPre: openedRegRec)));
//                                   bool result = await Printing.directPrintPdf(
//                                     // printer: _printersList.first,
//                                     printer: Printer(
//                                       location: "10.10.10.141:9100",
//                                       //kitchenCtrlObj.ktcSelectionModel![1].kitchenPrinter.toString(),
//                                       url:
//                                           "KOT 2", //kitchenCtrlObj.ktcSelectionModel![1].name.toString(),
//                                     ),
//                                     onLayout: (_) => RegisterPrintMethod()
//                                         .generatePdf(openedRegRec),
//                                     format: RegisterPrintMethod().roll80,
//                                   );
//                                   // if (registerCloseFormKey.currentState!.validate()) Get.back(result: true);
//                                 },
//                               ),
//                               // CustomButton(
//                               //   padding: const EdgeInsets.all(20),
//                               //   bgColor: Theme.of(context).primaryColor,
//                               //   btnTxt: 'Print KOT',
//                               //   onTap: () {
//                               //     Navigator.push(context, MaterialPageRoute(builder: (_)=> PrintKotInvoice()));
//                               //     // if (registerCloseFormKey.currentState!.validate()) Get.back(result: true);
//                               //   },
//                               // ),
//                               // CustomButton(
//                               //   padding: const EdgeInsets.all(20),
//                               //   bgColor: Theme.of(context).primaryColor,
//                               //   btnTxt: 'Print Invoice',
//                               //   onTap: () {
//                               //     Navigator.push(context, MaterialPageRoute(builder: (_)=> PrintInvoice()));
//                               //     // if (registerCloseFormKey.currentState!.validate()) Get.back(result: true);
//                               //   },
//                               // ),
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.end,
//                                 children: [
//                                   CustomButton(
//                                     padding: const EdgeInsets.all(20),
//                                     btnTxt: 'cancel'.tr,
//                                     onTap: () => Get.back(result: false),
//                                   ),
//                                   SizedBox(width: 10),
//                                   CustomButton(
//                                     padding: const EdgeInsets.all(20),
//                                     bgColor: Theme.of(context).primaryColor,
//                                     btnTxt: 'close_register'.tr,
//                                     onTap: () async {
//                                       if (registerCloseFormKey.currentState!
//                                           .validate()) {
//                                         Get.find<RegisterController>()
//                                             .closeRegister(context)
//                                             .then((isClosed) async {
//                                           if (isClosed)
//                                             bool result =
//                                                 await Printing.directPrintPdf(
//                                               // printer: _printersList.first,
//                                               printer: Printer(
//                                                 location: "10.10.10.141:9100",
//                                                 //kitchenCtrlObj.ktcSelectionModel![1].kitchenPrinter.toString(),
//                                                 url:
//                                                     "KOT 2", //kitchenCtrlObj.ktcSelectionModel![1].name.toString(),
//                                               ),
//                                               onLayout: (_) =>
//                                                   RegisterPrintMethod()
//                                                       .generatePdf(
//                                                           openedRegRec),
//                                               format:
//                                                   RegisterPrintMethod().roll80,
//                                             );
//                                           // Get.back(result: true);
//                                         });
//                                       }
//                                     },
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                           SizedBox(height: h * 0.02),
//                           Divider(height: 0.2, color: Colors.black),
//                           SizedBox(height: h * 0.03),
//
//                           Column(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 '${'user'.tr}: ' +
//                                     openedRegRec.registerDetails!.userName
//                                         .toString(),
//                                 style: TextStyle(
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.w600,
//                                 ),
//                               ),
//                               Text(
//                                 '${'email'.tr}: ' +
//                                     openedRegRec.registerDetails!.email
//                                         .toString(),
//                                 style: TextStyle(
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.w600,
//                                 ),
//                               ),
//                               Text(
//                                 '${'business_location'.tr}: ' +
//                                     openedRegRec.registerDetails!.locationName
//                                         .toString(),
//                                 style: TextStyle(
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.w600,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//
//               //Closing Register Fields
//
//               // Closing Note
//             ],
//           );
//         }),
//       ),
//     );
//   }
//
//   calculateGrandTotal(TransactionDetails? transactionDetails) {
//     return AppFormat.doubleToStringUpTo2(
//       (((double.parse(transactionDetails?.totalSales ?? '0')) +
//                   ((double.parse(transactionDetails?.totalSales ?? '0') *
//                           double.parse(transactionDetails?.totalTax ?? '0')) /
//                       100)) -
//               (double.parse(transactionDetails?.totalDiscount ?? '0')))
//           .toString(),
//     );
//   }
//
//   Widget registerFieldTitle(
//     BuildContext context,
//     String? titleValue, {
//     TextAlign? textAlign,
//   }) {
//     return Text(
//       titleValue ?? '--',
//       style: Theme.of(context).textTheme.subtitle1,
//       textAlign: TextAlign.start,
//     );
//   }
//
//   Widget registerRecordTable(
//     FontWeight fontWeight, {
//     String? srN,
//     String? text1,
//     String? mainTxt,
//     String? text3,
//     String? text4,
//     Color? bgColor,
//     Color? txtColor,
//     mainTextAlign = TextAlign.left,
//     mainTextDirection = TextDirection.rtl,
//   }) {
//     return Container(
//       color: bgColor,
//       padding: const EdgeInsets.all(7.5),
//       child: Row(
//         children: [
//           if (srN != null)
//             Expanded(
//               flex: 1,
//               child: Center(
//                 child: Text(
//                   srN == 'null' ? '' : srN,
//                   style: TextStyle(fontWeight: fontWeight, color: txtColor),
//                 ),
//               ),
//             ),
//           if (text1 != null)
//             Expanded(
//               flex: 2,
//               child: Text(
//                 text1 == 'null' ? '' : text1,
//                 textAlign: TextAlign.left,
//                 style: TextStyle(fontWeight: fontWeight, color: txtColor),
//               ),
//             ),
//           if (mainTxt != null)
//             Expanded(
//               flex: 5,
//               child: Text(
//                 mainTxt == 'null' ? '' : mainTxt,
//                 maxLines: 2,
//                 textAlign: mainTextAlign,
//                 textDirection: mainTextDirection,
//                 style: TextStyle(
//                   fontWeight: fontWeight,
//                   color: txtColor,
//                   fontFamily: 'Arial',
//                 ),
//               ),
//             ),
//           if (text3 != null)
//             Expanded(
//               flex: 3,
//               child: Center(
//                 child: Text(
//                   text3 == 'null' ? '' : text3,
//                   textAlign: TextAlign.left,
//                   style: TextStyle(
//                     fontWeight: fontWeight,
//                     color: txtColor,
//                   ),
//                 ),
//               ),
//             ),
//           if (text4 != null)
//             Expanded(
//               flex: 3,
//               child: Text(
//                 text4 == 'null' ? '' : text4,
//                 textAlign: TextAlign.left,
//                 style: TextStyle(
//                   fontWeight: fontWeight,
//                   color: txtColor,
//                 ),
//               ),
//             ),
//           // if (text1 != null)
//           //   Expanded(
//           //     flex: 2,
//           //     child: Text(
//           //       text1,
//           //       maxLines: 2,
//           //       // style: orderDetailSubTitle.copyWith(fontWeight: fontWeight),
//           //     ),
//           //   ),
//         ],
//       ),
//     );
//   }
//
//   Widget registerPaymentMethodTable(
//     FontWeight fontWeight, {
//     String? paymentMethod,
//     String? sales,
//     String? expense,
//     Color? bgColor,
//     Color? txtColor,
//   }) {
//     return Container(
//       color: bgColor,
//       padding: const EdgeInsets.all(15),
//       child: Row(
//         // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         // alignment: WrapAlignment.spaceBetween,
//         children: [
//           if (paymentMethod != null)
//             Expanded(
//               flex: 7,
//               child: Text(
//                 paymentMethod,
//                 textAlign: TextAlign.left,
//                 style: TextStyle(fontWeight: fontWeight, color: txtColor),
//               ),
//             ),
//           if (sales != null)
//             Expanded(
//               flex: 6,
//               child: Text(
//                 sales,
//                 textAlign: TextAlign.left,
//                 style: TextStyle(fontWeight: fontWeight, color: txtColor),
//               ),
//             ),
//           if (expense != null)
//             Expanded(
//               flex: 3,
//               child: Text(
//                 expense,
//                 maxLines: 2,
//                 textAlign: TextAlign.left,
//                 style: TextStyle(fontWeight: fontWeight, color: txtColor),
//               ),
//             ),
//         ],
//       ),
//     );
//   }
//
//   Widget totalSales(
//     FontWeight fontWeight, {
//     String? label,
//     String? text,
//     Color? bgColor,
//     Color? txtColor,
//   }) {
//     return Container(
//       color: bgColor,
//       padding: const EdgeInsets.all(15),
//       child: Row(
//         // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         // alignment: WrapAlignment.spaceBetween,
//         children: [
//           if (label != null)
//             Expanded(
//               flex: 7,
//               child: Text(
//                 label,
//                 textAlign: TextAlign.left,
//                 style: TextStyle(fontWeight: fontWeight, color: txtColor),
//               ),
//             ),
//           if (text != null)
//             Expanded(
//               flex: 6,
//               child: Text(
//                 text,
//                 textAlign: TextAlign.left,
//                 style: TextStyle(fontWeight: fontWeight, color: txtColor),
//               ),
//             ),
//         ],
//       ),
//     );
//   }
//
//   int totalQuantities(RegisterController regCtrlObj) {
//     int totalSoldProducts = 0;
//     try {
//       regCtrlObj.openedRegisterRecord!.details!.productDetails
//           .forEach((element) {
//         totalSoldProducts += double.parse('${element.totalQuantity}').toInt();
//         debugPrint(totalSoldProducts.toString());
//       });
//     } catch (_e) {
//       debugPrint('Error => $_e');
//     }
//     return totalSoldProducts;
//   }
// }
