import 'package:bizmodo_emenu/Pages/Return/returnTile.dart';
import 'package:bizmodo_emenu/Pages/Return/saleReturn.dart';
import 'package:bizmodo_emenu/Pages/Return/searchSalesReturn.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Config/utils.dart';

import '../../../Theme/colors.dart';
import '../../Controllers/SalesReturnController/saleReturnController.dart';

class Return extends StatefulWidget {
  const Return({Key? key}) : super(key: key);

  @override
  State<Return> createState() => _ReturnState();
}

class _ReturnState extends State<Return> {
  SaleReturnController saleReturnCtrlObj = Get.find<SaleReturnController>();
  @override
  void initState() {
    // TODO: implement initState
    saleReturnCtrlObj.fetchSalesReturnList();
    super.initState();
  }

  bool valuefirst = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Return'),
          actions: [
            Icon(
              Icons.calendar_month_outlined,
              color: primaryColor,
            ),
            SizedBox(
              width: 10,
            ),
          ],
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
        body: GetBuilder<SaleReturnController>(
            builder: (SaleReturnController saleReturnCtrl) {
          if (saleReturnCtrl.saleReturnListModel != null) {
            return RefreshIndicator(
              onRefresh: () async {
                await saleReturnCtrl.fetchSalesReturnList();
              },
              child: ListView.builder(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.only(bottom: 100),
                  itemCount: saleReturnCtrl.saleReturnListModel?.data?.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Get.to(SalesReturn(
                            saleReturnCtrl: saleReturnCtrl, index: index));
                      },
                      child: IntrinsicHeight(
                        child: ReturnTile(
                          saleReturnCtrlObj: saleReturnCtrl,
                          index: index,
                        ),
                      ),
                    );
                  }),
            );
          } else
            return progressIndicator();
        }));
  }
}
