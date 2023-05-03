// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '/Pages/print_page.dart';
// import '/Theme/colors.dart';
//
// class CartPageTable extends StatefulWidget {
//   final String? tableName;
//   CartPageTable({Key? key, this.tableName}) : super(key: key);
//
//   @override
//   State<CartPageTable> createState() => _CartPageTableState();
// }
//
// class _CartPageTableState extends State<CartPageTable> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: Text(
//           'cart'.tr,
//           style: TextStyle(fontSize: 16, color: Colors.black),
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.only(top: 10.0, left: 10, right: 10, bottom: 10),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Column(
//               //mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   children: [
//                     Text('table'.tr + ' ${widget.tableName}'),
//                     SizedBox(width: 30),
//                     Container(
//                       height: 27,
//                       width: 70,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(20),
//                         border: Border.all(width: 1, color: primaryColor),
//                       ),
//                       child: Center(
//                         child: Text(
//                           'add_item'.tr,
//                           style: TextStyle(fontWeight: FontWeight.w500, color: primaryColor),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 10),
//                 MenuData(product: 'Yemini Bread'),
//                 SizedBox(height: 8),
//                 MenuData(product: 'Kima'),
//                 SizedBox(height: 8),
//                 MenuData(product: 'Dal'),
//                 SizedBox(height: 8),
//                 MenuData(product: 'Date Fatteh'),
//                 SizedBox(height: 8),
//                 MenuData(product: 'Liver'),
//
//                 //SizedBox(height: MediaQuery.of(context).size.height*0.27),
//               ],
//             ),
//             Container(
//               height: MediaQuery.of(context).size.height * 0.143,
//               color: Colors.grey.withOpacity(0.1),
//               child: Column(
//                 children: [
//                   Padding(
//                     padding: EdgeInsets.all(5),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           'totalAmount'.tr,
//                           style: TextStyle(
//                               fontSize: 14, color: Colors.black, fontWeight: FontWeight.w500),
//                         ),
//                         Text(
//                           '40.00',
//                           style: TextStyle(
//                               fontSize: 14, color: Colors.black, fontWeight: FontWeight.w500),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Row(
//                     children: [
//                       Container(
//                         height: 40,
//                         width: MediaQuery.of(context).size.width * 0.47,
//                         color: Colors.green,
//                         child: Center(
//                             child: Text('check_out'.tr, style: TextStyle(color: Colors.white))),
//                       ),
//                       Container(
//                         height: 40,
//                         width: MediaQuery.of(context).size.width * 0.47,
//                         color: Colors.blue,
//                         child: Center(
//                           child: Text(
//                             'update_order'.tr,
//                             style: TextStyle(color: Colors.white),
//                           ),
//                         ),
//                       )
//                     ],
//                   ),
//                   Row(
//                     children: [
//                       Container(
//                         height: 40,
//                         width: MediaQuery.of(context).size.width * 0.47,
//                         color: Colors.red,
//                         child: Center(
//                             child: Text('cancel_order'.tr, style: TextStyle(color: Colors.white))),
//                       ),
//                       GestureDetector(
//                         onTap: () {
//                           Get.to(PrintData());
//                         },
//                         child: Container(
//                           height: 40,
//                           width: MediaQuery.of(context).size.width * 0.47,
//                           color: primaryColor,
//                           child: Center(
//                               child: Text(
//                             'print_invoice'.tr,
//                             style: TextStyle(color: Colors.white),
//                           )),
//                         ),
//                       )
//                     ],
//                   ),
//                   //SizedBox(height: 5,)
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class MenuData extends StatefulWidget {
//   var product;
//   MenuData({Key? key, this.product}) : super(key: key);
//
//   @override
//   State<MenuData> createState() => _MenuDataState();
// }
//
// class _MenuDataState extends State<MenuData> {
//   int itemsCount = 0;
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         ClipRRect(
//             borderRadius: BorderRadius.circular(5),
//             child: Image.asset(
//               'assets/food items/food2.jpg',
//               fit: BoxFit.fill,
//               height: 50,
//               width: 60,
//             )),
//         SizedBox(
//           width: 5,
//         ),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//               width: MediaQuery.of(context).size.width * 0.75,
//               // color: Colors.greenAccent,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     widget.product,
//                     style: TextStyle(
//                       fontSize: 14,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                   //SizedBox(width: MediaQuery.of(context).size.width*0.47,),
//                   Text(
//                     'X',
//                     style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.red),
//                   ),
//                   //Icon(Icons.cancel_outlined,color: Colors.black,size: 25,),
//                 ],
//               ),
//             ),
//             Container(
//               width: MediaQuery.of(context).size.width * 0.75,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Container(
//                     width: 80,
//                     height: 30,
//                     decoration: BoxDecoration(
//                         border: Border.all(width: 1, color: primaryColor.withOpacity(0.5)),
//                         borderRadius: BorderRadius.circular(20)),
//                     child: Padding(
//                       padding: const EdgeInsets.only(left: 8.0, right: 8.0),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         //crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           GestureDetector(
//                             onTap: () {
//                               itemsCount--;
//                               setState(() {});
//                             },
//                             child: Text(
//                               '-',
//                               style: TextStyle(color: primaryColor, fontSize: 20),
//                             ),
//                           ),
//                           Text(
//                             itemsCount.toString(),
//                             style: TextStyle(color: primaryColor, fontSize: 16),
//                           ),
//                           GestureDetector(
//                             onTap: () {
//                               itemsCount++;
//                               setState(() {});
//                             },
//                             child: Text(
//                               '+',
//                               style: TextStyle(color: primaryColor, fontSize: 20),
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                   ),
//                   //SizedBox(width: MediaQuery.of(context).size.width*0.44,),
//                   Text(
//                     '3.50',
//                     style: TextStyle(fontSize: 14, color: Colors.black),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }
