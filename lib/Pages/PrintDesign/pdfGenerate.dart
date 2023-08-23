import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../../Config/DateTimeFormat.dart';
import '../../Controllers/ProductController/all_products_controller.dart';
import '../../Models/ProductsModel/ProductModel.dart';
import '../../Models/order_type_model/SaleOrderModel.dart';
import '../../Services/storage_services.dart';
import '/Controllers/ProductController/product_cart_controller.dart';
import 'package:http/http.dart' as http;

class PrintData extends StatelessWidget {
  final SaleOrderDataModel? saleOrderDataModel;
  PrintData({Key? key, this.saleOrderDataModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: PdfPreview(build: (format) => _generatePdf(format)),
    );
  }

  Future<Uint8List> _generatePdf(PdfPageFormat format) async {
    final pdf = pw.Document();
    final url = AppStorage.getBusinessDetailsData()?.businessData?.logo;
    print(AppStorage.getBusinessDetailsData()?.businessData?.logo);
    final response = await http.get(Uri.parse(url!));
    final Uint8List imageBytes = response.bodyBytes;
    final pdfImage = pw.MemoryImage(imageBytes);

    pdf.addPage(invoicePrintPage(
      format,
      itemList: Get.find<ProductCartController>().itemCartList,
      saleOrderDataModel: saleOrderDataModel,
      image: pdfImage,
    ));

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
    SaleOrderDataModel? saleOrderDataModel,
    pw.MemoryImage? image,
  }) {
    return pw.Page(
      pageFormat: format,
      build: (context) => pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.center,
        children: [
          // Slip Title
          pw.Image(
              pw.MemoryImage(
                  image!.bytes), // Convert MemoryImage to ImageProvider
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
                '${AppStorage.getBusinessDetailsData()?.businessData?.locations.first.id ?? ''}, '
                '${AppStorage.getBusinessDetailsData()?.businessData?.locations.first.landmark ?? ''}, '
                '${AppStorage.getBusinessDetailsData()?.businessData?.locations.first.city ?? ''}, '
                '${AppStorage.getBusinessDetailsData()?.businessData?.locations.first.country ?? ''}'),
          ),
          pw.Center(
            child: pw.Text(
                'Mobile: ${AppStorage.getBusinessDetailsData()?.businessData?.locations.first.mobile ?? ''}, ${AppStorage.getBusinessDetailsData()?.businessData?.locations.first.alternateNumber ?? ''}, '
                'Email: ${AppStorage.getBusinessDetailsData()?.businessData?.locations.first.email ?? ''}'),
          ),
          pw.Center(
            child: pw.Text(
              AppStorage.getBusinessDetailsData()
                      ?.businessData
                      ?.locations
                      .first
                      .name ??
                  '',
              // style:
              //     pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold),
            ),
          ),
          pw.Center(
              child: pw.Text('Tax Invoice',
                  style: pw.TextStyle(
                      fontSize: 18, fontWeight: pw.FontWeight.bold))),
          pw.Center(
            child: pw.Text(
              '${AppStorage.getBusinessDetailsData()?.businessData?.taxLabel1 ?? ''}:${AppStorage.getBusinessDetailsData()?.businessData?.taxNumber1 ?? ''}',
            ),
          ),
          // pw.Center(
          //     child: pw.Text('Retail Invoice',
          //         style: pw.TextStyle(
          //             fontSize: 16, fontWeight: pw.FontWeight.bold))),
          pw.Divider(),

          pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                printBasicInfoWidget(
                    title: 'Invoice No: ',
                    titleVal: '${saleOrderDataModel?.invoiceNo}'),
                printBasicInfoWidget(
                    title: 'Date: ',
                    titleVal:
                        '${AppFormat.dateYYYYMMDDHHMM24(saleOrderDataModel?.transactionDate)}'),
              ]),

          pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                printBasicInfoWidget(
                    title: 'Date: ',
                    titleVal:
                        '${AppFormat.dateOnly(saleOrderDataModel!.transactionDate!)}'),
                printBasicInfoWidget(
                    title: 'Time: ',
                    titleVal:
                        '${AppFormat.timeOnly(saleOrderDataModel.transactionDate!)}'),
              ]),

          printBasicInfoWidget(
              title: 'Customer Name: ',
              titleVal: '${saleOrderDataModel.contact?.name}'),

          pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                if (saleOrderDataModel.contact?.mobile != null)
                  printBasicInfoWidget(
                      title: 'Contact No: ',
                      titleVal: '${saleOrderDataModel.contact?.mobile}'),
                if (saleOrderDataModel.contact?.email != null)
                  printBasicInfoWidget(
                      title: 'Email: ',
                      titleVal: '${saleOrderDataModel.contact?.email ?? ''}'),
              ]),

          printBasicInfoWidget(
              title: 'Customer Tax No: ',
              titleVal: '${saleOrderDataModel.contact?.taxNumber ?? ''}'),
          // pw.Divider(),

          pw.SizedBox(height: 5),

          // Order Items Table
          pw.Divider(),
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
                      child: pw.Text('Product',
                          style: pw.TextStyle(
                              fontSize: 16, fontWeight: pw.FontWeight.bold)),
                    ),
                  ),
                  pw.Expanded(
                    flex: 3,
                    child: pw.Padding(
                      padding: pw.EdgeInsets.symmetric(horizontal: 2.5),
                      child: pw.Text('QTY',
                          style: pw.TextStyle(
                              fontSize: 16, fontWeight: pw.FontWeight.bold)),
                    ),
                  ),
                  pw.Expanded(
                    flex: 4,
                    child: pw.Padding(
                      padding: pw.EdgeInsets.symmetric(horizontal: 2.5),
                      child: pw.Text('Unit Price',
                          style: pw.TextStyle(
                              fontSize: 16, fontWeight: pw.FontWeight.bold)),
                    ),
                  ),
                  pw.Expanded(
                    flex: 3,
                    child: pw.Padding(
                      padding: pw.EdgeInsets.symmetric(horizontal: 2.5),
                      child: pw.Text('Subtotal',
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
            ...List.generate(saleOrderDataModel?.sellLines.length ?? 0,
                (index) {
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
                        flex: 6,
                        child: pw.Padding(
                          padding: pw.EdgeInsets.symmetric(horizontal: 2.5),
                          child: pw.Text(
                              AppFormat.removeArabic(
                                  '${saleOrderDataModel.sellLines[index].product?.name}'),
                              style: pw.TextStyle(
                                fontSize: 16,
                              )),
                        ),
                      ),
                      pw.Expanded(
                        flex: 4,
                        child: pw.Padding(
                          padding: pw.EdgeInsets.symmetric(horizontal: 2.5),
                          child: pw.Text(
                              '${double.parse('${saleOrderDataModel?.sellLines[index].quantity}') / double.parse('${Get.find<AllProductsController>().checkUnitValueWithGivenId(idNumber: saleOrderDataModel?.sellLines[index].subUnitId)}')}  / ${Get.find<AllProductsController>().checkUnitsShortName(unitId: saleOrderDataModel?.sellLines[index].subUnitId)}',
                              style: pw.TextStyle(
                                fontSize: 16,
                              )),
                        ),
                      ),
                      pw.Expanded(
                        flex: 5,
                        child: pw.Padding(
                          padding: pw.EdgeInsets.symmetric(horizontal: 2.5),
                          child: pw.Text(
                              '${double.parse('${saleOrderDataModel?.sellLines[index].unitPriceIncTax}') * double.parse('${Get.find<AllProductsController>().checkUnitValueWithGivenId(idNumber: saleOrderDataModel?.sellLines[index].subUnitId)}')}',
                              textAlign: pw.TextAlign.center,
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
                              AppFormat.doubleToStringUpTo2(
                                      '${double.parse('${saleOrderDataModel?.sellLines[index].unitPriceIncTax ?? 0.0}') * double.parse('${saleOrderDataModel?.sellLines[index].quantity ?? 0.0}')}') ??
                                  '0.0',
                              textAlign: pw.TextAlign.right,
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
                      '${AppFormat.doubleToStringUpTo2(saleOrderDataModel?.totalBeforeTax)}'),
              pw.SizedBox(height: 5),
              finalDetails(
                  txt1: 'Discount:',
                  txt2: '${saleOrderDataModel?.discountAmount ?? '0.00'}'),
              pw.SizedBox(height: 5),
              // finalDetails(
              //     txt1: 'Tax (VAT):',
              //     txt2: //'${saleOrderDataModel.totalItemTax}'
              //         '${AppFormat.doubleToStringUpTo2('${saleOrderDataModel?.taxAmount}')}'),
              // pw.SizedBox(height: 5),
              finalDetails(
                  txt1: 'Tax (VAT):',
                  txt2: //'${saleOrderDataModel.totalItemTax}'
                      '${AppFormat.doubleToStringUpTo2('${totalItemsTax()}')}'),
              pw.SizedBox(height: 5),
              finalDetails(
                  txt1: 'Total:',
                  txt2:
                      '${AppFormat.doubleToStringUpTo2(saleOrderDataModel.finalTotal)}'),
              pw.SizedBox(height: 5),
              finalDetails(
                  txt1: 'Total paid:',
                  txt2:
                      '${AppFormat.doubleToStringUpTo2(saleOrderDataModel.totalPaid ?? '0.00')}'),
              pw.SizedBox(height: 5),
              finalDetails(
                  txt1: 'Due Amount:',
                  txt2:
                      '${double.parse('${saleOrderDataModel?.finalTotal ?? 0.00}') - double.parse('${saleOrderDataModel?.totalPaid ?? 0.00}')}'),
              pw.SizedBox(height: 5),
            ],
          ),
          pw.SizedBox(height: 15),
          pw.Divider(),
          pw.SizedBox(height: 10),
          pw.Center(
              child: pw.Text(
                  'Digitally generated invoice,\nvalid without signature or stamp')),
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

  totalItemsTax() {
    double totalTax = 0.00;
    for (int i = 0; i < saleOrderDataModel!.sellLines.length; i++) {
      totalTax = totalTax +
          (double.parse('${saleOrderDataModel!.sellLines[i].itemTax}') *
              double.parse('${saleOrderDataModel!.sellLines[i].quantity}')
          // * double.parse(
          //     '${Get.find<AllProductsController>().checkUnitValueWithGivenId(idNumber: saleOrderDataModel?.sellLines[i].subUnitId)}')
          );
    }
    return totalTax;
  }

  printBasicInfoWidget({String? title, String? titleVal}) {
    return pw.Padding(
      padding: pw.EdgeInsets.symmetric(vertical: 2.5),
      child: pw.Row(
        // mainAxisAlignment: ,
        children: [
          if (title != null) pw.Text(title ?? ''),
          if (titleVal != null) pw.Text(titleVal ?? ''),
          pw.SizedBox(),
        ],
      ),
    );
  }
}
