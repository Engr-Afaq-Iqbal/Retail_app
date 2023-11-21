import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Controllers/StockTransferController/stockTransferController.dart';
import '../../../Theme/colors.dart';
import '/Pages/Orders/Controller/OrderController.dart';

class OrdersTabPage extends StatefulWidget {
  const OrdersTabPage({Key? key}) : super(key: key);
  @override
  _OrdersTabPageState createState() => _OrdersTabPageState();
}

class _OrdersTabPageState extends State<OrdersTabPage> {
  final OrderController _orderCtrlObj = Get.find<OrderController>();
  @override
  initState() {
    loadOrdersData();
    super.initState();
  }

  loadOrdersData() async {
    if (_orderCtrlObj.allSaleOrdersPage == 1) {
      _orderCtrlObj.isFirstLoadRunning = true;
      await _orderCtrlObj.fetchSaleOrders(_orderCtrlObj.allSaleOrdersPage);
      _orderCtrlObj.isFirstLoadRunning = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text('stock_transfer'.tr),
      ),
      body: DefaultTabController(
        length: StockTransferController.stockTabsList().length,
        child: Padding(
          padding: EdgeInsets.only(top: 0),
          child: Column(
            children: [
              Container(
                height: 35,
                width: MediaQuery.of(context).size.width,
                color: kWhiteColor,
                child: TabBar(
                  labelColor: Theme.of(context).colorScheme.primary,
                  unselectedLabelColor:
                      Theme.of(context).colorScheme.primary.withOpacity(0.3),
                  indicator: UnderlineTabIndicator(
                    borderSide: BorderSide(
                      width: 2, // Adjust the thickness of the underline
                      color: Theme.of(context)
                          .colorScheme
                          .primary, // Color of the underline
                    ),
                  ),
                  automaticIndicatorColorAdjustment: true,
                  tabs:
                      StockTransferController.stockTabsList().map((_orderTab) {
                    return Tab(text: _orderTab.label);
                  }).toList(),
                ),
              ),
              Expanded(
                // child: OrdersListPage(),
                child: TabBarView(
                  children: StockTransferController.stockTabsList()
                      .map(
                        (_orderTab) => _orderTab.page != null
                            ? _orderTab.page!
                            : SizedBox(),
                      )
                      .toList(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
