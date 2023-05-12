import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
        title: Text('Stock Transfer'),
      ),
      body: DefaultTabController(
        length: OrderController.stockTabsList().length,
        child: Padding(
          padding: EdgeInsets.only(top: 0),
          child: Column(
            children: [
              Container(
                height: 35,
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                child: TabBar(
                  tabs: OrderController.stockTabsList().map((_orderTab) {
                    return Tab(text: _orderTab.label);
                  }).toList(),
                ),
              ),
              Expanded(
                // child: OrdersListPage(),
                child: TabBarView(
                  children: OrderController.stockTabsList()
                      .map((_orderTab) => _orderTab.page)
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
