import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/Config/utils.dart';
import '/Pages/Orders/Controller/OrderController.dart';
import 'ActiveOrderInfoTile.dart';

class ActiveOrdersTab extends StatefulWidget {
  @override
  State<ActiveOrdersTab> createState() => _ActiveOrdersTabState();
}

class _ActiveOrdersTabState extends State<ActiveOrdersTab> {
  ScrollController? _activeOrdersScrollCtrl;

  void initState() {
    scrollControllerLis();
    super.initState();
  }

  @override
  void dispose() {
    _activeOrdersScrollCtrl?.removeListener(scrollControllerLis);
    super.dispose();
  }

  scrollControllerLis() {
    _activeOrdersScrollCtrl = ScrollController();
    if (_activeOrdersScrollCtrl != null) {
      _activeOrdersScrollCtrl?.addListener(() {
        double maxScroll = _activeOrdersScrollCtrl!.position.maxScrollExtent;
        double currentScroll = _activeOrdersScrollCtrl!.position.pixels;
        // double delta = MediaQuery.of(context).size.height * 0.75;

        // if ((maxScroll - currentScroll) <= delta) _loadMore();
        if (maxScroll == currentScroll)
          Get.find<OrderController>().loadMoreSaleOrders();
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
                        controller: _activeOrdersScrollCtrl,
                        interactive: true,
                        child: ListView.builder(
                          controller: _activeOrdersScrollCtrl,
                          physics: AlwaysScrollableScrollPhysics(),
                          padding: const EdgeInsets.only(bottom: 100),
                          itemCount: orderCtrlObj
                                  .allSaleOrders?.saleOrdersData.length ??
                              0,
                          itemBuilder: (context, index) {
                            return orderCtrlObj.allSaleOrders!
                                    .saleOrdersData[index].isSuspend
                                ? ActiveOrderInfoTile(
                                    orderCtrlObj
                                        .allSaleOrders!.saleOrdersData[index],
                                  )
                                : const SizedBox();
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
