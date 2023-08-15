import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Config/DateTimeFormat.dart';
import '../../../Controllers/StockTransferController/stockTransferController.dart';
import '../../../Models/ViewStockTransferModel/viewStockTransferModel.dart';
import '../../../Theme/colors.dart';
import 'changeStockTransferStatus.dart';

class ViwStockTile extends StatefulWidget {
  final StockTransferData? stockTransferData;
  ViwStockTile({
    Key? key,
    this.stockTransferData,
  }) : super(key: key);

  @override
  State<ViwStockTile> createState() => _ViwStockTileState();
}

class _ViwStockTileState extends State<ViwStockTile> {
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
          GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 0),
                  content: ChangeStockTransferStatus(
                      id: widget.stockTransferData?.id),
                ),
              );
            },
            child: RotatedBox(
              quarterTurns: -1,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                height: 35,
                width: 140,
                decoration: BoxDecoration(
                  color: (widget.stockTransferData?.status == 'final')
                      ? Colors.green
                      : (widget.stockTransferData?.status == 'pending')
                          ? Colors.red
                          : Colors.orange,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      (widget.stockTransferData?.status == 'final')
                          ? 'Completed'
                          : Get.find<StockTransferController>().checkStatusName(
                                  statusValue:
                                      widget.stockTransferData?.status) ??
                              '',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontSize: 11.7,
                            fontWeight: FontWeight.bold,
                            color: kWhiteColor,
                          ),
                    )
                  ],
                ),
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
                        text1: widget.stockTransferData?.refNo ?? '',
                        text1Style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(fontSize: 14),
                      ),
                    ],
                  ),

                  Row(
                    children: [
                      orderInfoRow(
                        context,
                        text1: 'from'.tr + ': ',
                        text1Style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(fontSize: 11.7),
                        text2: widget.stockTransferData?.locationFrom ?? '',
                        text2Style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(
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
                      orderInfoRow(
                        context,
                        text1: 'to'.tr + ': ',
                        text1Style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(fontSize: 11.7),
                        text2: widget.stockTransferData?.locationTo ?? '',
                        text2Style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(
                              color: Color(0xffffa025),
                              fontWeight: FontWeight.bold,
                              fontSize: 11.7,
                              letterSpacing: 0.06,
                            ),
                      ),
                    ],
                  ),

                  Row(
                    children: [
                      orderInfoRow(
                        context,
                        text1: 'date'.tr + ': ',
                        text1Style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(fontSize: 12),
                        text2: AppFormat.dateDDMMYY(
                            widget.stockTransferData?.transactionDate ??
                                DateTime.now()),
                        text2Style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(
                              color: Color(0xffffa025),
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              letterSpacing: 0.06,
                            ),
                      ),
                    ],
                  ),

                  //  if (viewStocksModel?.additionalNotes)
                  Row(
                    // mainAxisAlignment:
                    //     MainAxisAlignment.spaceBetween,
                    children: [
                      orderInfoRow(
                        context,
                        text1: 'shipping'.tr + ': ',
                        text1Style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(fontSize: 12),
                        text2: AppFormat.doubleToStringUpTo2(
                                widget.stockTransferData?.shippingCharges) ??
                            '',
                        text2Style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(
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
                        text1: 'final_amount'.tr + ': ',
                        text1Style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(fontSize: 12),
                        text2: AppFormat.doubleToStringUpTo2(
                                widget.stockTransferData?.finalTotal) ??
                            '',
                        text2Style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(
                              color: Color(0xffffa025),
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              letterSpacing: 0.06,
                            ),
                      ),
                    ],
                  ),
                  if (widget.stockTransferData?.additionalNotes != null)
                    Divider(color: Theme.of(context).cardColor, thickness: 1.0),
                  if (widget.stockTransferData?.additionalNotes != null)
                    Text(
                      'note'.tr +
                          ': ${widget.stockTransferData?.additionalNotes ?? '- -'}',
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
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
