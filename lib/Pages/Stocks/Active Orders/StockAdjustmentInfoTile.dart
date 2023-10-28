import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/Config/const.dart';
import '/Config/enums.dart';
import '/Models/order_type_model/SaleOrderModel.dart';
import '/Pages/Orders/Components/AmountInfo.dart';
import '/Pages/Orders/Components/CustomerInfo.dart';
import '/Pages/Orders/Components/StaffInfo.dart';
import '/Pages/Orders/Components/TableInfo.dart';
import '/Theme/style.dart';

class StockAdjustmentInfoTile extends StatelessWidget {
  final SaleOrderDataModel pastOrder;
  const StockAdjustmentInfoTile(this.pastOrder, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
     // onTap: () => Get.to(() => OrderDetailsPage(pastOrder)),
      child: Container(
        decoration: BoxDecoration(
          border: Border.symmetric(
              horizontal: BorderSide(color: Colors.white, width: 5)),
        ),
        padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  pastOrder.invoiceNo ?? '',
                  style: Theme.of(context).textTheme.caption!.copyWith(
                      fontWeight: FontWeight.bold, color: Colors.black),
                ),
                Row(
                  children: [
                    Text(
                      orderStatusValues
                              .reverse?[pastOrder.resOrderStatus]?.capitalize ??
                          '-',
                    ),
                    SizedBox(width: 5),
                    Container(height: 12, width: 1, color: Colors.black),
                    SizedBox(width: 5),
                    Text(
                      paymentStatusValues.reverse?[pastOrder.paymentStatus]
                              ?.toLowerCase()
                              .tr ??
                          '-',
                      style: AppStyles.orderMapAppBarTextStyle.copyWith(
                          color: pastOrder.paymentStatusColorValue != null
                              ? Color(pastOrder.paymentStatusColorValue!)
                              : null),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomerInfo(
                    pastOrder.contact?.name, pastOrder.transactionDate),
                if (pastOrder.totalAmountRecovered != null)
                  AmountInfo(
                    amount: pastOrder.totalAmountRecovered,
                    status: pastOrder.preferPaymentMethod,
                  ),
              ],
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        pastOrder.typesOfService?.name?.tr ?? '',
                        style: Theme.of(context)
                            .textTheme
                            .headline6!
                            .copyWith(fontSize: 12, color: Colors.black),
                      ),
                      AppConst.dividerLine(height: 12, width: 1),
                      TableInfo(pastOrder.tableData?.name),
                      AppConst.dividerLine(height: 12, width: 1),
                      StaffInfo(
                        (pastOrder.serviceStaff?.firstName ?? '') +
                            ' ' +
                            (pastOrder.serviceStaff?.lastName ?? ''),
                      ),
                    ],
                  ),
                ),
                if (pastOrder.finalTotal != null)
                  AmountInfo(
                    amount: (double.parse('${pastOrder.finalTotal ?? 0}') -
                            double.parse(
                                '${pastOrder.totalAmountRecovered ?? 0}'))
                        .toString(),
                    status: 'due'.tr,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
