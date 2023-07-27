import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Models/order_type_model/SaleOrderModel.dart';
import '/Pages/Orders/Components/AmountInfo.dart';
import '/Pages/Orders/Components/CustomerInfo.dart';

class SalesViewTile extends StatelessWidget {
  final SaleOrderDataModel pastOrder;
  SalesViewTile({Key? key, required this.pastOrder}) : super(key: key);

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
                '${pastOrder.invoiceNo}',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(fontWeight: FontWeight.bold, color: Colors.black),
              ),
              Row(
                children: [
                  AmountInfo(
                    amount: '${pastOrder.finalTotal ?? '0.00'}',
                    status: 'amount'.tr,
                  ),
                  // SizedBox(
                  //   width: 5,
                  // ),
                  // GestureDetector(
                  //     onTap: () {
                  //       print('Past Order Data');
                  //       Get.find<AllProductsController>().salesOrderModel =
                  //           pastOrder;
                  //       Get.dialog(Dialog(
                  //         shape: RoundedRectangleBorder(
                  //             borderRadius: BorderRadius.circular(
                  //                 Dimensions.radiusSmall)),
                  //         insetPadding:
                  //             EdgeInsets.all(Dimensions.paddingSizeSmall),
                  //         child: InVoicePrintScreen(),
                  //       ));
                  //     },
                  //     child: Icon(
                  //       Icons.print_outlined,
                  //       color: Theme.of(context).colorScheme.primary,
                  //     )),
                  // SizedBox(
                  //   width: 5,
                  // ),
                  // GestureDetector(
                  //     onTap: () {
                  //       print('Past Order Data');
                  //       // Get.dialog(Dialog(
                  //       //   shape: RoundedRectangleBorder(
                  //       //       borderRadius: BorderRadius.circular(
                  //       //           Dimensions.radiusSmall)),
                  //       //   insetPadding:
                  //       //   EdgeInsets.all(Dimensions.paddingSizeSmall),
                  //       //   child: InVoicePrintScreen(),
                  //       // ));
                  //
                  //       Get.to(PrintData(
                  //         saleOrderDataModel: pastOrder,
                  //       ));
                  //     },
                  //     child: Icon(
                  //       Icons.picture_as_pdf_outlined,
                  //       color: Theme.of(context).colorScheme.primary,
                  //     )),
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
                status: 'paid'.tr,
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
