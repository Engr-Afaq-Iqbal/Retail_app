import 'package:bizmodo_emenu/Components/custom_circular_button.dart';
import 'package:bizmodo_emenu/Config/DateTimeFormat.dart';
import 'package:bizmodo_emenu/Config/enums.dart';

import 'package:bizmodo_emenu/Pages/Receipts/receiptsTile.dart';
import 'package:bizmodo_emenu/Pages/Receipts/searchInReceipts.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Controllers/StockTransferController/stockTransferController.dart';
import '../../../Theme/colors.dart';
import '../../Config/utils.dart';
import '../../Controllers/AllSalesController/allSalesController.dart';
import '../../Controllers/ContactController/ContactController.dart';
import '../../Controllers/ProductController/all_products_controller.dart';
import '../../Controllers/ReceiptsController/receiptsController.dart';
import '../../Theme/style.dart';
import '../checkout/check_out.dart';
import '../order_type/search_customer_page.dart';

class Receipts extends StatefulWidget {
  const Receipts({Key? key}) : super(key: key);

  @override
  State<Receipts> createState() => _ReceiptsState();
}

class _ReceiptsState extends State<Receipts> {
  bool valuefirst = false;
  StockTransferController stockTranCtrlObj =
      Get.find<StockTransferController>();

  ContactController contactCtrlObjj = Get.find<ContactController>();

  AllSalesController allSalesCtrl = Get.find<AllSalesController>();
  ScrollController? _pastOrdersScrollCtrl;
  ReceiptsController receiptsCtrl = Get.find<ReceiptsController>();
  int selectedMethod = 0;

  @override
  void initState() {
    // TODO: implement initState
    allSalesCtrl.callFirstOrderPageForReceipt();
    stockTranCtrlObj.fetchStockTransfersList();
    receiptsCtrl.totalAmount = '0';
    receiptsCtrl.listSaleOrderDataModel =
        allSalesCtrl.allSaleOrders?.saleOrdersData;
    scrollControllerLis();
    super.initState();
  }

  scrollControllerLis() {
    _pastOrdersScrollCtrl = ScrollController();
    if (_pastOrdersScrollCtrl != null) {
      _pastOrdersScrollCtrl?.addListener(() {
        double maxScroll = _pastOrdersScrollCtrl!.position.maxScrollExtent;
        double currentScroll = _pastOrdersScrollCtrl!.position.pixels;
        double delta = MediaQuery.of(context).size.height * 0.75;

        if ((maxScroll - currentScroll) <= delta) {
          // if (maxScroll == currentScroll) {
          Get.find<AllSalesController>().loadMoreSaleOrders();
        }
      });
    }
  }

  @override
  void dispose() {
    _pastOrdersScrollCtrl?.removeListener(scrollControllerLis);
    receiptsCtrl.totalAmount = '0';
    allSalesCtrl.allSaleOrders = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Issue Receipts'),
        actions: [
          GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 0),
                  content: SearchInReceipts(),
                ),
              );
            },
            child: Icon(
              Icons.filter_alt_outlined,
              color: blackColor,
            ),
          ),
          SizedBox(
            width: 3,
          ),
          GestureDetector(
            onTap: () {
              Get.to(CustomerSearch(
                dashBoardId: 4,
              ));
            },
            child: Icon(
              Icons.search_outlined,
              color: blackColor,
            ),
          ),
          Padding(
            // height: 20,
            // width: 20,
            padding: EdgeInsets.only(right: 5),
            child: Checkbox(
              value: valuefirst,
              onChanged: (bool? value) {
                setState(() {
                  valuefirst = value!;
                  if (valuefirst == true) {
                    Get.find<ReceiptsController>().markUnMarkAllOrder();
                  } else {
                    receiptsCtrl.totalAmount = '0';
                  }
                });
              },
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: GetBuilder<ContactController>(
                builder: (ContactController contactCtrl) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Customer Name:'),
                  Center(
                    child: Text(
                      '${contactCtrl.nameCtrl.text} (${contactCtrl.contactId})',
                      style: appBarHeaderStyle,
                    ),
                  ),
                ],
              );
            }),
          ),
        ),
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      // floatingActionButton: FloatingActionButton.small(
      //     child: Icon(Icons.add),
      //     backgroundColor: primaryColor.withOpacity(0.5),
      //     onPressed: () {
      //       showModalBottomSheet(
      //         isScrollControlled: true,
      //         context: context,
      //         builder: (context) {
      //           return Container(
      //             child: CreateStockTransfer(),
      //           );
      //         },
      //       );
      //     }),
      body: Stack(
        children: [
          GetBuilder(
            builder: (AllSalesController allSalesCtrlObj) {
              return RefreshIndicator(
                onRefresh: () async {
                  await allSalesCtrlObj.callFirstOrderPageForReceipt();
                  setState(() {
                    receiptsCtrl.totalAmount = '0';
                  });
                },
                child: (allSalesCtrlObj.allSaleOrders == null)
                    ? progressIndicator()
                    : Scrollbar(
                        controller: _pastOrdersScrollCtrl,
                        child: ListView.builder(
                          controller: _pastOrdersScrollCtrl,
                          physics: AlwaysScrollableScrollPhysics(),
                          padding: const EdgeInsets.only(bottom: 100),
                          itemCount: allSalesCtrlObj
                                  .allSaleOrders?.saleOrdersData.length ??
                              0,
                          itemBuilder: (context, index) {
                            print(paymentStatusValues.reverse);

                            print(paymentStatusValues.reverse?[allSalesCtrlObj
                                .allSaleOrders
                                ?.saleOrdersData[index]
                                .paymentStatus]);
                            return IntrinsicHeight(
                              child: GestureDetector(
                                // onTap: () {
                                //   Get.to(SalesViewDetailsPage());
                                // },
                                // child: (allSalesCtrlObj
                                //             .allSaleOrders
                                //             ?.saleOrdersData[index]
                                //             .paymentStatus !=
                                //         PaymentStatus.PAID)
                                child: (paymentStatusValues.reverse?[
                                            allSalesCtrlObj
                                                .allSaleOrders
                                                ?.saleOrdersData[index]
                                                .paymentStatus] ==
                                        'Due')
                                    ? ReceiptsTile(
                                        pastOrder: allSalesCtrlObj
                                            .allSaleOrders!
                                            .saleOrdersData[index],
                                        index: index,
                                      )
                                    : SizedBox(),

                                //     SalesViewTile(
                                //   allSalesCtrlObj: allSalesCtrlObj,
                                //   index: index,
                                //   pastOrder: allSalesCtrlObj
                                //       .allSaleOrders!.saleOrdersData[index],
                                // )
                              ),
                            );
                            //   !allSalesCtrlObj.allSaleOrders!
                            //     .saleOrdersData[index].isSuspend
                            //     ? PastOrderInfoTile(
                            //   allSalesCtrlObj
                            //       .allSaleOrders!.saleOrdersData[index],
                            // )
                            //     : SizedBox();
                          },
                        ),
                      ),
              );
            },
          ),
          Positioned(
            bottom: 5,
            left: 0,
            right: 0,
            child: GetX(builder: (AllSalesController orderCtrlObj) {
              return orderCtrlObj.isLoadMoreRunning.isTrue
                  ? progressIndicator()
                  : SizedBox();
            }),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GetBuilder<ReceiptsController>(
                  builder: (ReceiptsController receiptCtrlObj) {
                return Container(
                  color: kWhiteColor,
                  height: 25,
                  width: 150,
                  child: Center(
                    child: Text(
                      'Total (AED) = ${AppFormat.doubleToStringUpTo2(receiptCtrlObj.totalAmount)}',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ),
                );
              }),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     CustomButton(
              //       onTap: () {
              //         setState(() {
              //           selectedMethod = 1;
              //         });
              //       },
              //       title: Text(
              //         'CASH',
              //         style: TextStyle(color: kWhiteColor),
              //       ),
              //       bgColor: selectedMethod == 1
              //           ? Theme.of(context).colorScheme.primary
              //           : strikeThroughColor,
              //     ),
              //     SizedBox(
              //       width: 10,
              //     ),
              //     CustomButton(
              //       onTap: () {
              //         setState(() {
              //           selectedMethod = 2;
              //         });
              //       },
              //       title: Text(
              //         'CHEQUE',
              //         style: TextStyle(color: kWhiteColor),
              //       ),
              //       bgColor: selectedMethod == 2
              //           ? Theme.of(context).colorScheme.primary
              //           : strikeThroughColor,
              //     ),
              //   ],
              // ),
              CustomButton(
                onTap: () {
                  Get.find<AllProductsController>().receiptPayment = true;
                  Get.find<AllProductsController>().finalTotal = 0.00;
                  Get.find<AllProductsController>().update();
                  Get.to(CheckOutPage(
                    isReceipt: true,
                  ));

                  ///for cash
                  // if (selectedMethod == 1) {}
                  //
                  // ///for cheque
                  // if (selectedMethod == 2) {}
                  // if (selectedMethod == 0) {
                  //   showToast('Please select method');
                  // }
                },
                title: Text(
                  'SUBMIT',
                  style: TextStyle(color: kWhiteColor),
                ),
              ),
            ],
          ),
        ],
      ),
      // SingleChildScrollView(
      //   child: Column(
      //     children: [
      //       Container(
      //         height: MediaQuery.of(context).size.height * 0.73,
      //         child: ListView.builder(
      //             physics: AlwaysScrollableScrollPhysics(),
      //             padding: const EdgeInsets.only(bottom: 100),
      //             itemCount: 7,
      //             itemBuilder: (context, index) {
      //               return IntrinsicHeight(
      //                 child: ReceiptsTile(),
      //               );
      //             }),
      //       ),
      //       Column(
      //         crossAxisAlignment: CrossAxisAlignment.center,
      //         //mainAxisAlignment: MainAxisAlignment.center,
      //         children: [
      //           Text(
      //             'Total (AED) = 0.00',
      //             style: Theme.of(context).textTheme.headline6!.copyWith(
      //                   fontSize: 14,
      //                   fontWeight: FontWeight.w500,
      //                 ),
      //           ),
      //           Row(
      //             mainAxisAlignment: MainAxisAlignment.center,
      //             children: [
      //               CustomButton(
      //                 onTap: () {},
      //                 title: Text(
      //                   'CASH',
      //                   style: TextStyle(color: kWhiteColor),
      //                 ),
      //               ),
      //               SizedBox(
      //                 width: 10,
      //               ),
      //               CustomButton(
      //                 onTap: () {},
      //                 title: Text(
      //                   'CHEQUE',
      //                   style: TextStyle(color: kWhiteColor),
      //                 ),
      //               ),
      //             ],
      //           ),
      //           CustomButton(
      //             onTap: () {},
      //             title: Text(
      //               'SUBMIT',
      //               style: TextStyle(color: kWhiteColor),
      //             ),
      //           ),
      //         ],
      //       ),
      //     ],
      //   ),
      // )
    );
  }
}
