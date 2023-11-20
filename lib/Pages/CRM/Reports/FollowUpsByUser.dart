import '../../../Controllers/CRMControllers/ReportsController/reportsController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'followUpsByUserTile.dart';

class FollowUpsByUser extends StatefulWidget {
  const FollowUpsByUser({Key? key}) : super(key: key);

  @override
  State<FollowUpsByUser> createState() => _FollowUpsByUserState();
}

class _FollowUpsByUserState extends State<FollowUpsByUser> {

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
                          child: FollowUpsByUserTile(),
                        );
                      }),
                );

            }));
  }
}
