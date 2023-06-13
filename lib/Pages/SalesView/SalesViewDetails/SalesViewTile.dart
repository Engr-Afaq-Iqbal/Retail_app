import 'package:bizmodo_emenu/Config/DateTimeFormat.dart';
import 'package:bizmodo_emenu/Controllers/AllSalesController/allSalesController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Config/enums.dart';
import '../../../Models/order_type_model/SaleOrderModel.dart';
import '../../../Theme/colors.dart';
import '/Config/const.dart';
import '/Pages/Orders/Components/AmountInfo.dart';
import '/Pages/Orders/Components/CustomerInfo.dart';
import '/Theme/style.dart';

class SalesViewTile extends StatelessWidget {
  AllSalesController allSalesCtrlObj;
  final SaleOrderDataModel pastOrder;
  int index;
  SalesViewTile(
      {Key? key,
      required this.allSalesCtrlObj,
      required this.index,
      required this.pastOrder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
                '${allSalesCtrlObj.allSaleOrders?.saleOrdersData[index].invoiceNo}',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(fontWeight: FontWeight.bold, color: Colors.black),
              ),
              Row(
                children: [
                  AmountInfo(
                    amount: '${pastOrder.finalTotal ?? '0.00'}',
                    status: 'Amount',
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
                  '${pastOrder.contact?.name}', pastOrder.transactionDate),
              //if (pastOrder.totalAmountRecovered != null)
              AmountInfo(
                amount: '${pastOrder.totalPaid ?? '0.00'}',
                status: 'Paid',
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
                      '', //Mohammad Al Tamimi
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(fontSize: 12, color: Colors.black),
                    ),
                    //AppConst.dividerLine(height: 12, width: 1),
                    // Text(
                    //   'Items: ${pastOrder.}',
                    //   style: Theme.of(context)
                    //       .textTheme
                    //       .titleLarge!
                    //       .copyWith(fontSize: 12, color: Colors.black),
                    // ),
                    //  TableInfo(pastOrder.tableData?.name),
                    // AppConst.dividerLine(height: 12, width: 1),
                    // StaffInfo(
                    //   (pastOrder.serviceStaff?.firstName ?? '') +
                    //       ' ' +
                    //       (pastOrder.serviceStaff?.lastName ?? ''),
                    // ),
                  ],
                ),
              ),
              // if (pastOrder.finalTotal != null)
              AmountInfo(
                amount: (double.parse(
                        '${double.parse('${pastOrder.finalTotal ?? '0.00'}') - double.parse('${pastOrder.totalPaid ?? '0.00'}')}'))
                    .toString(),
                status: 'due'.tr,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
