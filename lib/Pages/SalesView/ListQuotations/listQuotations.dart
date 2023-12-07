import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/Pages/SalesView/ListQuotations/viewQuotationsPage.dart';
import '../../../Config/utils.dart';
import '../../../Controllers/AllSalesController/quotationController.dart';
import '../SalesViewDetails/AddSalesAndQuotation.dart';
import 'listQuotationsTile.dart';

class ListQuotations extends StatefulWidget {
  const ListQuotations({Key? key}) : super(key: key);

  @override
  State<ListQuotations> createState() => _ListQuotationsState();
}

class _ListQuotationsState extends State<ListQuotations> {
  QuotationController quotCtrlObj = Get.find<QuotationController>();
  @override
  void initState() {
    quotCtrlObj.fetchListQuotations();
    // TODO: implement initState
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
              Get.to(
                AddSalesAndQuotation(
                  isSale: true,
                ),
              );
            }),
        body: GetBuilder<QuotationController>(
            builder: (QuotationController quotCtrl) {
          return RefreshIndicator(
            onRefresh: () async {
              await quotCtrl.fetchListQuotations();
            },
            child: (quotCtrl.listQuotationModel == null)
                ? progressIndicator()
                : ListView.builder(
                    physics: AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.only(bottom: 100),
                    itemCount: quotCtrl.listQuotationModel?.data?.length ?? 0,
                    itemBuilder: (context, index) {
                      return IntrinsicHeight(
                        child: GestureDetector(
                            onTap: () {
                              Get.to(ViewQuotationPage(
                                id: quotCtrl.listQuotationModel?.data?[index].id
                                    .toString(),
                              ));
                            },
                            child: ListQuotationTile(
                                listQuotModel: quotCtrl.listQuotationModel,
                                index: index)),
                      );
                    }),
          );
        }));
  }
}
