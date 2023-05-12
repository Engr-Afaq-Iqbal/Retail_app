import 'package:bizmodo_emenu/Config/DateTimeFormat.dart';
import '../../../Pages/Stocks/ViewStockTransfer/viewStockTransferTile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Config/utils.dart';
import '../../../Controllers/StockTransferController/stockTransferController.dart';
import '../../../Theme/colors.dart';
import '../Stocks/ViewStockTransfer/createStockTransfer.dart';
import 'VIewCustomerVisit/viewCustomerVisit.dart';
import 'createCustomerVisit.dart';
import 'customerVisitTile.dart';

class CustomerVisits extends StatefulWidget {
  const CustomerVisits({Key? key}) : super(key: key);

  @override
  State<CustomerVisits> createState() => _CustomerVisitsState();
}

class _CustomerVisitsState extends State<CustomerVisits> {
  StockTransferController stockTranCtrlObj =
      Get.find<StockTransferController>();

  @override
  void initState() {
    // TODO: implement initState
    stockTranCtrlObj.fetchStockTransfersList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Customer Visits'),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton.small(
            child: Icon(Icons.add),
            backgroundColor: primaryColor.withOpacity(0.5),
            onPressed: () {
              showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (context) {
                  return GetBuilder<StockTransferController>(
                      builder: (StockTransferController stockTransferCtrlObj) {
                    return Container(
                      child: CreateCustomerVisits(),
                    );
                  });
                },
              );
            }),
        body: GetBuilder<StockTransferController>(
            builder: (StockTransferController stockTransferCtrlObj) {
          return (stockTransferCtrlObj.viewStockTransferMoodel?.data == null)
              ? progressIndicator()
              : ListView.builder(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.only(bottom: 100),
                  itemCount: stockTransferCtrlObj
                          .viewStockTransferMoodel?.data.length ??
                      0,
                  itemBuilder: (context, index) {
                    return IntrinsicHeight(
                      child: GestureDetector(
                          onTap: () {
                            Get.to(ViewCustomerVisit());
                            // showModalBottomSheet(
                            //   isScrollControlled: true,
                            //   context: context,
                            //   builder: (context) {
                            //     return GetBuilder<StockTransferController>(
                            //         builder: (StockTransferController
                            //             stockTransferCtrlObj) {
                            //       return Container(
                            //         child: ViewCustomerVisit(),
                            //       );
                            //     });
                            //   },
                            // );
                          },
                          child: CustomerVisitTile()),
                    );
                  });
        }));
  }
}
