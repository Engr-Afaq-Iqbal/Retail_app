import 'package:bizmodo_emenu/Config/utils.dart';
import 'package:bizmodo_emenu/Controllers/AllSalesController/allSalesController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Controllers/ContactController/ContactController.dart';
import '../../Return/saleReturn.dart';
import '../../order_type/search_customer_page.dart';
import 'SalesViewTile.dart';
import 'ViewSalesPage.dart';

class SalesView extends StatefulWidget {
  bool isSalesReturn;
  SalesView({Key? key, this.isSalesReturn = false}) : super(key: key);

  @override
  State<SalesView> createState() => _SalesViewState();
}

class _SalesViewState extends State<SalesView> {
  AllSalesController allSalesCtrl = Get.find<AllSalesController>();
  ScrollController? _pastOrdersScrollCtrl;

  @override
  void initState() {
    // TODO: implement initState
    if (widget.isSalesReturn) {
      allSalesCtrl.callFirstOrderPageForReceipt();
    } else {
      allSalesCtrl.callFirstOrderPage();
    }

    scrollControllerLis();
    super.initState();
  }

  @override
  void dispose() {
    _pastOrdersScrollCtrl?.removeListener(scrollControllerLis);
    super.dispose();
  }

  scrollControllerLis() {
    _pastOrdersScrollCtrl = ScrollController();
    if (_pastOrdersScrollCtrl != null) {
      _pastOrdersScrollCtrl?.addListener(() {
        double maxScroll = _pastOrdersScrollCtrl!.position.maxScrollExtent;
        double currentScroll = _pastOrdersScrollCtrl!.position.pixels;
        double delta = MediaQuery.of(context).size.height * 0.75;

        if ((maxScroll - currentScroll) <= delta) {
          // if (maxScroll == currentScroll) {
          Get.find<AllSalesController>().loadMoreSaleOrders();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text('Sales'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: (widget.isSalesReturn)
          ? null
          : FloatingActionButton.small(
              child: Icon(Icons.add),
              backgroundColor:
                  Theme.of(context).colorScheme.primary.withOpacity(0.5),
              onPressed: () {
                Get.to(CustomerSearch(
                  dashBoardId: 5,
                ));
                // Get.to(
                //   AddSalesAndQuotation(
                //     isSale: false,
                //   ),
                // );
              }),
      body: Stack(
        children: [
          GetBuilder(
            builder: (AllSalesController allSalesCtrlObj) {
              return RefreshIndicator(
                onRefresh: () async {
                  await allSalesCtrlObj.callFirstOrderPage();
                },
                child: (allSalesCtrlObj.allSaleOrders == null)
                    ? progressIndicator()
                    : Scrollbar(
                        controller: _pastOrdersScrollCtrl,
                        child: ListView.builder(
                          controller: _pastOrdersScrollCtrl,
                          physics: AlwaysScrollableScrollPhysics(),
                          padding: const EdgeInsets.only(bottom: 100),
                          itemCount: allSalesCtrlObj
                                  .allSaleOrders?.saleOrdersData.length ??
                              0,
                          itemBuilder: (context, index) {
                            return IntrinsicHeight(
                              child: GestureDetector(
                                  onTap: () {
                                    if (widget.isSalesReturn) {
                                      Get.to(SalesReturn(
                                        id: '${allSalesCtrlObj.allSaleOrders!.saleOrdersData[index].id}',
                                      ));
                                    } else {
                                      Get.to(SalesViewDetailsPage(
                                        salesOrderData: allSalesCtrlObj
                                            .allSaleOrders!
                                            .saleOrdersData[index],
                                      ));
                                    }
                                  },
                                  child: SalesViewTile(
                                    allSalesCtrlObj: allSalesCtrlObj,
                                    index: index,
                                    pastOrder: allSalesCtrlObj
                                        .allSaleOrders!.saleOrdersData[index],
                                  )),
                            );
                            //   !allSalesCtrlObj.allSaleOrders!
                            //     .saleOrdersData[index].isSuspend
                            //     ? PastOrderInfoTile(
                            //   allSalesCtrlObj
                            //       .allSaleOrders!.saleOrdersData[index],
                            // )
                            //     : SizedBox();
                          },
                        ),
                      ),
              );
            },
          ),
          Positioned(
            bottom: 5,
            left: 0,
            right: 0,
            child: GetX(builder: (AllSalesController orderCtrlObj) {
              return orderCtrlObj.isLoadMoreRunning.isTrue
                  ? progressIndicator()
                  : SizedBox();
            }),
          ),
        ],
      ),
      // body: GetBuilder<AllSalesController>(
      //     builder: (AllSalesController allSalesCtrlObj) {
      //   if (allSalesCtrlObj.allSalesModel != null) {
      //     return RefreshIndicator(
      //         onRefresh: () async {
      //           //await allSalesCtrlObj.fetchAllSalesList();
      //           await allSalesCtrlObj.callFirstOrderPage();
      //         },
      //         child: ListView.builder(
      //             physics: AlwaysScrollableScrollPhysics(),
      //             padding: const EdgeInsets.only(bottom: 100),
      //             itemCount: allSalesCtrlObj.allSalesModel?.data?.length,
      //             itemBuilder: (context, index) {
      //               return IntrinsicHeight(
      //                 child: GestureDetector(
      //                     onTap: () {
      //                       Get.to(SalesViewDetailsPage());
      //                     },
      //                     child: SalesViewTile(
      //                       allSalesCtrlObj: allSalesCtrlObj,
      //                       index: index,
      //                     )),
      //               );
      //             })
      //     );
      //   } else {
      //     return progressIndicator();
      //   }
      // })
    );
  }
}
