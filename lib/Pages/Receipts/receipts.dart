import 'package:bizmodo_emenu/Components/custom_circular_button.dart';

import 'package:bizmodo_emenu/Pages/Receipts/receiptsTile.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Controllers/StockTransferController/stockTransferController.dart';
import '../../../Theme/colors.dart';
import '../../Controllers/AllSalesController/allSalesController.dart';
import '../../Controllers/ContactController/ContactController.dart';
import '../../Theme/style.dart';

class Receipts extends StatefulWidget {
  const Receipts({Key? key}) : super(key: key);

  @override
  State<Receipts> createState() => _ReceiptsState();
}

class _ReceiptsState extends State<Receipts> {
  StockTransferController stockTranCtrlObj =
      Get.find<StockTransferController>();

  AllSalesController allSalesCtrl = Get.find<AllSalesController>();
  ContactController contactCtrlObjj = Get.find<ContactController>();

  @override
  void initState() {
    // TODO: implement initState
    allSalesCtrl.callFirstOrderPage();
    stockTranCtrlObj.fetchStockTransfersList();
    super.initState();
  }

  bool valuefirst = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Issue Receipts'),
          actions: [
            GestureDetector(
              onTap: () {},
              child: Icon(
                Icons.filter_alt_outlined,
                color: blackColor,
              ),
            ),
            SizedBox(
              width: 3,
            ),
            GestureDetector(
              onTap: () {},
              child: Icon(
                Icons.search_outlined,
                color: blackColor,
              ),
            ),
            Padding(
              // height: 20,
              // width: 20,
              padding: EdgeInsets.only(right: 5),
              child: Checkbox(
                value: valuefirst,
                onChanged: (bool? value) {
                  setState(() {
                    valuefirst = value!;
                  });
                },
              ),
            ),
          ],
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Customer Name:'),
                  Center(
                    child: Text(
                      '${contactCtrlObjj.nameCtrl.text} (${contactCtrlObjj.contactId})',
                      style: appBarHeaderStyle,
                    ),
                  ),
                ],
              ),
            ),
          ),
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
        //             child: CreateStockTransfer(),
        //           );
        //         },
        //       );
        //     }),
        body: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.73,
              child: ListView.builder(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.only(bottom: 100),
                  itemCount: 7,
                  itemBuilder: (context, index) {
                    return IntrinsicHeight(
                      child: ReceiptsTile(),
                    );
                  }),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Total (AED) = 0.00',
                  style: Theme.of(context).textTheme.headline6!.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomButton(
                      onTap: () {},
                      title: Text(
                        'CASH',
                        style: TextStyle(color: kWhiteColor),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    CustomButton(
                      onTap: () {},
                      title: Text(
                        'CHEQUE',
                        style: TextStyle(color: kWhiteColor),
                      ),
                    ),
                  ],
                ),
                CustomButton(
                  onTap: () {},
                  title: Text(
                    'SUBMIT',
                    style: TextStyle(color: kWhiteColor),
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
