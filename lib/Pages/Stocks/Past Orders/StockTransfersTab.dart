import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Config/DateTimeFormat.dart';
import '../../../Controllers/StockTransferController/stockTransferController.dart';
import '../../../Theme/colors.dart';
import '/Config/utils.dart';
import '/Pages/Orders/Controller/OrderController.dart';
import 'StockTransfersInfoTile.dart';

class StockTransfer extends StatefulWidget {
  @override
  State<StockTransfer> createState() => _StockTransferState();
}

class _StockTransferState extends State<StockTransfer> {
  ScrollController? _activeOrdersScrollCtrl;

  StockTransferController stockTransferController =
      Get.find<StockTransferController>();
  void initState() {
    stockTransferController.fetchStockTransfersList();
    // scrollControllerLis();
    super.initState();
  }

  // @override
  // void dispose() {
  //   _activeOrdersScrollCtrl?.removeListener(scrollControllerLis);
  //   super.dispose();
  // }

  // scrollControllerLis() {
  //   _activeOrdersScrollCtrl = ScrollController();
  //   if (_activeOrdersScrollCtrl != null) {
  //     _activeOrdersScrollCtrl?.addListener(() {
  //       double maxScroll = _activeOrdersScrollCtrl!.position.maxScrollExtent;
  //       double currentScroll = _activeOrdersScrollCtrl!.position.pixels;
  //       // double delta = MediaQuery.of(context).size.height * 0.75;
  //
  //       // if ((maxScroll - currentScroll) <= delta) _loadMore();
  //       if (maxScroll == currentScroll)
  //         Get.find<OrderController>().loadMoreSaleOrders();
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          ListView.builder(
            //controller: _activeOrdersScrollCtrl,
            physics: AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.only(bottom: 100),
            itemCount:
                stockTransferController.viewStockTransferMoodel?.data.length ??
                    0,
            itemBuilder: (context, index) {
              return Container(
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              stockTransferController.viewStockTransferMoodel
                                      ?.data[index].refNo ??
                                  '',
                              // 'delivery'.tr,
                              style:
                                  Theme.of(context).textTheme.caption!.copyWith(
                                        fontSize: 11.7,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                            ),
                            if (stockTransferController.viewStockTransferMoodel
                                    ?.data[index].transactionDate !=
                                null)
                              Text(
                                AppFormat.hhmmDifference(stockTransferController
                                    .viewStockTransferMoodel
                                    ?.data[index]
                                    .transactionDate),
                                style: Theme.of(context)
                                    .textTheme
                                    .caption!
                                    .copyWith(
                                      fontSize: 11.7,
                                      fontWeight: FontWeight.bold,
                                      color: stockTransferController
                                                  .viewStockTransferMoodel
                                                  ?.data[index]
                                                  .transactionDate !=
                                              null
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
                                        .headline4!
                                        .copyWith(fontSize: 14),
                                    text2: 'Location (to)',
                                    text2Style: Theme.of(context)
                                        .textTheme
                                        .headline4!
                                        .copyWith(
                                          color: Color(0xffffa025),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 11.7,
                                          letterSpacing: 0.06,
                                        ),
                                  ),
                                  orderInfoRow(
                                    context,
                                    text1:
                                        '${stockTransferController.viewStockTransferMoodel?.data[index].locationFrom}',
                                    text2:
                                        '${stockTransferController.viewStockTransferMoodel?.data[index].locationTo}',
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
                            Divider(
                                color: Theme.of(context).cardColor,
                                thickness: 1.0),
                            if (stockTransferController.viewStockTransferMoodel
                                ?.data[index].additionalNotes)
                              Text(
                                '${stockTransferController.viewStockTransferMoodel?.data[index].additionalNotes}',
                              )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );

              // StockTransfersInfoTile(
              //       stockTransferController
              //           .viewStockTransferMoodel!.data[index],
              //     );
              // return orderCtrlObj.allSaleOrders!
              //         .saleOrdersData[index].isSuspend
              //     ? StockTransfersInfoTile(
              //         orderCtrlObj
              //             .allSaleOrders!.saleOrdersData[index],
              //       )
              //     : const SizedBox();
            },
          )

          // Positioned(
          //   bottom: 5,
          //   left: 0,
          //   right: 0,
          //   child: GetX(builder: (OrderController orderCtrlObj) {
          //     return orderCtrlObj.isLoadMoreRunning.isTrue
          //         ? progressIndicator()
          //         : SizedBox();
          //   }),
          // ),
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
