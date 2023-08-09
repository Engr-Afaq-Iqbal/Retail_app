import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../../Config/DateTimeFormat.dart';
import '../../Models/ProductsModel/ProductModel.dart';
import '../../Models/ReceiptModel.dart';
import '../../Services/storage_services.dart';
import '/Controllers/ProductController/product_cart_controller.dart';
import 'package:http/http.dart' as http;

class ReceiptPdfGenerate extends StatelessWidget {
  final SingleReceiptData? singleReceiptModel;
  ReceiptPdfGenerate({Key? key, this.singleReceiptModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: PdfPreview(build: (format) => _generatePdf(format)),
    );
  }

  Future<Uint8List> _generatePdf(PdfPageFormat format) async {
    final pdf = pw.Document();

    // final netImage = NetworkImage(
    //     '${AppStorage.getBusinessDetailsData()?.businessData?.logo}');
    final url = AppStorage.getBusinessDetailsData()?.businessData?.logo;
    final response = await http.get(Uri.parse(url!));
    final Uint8List imageBytes = response.bodyBytes;
    final pdfImage = pw.MemoryImage(imageBytes);

    pdf.addPage(
      invoicePrintPage(
        format,
        itemList: Get.find<ProductCartController>().itemCartList,
        singleReceiptModel: singleReceiptModel,
        image: pdfImage,
      ),
    );

    return pdf.save();
  }

  invoicePrintPage(
    PdfPageFormat format, {
    String? invoiceNum,
    DateTime? dateTimeStamp,
    String? table,
    String? customerType,
    String? mobile,
    String? shippingAddress,
    List<ProductModel> itemList = const [],
    SingleReceiptData? singleReceiptModel,
    required pw.MemoryImage image,
  }) {
    return pw.Page(
      pageFormat: format,
      build: (context) => pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.center,
        children: [
          // Slip Title

          pw.Image(
              pw.MemoryImage(
                  image.bytes), // Convert MemoryImage to ImageProvider
              fit: pw.BoxFit.contain,
              width: 200,
              height: 100),
          pw.Center(
              child: pw.Text('Retail',
                  style: pw.TextStyle(
                      fontSize: 18, fontWeight: pw.FontWeight.bold))),

          pw.Center(
              child: pw.Text(
                  '${singleReceiptModel?.contact?.city ?? ''}, ${singleReceiptModel?.contact?.country ?? ''}')),
          pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                printBasicInfoWidget(
                    title: 'Contact No.: ',
                    titleVal: '${singleReceiptModel?.contact?.mobile}'),
                if (singleReceiptModel?.contact?.email != null)
                  printBasicInfoWidget(
                      title: 'Email: ',
                      titleVal: '${singleReceiptModel?.contact?.email ?? ''}'),
              ]),
          // pw.Divider(),
          // pw.Center(
          //     child: pw.Text('Tax Invoice',
          //         style: pw.TextStyle(
          //             fontSize: 18, fontWeight: pw.FontWeight.bold))),

          pw.Divider(),
          pw.Center(
              child: pw.Text('Receipt',
                  style: pw.TextStyle(
                      fontSize: 18, fontWeight: pw.FontWeight.bold))),
          pw.Divider(),
          pw.SizedBox(height: 10),
          printBasicInfoWidget(
              title: 'Customer Name: ',
              titleVal: '${singleReceiptModel?.contact?.name}'),
          pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                printBasicInfoWidget(
                    title: 'Salesman: ',
                    titleVal: '${singleReceiptModel?.salesPerson?.firstName}'),
                printBasicInfoWidget(
                    title: 'Receipt Date: ',
                    titleVal:
                        '${AppFormat.dateYYYYMMDDHHMM24(singleReceiptModel?.transactionDate)}'),
              ]),

          pw.SizedBox(height: 10),
          pw.Divider(),
          // Order Items Table
          pw.Table(
            //border: pw.TableBorder.all(width: 0.8),

            children: [
              pw.TableRow(
                children: [
                  pw.Expanded(
                    flex: 2,
                    child: pw.Padding(
                      padding: pw.EdgeInsets.symmetric(horizontal: 2.5),
                      child: pw.Text('#',
                          style: pw.TextStyle(
                              fontSize: 16, fontWeight: pw.FontWeight.bold)),
                    ),
                  ),
                  pw.Expanded(
                    flex: 7,
                    child: pw.Padding(
                      padding: pw.EdgeInsets.symmetric(horizontal: 2.5),
                      child: pw.Text('Reference No',
                          style: pw.TextStyle(
                              fontSize: 16, fontWeight: pw.FontWeight.bold)),
                    ),
                  ),
                  pw.Expanded(
                    flex: 3,
                    child: pw.Padding(
                      padding: pw.EdgeInsets.symmetric(horizontal: 2.5),
                      child: pw.Text('Amount',
                          style: pw.TextStyle(
                              fontSize: 16, fontWeight: pw.FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ],
          ),
          pw.Divider(),
          pw.Column(children: [
            ...List.generate(singleReceiptModel!.paymentLines!.length, (index) {
              return pw.Table(
                //border: pw.TableBorder.all(width: 0.8),

                children: [
                  pw.TableRow(
                    children: [
                      pw.Expanded(
                        flex: 2,
                        child: pw.Padding(
                          padding: pw.EdgeInsets.symmetric(horizontal: 2.5),
                          child: pw.Text('$index',
                              style: pw.TextStyle(
                                fontSize: 16,
                              )),
                        ),
                      ),
                      pw.Expanded(
                        flex: 7,
                        child: pw.Padding(
                          padding: pw.EdgeInsets.symmetric(horizontal: 2.5),
                          child: pw.Text(
                              '${singleReceiptModel.paymentLines?[index].paymentRefNo}',
                              style: pw.TextStyle(
                                fontSize: 16,
                              )),
                        ),
                      ),
                      pw.Expanded(
                        flex: 3,
                        child: pw.Padding(
                          padding: pw.EdgeInsets.symmetric(horizontal: 2.5),
                          child: pw.Text(
                              '${AppFormat.doubleToStringUpTo2(singleReceiptModel.paymentLines?[index].amount)}',
                              style: pw.TextStyle(
                                fontSize: 16,
                              )),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            })
          ]),

          pw.Column(
            // mainAxisAlignment: pw.MainAxisAlignment.end,
            crossAxisAlignment: pw.CrossAxisAlignment.end,

            children: [
              pw.SizedBox(height: 15),
              finalDetails(
                  txt1: 'Subtotal:',
                  txt2:
                      '${AppFormat.doubleToStringUpTo2(singleReceiptModel.totalBeforeTax)}'),
              pw.SizedBox(height: 5),
              finalDetails(
                  txt1: 'Tax (VAT):',
                  txt2:
                      '${AppFormat.doubleToStringUpTo2(singleReceiptModel.taxAmount)}'),
              pw.SizedBox(height: 5),
              finalDetails(
                  txt1: 'Total:',
                  txt2:
                      '${AppFormat.doubleToStringUpTo2(singleReceiptModel.finalTotal)}'),
              pw.SizedBox(height: 5),
            ],
          ),
          pw.SizedBox(height: 15),
          pw.Divider(),
        ],
      ),
    );
  }

  pw.Row finalDetails({String? txt1, String? txt2}) {
    return pw.Row(children: [
      pw.Padding(padding: pw.EdgeInsets.only(left: 170)),
      //pw.SizedBox(width: 50),
      pw.Expanded(
        flex: 3,
        child: pw.Padding(
          padding: pw.EdgeInsets.symmetric(horizontal: 2.5),
          child: pw.Text('${txt1}',
              style: pw.TextStyle(
                fontSize: 16,
              )),
        ),
      ),
      pw.Expanded(
        flex: 0,
        child: pw.Padding(
          padding: pw.EdgeInsets.symmetric(horizontal: 2.5),
          child: pw.Text('${txt2}',
              style: pw.TextStyle(
                fontSize: 16,
              )),
        ),
      ),
    ]);
  }

  printBasicInfoWidget({String? title, String? titleVal}) {
    return pw.Padding(
      padding: pw.EdgeInsets.symmetric(vertical: 2.5),
      child: pw.Row(
        children: [
          pw.Text(title ?? ''),
          pw.Text(titleVal ?? ''),
          pw.SizedBox(),
        ],
      ),
    );
  }
}
