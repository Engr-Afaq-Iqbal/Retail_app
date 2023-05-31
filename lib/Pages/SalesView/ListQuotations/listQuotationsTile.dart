import 'package:flutter/material.dart';

import '../../../Models/QuotationModel/listQuotationModel.dart';
import '/Config/const.dart';
import '/Pages/Orders/Components/CustomerInfo.dart';

class ListQuotationTile extends StatelessWidget {
  final ListQuotationModel? listQuotModel;
  final int index;
  ListQuotationTile({Key? key, this.listQuotModel, required this.index})
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
                '${listQuotModel?.data?[index].invoiceNo ?? ''}',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(fontWeight: FontWeight.bold, color: Colors.black),
              ),
              // Row(
              //   children: [
              //     Container(height: 12, width: 1, color: Colors.black),
              //     SizedBox(width: 5),
              //     Text(
              //       'Due'.capitalizeFirst ?? '-',
              //       style: AppStyles.orderMapAppBarTextStyle
              //           .copyWith(color: orangeColor),
              //     ),
              //   ],
              // )
            ],
          ),
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomerInfo('${listQuotModel?.data?[index].name ?? ''}',
                  listQuotModel?.data?[index].transactionDate),
              //if (pastOrder.totalAmountRecovered != null)
              // AmountInfo(
              //   amount: '122',
              //   status: 'Received',
              // ),
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
                      '${listQuotModel?.data?[index].addedBy ?? ''}',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(fontSize: 12, color: Colors.black),
                    ),
                    AppConst.dividerLine(height: 12, width: 1),
                    Text(
                      'Items: '
                      ''
                      '${listQuotModel?.data?[index].totalItems ?? ''}',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(fontSize: 12, color: Colors.black),
                    ),
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
              // AmountInfo(
              //   amount:
              //       (double.parse('${0}') - double.parse('${0}')).toString(),
              //   status: 'due'.tr,
              // ),
            ],
          ),
        ],
      ),
    );
  }
}
