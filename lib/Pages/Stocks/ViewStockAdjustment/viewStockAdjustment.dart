import 'package:bizmodo_emenu/Config/DateTimeFormat.dart';
import '../../../Pages/Stocks/ViewStockAdjustment/viewStockAdjustmentTile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Config/utils.dart';
import '../../../Controllers/StockTransferController/stockTransferController.dart';
import '../../../Theme/colors.dart';
import '../ViewStockTransfer/createStockTransfer.dart';
import 'createStockAdjustment.dart';

class ViewStockAdjustment extends StatefulWidget {
  const ViewStockAdjustment({Key? key}) : super(key: key);

  @override
  State<ViewStockAdjustment> createState() => _ViewStockAdjustmentState();
}

class _ViewStockAdjustmentState extends State<ViewStockAdjustment> {
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
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton.small(
            child: Icon(Icons.add),
            backgroundColor: primaryColor.withOpacity(0.5),
            onPressed: () {
              showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (context) {
                  return Container(
                    child: CreateStockAdjustment(),
                  );
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
                      child: ViwStockAdjustmentTile(
                        index: index,
                        stockTransferCtrlObj: stockTransferCtrlObj,
                      ),
                    );
                  });
        }));
  }
}
