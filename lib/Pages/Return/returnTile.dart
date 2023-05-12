import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Config/DateTimeFormat.dart';
import '../../../Controllers/StockTransferController/stockTransferController.dart';
import '../../../Theme/colors.dart';
import '../../Components/counter_with_add_remove_button.dart';

class ReturnTile extends StatefulWidget {
  ReturnTile({
    Key? key,
  }) : super(key: key);

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
                    'Brand: ',
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
                  Text(
                    'Rita',
                    style: Theme.of(context).textTheme.caption!.copyWith(
                          fontSize: 11.7,
                          fontWeight: FontWeight.bold,
                          color: Color(0xffffa025),
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
                        text1: 'Rita Red - 240ML',
                        text1Style: Theme.of(context)
                            .textTheme
                            .headline4!
                            .copyWith(fontSize: 14),
                      ),
                      CounterWithAddRemoveButton(
                        removeTabFun: () {
                          if (quantity > 0) {
                            setState(() {
                              quantity = quantity - 1;
                              print(quantity);
                            });
                            // prodCartCtrlObj.removeItemQuantity(product);
                          } else if (quantity == 1) {
                            //prodCartCtrlObj.deleteFromCart(product);
                          }
                        },
                        counter: '${quantity}',
                        addTabFun: () {
                          setState(() {
                            quantity = quantity + 1;
                            print(quantity);
                          });

                          // if (quantity != 0) {
                          //   // prodCartCtrlObj.addItemQuantity(product);
                          // }
                        },
                      ),
                    ],
                  ),
                  Row(
                    // mainAxisAlignment:
                    //     MainAxisAlignment.spaceBetween,
                    children: [
                      orderInfoRow(
                        context,
                        text1: 'Unit: ',
                        text1Style: Theme.of(context)
                            .textTheme
                            .headline4!
                            .copyWith(fontSize: 12),
                        text2: 'PCS',
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
                  Row(
                    children: [
                      orderInfoRow(
                        context,
                        text1: 'Reason: ',
                        text1Style: Theme.of(context)
                            .textTheme
                            .headline4!
                            .copyWith(fontSize: 12),
                        text2: 'None',
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
