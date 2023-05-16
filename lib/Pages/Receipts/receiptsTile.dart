import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Config/DateTimeFormat.dart';
import '../../../Controllers/StockTransferController/stockTransferController.dart';
import '../../../Theme/colors.dart';
import '../../Config/const.dart';
import '../Orders/Components/AmountInfo.dart';
import '../Orders/Components/CustomerInfo.dart';

class ReceiptsTile extends StatefulWidget {
  ReceiptsTile({
    Key? key,
  }) : super(key: key);

  @override
  State<ReceiptsTile> createState() => _ReceiptsTileState();
}

class _ReceiptsTileState extends State<ReceiptsTile> {
  bool valuefirst = false;
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
                    'Paid',
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
                        text1: 'INV88789',
                        text1Style: Theme.of(context)
                            .textTheme
                            .headline4!
                            .copyWith(fontSize: 14),
                      ),
                      Container(
                        height: 20,
                        width: 20,
                        child: Checkbox(
                          value: valuefirst,
                          onChanged: (bool? value) {
                            setState(() {
                              valuefirst = value!;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomerInfo('Walkin', DateTime.now()),
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
                            .headline4!
                            .copyWith(fontSize: 14),
                        text2: '1122235665432345',
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
                  Row(
                    // mainAxisAlignment:
                    //     MainAxisAlignment.spaceBetween,
                    children: [
                      orderInfoRow(
                        context,
                        text1: 'Type: ',
                        text1Style: Theme.of(context)
                            .textTheme
                            .headline4!
                            .copyWith(fontSize: 12),
                        text2: 'INV',
                        text2Style:
                            Theme.of(context).textTheme.headline4!.copyWith(
                                  color: Color(0xffffa025),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  letterSpacing: 0.06,
                                ),
                      ),
                      AppConst.dividerLine(height: 12, width: 1),
                      AmountInfo(
                        amount: '543',
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
