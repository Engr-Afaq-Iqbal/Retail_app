import '../../../Pages/Stocks/ViewStockTransfer/viewStockTransferTile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Config/utils.dart';
import '../../../Controllers/StockTransferController/stockTransferController.dart';
import '../../../Services/storage_services.dart';
import 'createStockTransfer.dart';

class ViewStockTransfer extends StatefulWidget {
  const ViewStockTransfer({Key? key}) : super(key: key);

  @override
  State<ViewStockTransfer> createState() => _ViewStockTransferState();
}

class _ViewStockTransferState extends State<ViewStockTransfer> {
  StockTransferController stockTranCtrlObj =
      Get.find<StockTransferController>();

  @override
  void initState() {
    // TODO: implement initState
    stockTranCtrlObj.fetchStatusList();
    stockTranCtrlObj.fetchStockTransfersList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton.small(
            child: Icon(Icons.add),
            backgroundColor:
                Theme.of(context).colorScheme.primary.withOpacity(0.5),
            onPressed: () {
              Get.to(CreateStockTransfer());
            }),
        body: GetBuilder<StockTransferController>(
            builder: (StockTransferController stockTransferCtrlObj) {
          if (stockTransferCtrlObj.viewStockTransferMoodel != null) {
            return RefreshIndicator(
              onRefresh: () async {
                await stockTranCtrlObj.fetchStockTransfersList();
              },
              child: ListView.builder(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.only(bottom: 100),
                  itemCount: stockTransferCtrlObj
                          .viewStockTransferMoodel?.data.length ??
                      0,
                  itemBuilder: (context, index) {
                    return (stockTransferCtrlObj.viewStockTransferMoodel
                                    ?.data[index].locationTo ==
                                AppStorage.getBusinessDetailsData()
                                    ?.businessData
                                    ?.locations
                                    .first
                                    .name ||
                            stockTransferCtrlObj.viewStockTransferMoodel
                                    ?.data[index].locationFrom ==
                                AppStorage.getBusinessDetailsData()
                                    ?.businessData
                                    ?.locations
                                    .first
                                    .name)
                        ? IntrinsicHeight(
                            child: ViwStockTile(
                              stockTransferData: stockTransferCtrlObj
                                  .viewStockTransferMoodel?.data[index],
                            ),
                          )
                        : SizedBox();
                  }),
            );
          } else
            return progressIndicator();
        }));
  }
}
