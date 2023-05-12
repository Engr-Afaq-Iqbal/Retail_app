import 'package:bizmodo_emenu/Components/custom_circular_button.dart';
import 'package:bizmodo_emenu/Config/DateTimeFormat.dart';
import 'package:bizmodo_emenu/Pages/Receipts/receiptsTile.dart';
import 'package:bizmodo_emenu/Pages/Return/returnTile.dart';
import '../../../Pages/Stocks/ViewStockTransfer/viewStockTransferTile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Config/utils.dart';
import '../../../Controllers/StockTransferController/stockTransferController.dart';
import '../../../Theme/colors.dart';
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
        // floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        // floatingActionButton: FloatingActionButton.small(
        //     child: Icon(Icons.add),
        //     backgroundColor: primaryColor.withOpacity(0.5),
        //     onPressed: () {
        //       showModalBottomSheet(
        //         isScrollControlled: true,
        //         context: context,
        //         builder: (context) {
        //           return Container(
        //             child: AddSaleReturn(),
        //           );
        //         },
        //       );
        //     }),
        body: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.8,
              child: ListView.builder(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.only(bottom: 100),
                  itemCount: 7,
                  itemBuilder: (context, index) {
                    return IntrinsicHeight(
                      child: ReturnTile(),
                    );
                  }),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Total (AED) = 0.00',
                  style: Theme.of(context).textTheme.headline6!.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                ),
                CustomButton(
                  onTap: () {},
                  title: Text(
                    'RETURN',
                    style: TextStyle(color: kWhiteColor),
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
