import 'package:bizmodo_emenu/Config/DateTimeFormat.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Theme/colors.dart';
import '../../Config/const.dart';
import '../../Controllers/SalesReturnController/saleReturnController.dart';
import '../Orders/Components/AmountInfo.dart';
import '../Orders/Components/CustomerInfo.dart';

class ReturnTile extends StatefulWidget {
  SaleReturnController saleReturnCtrlObj;
  int index;
  ReturnTile({Key? key, required this.index, required this.saleReturnCtrlObj})
      : super(key: key);

  @override
  State<ReturnTile> createState() => _ReturnTileState();
}

class _ReturnTileState extends State<ReturnTile> {
  int quantity = 0;
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
                color: primaryColor.withOpacity(0.1),
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
                    widget.saleReturnCtrlObj.saleReturnListModel!
                        .data![widget.index].paymentStatus.capitalizeFirst!,
                    style: Theme.of(context).textTheme.caption!.copyWith(
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
                        text1:
                            'Invoice No.: ${widget.saleReturnCtrlObj.saleReturnListModel!.data![widget.index].invoiceNo}',
                        text1Style: Theme.of(context)
                            .textTheme
                            .headline4!
                            .copyWith(fontSize: 14),
                      ),
                      // CounterWithAddRemoveButton(
                      //   removeTabFun: () {
                      //     if (quantity > 0) {
                      //       setState(() {
                      //         quantity = quantity - 1;
                      //         print(quantity);
                      //       });
                      //       // prodCartCtrlObj.removeItemQuantity(product);
                      //     } else if (quantity == 1) {
                      //       //prodCartCtrlObj.deleteFromCart(product);
                      //     }
                      //   },
                      //   counter: '${quantity}',
                      //   addTabFun: () {
                      //     setState(() {
                      //       quantity = quantity + 1;
                      //       print(quantity);
                      //     });
                      //
                      //     // if (quantity != 0) {
                      //     //   // prodCartCtrlObj.addItemQuantity(product);
                      //     // }
                      //   },
                      // ),
                    ],
                  ),
                  Row(
                    children: [
                      orderInfoRow(
                        context,
                        text1:
                            'Parent Sale: ${widget.saleReturnCtrlObj.saleReturnListModel!.data![widget.index].parentSale}',
                        text1Style: Theme.of(context)
                            .textTheme
                            .headline4!
                            .copyWith(fontSize: 12),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomerInfo(
                          '${widget.saleReturnCtrlObj.saleReturnListModel!.data![widget.index].name}',
                          widget.saleReturnCtrlObj.saleReturnListModel!
                              .data![widget.index].transactionDate),
                      //if (pastOrder.totalAmountRecovered != null)
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    // mainAxisAlignment:
                    //     MainAxisAlignment.spaceBetween,
                    children: [
                      AmountInfo(
                        amount:
                            '${AppFormat.doubleToStringUpTo2(widget.saleReturnCtrlObj.saleReturnListModel!.data![widget.index].finalTotal)}',
                        status: 'Total Amount',
                      ),
                      AppConst.dividerLine(height: 12, width: 1),
                      AmountInfo(
                        amount:
                            '${AppFormat.doubleToStringUpTo2(widget.saleReturnCtrlObj.saleReturnListModel!.data![widget.index].due.toString())}',
                        status: 'due'.tr,
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
                    Theme.of(context).textTheme.headline6!.copyWith(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
              ),
          text2Overwrite ??
              Text(
                (text2 != null && text2.isNotEmpty) ? text2.capitalize! : '',
                style: text2Style ??
                    Theme.of(context).textTheme.headline6!.copyWith(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
              ),
        ],
      ),
    );
  }
}
