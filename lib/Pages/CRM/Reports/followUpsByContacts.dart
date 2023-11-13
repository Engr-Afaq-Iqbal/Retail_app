import '../../../Controllers/CRMControllers/ReportsController/reportsController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Controllers/StockTransferController/stockTransferController.dart';
import 'followUpsByContactsTile.dart';
import 'followUpsByUserTile.dart';

class FollowUpsByContacts extends StatefulWidget {
  const FollowUpsByContacts({Key? key}) : super(key: key);

  @override
  State<FollowUpsByContacts> createState() => _FollowUpsByContactsState();
}

class _FollowUpsByContactsState extends State<FollowUpsByContacts> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GetBuilder<ReportsController>(
            builder: (ReportsController reportsCtrl) {

              return RefreshIndicator(
                onRefresh: () async {
                  // await stockTranCtrlObj.fetchStockTransfersList();
                },
                child: ListView.builder(
                    physics: AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.only(bottom: 100),
                    itemCount: 2,
                    itemBuilder: (context, index) {
                      return IntrinsicHeight(
                        child: FollowUpsByContactsTile(),
                      );
                    }),
              );

            }));
  }
}
