import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Config/DateTimeFormat.dart';
import '../../../Controllers/StockTransferController/stockTransferController.dart';
import '../../../Theme/colors.dart';

class ViwStockAdjustmentTile extends StatefulWidget {
  StockTransferController stockTransferCtrlObj;
  int index;
  ViwStockAdjustmentTile(
      {Key? key, required this.stockTransferCtrlObj, required this.index})
      : super(key: key);

  @override
  State<ViwStockAdjustmentTile> createState() => _ViwStockAdjustmentTileState();
}

class _ViwStockAdjustmentTileState extends State<ViwStockAdjustmentTile> {
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
              width: 140,
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
                    AppFormat.dateDDMMYY(widget.stockTransferCtrlObj
                                    .viewStockTransferMoodel !=
                                null
                            ? widget
                                .stockTransferCtrlObj
                                .viewStockTransferMoodel!
                                .data[widget.index]
                                .transactionDate
                            : DateTime.now()) ??
                        '',
                    style: Theme.of(context).textTheme.caption!.copyWith(
                        fontSize: 11.7,
                        fontWeight: FontWeight.bold,
                        color: Colors.black
                        // viewStocksModel?.transactionDate !=
                        //         null
                        //     ? Colors.white
                        //     : Colors.black,
                        ),
                  )
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
                        text1: widget
                                .stockTransferCtrlObj
                                .viewStockTransferMoodel
                                ?.data[widget.index]
                                .refNo ??
                            '',
                        text1Style: Theme.of(context)
                            .textTheme
                            .headline4!
                            .copyWith(fontSize: 14),
                      ),
                      orderInfoRow(
                        context,
                        text1: 'Normal',
                        text1Style: Theme.of(context)
                            .textTheme
                            .headline4!
                            .copyWith(fontSize: 14),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      orderInfoRow(
                        context,
                        text1: 'Location: ',
                        text1Style: Theme.of(context)
                            .textTheme
                            .headline4!
                            .copyWith(fontSize: 11.7),
                        text2: widget
                                .stockTransferCtrlObj
                                .viewStockTransferMoodel
                                ?.data[widget.index]
                                .locationFrom ??
                            '',
                        text2Style:
                            Theme.of(context).textTheme.headline4!.copyWith(
                                  color: Color(0xffffa025),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11.7,
                                  letterSpacing: 0.06,
                                ),
                      ),
                      Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          height: 12,
                          width: 1,
                          color: Colors.black),
                    ],
                  ),

                  //  if (viewStocksModel?.additionalNotes)
                  Row(
                    // mainAxisAlignment:
                    //     MainAxisAlignment.spaceBetween,
                    children: [
                      orderInfoRow(
                        context,
                        text1: 'Total Amount: ',
                        text1Style: Theme.of(context)
                            .textTheme
                            .headline4!
                            .copyWith(fontSize: 12),
                        text2: AppFormat.doubleToStringUpTo2(widget
                                .stockTransferCtrlObj
                                .viewStockTransferMoodel
                                ?.data[widget.index]
                                .shippingCharges) ??
                            '',
                        text2Style:
                            Theme.of(context).textTheme.headline4!.copyWith(
                                  color: Color(0xffffa025),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  letterSpacing: 0.06,
                                ),
                      ),
                      Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          height: 12,
                          width: 1,
                          color: Colors.black),
                      orderInfoRow(
                        context,
                        text1: 'Total amount received: ',
                        text1Style: Theme.of(context)
                            .textTheme
                            .headline4!
                            .copyWith(fontSize: 12),
                        text2: AppFormat.doubleToStringUpTo2(widget
                                .stockTransferCtrlObj
                                .viewStockTransferMoodel
                                ?.data[widget.index]
                                .finalTotal) ??
                            '',
                        text2Style:
                            Theme.of(context).textTheme.headline4!.copyWith(
                                  color: Color(0xffffa025),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  letterSpacing: 0.06,
                                ),
                      ),
                    ],
                  ),
                  Divider(color: Theme.of(context).cardColor, thickness: 1.0),
                  Text(
                    'Reason: ${widget.stockTransferCtrlObj.viewStockTransferMoodel?.data[widget.index].additionalNotes ?? '- -'}',
                    style: Theme.of(context)
                        .textTheme
                        .headline4!
                        .copyWith(fontSize: 12),
                  )
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
