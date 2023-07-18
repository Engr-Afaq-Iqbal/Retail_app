import 'dart:io';
import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:image/image.dart' as i;
import 'package:path_provider/path_provider.dart';

import '/Models/order_type_model/payment_line_model.dart';
import '../../Config/DateTimeFormat.dart';
import '../../Config/const.dart';
import '../../Controllers/ProductController/product_cart_controller.dart';
import '../../Services/storage_services.dart';
import '/Models/order_type_model/SellLineModel.dart';
import '../../Models/order_type_model/SaleOrderModel.dart';

Future<List<int>> posInvoiceAndKotPrintLayout(
  Generator printer, {
  required SaleOrderDataModel selectedSaleOrderData,
  List<SellLine>? items,
  required bool isInvoice,
  required bool isKOT,
  String? kitchenName,
}) async {
  double totalPayedAmount() {
    double totalPayed = 0;
    selectedSaleOrderData.paymentLines.forEach((element) {
      totalPayed += double.parse('${element.amount ?? 0}');
    });
    return totalPayed;
  }

  double? anyAmountDue({bool isDueValue = false}) {
    if (selectedSaleOrderData.sellDue != null &&
        selectedSaleOrderData.sellDue! > 0)
      return selectedSaleOrderData.sellDue!;
    else if (selectedSaleOrderData.finalTotal != null) {
      double due = double.parse('${selectedSaleOrderData.finalTotal ?? 0}') -
          totalPayedAmount();
      if (due > 0) return due;
    }
    return null;
  }

  List<int> bytes = [];
  String totalQuantity(List<SellLine> allSellItems) {
    int totalProducts = 0;
    try {
      allSellItems.forEach((element) {
        totalProducts += double.parse('${element.quantity}').toInt();
      });
    } catch (_e) {
      debugPrint('Error => $_e');
    }
    return totalProducts.toString();
  }

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
  if (isInvoice) {
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
      final i.Image? image = i.decodeImage(img);
      if (image != null) bytes += printer.image(image);
    });

    // Print image:
    // final ByteData data = await rootBundle.load(
    //     'https://manage.bizmodo.ae/uploads/business_logos/1682843394_Elegant%20Logo%20small.png');
    // final Uint8List imgBytes = data.buffer.asUint8List();
    // i.Image img = i.decodeImage(imgBytes)!;
    // bytes += printer.imageRaster(img);

    // printer.image();
  }
  // Slip Title / Business Name
  bytes += centeredBoldTitle(
    AppStorage.getBusinessDetailsData()?.businessData?.name ?? '',
  );

  // Business Location
  bytes += centeredTitle(
    '${AppStorage.getBusinessDetailsData()?.businessData?.locations.first.landmark ?? ''}, '
    '${AppStorage.getBusinessDetailsData()?.businessData?.locations.first.city ?? ''}, '
    '${AppStorage.getBusinessDetailsData()?.businessData?.locations.first.country ?? ''}',
  );

  // Business Contact Information
  bytes += centeredTitle(
    'Mobile: ${AppStorage.getBusinessDetailsData()?.businessData?.locations.first.mobile ?? ''}, '
    'Email: ${AppStorage.getBusinessDetailsData()?.businessData?.locations.first.email ?? ''}',
  );

  ///
  ///
  /// TODO: Invoice Label ke setting add krni han...
  ///
  ///
  // Tax Invoice Label
  if (isInvoice) bytes += centeredBoldTitle(AppStorage.getPrintInvoiceTitle());
  if (isInvoice)
    bytes += centeredTitle(
      '${AppStorage.getBusinessDetailsData()?.businessData?.taxLabel1 ?? ''}:${AppStorage.getBusinessDetailsData()?.businessData?.taxNumber1 ?? ''}',
    );

  // Invoice Number / user
  bytes += cl2(
    // Invoice Number
    cTxt1: (isInvoice)
        ? 'Invoice: ${selectedSaleOrderData.invoiceNo ?? ''}'
        : null,

    // Staff Name
    cTxt2: 'User: ${AppStorage.getLoggedUserData()?.staffUser.firstName ?? ''}',
  );

  // Transaction Date & Time
  bytes += cl2(
    cTxt1: (selectedSaleOrderData.transactionDate != null)
        ? 'Date: ${AppFormat.dateOnly(selectedSaleOrderData.transactionDate!)}'
        : null,
    cTxt2:
        'Time: ${AppFormat.timeOnly(selectedSaleOrderData.transactionDate!)} ',
  );

  // Kitchen Name

  bytes += cl2(
    cTxt1: '${selectedSaleOrderData.typesOfService?.name}',
    cTxt2: (isKOT) ? 'Kitchen: ${kitchenName ?? ''}' : null,
  );

  // Table Name & Service Staff
  debugPrint(selectedSaleOrderData.toString());
  bytes += cl2(
    cTxt1: (selectedSaleOrderData.tableData?.name == AppValues.dineIn)
        ? 'Table: ${selectedSaleOrderData.tableData?.name ?? ''}'
        : null,
    cTxt2: 'Staff: ${selectedSaleOrderData.serviceStaff?.firstName ?? ''}',
  );
  // Customer Information
  bytes += cl2(
    cTxt1: (selectedSaleOrderData.contact?.name != null)
        ? 'Customer: ${selectedSaleOrderData.contact?.name ?? ''}'
        : null,
    cTxt2: (selectedSaleOrderData.contact?.mobile != null)
        ? 'Mobile: ${selectedSaleOrderData.contact?.mobile ?? ''}'
        : null,
  );

  // Table Name & Service Staff
  // if (isKOT)
  //   bytes += cl2(
  //     cTxt1: 'Table: ${selectedSaleOrderData.tableData?.name ?? ''}',
  //     cTxt2: 'Staff: ${selectedSaleOrderData.serviceStaff?.firstName ?? ''}',
  //   );
  // Table Name & Service Staff
  // bytes += cl2(
  //   cTxt1: (selectedSaleOrderData.typesOfService == AppValues.dineIn &&
  //           selectedSaleOrderData.tableData != null)
  //       ? 'Table: ${selectedSaleOrderData.tableData?.name ?? ''}'
  //       : (selectedSaleOrderData.typesOfService == AppValues.delivery &&
  //               selectedSaleOrderData.contact != null)
  //           ? 'Address: ${selectedSaleOrderData.contact?.addressLine1}'
  //           : null,
  //   cTxt2: (selectedSaleOrderData.serviceStaff != null)
  //       ? '${selectedSaleOrderData.typesOfService == AppValues.delivery ? 'Driver' : 'Waiter'}: '
  //           '${selectedSaleOrderData.serviceStaff?.firstName}'
  //       : null,
  // );

  /// product details

  // Divider
  bytes += printDivider();

  // Items Table Columns Title
  bytes += cl5(
    cTxt1: '#',
    cTxt2: 'Item',
    cTxt3: 'Qty',
    isBold: true,
    cTxt4: (isInvoice) ? 'Price' : null,
    cTxt5: (isInvoice) ? 'Total' : null,
  );

  // Divider
  bytes += printDivider();

  // Items Table
  List.generate(
    items != null ? items.length : selectedSaleOrderData.sellLines.length,
    (index) {
      bytes += cl5(
        // Serial Number
        cTxt1: '${index + 1}',
        // Item Details
        cTxt2: AppFormat.removeArabic(
                '${items != null ? items[index].product?.name : selectedSaleOrderData.sellLines[index].product?.name}')
            .trim(),
        /* Item Variation & Modifiers
              if (selectedSaleOrderData
                            .sellLines[index].product?.modifier !=
                        null)
                      ...List.generate(
                        selectedSaleOrderData
                            .sellLines[index].product!.modifier.length,
                        (modifierIndex) {
                          ProductModel prodMod = selectedSaleOrderData
                              .sellLines[index]
                              .product!
                              .modifier[modifierIndex]
                              .productModifier;
                          return SizedBox(
                            width: 175,
                            child: Column(
                              children: [
                                Text(
                                  '${selectedSaleOrderData.sellLines[index].product!.modifier[modifierIndex].productModifier.name}',
                                  textDirection: TextDirection.rtl,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black,
                                    // font: font,
                                  ),
                                ),
                                Wrap(
                                  children: prodMod.variations
                                      .map(
                                        (modVar) => Text(
                                          ' - ${modVar.name} ( ${selectedSaleOrderData.sellLines[index].product!.quantity * modVar.productVariationQuantity} )',
                                          textDirection: TextDirection.rtl,
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.black,
                                            // font: font,
                                          ),
                                        ),
                                      )
                                      .toList(),
                                )
                              ],
                            ),
                          );
                        },
                      )
              */
        // Item Quantity
        cTxt3:
            '${items != null ? items[index].quantity : selectedSaleOrderData.sellLines[index].quantity}',
        // Price
        cTxt4: (isInvoice)
            ? '${AppFormat.doubleToStringUpTo2('${selectedSaleOrderData.sellLines[index].unitPriceIncTax}') ?? ''}'
            : null,
        // Total
        cTxt5: (isInvoice)
            ? '${AppFormat.doubleToStringUpTo2('${Get.find<ProductCartController>().productTotalAmount(selectedSaleOrderData.sellLines[index].unitPriceIncTax, selectedSaleOrderData.sellLines[index].quantity)}') ?? ''}'
            : null,
      );
    },
  );

  // Divider

  bytes += printDivider();

  // Totals Information
  bytes += cl2(
    // Total Items
    cTxt1: 'Items: ${selectedSaleOrderData.sellLines.length}',
    cTxt2: (isInvoice)
        ? 'Sub Total: ${AppFormat.doubleToStringUpTo2('${selectedSaleOrderData.totalBeforeTax}')}'
        : null,
  );
  bytes += cl2(
    // Total Quantity
    cTxt1: 'Qty: ${totalQuantity(selectedSaleOrderData.sellLines)}',
    // Total Quantity
    cTxt2: (isInvoice)
        ? 'VAT: ${AppFormat.doubleToStringUpTo2('${selectedSaleOrderData.taxAmount}')}'
        : null,
  );

  if (isInvoice)
    bytes += cl2(
      cTxt1: '',
      cTxt2:
          'Total: ${AppFormat.doubleToStringUpTo2('${selectedSaleOrderData.finalTotal}')}',
    );

  // Divider
  bytes += printDivider();

  //Payment heading
  if (isInvoice) bytes += cl2(cTxt1: 'Payment');

  //Date & Time
  // if ((selectedSaleOrderData.sellDue == null ||
  //         selectedSaleOrderData.sellDue! < totalPayedAmount()) &&
  //     selectedSaleOrderData.transactionDate != null &&
  //     isInvoice)
  //   bytes += cl2(
  //     cTxt1:
  //         'Date: ${AppFormat.dateYYYYMMDDHHMM24(selectedSaleOrderData.transactionDate ?? DateTime.now())}',
  //   );

  // bytes += cl2(
  //   cTxt1: paymentStatusValues.reverse?[selectedSaleOrderData.paymentStatus]
  //           .toString()
  //           .capitalize ??
  //       '',
  // );
  debugPrint(selectedSaleOrderData.paymentLines.toString());
  if (isInvoice)
    for (PaymentLine e in selectedSaleOrderData.paymentLines) {
      bytes += cl2(
        cTxt1: (e.chequeNumber != null)
            ? 'Cheque #: ${e.chequeNumber}'
            : (e.transactionNo != null)
                ? 'Tr #: ${e.transactionNo}'
                : '',
        cTxt2:
            '${(e.isReturn == 1) ? 'Return Amount' : '${e.method}'}: ${AppFormat.doubleToStringUpTo2(e.amount)}',
      );
      if (e.isReturn == 0)
        bytes += cl2(cTxt1: '${AppFormat.dateYYYYMMDDHHMM24(e.paidOn)}');
    }

  if (selectedSaleOrderData.totalPaid != null && isInvoice)
    bytes += cl2(cTxt2: 'Total Paid Amount ${selectedSaleOrderData.totalPaid}');

  if (anyAmountDue() != null && isInvoice)
    bytes += cl2(cTxt2: 'Due ${anyAmountDue()}');

  // Divider
  if (isInvoice) bytes += printDivider();
  //Additional Notes
  bytes += cl2(cTxt1: 'Note:');
  bytes += cl2(cTxt1: '${selectedSaleOrderData.additionalNotes ?? ''}');

  // Footer
  if (isInvoice) bytes += printDivider();
  if (isInvoice) bytes += centeredBoldTitle('Thank You... Visit Again...');
  return bytes;
}
