import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/Config/utils.dart';
import '/Pages/Orders/Controller/OrderController.dart';
import '/Pages/Orders/View/PastOrders/PastOrderInfoTile.dart';

class PastOrdersTab extends StatefulWidget {
  @override
  State<PastOrdersTab> createState() => _PastOrdersTabState();
}

class _PastOrdersTabState extends State<PastOrdersTab> {
  ScrollController? _pastOrdersScrollCtrl;

  void initState() {
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
          Get.find<OrderController>().loadMoreSaleOrders();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          GetBuilder(
            builder: (OrderController orderCtrlObj) {
              return RefreshIndicator(
                onRefresh: () async {
                  await orderCtrlObj.callFirstOrderPage();
                },
                child: (orderCtrlObj.allSaleOrders == null)
                    ? progressIndicator()
                    : Scrollbar(
                        controller: _pastOrdersScrollCtrl,
                        child: ListView.builder(
                          controller: _pastOrdersScrollCtrl,
                          physics: AlwaysScrollableScrollPhysics(),
                          padding: const EdgeInsets.only(bottom: 100),
                          itemCount: orderCtrlObj
                                  .allSaleOrders?.saleOrdersData.length ??
                              0,
                          itemBuilder: (context, index) {
                            return !orderCtrlObj.allSaleOrders!
                                    .saleOrdersData[index].isSuspend
                                ? PastOrderInfoTile(
                                    orderCtrlObj
                                        .allSaleOrders!.saleOrdersData[index],
                                  )
                                : SizedBox();
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
            child: GetX(builder: (OrderController orderCtrlObj) {
              return orderCtrlObj.isLoadMoreRunning.isTrue
                  ? progressIndicator()
                  : SizedBox();
            }),
          ),
        ],
      ),
    );
  }
}
