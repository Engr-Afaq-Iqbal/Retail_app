import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Controllers/AllSalesController/allSalesController.dart';
import '/Pages/Orders/Controller/OrderController.dart';

class SalesTabPage extends StatefulWidget {
  const SalesTabPage({Key? key}) : super(key: key);
  @override
  _SalesTabPageState createState() => _SalesTabPageState();
}

class _SalesTabPageState extends State<SalesTabPage> {
  final AllSalesController _orderCtrlObj = Get.find<AllSalesController>();
  @override
  initState() {
    // loadOrdersData();
    super.initState();
  }

  // loadOrdersData() async {
  //   if (_orderCtrlObj.allSaleOrdersPage == 1) {
  //     _orderCtrlObj.isFirstLoadRunning = true;
  //     await _orderCtrlObj.fetchSaleOrders(_orderCtrlObj.allSaleOrdersPage);
  //     _orderCtrlObj.isFirstLoadRunning = false;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sales'),
      ),
      body: DefaultTabController(
        length: AllSalesController.stockTabsList().length,
        child: Padding(
          padding: EdgeInsets.only(top: 0),
          child: Column(
            children: [
              Container(
                height: 35,
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                child: TabBar(
                  tabs: AllSalesController.stockTabsList().map((_orderTab) {
                    return Tab(text: _orderTab.label);
                  }).toList(),
                ),
              ),
              Expanded(
                // child: OrdersListPage(),
                child: TabBarView(
                  children: AllSalesController.stockTabsList()
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
