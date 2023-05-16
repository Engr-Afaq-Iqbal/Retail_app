import 'package:bizmodo_emenu/Components/custom_circular_button.dart';
import 'package:bizmodo_emenu/Config/DateTimeFormat.dart';
import 'package:bizmodo_emenu/Pages/Receipts/receiptsTile.dart';
import 'package:bizmodo_emenu/Pages/Return/returnTile.dart';
import 'package:bizmodo_emenu/Pages/Return/saleReturn.dart';
import 'package:bizmodo_emenu/Pages/Return/searchSalesReturn.dart';
import '../../../Pages/Stocks/ViewStockTransfer/viewStockTransferTile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Config/utils.dart';
import '../../../Controllers/StockTransferController/stockTransferController.dart';
import '../../../Theme/colors.dart';
import '../Tabs/View/packingCharges.dart';
import 'addSaleReturn.dart';

class Return extends StatefulWidget {
  const Return({Key? key}) : super(key: key);

  @override
  State<Return> createState() => _ReturnState();
}

class _ReturnState extends State<Return> {
  StockTransferController stockTranCtrlObj =
      Get.find<StockTransferController>();

  @override
  void initState() {
    // TODO: implement initState
    stockTranCtrlObj.fetchStockTransfersList();
    super.initState();
  }

  bool valuefirst = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Return'),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton.small(
            child: Icon(Icons.add),
            backgroundColor: primaryColor.withOpacity(0.5),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 0),
                  content: SearchSalesReturn(),
                ),
              );
            }),
        body: ListView.builder(
            physics: AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.only(bottom: 100),
            itemCount: 7,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Get.to(SalesReturn());
                },
                child: IntrinsicHeight(
                  child: ReturnTile(),
                ),
              );
            }));
  }
}
