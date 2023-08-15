import 'dart:io';
import 'dart:typed_data';
import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:image/image.dart' as i;

import '../../Config/DateTimeFormat.dart';
import '../../Models/ReceiptModel.dart';
import '../../Services/storage_services.dart';

Future<List<int>> posReceiptLayout(
  Generator printer, {
  SingleReceiptData? singleReceiptModel,
  // List<SellLine>? items,
  String? kitchenName,
}) async {
  // double totalPayedAmount() {
  //   double totalPayed = 0;
  //   selectedSaleOrderData.paymentLines.forEach((element) {
  //     totalPayed += double.parse('${element.amount ?? 0}');
  //   });
  //   return totalPayed;
  // }

  // double? anyAmountDue({bool isDueValue = false}) {
  //   if (selectedSaleOrderData.sellDue != null &&
  //       selectedSaleOrderData.sellDue! > 0)
  //     return selectedSaleOrderData.sellDue!;
  //   else if (selectedSaleOrderData.finalTotal != null) {
  //     double due = double.parse('${selectedSaleOrderData.finalTotal ?? 0}') -
  //         totalPayedAmount();
  //     if (due > 0) return due;
  //   }
  //   return null;
  // }

  List<int> bytes = [];
  // String totalQuantity(List<SellLine> allSellItems) {
  //   int totalProducts = 0;
  //   try {
  //     allSellItems.forEach((element) {
  //       totalProducts += double.parse('${element.quantity}').toInt();
  //     });
  //   } catch (_e) {
  //     debugPrint('Error => $_e');
  //   }
  //   return totalProducts.toString();
  // }

  List<int> printDivider() {
    return printer.text('------------------------------------------------',
        styles: PosStyles(align: PosAlign.center));
  }

  List<int> centeredBoldTitle(String? txt) {
    return printer.text(
      txt ?? '',
      styles: PosStyles(align: PosAlign.center, bold: true),
    );
  }

  List<int> centeredTitle(String? txt) {
    return printer.text(
      txt ?? '',
      styles: PosStyles(align: PosAlign.center),
    );
  }

  List<int> cl2({String? cTxt1, String? cTxt2}) {
    try {
      return (cTxt1 == null && cTxt2 == null)
          ? printer.text('')
          : printer.row(
              [
                if (cTxt1 != null)
                  PosColumn(width: cTxt2 == null ? 12 : 6, text: cTxt1 ?? ''),
                if (cTxt2 != null)
                  PosColumn(
                      width: cTxt1 == null ? 12 : 6,
                      text: cTxt2 ?? '',
                      styles: PosStyles(align: PosAlign.right)),
              ],
            );
    } catch (e) {
      debugPrint('pos invoice and kot print layout issue -> $e');
      return printer.text('Inside cl5 Issue -> $e');
    }
  }

  List<int> cl5(
      {String? cTxt1,
      String? cTxt2,
      cTxt3,
      String? cTxt4,
      String? cTxt5,
      bool isBold = false}) {
    try {
      return (cTxt1 == null &&
              cTxt2 == null &&
              cTxt3 == null &&
              cTxt4 == null &&
              cTxt5 == null)
          ? printer.text('')
          : printer.row(
              [
                PosColumn(
                  width: 1,
                  text: cTxt1 ?? '',
                  styles: PosStyles(bold: isBold),
                ),
                PosColumn(
                  width: cTxt4 == null && cTxt5 == null
                      ? 9
                      : cTxt4 == null || cTxt5 == null
                          ? 10
                          : 6,
                  text: cTxt2 ?? '',
                  styles: PosStyles(bold: isBold),
                ),
                PosColumn(
                  width: cTxt4 == null && cTxt5 == null ? 2 : 1,
                  text: cTxt3 ?? '',
                  styles: PosStyles(bold: isBold, align: PosAlign.center),
                ),
                if (cTxt4 != null)
                  PosColumn(
                    width: 2,
                    text: cTxt4 ?? '',
                    styles: PosStyles(bold: isBold, align: PosAlign.right),
                  ),
                if (cTxt5 != null)
                  PosColumn(
                    width: 2,
                    text: cTxt5 ?? '',
                    styles: PosStyles(bold: isBold, align: PosAlign.right),
                  ),
              ],
            );
    } catch (e) {
      debugPrint('pos invoice and kot print layout issue -> $e');
      return printer.text('Inside cl5 Issue -> $e');
    }
  }

  /// Layout
  // Business Logo
  Future<List<int>> fetchNetworkImage(String? imageUrl) async {
    if (imageUrl == null) return [];
    try {
      File file = await DefaultCacheManager()
          .getSingleFile(imageUrl, key: 'bizmodo_business_logo');

      return await file.readAsBytes();
    } catch (e) {
      var response = await http.get(Uri.parse(imageUrl));
      return response.bodyBytes;
    }
  }

  await fetchNetworkImage(
          AppStorage.getBusinessDetailsData()?.businessData?.logo)
      .then((img) {
    // final i.Image? image = i.decodeImage(img);
    // if (image != null) bytes += printer.image(image);

    final i.Image? image = i.decodeImage(img);
    if (image != null) {
      // Resize the image here
      final int targetHeight = 300; // Set your desired width
      final int targetWidth =
          (image.width * (targetHeight / image.height)).round();

      final resizedImage =
          i.copyResize(image, width: targetWidth, height: targetHeight);

      // Convert the resized image to bytes
      final List<int> resizedBytes = i.encodePng(resizedImage);

      // Print the resized image
      bytes += printer.image(i.decodeImage(Uint8List.fromList(resizedBytes))!);
    }
  });

  // Print image:
  // final ByteData data = await rootBundle.load(
  //     'https://manage.bizmodo.ae/uploads/business_logos/1682843394_Elegant%20Logo%20small.png');
  // final Uint8List imgBytes = data.buffer.asUint8List();
  // i.Image img = i.decodeImage(imgBytes)!;
  // bytes += printer.imageRaster(img);

  // printer.image();

  // Slip Title / Business Name
  bytes += centeredBoldTitle(
    AppStorage.getBusinessDetailsData()?.businessData?.name ?? '',
  );

  // Business Location
  bytes += centeredTitle(
    '${AppStorage.getBusinessDetailsData()?.businessData?.locations.first.id ?? ''}, '
    '${AppStorage.getBusinessDetailsData()?.businessData?.locations.first.landmark ?? ''}, '
    '${AppStorage.getBusinessDetailsData()?.businessData?.locations.first.city ?? ''}, '
    '${AppStorage.getBusinessDetailsData()?.businessData?.locations.first.country ?? ''}',
  );

  // Business Contact Information
  bytes += centeredTitle(
    'Contact No: ${AppStorage.getBusinessDetailsData()?.businessData?.locations.first.mobile ?? ''}, '
    'Alternate No: ${AppStorage.getBusinessDetailsData()?.businessData?.locations.first.alternateNumber ?? ''}',
  );

  bytes += centeredTitle(
    'Email: ${AppStorage.getBusinessDetailsData()?.businessData?.locations.first.email ?? ''}',
  );

  bytes += centeredTitle(
    '${AppStorage.getBusinessDetailsData()?.businessData?.taxLabel1 ?? ''}:${AppStorage.getBusinessDetailsData()?.businessData?.taxNumber1 ?? ''}',
  );

  bytes += printDivider();
  bytes += centeredBoldTitle(
    'Receipt Voucher',
  );
  // bytes += centeredTitle(
  //   'Receipt Voucher',
  // );
  bytes += printDivider();
  // Customer Information
  bytes += cl2(
    cTxt1: (singleReceiptModel?.contact?.name != null)
        ? 'Customer: ${singleReceiptModel?.contact?.name ?? ''}'
        : null,
    cTxt2: (singleReceiptModel?.contact?.mobile != null)
        ? 'Contact No: ${singleReceiptModel?.contact?.mobile ?? ''}'
        : null,
  );
  bytes += cl2(
    cTxt1: 'Salesman: ${singleReceiptModel?.salesPerson?.firstName ?? ''}',
    // Invoice Number
    cTxt2: 'Receipt Date: ${singleReceiptModel?.transactionDate ?? ''}',

    // Staff Name
  );

  bytes += cl2(
    cTxt1: 'Invoice No: ${singleReceiptModel?.invoiceNo ?? ''}',
    // Invoice Number

    // Staff Name
  );

  /// product details

  // Divider
  bytes += printDivider();

  // Items Table Columns Title
  bytes += cl5(
    cTxt1: '#',
    cTxt2: 'Document Reference No',
    cTxt3: 'Amount',
    isBold: true,
    cTxt4: null,
    cTxt5: null,
  );

  // Divider
  bytes += printDivider();

  // Items Table
  List.generate(
    singleReceiptModel!.paymentLines!.length,
    (index) {
      bytes += cl5(
        // Serial Number
        cTxt1: '${index + 1}',
        // Item Details
        cTxt2: '${singleReceiptModel.paymentLines?[index].paymentRefNo}',

        // Item Quantity
        cTxt3:
            '${AppFormat.doubleToStringUpTo2(singleReceiptModel.paymentLines?[index].amount)}',
        // Price
      );
    },
  );

  // Divider

  bytes += printDivider();

  bytes +=
      cl2(cTxt1: 'Currency: AED', cTxt2: '${singleReceiptModel.finalTotal}');
  bytes += cl2(
    cTxt1: 'Payment Mode: CASH',
  );

  bytes += cl2(
    cTxt1: 'Total outstanding Amount: 0.00 AED',
  );

  // Divider
  bytes += printDivider();
  bytes += centeredTitle(
    'Digitally generated receipt, valid without signature or stamp',
  );
  return bytes;
}
