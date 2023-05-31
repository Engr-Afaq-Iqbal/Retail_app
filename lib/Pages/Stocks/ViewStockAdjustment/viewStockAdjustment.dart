import '../../../Pages/Stocks/ViewStockAdjustment/viewStockAdjustmentTile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Config/utils.dart';
import '../../../Controllers/StockTransferController/stockTransferController.dart';

import 'createStockAdjustment.dart';

class ViewStockAdjustment extends StatefulWidget {
  const ViewStockAdjustment({Key? key}) : super(key: key);

  @override
  State<ViewStockAdjustment> createState() => _ViewStockAdjustmentState();
}

class _ViewStockAdjustmentState extends State<ViewStockAdjustment> {
  StockTransferController stockAdjustmentCtrlObj =
      Get.find<StockTransferController>();

  @override
  void initState() {
    // TODO: implement initState
    stockAdjustmentCtrlObj.fetchStockAdjustmentList();
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
            backgroundColor:
                Theme.of(context).colorScheme.primary.withOpacity(0.5),
            onPressed: () {
              Get.to(CreateStockAdjustment());
            }),
        body: GetBuilder<StockTransferController>(
            builder: (StockTransferController stockAdjustmentCtrlObj) {
          if (stockAdjustmentCtrlObj.viewStockAdjustmentModel != null) {
            return RefreshIndicator(
              onRefresh: () async {
                await stockAdjustmentCtrlObj.fetchStockAdjustmentList();
              },
              child: ListView.builder(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.only(bottom: 100),
                  itemCount: stockAdjustmentCtrlObj
                          .viewStockAdjustmentModel?.data.length ??
                      0,
                  itemBuilder: (context, index) {
                    return IntrinsicHeight(
                      child: ViwStockAdjustmentTile(
                        index: index,
                        stockAdjustmentCtrlObj: stockAdjustmentCtrlObj,
                      ),
                    );
                  }),
            );
          } else
            return progressIndicator();
        }));
  }
}
