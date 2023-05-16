import 'package:bizmodo_emenu/Config/DateTimeFormat.dart';
import '../../../Pages/Stocks/ViewStockTransfer/viewStockTransferTile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Config/utils.dart';
import '../../../Controllers/StockTransferController/stockTransferController.dart';
import '../../../Theme/colors.dart';
import '../../Controllers/CustomerVisits/CustomerVisitsController.dart';
import '../Stocks/ViewStockTransfer/createStockTransfer.dart';
import 'VIewCustomerVisit/viewCustomerVisit.dart';
import 'createCustomerVisit.dart';
import 'customerVisitTile.dart';

class CustomerVisits extends StatefulWidget {
  const CustomerVisits({Key? key}) : super(key: key);

  @override
  State<CustomerVisits> createState() => _CustomerVisitsState();
}

class _CustomerVisitsState extends State<CustomerVisits> {
  CustomerVisitsController customerVisitController =
      Get.find<CustomerVisitsController>();

  @override
  void initState() {
    // TODO: implement initState
    customerVisitController.fetchCustomerVisitsList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Customer Visits'),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton.small(
            child: Icon(Icons.add),
            backgroundColor: primaryColor.withOpacity(0.5),
            onPressed: () {
              showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (context) {
                  return GetBuilder<CustomerVisitsController>(
                      builder: (CustomerVisitsController stockTransferCtrlObj) {
                    return Container(
                      child: CreateCustomerVisits(),
                    );
                  });
                },
              );
            }),
        body: GetBuilder<CustomerVisitsController>(
            builder: (CustomerVisitsController customerVisitsCtrlObj) {
          if (customerVisitsCtrlObj.customerVisitsListModel != null) {
            return RefreshIndicator(
              onRefresh: () async {
                await customerVisitsCtrlObj.fetchCustomerVisitsList();
              },
              child: ListView.builder(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.only(bottom: 100),
                  itemCount: customerVisitsCtrlObj
                          .customerVisitsListModel?.data.length ??
                      0,
                  itemBuilder: (context, index) {
                    return IntrinsicHeight(
                      child: GestureDetector(
                          onTap: () {
                            Get.to(ViewCustomerVisit());
                          },
                          child: CustomerVisitTile(
                            index: index,
                            customerVisitsCtrlObj: customerVisitsCtrlObj,
                          )),
                    );
                  }),
            );
          } else
            return progressIndicator();
        }));
  }
}
