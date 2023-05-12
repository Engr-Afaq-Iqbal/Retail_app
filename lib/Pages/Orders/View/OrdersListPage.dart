// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '/Config/utils.dart';
// import '/Pages/Orders/Controller/OrderController.dart';
// import '/Pages/Orders/View/ActiveOrders/StockTransfersInfoTile.dart';
// import 'PastOrders/StockAdjustmentInfoTile.dart';
//
// class OrdersListPage extends StatefulWidget {
//   const OrdersListPage({Key? key}) : super(key: key);
//
//   @override
//   State<OrdersListPage> createState() => _OrdersListPageState();
// }
//
// class _OrdersListPageState extends State<OrdersListPage> {
//   ScrollController? _ordersScrollCtrl;
//
//   void initState() {
//     scrollControllerLis();
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     _ordersScrollCtrl?.removeListener(scrollControllerLis);
//     super.dispose();
//   }
//
//   scrollControllerLis() {
//     _ordersScrollCtrl = ScrollController();
//     if (_ordersScrollCtrl != null) {
//       _ordersScrollCtrl?.addListener(() {
//         double maxScroll = _ordersScrollCtrl!.position.maxScrollExtent;
//         double currentScroll = _ordersScrollCtrl!.position.pixels;
//         double delta = MediaQuery.of(context).size.height * 0.75;
//
//         if ((maxScroll - currentScroll) <= delta) {
//           // if (maxScroll == currentScroll) {
//           Get.find<OrderController>().loadMoreSaleOrders();
//         }
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       child: Stack(
//         children: [
//           GetBuilder(
//             builder: (OrderController orderCtrlObj) {
//               return RefreshIndicator(
//                 onRefresh: () async {
//                   await orderCtrlObj.callFirstOrderPage();
//                 },
//                 child: (orderCtrlObj.allSaleOrders == null)
//                     ? progressIndicator()
//                     : Scrollbar(
//                         controller: _ordersScrollCtrl,
//                         child: ListView.builder(
//                           controller: _ordersScrollCtrl,
//                           physics: AlwaysScrollableScrollPhysics(),
//                           padding: const EdgeInsets.only(bottom: 100),
//                           itemCount: orderCtrlObj.allSaleOrders?.saleOrdersData.length ?? 0,
//                           itemBuilder: (context, index) {
//                             return orderCtrlObj.allSaleOrders!.saleOrdersData[index].isSuspend
//                                 ? ActiveOrderInfoTile(
//                                     orderCtrlObj.allSaleOrders!.saleOrdersData[index],
//                                   )
//                                 : PastOrderInfoTile(
//                                     orderCtrlObj.allSaleOrders!.saleOrdersData[index],
//                                   );
//                           },
//                         ),
//                       ),
//               );
//             },
//           ),
//           Positioned(
//             bottom: 5,
//             left: 0,
//             right: 0,
//             child: GetX(builder: (OrderController orderCtrlObj) {
//               return orderCtrlObj.isLoadMoreRunning.isTrue ? progressIndicator() : SizedBox();
//             }),
//           ),
//         ],
//       ),
//     );
//   }
// }
