import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/Config/enums.dart';
import '/Controllers/ReceiptsController/receiptsController.dart';
import '../../../Theme/colors.dart';
import '../../Models/order_type_model/SaleOrderModel.dart';
import '../Orders/Components/AmountInfo.dart';
import '../Orders/Components/CustomerInfo.dart';
import '../Orders/Controller/OrderController.dart';

class ReceiptsTile extends StatefulWidget {
  final SaleOrderDataModel pastOrder;
  // final AllSalesController allSalesCtrlObj;
  final int index;
  ReceiptsTile({Key? key, required this.pastOrder, required this.index})
      : super(key: key);

  @override
  State<ReceiptsTile> createState() => _ReceiptsTileState();
}

class _ReceiptsTileState extends State<ReceiptsTile> {
  bool valuefirst = false;
  OrderController orderCtrlObj = Get.find<OrderController>();

  @override
  void initState() {
    // TODO: implement initState
    //Get.find<ReceiptsController>().singleOrderData = ;
    orderCtrlObj.singleOrderData = widget.pastOrder;
    print('::::::::::');
    print(widget.index);
    print('::::::::::');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      //  height: 100,
      decoration: BoxDecoration(
        border: Border.symmetric(
            horizontal: BorderSide(color: Colors.white, width: 5)),
      ),
      child: Row(
        children: [
          RotatedBox(
            quarterTurns: -1,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              height: 35,
              //width: 110,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // if (viewStocksModel?.transactionDate != null)
                  Text(
                    paymentStatusValues.reverse?[widget.pastOrder.paymentStatus]
                            ?.toLowerCase()
                            .tr ??
                        '-',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontSize: 11.7,
                        fontWeight: FontWeight.bold,
                        color: Colors.black
                        // viewStocksModel?.transactionDate !=
                        //         null
                        //     ? Colors.white
                        //     : Colors.black,
                        ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      orderInfoRow(
                        context,
                        text1: '${widget.pastOrder.invoiceNo ?? ''}',
                        text1Style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(fontSize: 14),
                      ),
                      //   (widget.pastOrder.isSuspend)
                      // ? isItCooked(index)
                      //  ?
                      OrderSelectionBox(
                          index: widget.index, order: widget.pastOrder)
                      // : SizedBox(),
                      // Container(
                      //   height: 20,
                      //   width: 20,
                      //   child: Checkbox(
                      //     value: valuefirst,
                      //     onChanged: (bool? value) {
                      //       setState(() {
                      //         valuefirst = value!;
                      //       });
                      //     },
                      //   ),
                      // ),
                    ],
                  ),
                  Row(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomerInfo('${widget.pastOrder.contact?.name}',
                              widget.pastOrder.transactionDate),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      orderInfoRow(
                        context,
                        text1: 'Doc No.: ',
                        text1Style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(fontSize: 14),
                        text2: '${widget.pastOrder.document ?? '- -'}',
                        text2Style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(
                              color: orangeColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              letterSpacing: 0.06,
                            ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //   orderInfoRow(
                      //     context,
                      //     text1: 'Type: ',
                      //     text1Style: Theme.of(context)
                      //         .textTheme
                      //         .headlineMedium!
                      //         .copyWith(fontSize: 12),
                      //     text2:
                      //         '${widget.allSalesCtrlObj.allSaleOrders?.saleOrdersData[widget.index].type}',
                      //     text2Style: Theme.of(context)
                      //         .textTheme
                      //         .headlineMedium!
                      //         .copyWith(
                      //           color: Color(0xffffa025),
                      //           fontWeight: FontWeight.bold,
                      //           fontSize: 12,
                      //           letterSpacing: 0.06,
                      //         ),
                      //   ),
                      //AppConst.dividerLine(height: 12, width: 1),
                      AmountInfo(
                        amount: '${widget.pastOrder.finalTotal ?? '- -'}',
                        status: 'Amount',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget orderInfoRow(BuildContext context,
      {String? text1,
      TextStyle? text1Style,
      Widget? text1Overwrite,
      String? text2,
      TextStyle? text2Style,
      Widget? text2Overwrite,
      MainAxisAlignment mainAxisAlignment = MainAxisAlignment.spaceBetween}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.5),
      child: Row(
        mainAxisAlignment: mainAxisAlignment,
        children: [
          text1Overwrite ??
              Text(
                text1 ?? '',
                style: text1Style ??
                    Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
              ),
          text2Overwrite ??
              Text(
                (text2 != null && text2.isNotEmpty) ? text2.capitalize! : '',
                style: text2Style ??
                    Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
              ),
        ],
      ),
    );
  }
}

class OrderSelectionBox extends StatefulWidget {
  final int? index;
  final bool isHeading;
  final SaleOrderDataModel order;
  //final SellLine? sellLine;
  const OrderSelectionBox(
      {required this.order,
      // this.sellLine,
      this.index,
      this.isHeading = false,
      Key? key})
      : super(key: key);

  @override
  State<OrderSelectionBox> createState() => _OrderSelectionBoxState();
}

class _OrderSelectionBoxState extends State<OrderSelectionBox> {
  @override
  Widget build(BuildContext context) {
    // print(widget.index);
    return Checkbox(
      value: widget.order.isSelected,
      //widget.order.isSuspend ?
      // : widget.order.sellLines.every((element) => element.isSelected),
      onChanged: (_) {
        if (widget.isHeading)
          setState(() {
            Get.find<OrderController>().markUnMarkAllOrder(/*order.sellLines*/);
          });
        else
          setState(() {
            Get.find<ReceiptsController>()
                .markUnMarkOrder(widget.order, index: widget.index);
          });
      },
    );
  }
}
