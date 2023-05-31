import 'package:bizmodo_emenu/Config/DateTimeFormat.dart';
import 'package:bizmodo_emenu/Models/ViewStockTransferModel/viewStockTransferModel.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StockTransfersInfoTile extends StatelessWidget {
  Datum? viewStocksModel;
  StockTransfersInfoTile(this.viewStocksModel, {Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    return InkWell(
      // onTap: () {
      //   Get.to(() => OrderDetailsPage(activeOrder, isActiveOrder: true));
      // },
      child: Container(
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
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      viewStocksModel?.refNo ?? '',
                      // 'delivery'.tr,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontSize: 11.7,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                    ),
                    if (viewStocksModel?.transactionDate != null)
                      Text(
                        AppFormat.hhmmDifference(
                            viewStocksModel?.transactionDate),
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              fontSize: 11.7,
                              fontWeight: FontWeight.bold,
                              color: viewStocksModel?.transactionDate != null
                                  ? Colors.white
                                  : Colors.black,
                            ),
                      )
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          orderInfoRow(
                            context,
                            text1: 'Location (From)',
                            text1Style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(fontSize: 14),
                            text2: 'Location (to)',
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
                          orderInfoRow(
                            context,
                            text1: '${viewStocksModel?.locationFrom}',
                            text2: '${viewStocksModel?.locationTo}',
                          ),
                          // Row(children: [
                          //   TableInfo(activeOrder.tableData?.name),
                          //   AppConst.dividerLine(height: 12, width: 1),
                          //   StaffInfo(
                          //     (activeOrder.serviceStaff?.firstName ?? '') +
                          //         ' ' +
                          //         (activeOrder.serviceStaff?.lastName ?? ''),
                          //   ),
                          // ]),
                        ],
                      ),
                    ),
                    Divider(color: Theme.of(context).cardColor, thickness: 1.0),
                    if (viewStocksModel?.additionalNotes)
                      Text(
                        '${viewStocksModel?.additionalNotes}',
                      )
                  ],
                ),
              ),
            ),
          ],
        ),
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
