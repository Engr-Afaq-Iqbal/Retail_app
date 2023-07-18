import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/Controllers/ProductController/product_cart_controller.dart';
import '/Models/ProductsModel/ProductModel.dart';

class AppSettings {
  AppSettings._();

  static const String _lastSubnetKey = 'AppSettings-LAST_SUBNET';
  static const String _firstSubnetKey = 'AppSettings-FIRST_SUBNET';
  static const String _socketTimeoutKey = 'AppSettings-SOCKET_TIMEOUT';
  static const String _pingCountKey = 'AppSettings-PING_COUNT';
  int _firstSubnet = 1;
  int _lastSubnet = 254;
  int _socketTimeout = 500;
  int _pingCount = 5;

  static final AppSettings _instance = AppSettings._();

  static AppSettings get instance => _instance;
  int get firstSubnet => _firstSubnet;
  int get lastSubnet => _lastSubnet;
  int get socketTimeout => _socketTimeout;
  int get pingCount => _pingCount;

  Future<bool> setFirstSubnet(int firstSubnet) async {
    _firstSubnet = firstSubnet;
    return (await SharedPreferences.getInstance())
        .setInt(_firstSubnetKey, _firstSubnet);
  }

  Future<bool> setLastSubnet(int lastSubnet) async {
    _lastSubnet = lastSubnet;
    return (await SharedPreferences.getInstance())
        .setInt(_lastSubnetKey, _lastSubnet);
  }

  Future<bool> setSocketTimeout(int socketTimeout) async {
    _socketTimeout = socketTimeout;
    return (await SharedPreferences.getInstance())
        .setInt(_socketTimeoutKey, _socketTimeout);
  }

  Future<bool> setPingCount(int pingCount) async {
    _pingCount = pingCount;
    return (await SharedPreferences.getInstance())
        .setInt(_pingCountKey, _pingCount);
  }

  Future<void> load() async {
    _firstSubnet =
        (await SharedPreferences.getInstance()).getInt(_firstSubnetKey) ??
            _firstSubnet;

    _lastSubnet =
        (await SharedPreferences.getInstance()).getInt(_lastSubnetKey) ??
            _lastSubnet;

    _socketTimeout =
        (await SharedPreferences.getInstance()).getInt(_socketTimeoutKey) ??
            _socketTimeout;

    _pingCount =
        (await SharedPreferences.getInstance()).getInt(_pingCountKey) ??
            _pingCount;
  }
}

// class PrintData extends StatelessWidget {
//   const PrintData({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: PdfPreview(
//         build: (format) => _generatePdf(format),
//       ),
//     );
//   }
//
//   Future<Uint8List> _generatePdf(PdfPageFormat format) async {
//     final pdf = pw.Document();
//
//     pdf.addPage(kotPrintPage(
//       format,
//       itemList: Get.find<ProductCartController>().itemCartList,
//     ));
//
//     return pdf.save();
//   }
//
//   kotPrintPage(
//     PdfPageFormat format, {
//     String? invoiceNum,
//     DateTime? dateTimeStamp,
//     String? table,
//     String? customerType,
//     String? mobile,
//     String? shippingAddress,
//     List<ProductModel> itemList = const [],
//   }) {
//     return pw.Page(
//       pageFormat: format,
//       build: (context) => pw.Column(
//         children: [
//           // Slip Title
//           pw.Center(
//               child: pw.Text('RESTAURANT, RESTAURANT',
//                   style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold))),
//           pw.SizedBox(height: 5),
//           pw.Center(
//               child: pw.Text(
//             'Packing Slip',
//           )),
//           //printBasicInfoWidget(null, 'Packing Slip'),
//
//           pw.Divider(),
//           // Invoice Number Info
//           printBasicInfoWidget('Invoice No.: ', 'INV87647'),
//           //printBasicInfoWidget('Date: ', dateTimeStamp != null ? dateTimeStamp.toString() : null),
//           printBasicInfoWidget('Date: ', DateFormat.jm().format(DateTime.now())),
//
//           // printBasicInfoWidget('Table: ', table),
//           printBasicInfoWidget('Table: ', '02'),
//           // printBasicInfoWidget('Customer: ', customerType),
//           printBasicInfoWidget('Customer: ', 'Willan'),
//           printBasicInfoWidget('Mobile', mobile ?? 'Not Available'),
//           printBasicInfoWidget('Shipping Address', shippingAddress ?? 'Not Available'),
//           pw.Row(
//               crossAxisAlignment: pw.CrossAxisAlignment.start,
//               mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//               children: [
//                 pw.Column(
//                   mainAxisAlignment: pw.MainAxisAlignment.start,
//                   crossAxisAlignment: pw.CrossAxisAlignment.start,
//                   children: [],
//                 ),
//
//                 // printBasicInfoWidget('Invoice No.', invoiceNum),
//                 // printBasicInfoWidget('Delivery:', invoiceNum),
//               ]),
//           //  printBasicInfoWidget('Invoice No.', invoiceNum),
//
//           // Time Stamp
//
//           // Table Info
//
//           pw.SizedBox(height: 10),
//
//           // Customer & Shipping Info
//           // pw.Row(
//           //   children: [
//           //     // Customer Info
//           //     pw.Column(
//           //       children: [
//           //         // Customer Type
//           //
//           //
//           //         // Contact Number
//           //         // pw.Row(
//           //         //   children: [
//           //         //     pw.Text('Mobile'),
//           //         //     pw.Text(mobile ?? 'Not Available'),
//           //         //   ],
//           //         // ),
//           //       ],
//           //     ),
//           //
//           //     // Shipping Address
//           //     pw.Row(
//           //       children: [
//           //         pw.Text('Shipping Address'),
//           //         pw.Text(shippingAddress ?? 'Not Available'),
//           //       ],
//           //     ),
//           //   ],
//           // ),
//
//           // Order Items Table
//           pw.Table(
//             //border: pw.TableBorder.all(width: 0.8),
//             children: [
//               pw.TableRow(
//                 children: [
//                   pw.Expanded(
//                     flex: 2,
//                     child: pw.Padding(
//                       padding: pw.EdgeInsets.symmetric(horizontal: 2.5),
//                       child: pw.Text('#',
//                           style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold)),
//                     ),
//                   ),
//                   pw.Expanded(
//                     flex: 10,
//                     child: pw.Padding(
//                       padding: pw.EdgeInsets.symmetric(horizontal: 2.5),
//                       child: pw.Text('Product',
//                           style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold)),
//                     ),
//                   ),
//                   pw.Expanded(
//                     flex: 3,
//                     child: pw.Padding(
//                       padding: pw.EdgeInsets.symmetric(horizontal: 2.5),
//                       child: pw.Text('QTY',
//                           style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold)),
//                     ),
//                   ),
//                 ],
//               ),
//               ...List.generate(
//                 itemList.length,
//                 (index) => pw.TableRow(
//                   children: [
//                     pw.Expanded(
//                       flex: 2,
//                       child: pw.Padding(
//                         padding: pw.EdgeInsets.symmetric(horizontal: 2.5),
//                         child: pw.Text('${index + 1}'),
//                       ),
//                     ),
//                     pw.Expanded(
//                       flex: 10,
//                       child: pw.Padding(
//                         padding: pw.EdgeInsets.symmetric(horizontal: 2.5),
//                         child: pw.Text(
//                           '${itemList[index].name}',
//                         ),
//                       ),
//                     ),
//                     pw.Expanded(
//                       flex: 3,
//                       child: pw.Padding(
//                         padding: pw.EdgeInsets.symmetric(horizontal: 2.5),
//                         child: pw.Text('${itemList[index].quantity}'),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           pw.Divider(),
//         ],
//       ),
//     );
//   }
//
//   invoicePrintPage(
//     PdfPageFormat format, {
//     String? invoiceNum,
//     DateTime? dateTimeStamp,
//     String? table,
//     String? customerType,
//     String? mobile,
//     String? shippingAddress,
//     List<ProductModel> itemList = const [],
//   }) {
//     return pw.Page(
//       pageFormat: format,
//       build: (context) => pw.Column(
//         //mainAxisAlignment: pw.MainAxisAlignment.center,
//         crossAxisAlignment: pw.CrossAxisAlignment.center,
//         children: [
//           // Slip Title
//           pw.Center(
//               child: pw.Text('RESTAURANT, RESTAURANT',
//                   style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold))),
//           pw.Center(
//               child: pw.Text(
//             'Al Falah, Abu Dhabi, United Arab Emirates',
//           )),
//           pw.Center(
//               child: pw.Text(
//             'Mobile: 024445331, https://bizmodo.io',
//           )),
//           pw.Center(
//               child: pw.Text(
//             'VAT: 1020120012003',
//           )),
//           pw.Center(
//               child: pw.Text(
//             'INVOICE',
//           )),
//           //printBasicInfoWidget(null, 'RESTAURANT, RESTAURANT'),
//           //printBasicInfoWidget(null, 'Al Falah, Abu Dhabi, United Arab Emirates'),
//           //printBasicInfoWidget(null, 'Mobile: 024445331, https://bizmodo.io'),
//           //printBasicInfoWidget('VAT:', '1020120012003'),
//           //printBasicInfoWidget(null, 'Invoice'),
//           pw.Divider(),
//
//           // Invoice Number Info
//           //printBasicInfoWidget('Invoice No.', invoiceNum),
//           printBasicInfoWidget('Invoice No.', 'INV87646'),
//           // Time Stamp
//           //printBasicInfoWidget('Date', dateTimeStamp != null ? dateTimeStamp.toString() : null),
//           printBasicInfoWidget('Date', DateFormat.jm().format(DateTime.now())),
//           printBasicInfoWidget('Waiter', 'Fadal'),
//
//           // Table Info
//           //printBasicInfoWidget('Table', table),
//           printBasicInfoWidget('Table', '02'),
//           printBasicInfoWidget('Customer', 'Walkin'),
//           printBasicInfoWidget('Mobile', '213123'),
//
//           pw.SizedBox(height: 20),
//
//           // Customer & Shipping Info
//           pw.Row(
//             children: [
//               // Customer Info
//               pw.Column(
//                 children: [
//                   // Customer Type
//                   // printBasicInfoWidget('Customer', customerType),
//
//                   // Contact Number
//                   // pw.Row(
//                   //   children: [
//                   //     pw.Text('Mobile'),
//                   //     pw.Text(mobile ?? 'Not Available'),
//                   //   ],
//                   // ),
//                 ],
//               ),
//
//               // Shipping Address
//               // pw.Row(
//               //   children: [
//               //     pw.Text('Shipping Address'),
//               //     pw.Text(shippingAddress ?? 'Not Available'),
//               //   ],
//               // ),
//             ],
//           ),
//
//           // Order Items Table
//           pw.Table(
//             //border: pw.TableBorder.all(width: 0.8),
//
//             children: [
//               pw.TableRow(
//                 children: [
//                   pw.Expanded(
//                     flex: 2,
//                     child: pw.Padding(
//                       padding: pw.EdgeInsets.symmetric(horizontal: 2.5),
//                       child: pw.Text('#',
//                           style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
//                     ),
//                   ),
//                   pw.Expanded(
//                     flex: 7,
//                     child: pw.Padding(
//                       padding: pw.EdgeInsets.symmetric(horizontal: 2.5),
//                       child: pw.Text('Product',
//                           style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
//                     ),
//                   ),
//                   pw.Expanded(
//                     flex: 3,
//                     child: pw.Padding(
//                       padding: pw.EdgeInsets.symmetric(horizontal: 2.5),
//                       child: pw.Text('QTY',
//                           style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
//                     ),
//                   ),
//                   pw.Expanded(
//                     flex: 5,
//                     child: pw.Padding(
//                       padding: pw.EdgeInsets.symmetric(horizontal: 2.5),
//                       child: pw.Text('Unit Price',
//                           style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
//                     ),
//                   ),
//                   pw.Expanded(
//                     flex: 3,
//                     child: pw.Padding(
//                       padding: pw.EdgeInsets.symmetric(horizontal: 2.5),
//                       child: pw.Text('Subtotal',
//                           style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
//                     ),
//                   ),
//                 ],
//               ),
//
//               // ...List.generate(
//               //   itemList.length,
//               //   (index) => pw.TableRow(
//               //     children: [
//               //       pw.Expanded(
//               //         flex: 2,
//               //         child: pw.Padding(
//               //           padding: pw.EdgeInsets.symmetric(horizontal: 2.5),
//               //           child: pw.Text('${index + 1}'),
//               //         ),
//               //       ),
//               //       pw.Expanded(
//               //         flex: 10,
//               //         child: pw.Padding(
//               //           padding: pw.EdgeInsets.symmetric(horizontal: 2.5),
//               //           child: pw.Text(
//               //             '${itemList[index].name}',
//               //           ),
//               //         ),
//               //       ),
//               //       pw.Expanded(
//               //         flex: 3,
//               //         child: pw.Padding(
//               //           padding: pw.EdgeInsets.symmetric(horizontal: 2.5),
//               //           child: pw.Text('${itemList[index].quantity}'),
//               //         ),
//               //       ),
//               //     ],
//               //   ),
//               // ),
//             ],
//           ),
//           pw.Divider(),
//           pw.SizedBox(height: 50),
//           pw.Divider(),
//
//           pw.Column(
//             // mainAxisAlignment: pw.MainAxisAlignment.end,
//             crossAxisAlignment: pw.CrossAxisAlignment.end,
//
//             children: [
//               pw.SizedBox(height: 15),
//               pw.Row(
//
//                   // mainAxisAlignment: pw.MainAxisAlignment.end,
//                   //crossAxisAlignment: pw.CrossAxisAlignment.end,
//                   children: [
//                     pw.Padding(padding: pw.EdgeInsets.only(left: 170)),
//                     //pw.SizedBox(width: 50),
//                     pw.Expanded(
//                       flex: 3,
//                       child: pw.Padding(
//                         padding: pw.EdgeInsets.symmetric(horizontal: 2.5),
//                         child: pw.Text('Subtotal:',
//                             style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
//                       ),
//                     ),
//                     pw.Expanded(
//                       flex: 0,
//                       child: pw.Padding(
//                         padding: pw.EdgeInsets.symmetric(horizontal: 2.5),
//                         child: pw.Text('78',
//                             style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
//                       ),
//                     ),
//                   ]),
//               pw.SizedBox(height: 5),
//               pw.Row(children: [
//                 pw.Padding(padding: pw.EdgeInsets.only(left: 170)),
//                 //pw.SizedBox(width: 50),
//                 pw.Expanded(
//                   flex: 3,
//                   child: pw.Padding(
//                     padding: pw.EdgeInsets.symmetric(horizontal: 2.5),
//                     child: pw.Text('Discount (50.00%):',
//                         style: pw.TextStyle(
//                           fontSize: 16,
//                         )),
//                   ),
//                 ),
//                 pw.Expanded(
//                   flex: 0,
//                   child: pw.Padding(
//                     padding: pw.EdgeInsets.symmetric(horizontal: 2.5),
//                     child: pw.Text('(-) 39.00',
//                         style: pw.TextStyle(
//                           fontSize: 16,
//                         )),
//                   ),
//                 ),
//               ]),
//               pw.SizedBox(height: 5),
//               pw.Row(children: [
//                 pw.Padding(padding: pw.EdgeInsets.only(left: 170)),
//                 //pw.SizedBox(width: 50),
//                 pw.Expanded(
//                   flex: 3,
//                   child: pw.Padding(
//                     padding: pw.EdgeInsets.symmetric(horizontal: 2.5),
//                     child: pw.Text('Tax (VAT):',
//                         style: pw.TextStyle(
//                           fontSize: 16,
//                         )),
//                   ),
//                 ),
//                 pw.Expanded(
//                   flex: 0,
//                   child: pw.Padding(
//                     padding: pw.EdgeInsets.symmetric(horizontal: 2.5),
//                     child: pw.Text('(+) 1.95',
//                         style: pw.TextStyle(
//                           fontSize: 16,
//                         )),
//                   ),
//                 ),
//               ]),
//               pw.SizedBox(height: 5),
//               pw.Row(children: [
//                 pw.Padding(padding: pw.EdgeInsets.only(left: 170)),
//                 //pw.SizedBox(width: 50),
//                 pw.Expanded(
//                   flex: 3,
//                   child: pw.Padding(
//                     padding: pw.EdgeInsets.symmetric(horizontal: 2.5),
//                     child: pw.Text('Total',
//                         style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
//                   ),
//                 ),
//                 pw.Expanded(
//                   flex: 0,
//                   child: pw.Padding(
//                     padding: pw.EdgeInsets.symmetric(horizontal: 2.5),
//                     child: pw.Text('40.95',
//                         style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
//                   ),
//                 ),
//               ]),
//               pw.SizedBox(height: 5),
//               pw.Row(children: [
//                 pw.Padding(padding: pw.EdgeInsets.only(left: 170)),
//                 //pw.SizedBox(width: 50),
//                 pw.Expanded(
//                   flex: 3,
//                   child: pw.Padding(
//                     padding: pw.EdgeInsets.symmetric(horizontal: 2.5),
//                     child: pw.Text('Cash(01/09/203)',
//                         style: pw.TextStyle(
//                           fontSize: 18,
//                         )),
//                   ),
//                 ),
//                 pw.Expanded(
//                   flex: 0,
//                   child: pw.Padding(
//                     padding: pw.EdgeInsets.symmetric(horizontal: 2.5),
//                     child: pw.Text('40.95',
//                         style: pw.TextStyle(
//                           fontSize: 18,
//                         )),
//                   ),
//                 ),
//               ]),
//               pw.SizedBox(height: 5),
//               pw.Row(children: [
//                 pw.Padding(padding: pw.EdgeInsets.only(left: 170)),
//                 //pw.SizedBox(width: 50),
//                 pw.Expanded(
//                   flex: 3,
//                   child: pw.Padding(
//                     padding: pw.EdgeInsets.symmetric(horizontal: 2.5),
//                     child: pw.Text('Total paid',
//                         style: pw.TextStyle(
//                           fontSize: 18,
//                         )),
//                   ),
//                 ),
//                 pw.Expanded(
//                   flex: 0,
//                   child: pw.Padding(
//                     padding: pw.EdgeInsets.symmetric(horizontal: 2.5),
//                     child: pw.Text('40.95',
//                         style: pw.TextStyle(
//                           fontSize: 18,
//                         )),
//                   ),
//                 ),
//               ]),
//             ],
//           ),
//           pw.SizedBox(height: 15),
//           pw.Divider(),
//           pw.SizedBox(height: 10),
//           pw.Center(child: pw.Text('Thank You Visit Again!')),
//           pw.Center(child: pw.Text('Barkas Restaurant'))
//         ],
//       ),
//     );
//   }
//
//   printBasicInfoWidget(String? title, String? titleVal) {
//     return pw.Padding(
//       padding: pw.EdgeInsets.symmetric(vertical: 2.5),
//       child: pw.Row(
//         mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//         children: [
//           pw.Text(title ?? ''),
//           pw.Text(titleVal ?? ''),
//         ],
//       ),
//     );
//   }
// }
