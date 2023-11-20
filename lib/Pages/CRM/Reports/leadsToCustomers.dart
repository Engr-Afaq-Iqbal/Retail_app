import '../../../Controllers/CRMControllers/ReportsController/reportsController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'leadsToCustomersTile.dart';

class LeadsToCustomers extends StatefulWidget {
  const LeadsToCustomers({Key? key}) : super(key: key);

  @override
  State<LeadsToCustomers> createState() => _LeadsToCustomersState();
}

class _LeadsToCustomersState extends State<LeadsToCustomers> {

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
                        child: LeadsToCustomersTile(),
                      );
                    }),
              );

            }));
  }
}
