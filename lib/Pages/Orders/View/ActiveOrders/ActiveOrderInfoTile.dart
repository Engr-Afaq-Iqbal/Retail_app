import 'package:bizmodo_emenu/Config/DateTimeFormat.dart';
import 'package:bizmodo_emenu/Pages/Orders/Components/PaymentStatusInfo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/Config/const.dart';
import '/Config/enums.dart';
import '/Models/order_type_model/SaleOrderModel.dart';
import '/Pages/Orders/Components/CustomerInfo.dart';
import '/Pages/Orders/Components/StaffInfo.dart';
import '/Pages/Orders/Components/TableInfo.dart';
import '/Pages/Orders/View/OrderDetails/OrderDetailsPage.dart';
import '/Theme/colors.dart';

class ActiveOrderInfoTile extends StatelessWidget {
  final SaleOrderDataModel activeOrder;
  const ActiveOrderInfoTile(this.activeOrder, {Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() => OrderDetailsPage(activeOrder, isActiveOrder: true));
      },
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
                  color: activeOrder.typesOfService?.colorValue != null
                      ? Color(activeOrder.typesOfService!.colorValue!)
                      : primaryColor.withOpacity(0.1),
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
                      activeOrder.typesOfService?.name?.tr ?? '',
                      // 'delivery'.tr,
                      style: Theme.of(context).textTheme.caption!.copyWith(
                            fontSize: 11.7,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                    ),
                    if (activeOrder.createdAt != null)
                      Text(
                        AppFormat.hhmmDifference(activeOrder.createdAt),
                        style: Theme.of(context).textTheme.caption!.copyWith(
                              fontSize: 11.7,
                              fontWeight: FontWeight.bold,
                              color: activeOrder.typesOfService != null
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
                            text1: activeOrder.invoiceNo,
                            text1Style: Theme.of(context)
                                .textTheme
                                .headline4!
                                .copyWith(fontSize: 14),
                            text2: statusValues
                                .reverse?[activeOrder.resOrderStatus],
                            text2Style:
                                Theme.of(context).textTheme.headline4!.copyWith(
                                      color: Color(0xffffa025),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 11.7,
                                      letterSpacing: 0.06,
                                    ),
                          ),
                          orderInfoRow(
                            context,
                            text1Overwrite: CustomerInfo(
                              activeOrder.contact?.name,
                              activeOrder.transactionDate,
                            ),
                            text2Overwrite: PaymentStatusInfo(
                              AppFormat.doubleToStringUpTo2(
                                  activeOrder.finalTotal),
                              paymentStatusValues
                                  .reverse?[activeOrder.paymentStatus]
                                  ?.toLowerCase()
                                  .tr,
                              statusColor: activeOrder
                                          .paymentStatusColorValue !=
                                      null
                                  ? Color(activeOrder.paymentStatusColorValue!)
                                  : null,
                            ),
                          ),
                          Row(children: [
                            TableInfo(activeOrder.tableData?.name),
                            AppConst.dividerLine(height: 12, width: 1),
                            StaffInfo(
                              (activeOrder.serviceStaff?.firstName ?? '') +
                                  ' ' +
                                  (activeOrder.serviceStaff?.lastName ?? ''),
                            ),
                          ]),
                        ],
                      ),
                    ),
                    Divider(color: Theme.of(context).cardColor, thickness: 1.0),
                    if (activeOrder.sellLines.isNotEmpty)
                      ...List.generate(
                        activeOrder.sellLines.length > 2
                            ? 2
                            : activeOrder.sellLines.length,
                        (index) => Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: orderInfoRow(
                            context,
                            mainAxisAlignment: MainAxisAlignment.start,
                            text1: ('${activeOrder.sellLines[index].product?.name ?? ' '}') +
                                (' (x${activeOrder.sellLines[index].quantity}) '),
                            text2: activeOrder
                                        .sellLines[index].variations?.name ==
                                    'Dummy'
                                ? activeOrder.sellLines[index].variations?.name
                                : '',
                          ),
                        ),
                      ),
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
