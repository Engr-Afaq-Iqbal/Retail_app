import 'package:bizmodo_emenu/Controllers/ReceiptsController/receiptsController.dart';
import 'package:bizmodo_emenu/Pages/Tabs/View/TabsPage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf/src/pdf/page_format.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../Components/amount_tile.dart';
import '../../Components/custom_circular_button.dart';
import '../../Config/DateTimeFormat.dart';
import '../../Controllers/ProductController/PaymentController.dart';
import '../../Controllers/ProductController/all_products_controller.dart';
import '/Components/textfield.dart';

import '/Config/utils.dart';
import '/Controllers/ProductController/product_cart_controller.dart';

import '/Theme/colors.dart';
import '/Theme/style.dart';

class CheckOutPage extends StatefulWidget {
  final orderData;
  bool isReceipt;
  CheckOutPage({this.orderData, this.isReceipt = true, Key? key})
      : super(key: key);

  @override
  State<CheckOutPage> createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  // final AppScreenController _appScreenCtrlObj = Get.find<AppScreenController>();
  final PaymentController _paymentCtrlObj = Get.find<PaymentController>();
  final AllProductsController allProdCtrlObj =
      Get.find<AllProductsController>();

  // int paymentWidgetIndex = 0;

  @override
  void initState() {
    _paymentCtrlObj.sellNoteCtrl.clear();
    _paymentCtrlObj.staffNoteCtrl.clear();
    try {
      // if payment widget list is empty then new payment fields widget add
      if (_paymentCtrlObj.paymentWidgetList.isEmpty)
        _paymentCtrlObj.addPaymentWidget(
          totalAmount: double.tryParse(
            (widget.isReceipt == true)
                ? '${Get.find<ReceiptsController>().totalAmount ?? ''}'
                : '${Get.find<AllProductsController>().finalTotal ?? ''}',
          ),
        );
    } catch (e) {
      logger.e('Error -> check_out -> initState -> addPaymentWidget => $e');
    }
    super.initState();
  }

  void closeCheckoutPage() {
    Get.to(TabsPage());
    // if (_appScreenCtrlObj.getHomeCurrentSidePageSection.toString() ==
    //     'CheckOutPage') {
    //   _appScreenCtrlObj.setHomeCurrentSidePageSection(CartPage());
    // } else {
    //   Get.back();
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      persistentFooterButtons: [
        GetBuilder(
          builder: (ProductCartController prodCartCtrlObj) {
            return Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (prodCartCtrlObj.itemCartList.isNotEmpty)
                    AmountTile(
                      title: 'sub'.tr,
                      trailValue: prodCartCtrlObj.subTotalAmount(),
                    ),

                  if (prodCartCtrlObj.itemCartList.isNotEmpty)
                    AmountTile(
                      title: 'order_tax'.tr,
                      trailValue: AppFormat.doubleToStringUpTo2(
                            '${prodCartCtrlObj.totalTaxAmount()}',
                          ) ??
                          '0',
                    ),

                  // Total Amount and Tax
                  if (prodCartCtrlObj.itemCartList.isNotEmpty)
                    AmountTile(
                      title: 'total_amount'.tr,
                      trailValue: prodCartCtrlObj.finalAmount(),
                    ),

                  // if(orderCtrl.selectedOrderType.value == '2')
                  Row(
                    // mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: CustomButton(
                          onTap: closeCheckoutPage,
                          bgColor: Colors.redAccent,
                          btnTxt: 'close'.tr,
                          borderRadius: 0,
                        ),
                      ),
                      Expanded(
                        child: CustomButton(
                          onTap: () {
                            showProgress();
                            if (allProdCtrlObj.receiptPayment == true) {
                              print('inside add receipt method call');
                              allProdCtrlObj.addReceipt();
                            } else if (allProdCtrlObj.isUpdate == true) {
                              print('->> for Update Order');
                              allProdCtrlObj.updateOrder();
                            } else {
                              print('->> for Create Order');
                              allProdCtrlObj.orderCreate();
                            }

                            // if (widget.orderData != null) {
                            //   _paymentCtrlObj
                            //       .submitOrderPayment('${widget.orderData.id}');
                            //   // print(
                            //   //     'Id --> ${tableManageCtrlObj.selectedTables.first.id}');
                            //   // Get.find<TableSelectionController>()
                            //   //     .changeTableStatus(
                            //   //         tableManageCtrlObj
                            //   //             .selectedTables.first.id,
                            //   //         TableStatus.FREE);
                            // } else {
                            //   //prodCartCtrlObj.placeOrder();
                            // }

                            ///todo
                            // if (orderCtrl.selectedOrderType.value ==
                            //     '1')
                            //   Get.find<AllProductsController>()
                            //           .currentPageSection
                            //           .value =
                            //       OrderProcessScreen
                            //           .ServiceSelectionPage;
                            // if (orderCtrl.selectedOrderType.value ==
                            //     '2')
                            //   Get.find<AllProductsController>()
                            //           .currentPageSection
                            //           .value =
                            //       OrderProcessScreen
                            //           .ServiceSelectionPage;
                          },
                          bgColor: Theme.of(context).primaryColor,
                          btnTxt: 'finalize_payment'.tr,
                          borderRadius: 0,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ],
      appBar: AppBar(
        title: Text('payment_small'.tr),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        leading: AppStyles.backButton(onTap: () {
          Get.back();
        }),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(7.5),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Advance Balance: ',
              style: orderMapAppBarTextStyle,
            ),

            // buildPaymentContainer(isFirst: true),

            GetX(builder: (PaymentController _paymentCtrlObj) {
              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _paymentCtrlObj.paymentWidgetList.length,
                itemBuilder: (context, index) {
                  return _paymentCtrlObj.paymentWidgetList[index];
                },
              );
              // return Column(
              //   children: _paymentCtrlObj.paymentWidgetList,
              // );
            }),

            CustomButton(
              btnTxt: 'add_payment_row'.tr,
              bgColor: primaryColor,
              borderRadius: 10,
              onTap: () {
                _paymentCtrlObj.addPaymentWidget(
                  totalAmount: double.tryParse(
                    (Get.find<AllProductsController>().finalTotal != null)
                        ? '${Get.find<AllProductsController>().finalTotal ?? ''}'
                        : '${Get.find<ReceiptsController>().totalAmount ?? ''}',
                  ),
                );
              },
            ),

            AppFormField(
              labelText: 'sell_note'.tr,
              title: 'sell_note'.tr + ':*',
              maxLines: 2,
              controller: _paymentCtrlObj.sellNoteCtrl,
            ),

            AppFormField(
              labelText: 'staff_note'.tr,
              title: 'staff_note'.tr + ':*',
              maxLines: 2,
              controller: _paymentCtrlObj.staffNoteCtrl,
            ),
          ],
        ),
      ),
    );
  }

  Future<Uint8List> _generatePdf(PdfPageFormat format) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: format,
        build: (context) => pw.Container(
          child: pw.Text('what_is_print_page_size'.tr),
        ),
      ),
    );

    return pdf.save();
  }
}
