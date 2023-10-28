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
  final List<SingleReceiptData>? singleReceiptModel;
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
    List<SingleReceiptData>? singleReceiptModel,
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
              child: pw.Text(
                  AppStorage.getBusinessDetailsData()?.businessData?.name ?? '',
                  style: pw.TextStyle(
                      fontSize: 16, fontWeight: pw.FontWeight.bold))),

          pw.Center(
            child: pw.Text(
              '${AppStorage.getBusinessDetailsData()?.businessData?.locations.first.name ?? ''}, '
              '${AppStorage.getBusinessDetailsData()?.businessData?.locations.first.landmark ?? ''}, '
              '${AppStorage.getBusinessDetailsData()?.businessData?.locations.first.city ?? ''}, '
              '${AppStorage.getBusinessDetailsData()?.businessData?.locations.first.country ?? ''}',
            ),
          ),
          pw.Center(
            child: pw.Text(
              'Contact No: ${AppStorage.getBusinessDetailsData()?.businessData?.locations.first.mobile ?? ''}, '
              'Alternate No: ${AppStorage.getBusinessDetailsData()?.businessData?.locations.first.alternateNumber ?? ''}',
            ),
          ),

          pw.Center(
            child: pw.Text(
              'Email: ${AppStorage.getBusinessDetailsData()?.businessData?.locations.first.email ?? ''}',
            ),
          ),

          pw.Center(
            child: pw.Text(
              '${AppStorage.getBusinessDetailsData()?.businessData?.taxLabel1 ?? ''}:${AppStorage.getBusinessDetailsData()?.businessData?.taxNumber1 ?? ''}',
            ),
          ),

          pw.Divider(),
          pw.Center(
            child: pw.Text('Receipt Voucher',
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
          ),
          pw.Divider(),

          // pw.Center(
          //     child: pw.Text(
          //         '${singleReceiptModel?.contact?.city ?? ''}, ${singleReceiptModel?.contact?.country ?? ''}')),
          // pw.Row(
          //     mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          //     children: [
          //       printBasicInfoWidget(
          //           title: 'Contact No.: ',
          //           titleVal: '${singleReceiptModel?.contact?.mobile}'),
          //       if (singleReceiptModel?.contact?.email != null)
          //         printBasicInfoWidget(
          //             title: 'Email: ',
          //             titleVal: '${singleReceiptModel?.contact?.email ?? ''}'),
          //     ]),
          // pw.Divider(),
          // pw.Center(
          //     child: pw.Text('Tax Invoice',
          //         style: pw.TextStyle(
          //             fontSize: 18, fontWeight: pw.FontWeight.bold))),

          pw.SizedBox(height: 10),
          printBasicInfoWidget(
              title: 'Customer Name: ',
              titleVal: '${singleReceiptModel?.first.contact?.name}'),
          pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                printBasicInfoWidget(
                    title: 'Salesman: ',
                    titleVal:
                        '${singleReceiptModel?.first.salesPerson?.firstName}'),
                printBasicInfoWidget(
                    title: 'Receipt Date: ',
                    titleVal:
                        '${AppFormat.dateYYYYMMDDHHMM24(singleReceiptModel?.first.transactionDate)}'),
              ]),
          // printBasicInfoWidget(
          //     title: 'Invoice No: ',
          //     titleVal: '${singleReceiptModel?.invoiceNo ?? ''}'),
          if (singleReceiptModel?.first.contact?.taxNumber != null)
            printBasicInfoWidget(
                title: 'Customer Tax No: ',
                titleVal:
                    '${singleReceiptModel?.first.contact?.taxNumber ?? ''}'),

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
                      child: pw.Text('Description',
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
            ...List.generate(singleReceiptModel?.length ?? 0, (index) {
              return pw.Table(
                //border: pw.TableBorder.all(width: 0.8),

                children: [
                  pw.TableRow(
                    children: [
                      pw.Expanded(
                        flex: 2,
                        child: pw.Padding(
                          padding: pw.EdgeInsets.symmetric(horizontal: 2.5),
                          child: pw.Text('${index + 1}',
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
                              '${singleReceiptModel?[index].paymentLines?.first.paymentRefNo}\n${singleReceiptModel?[index].invoiceNo}',
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
                              '${AppFormat.doubleToStringUpTo2(singleReceiptModel?[index].finalTotal)}',
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
              // finalDetails(
              //     txt1: 'Subtotal:',
              //     txt2:
              //         '${AppFormat.doubleToStringUpTo2(singleReceiptModel.totalBeforeTax)}'),
              pw.SizedBox(height: 5),
              // finalDetails(
              //     txt1: 'Tax (VAT):',
              //     txt2: '${AppFormat.doubleToStringUpTo2(totalReceiptTax())}'),
              // pw.SizedBox(height: 5),
              finalDetails(
                  txt1: 'Total Paid Amount:',
                  txt2:
                      '${AppFormat.doubleToStringUpTo2(totalPayedAmount())} AED'),
              pw.SizedBox(height: 5),
            ],
          ),
          pw.SizedBox(height: 15),
          pw.Divider(),
          pw.Center(
              child: pw.Text(
                  'Digitally generated receipt,\nvalid without signature or stamp')),
        ],
      ),
    );
  }

  totalReceiptTax() {
    double totalReceiptTax = 0.00;
    var length = singleReceiptModel?.length ?? 0;
    for (int i = 0; i < length; i++) {
      totalReceiptTax =
          totalReceiptTax + totalItemsTax(singleOrder: singleReceiptModel?[i]);
    }
    return totalReceiptTax;
  }

  totalItemsTax({SingleReceiptData? singleOrder}) {
    double totalTax = 0.00;
    var length = singleOrder?.sellLines?.length ?? 0;
    ;
    for (int i = 0; i < length; i++) {
      totalTax = totalTax +
          (double.parse('${singleOrder?.sellLines?[i].itemTax}') *
              double.parse('${singleOrder?.sellLines?[i].quantity}')
          // * double.parse(
          //     '${Get.find<AllProductsController>().checkUnitValueWithGivenId(idNumber: saleOrderDataModel?.sellLines[i].subUnitId)}')
          );
    }
    return totalTax;
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

  totalPayedAmount() {
    double totalPayed = 0;
    singleReceiptModel?.forEach((element) {
      totalPayed += double.parse('${element.finalTotal ?? 0}');
    });
    return totalPayed;
  }
}
