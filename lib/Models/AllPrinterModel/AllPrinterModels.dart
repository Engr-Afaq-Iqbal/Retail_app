// To parse this JSON data, do
//
//     final allPrintersModel = allPrintersModelFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/material.dart';

List<AllPrintersModel> allPrintersModelFromJson(String str) =>
    List<AllPrintersModel>.from(
        json.decode(str).map((x) => AllPrintersModel.fromJson(x)));

String allPrintersModelToJson(List<AllPrintersModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AllPrintersModel {
  AllPrintersModel({
    this.id,
    this.businessId,
    this.name,
    this.connectionType,
    this.capabilityProfile,
    this.charPerLine,
    this.ipAddress,
    this.port,
    this.path,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
    // this.isEnabled = true,
    this.isEnabledKOT = false,
    // this.isEnabledInvoice = false,
    this.isEnableCreateOrderInvoiceAutoPrint = false,
    // this.isEnableUpdateOrderInvoiceAutoPrint = false,
    this.isEnableCheckoutOrderInvoiceAutoPrint = false,
    this.isEnableAutoPrintRegister = false,
    this.kitchenPrinter,
  });

  int? id;
  int? businessId;
  String? name;
  String? connectionType;
  String? capabilityProfile;
  String? charPerLine;
  String? ipAddress;
  String? port;
  String? path;
  int? createdBy;
  DateTime? createdAt;
  DateTime? updatedAt;
  // late bool isEnabled;
  bool isEnabledKOT = false;
  // bool isEnabledInvoice = false;
  bool isEnableCreateOrderInvoiceAutoPrint = false;
  // bool isEnableUpdateOrderInvoiceAutoPrint = false;
  bool isEnableCheckoutOrderInvoiceAutoPrint = false;
  bool isEnableAutoPrintRegister = false;
  KitchenPrinter? kitchenPrinter;

  AllPrintersModel copyWith({
    int? id,
    int? businessId,
    String? name,
    String? connectionType,
    String? capabilityProfile,
    String? charPerLine,
    String? ipAddress,
    String? port,
    String? path,
    int? createdBy,
    DateTime? createdAt,
    DateTime? updatedAt,
    // bool isEnabled = true,
    bool isEnabledKOT = false,
    // bool isEnabledInvoice = false,
    bool isEnableCreateOrderInvoiceAutoPrint = false,
    // bool isEnableUpdateOrderInvoiceAutoPrint = false,
    bool isEnableCheckoutOrderInvoiceAutoPrint = true,
    bool isEnableAutoPrintRegister = false,
    KitchenPrinter? kitchenPrinter,
  }) =>
      AllPrintersModel(
        id: id ?? this.id,
        businessId: businessId ?? this.businessId,
        name: name ?? this.name,
        connectionType: connectionType ?? this.connectionType,
        capabilityProfile: capabilityProfile ?? this.capabilityProfile,
        charPerLine: charPerLine ?? this.charPerLine,
        ipAddress: ipAddress ?? this.ipAddress,
        port: port ?? this.port,
        path: path ?? this.path,
        createdBy: createdBy ?? this.createdBy,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        // isEnabled: isEnabled,
        isEnabledKOT: this.isEnabledKOT,
        // isEnabledInvoice: isEnabledInvoice,
        isEnableCreateOrderInvoiceAutoPrint:
            this.isEnableCreateOrderInvoiceAutoPrint,
        // isEnableUpdateOrderInvoiceAutoPrint:
        //     isEnableUpdateOrderInvoiceAutoPrint,
        isEnableCheckoutOrderInvoiceAutoPrint:
            this.isEnableCheckoutOrderInvoiceAutoPrint,
        isEnableAutoPrintRegister: this.isEnableAutoPrintRegister,
        kitchenPrinter: kitchenPrinter ?? this.kitchenPrinter,
      );

  AllPrintersModel.fromJson(Map<String, dynamic> json) {
    id = int.tryParse('${json["id"]}');
    businessId = int.tryParse('${json["business_id"]}');
    name = json["name"];
    connectionType = json["connection_type"];
    capabilityProfile = json["capability_profile"];
    charPerLine = json["char_per_line"];
    ipAddress = json["ip_address"];
    port = json["port"];
    path = json["path"];
    createdBy = int.tryParse('${json["created_by"]}');
    createdAt = DateTime.tryParse('${json["created_at"]}');
    updatedAt = DateTime.tryParse('${json["updated_at"]}');
    // isEnabled = json['is_enabled'] ?? true;
    isEnabledKOT = json['is_enabled_kot'] ?? false;
    // isEnabledInvoice = json['is_enabled_invoice'] ??
    //     (Get.find<AllPrinterController>().isPrinterNameReceipt(json["name"])
    //         ? true
    //         : false);
    isEnableCreateOrderInvoiceAutoPrint =
        json['create_order_invoice_auto_print'] ?? false;
    // isEnableUpdateOrderInvoiceAutoPrint =
    //     json['update_order_invoice_auto_print'] ?? false;
    isEnableCheckoutOrderInvoiceAutoPrint =
        json['checkout_order_invoice_auto_print'] ?? true;
    isEnableAutoPrintRegister = json['auto_print_register'] ?? false;
    try {
      if (json["kitchen_printer"] != null)
        kitchenPrinter = KitchenPrinter.fromJson(json["kitchen_printer"]);
    } catch (e) {
      debugPrint('Kitchen Printer -> All printers Model -> Error => $e');
    }
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "business_id": businessId,
        "name": name,
        "connection_type": connectionType,
        "capability_profile": capabilityProfile,
        "char_per_line": charPerLine,
        "ip_address": ipAddress,
        "port": port,
        "path": path,
        "created_by": createdBy,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        // "is_enabled": isEnabled,
        "is_enabled_kot": isEnabledKOT,
        // "is_enabled_invoice": isEnabledInvoice,
        "create_order_invoice_auto_print": isEnableCreateOrderInvoiceAutoPrint,
        // "update_order_invoice_auto_print": isEnableUpdateOrderInvoiceAutoPrint,
        "checkout_order_invoice_auto_print":
            isEnableCheckoutOrderInvoiceAutoPrint,
        "auto_print_register": isEnableAutoPrintRegister,
        "kitchen_printer": kitchenPrinter?.toJson(),
      };
}

class KitchenPrinter {
  KitchenPrinter({
    this.id,
    this.receiptPrinterType,
    this.printerId,
    this.invoiceLayoutId,
    this.invoiceSchemeId,
    this.printReceiptOnInvoice,
    this.kitchenId,
    this.locationId,
    this.businessId,
    this.createdAt,
    this.updatedAt,
    this.kitchen,
    this.invoiceSchema,
    this.invoiceLayout,
  });

  int? id;
  int? receiptPrinterType;
  int? printerId;
  int? invoiceLayoutId;
  int? invoiceSchemeId;
  int? printReceiptOnInvoice;
  int? kitchenId;
  int? locationId;
  int? businessId;
  dynamic createdAt;
  dynamic updatedAt;
  Kitchen? kitchen;
  InvoiceSchema? invoiceSchema;
  InvoiceLayout? invoiceLayout;

  KitchenPrinter copyWith({
    int? id,
    int? receiptPrinterType,
    int? printerId,
    int? invoiceLayoutId,
    int? invoiceSchemeId,
    int? printReceiptOnInvoice,
    int? kitchenId,
    int? locationId,
    int? businessId,
    dynamic createdAt,
    dynamic updatedAt,
    Kitchen? kitchen,
    InvoiceSchema? invoiceSchema,
    InvoiceLayout? invoiceLayout,
  }) =>
      KitchenPrinter(
        id: id ?? this.id,
        receiptPrinterType: receiptPrinterType ?? this.receiptPrinterType,
        printerId: printerId ?? this.printerId,
        invoiceLayoutId: invoiceLayoutId ?? this.invoiceLayoutId,
        invoiceSchemeId: invoiceSchemeId ?? this.invoiceSchemeId,
        printReceiptOnInvoice:
            printReceiptOnInvoice ?? this.printReceiptOnInvoice,
        kitchenId: kitchenId ?? this.kitchenId,
        locationId: locationId ?? this.locationId,
        businessId: businessId ?? this.businessId,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        kitchen: kitchen ?? this.kitchen,
        invoiceSchema: invoiceSchema ?? this.invoiceSchema,
        invoiceLayout: invoiceLayout ?? this.invoiceLayout,
      );

  factory KitchenPrinter.fromJson(Map<String, dynamic> json) => KitchenPrinter(
        id: json["id"],
        receiptPrinterType: json["receipt_printer_type"],
        printerId: json["printer_id"],
        invoiceLayoutId: json["invoice_layout_id"],
        invoiceSchemeId: json["invoice_scheme_id"],
        printReceiptOnInvoice: json["print_receipt_on_invoice"],
        kitchenId: json["kitchen_id"],
        locationId: json["location_id"],
        businessId: json["business_id"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        kitchen:
            json["kitchen"] == null ? null : Kitchen.fromJson(json["kitchen"]),
        invoiceSchema: json["invoice_schema"] == null
            ? null
            : InvoiceSchema.fromJson(json["invoice_schema"]),
        invoiceLayout: json["invoice_layout"] == null
            ? null
            : InvoiceLayout.fromJson(json["invoice_layout"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "receipt_printer_type": receiptPrinterType,
        "printer_id": printerId,
        "invoice_layout_id": invoiceLayoutId,
        "invoice_scheme_id": invoiceSchemeId,
        "print_receipt_on_invoice": printReceiptOnInvoice,
        "kitchen_id": kitchenId,
        "location_id": locationId,
        "business_id": businessId,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "kitchen": kitchen?.toJson(),
        "invoice_schema": invoiceSchema?.toJson(),
        "invoice_layout": invoiceLayout?.toJson(),
      };
}

class InvoiceLayout {
  InvoiceLayout({
    this.id,
    this.name,
    this.headerText,
    this.invoiceNoPrefix,
    this.quotationNoPrefix,
    this.invoiceHeading,
    this.subHeadingLine1,
    this.subHeadingLine2,
    this.subHeadingLine3,
    this.subHeadingLine4,
    this.subHeadingLine5,
    this.invoiceHeadingNotPaid,
    this.invoiceHeadingPaid,
    this.quotationHeading,
    this.subTotalLabel,
    this.discountLabel,
    this.taxLabel,
    this.totalLabel,
    this.roundOffLabel,
    this.totalDueLabel,
    this.paidLabel,
    this.showClientId,
    this.clientIdLabel,
    this.clientTaxLabel,
    this.dateLabel,
    this.dateTimeFormat,
    this.showTime,
    this.showBrand,
    this.showSku,
    this.showCatCode,
    this.showExpiry,
    this.showLot,
    this.showImage,
    this.showSaleDescription,
    this.salesPersonLabel,
    this.showSalesPerson,
    this.tableProductLabel,
    this.tableQtyLabel,
    this.tableUnitPriceLabel,
    this.tableSubtotalLabel,
    this.catCodeLabel,
    this.logo,
    this.showLogo,
    this.showBusinessName,
    this.showLocationName,
    this.showLandmark,
    this.showCity,
    this.showState,
    this.showZipCode,
    this.showCountry,
    this.showMobileNumber,
    this.showAlternateNumber,
    this.showEmail,
    this.showTax1,
    this.showTax2,
    this.showBarcode,
    this.showPayments,
    this.showCustomer,
    this.customerLabel,
    this.commissionAgentLabel,
    this.showCommissionAgent,
    this.showRewardPoint,
    this.highlightColor,
    this.footerText,
    this.moduleInfo,
    this.commonSettings,
    this.isDefault,
    this.businessId,
    this.showLetterHead,
    this.letterHead,
    this.showQrCode,
    this.qrCodeFields,
    this.design,
    this.cnHeading,
    this.cnNoLabel,
    this.cnAmountLabel,
    this.tableTaxHeadings,
    this.showPreviousBal,
    this.prevBalLabel,
    this.changeReturnLabel,
    this.productCustomFields,
    this.contactCustomFields,
    this.locationCustomFields,
    this.createdAt,
    this.updatedAt,
    this.print,
  });

  int? id;
  String? name;
  String? headerText;
  String? invoiceNoPrefix;
  String? quotationNoPrefix;
  String? invoiceHeading;
  dynamic subHeadingLine1;
  dynamic subHeadingLine2;
  dynamic subHeadingLine3;
  dynamic subHeadingLine4;
  dynamic subHeadingLine5;
  dynamic invoiceHeadingNotPaid;
  dynamic invoiceHeadingPaid;
  String? quotationHeading;
  String? subTotalLabel;
  String? discountLabel;
  String? taxLabel;
  String? totalLabel;
  String? roundOffLabel;
  String? totalDueLabel;
  String? paidLabel;
  int? showClientId;
  dynamic clientIdLabel;
  dynamic clientTaxLabel;
  String? dateLabel;
  dynamic dateTimeFormat;
  int? showTime;
  int? showBrand;
  int? showSku;
  int? showCatCode;
  int? showExpiry;
  int? showLot;
  int? showImage;
  int? showSaleDescription;
  dynamic salesPersonLabel;
  int? showSalesPerson;
  String? tableProductLabel;
  String? tableQtyLabel;
  String? tableUnitPriceLabel;
  String? tableSubtotalLabel;
  String? catCodeLabel;
  String? logo;
  int? showLogo;
  int? showBusinessName;
  int? showLocationName;
  int? showLandmark;
  int? showCity;
  int? showState;
  int? showZipCode;
  int? showCountry;
  int? showMobileNumber;
  int? showAlternateNumber;
  int? showEmail;
  int? showTax1;
  int? showTax2;
  int? showBarcode;
  int? showPayments;
  int? showCustomer;
  String? customerLabel;
  String? commissionAgentLabel;
  int? showCommissionAgent;
  int? showRewardPoint;
  String? highlightColor;
  String? footerText;
  String? moduleInfo;
  CommonSettings? commonSettings;
  int? isDefault;
  int? businessId;
  int? showLetterHead;
  dynamic letterHead;
  int? showQrCode;
  List<String>? qrCodeFields;
  String? design;
  String? cnHeading;
  String? cnNoLabel;
  String? cnAmountLabel;
  dynamic tableTaxHeadings;
  int? showPreviousBal;
  dynamic prevBalLabel;
  String? changeReturnLabel;
  dynamic productCustomFields;
  dynamic contactCustomFields;
  dynamic locationCustomFields;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? print;

  InvoiceLayout copyWith({
    int? id,
    String? name,
    String? headerText,
    String? invoiceNoPrefix,
    String? quotationNoPrefix,
    String? invoiceHeading,
    dynamic subHeadingLine1,
    dynamic subHeadingLine2,
    dynamic subHeadingLine3,
    dynamic subHeadingLine4,
    dynamic subHeadingLine5,
    dynamic invoiceHeadingNotPaid,
    dynamic invoiceHeadingPaid,
    String? quotationHeading,
    String? subTotalLabel,
    String? discountLabel,
    String? taxLabel,
    String? totalLabel,
    String? roundOffLabel,
    String? totalDueLabel,
    String? paidLabel,
    int? showClientId,
    dynamic clientIdLabel,
    dynamic clientTaxLabel,
    String? dateLabel,
    dynamic dateTimeFormat,
    int? showTime,
    int? showBrand,
    int? showSku,
    int? showCatCode,
    int? showExpiry,
    int? showLot,
    int? showImage,
    int? showSaleDescription,
    dynamic salesPersonLabel,
    int? showSalesPerson,
    String? tableProductLabel,
    String? tableQtyLabel,
    String? tableUnitPriceLabel,
    String? tableSubtotalLabel,
    String? catCodeLabel,
    String? logo,
    int? showLogo,
    int? showBusinessName,
    int? showLocationName,
    int? showLandmark,
    int? showCity,
    int? showState,
    int? showZipCode,
    int? showCountry,
    int? showMobileNumber,
    int? showAlternateNumber,
    int? showEmail,
    int? showTax1,
    int? showTax2,
    int? showBarcode,
    int? showPayments,
    int? showCustomer,
    String? customerLabel,
    String? commissionAgentLabel,
    int? showCommissionAgent,
    int? showRewardPoint,
    String? highlightColor,
    String? footerText,
    String? moduleInfo,
    CommonSettings? commonSettings,
    int? isDefault,
    int? businessId,
    int? showLetterHead,
    dynamic letterHead,
    int? showQrCode,
    List<String>? qrCodeFields,
    String? design,
    String? cnHeading,
    String? cnNoLabel,
    String? cnAmountLabel,
    dynamic tableTaxHeadings,
    int? showPreviousBal,
    dynamic prevBalLabel,
    String? changeReturnLabel,
    dynamic productCustomFields,
    dynamic contactCustomFields,
    dynamic locationCustomFields,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? print,
  }) =>
      InvoiceLayout(
        id: id ?? this.id,
        name: name ?? this.name,
        headerText: headerText ?? this.headerText,
        invoiceNoPrefix: invoiceNoPrefix ?? this.invoiceNoPrefix,
        quotationNoPrefix: quotationNoPrefix ?? this.quotationNoPrefix,
        invoiceHeading: invoiceHeading ?? this.invoiceHeading,
        subHeadingLine1: subHeadingLine1 ?? this.subHeadingLine1,
        subHeadingLine2: subHeadingLine2 ?? this.subHeadingLine2,
        subHeadingLine3: subHeadingLine3 ?? this.subHeadingLine3,
        subHeadingLine4: subHeadingLine4 ?? this.subHeadingLine4,
        subHeadingLine5: subHeadingLine5 ?? this.subHeadingLine5,
        invoiceHeadingNotPaid:
            invoiceHeadingNotPaid ?? this.invoiceHeadingNotPaid,
        invoiceHeadingPaid: invoiceHeadingPaid ?? this.invoiceHeadingPaid,
        quotationHeading: quotationHeading ?? this.quotationHeading,
        subTotalLabel: subTotalLabel ?? this.subTotalLabel,
        discountLabel: discountLabel ?? this.discountLabel,
        taxLabel: taxLabel ?? this.taxLabel,
        totalLabel: totalLabel ?? this.totalLabel,
        roundOffLabel: roundOffLabel ?? this.roundOffLabel,
        totalDueLabel: totalDueLabel ?? this.totalDueLabel,
        paidLabel: paidLabel ?? this.paidLabel,
        showClientId: showClientId ?? this.showClientId,
        clientIdLabel: clientIdLabel ?? this.clientIdLabel,
        clientTaxLabel: clientTaxLabel ?? this.clientTaxLabel,
        dateLabel: dateLabel ?? this.dateLabel,
        dateTimeFormat: dateTimeFormat ?? this.dateTimeFormat,
        showTime: showTime ?? this.showTime,
        showBrand: showBrand ?? this.showBrand,
        showSku: showSku ?? this.showSku,
        showCatCode: showCatCode ?? this.showCatCode,
        showExpiry: showExpiry ?? this.showExpiry,
        showLot: showLot ?? this.showLot,
        showImage: showImage ?? this.showImage,
        showSaleDescription: showSaleDescription ?? this.showSaleDescription,
        salesPersonLabel: salesPersonLabel ?? this.salesPersonLabel,
        showSalesPerson: showSalesPerson ?? this.showSalesPerson,
        tableProductLabel: tableProductLabel ?? this.tableProductLabel,
        tableQtyLabel: tableQtyLabel ?? this.tableQtyLabel,
        tableUnitPriceLabel: tableUnitPriceLabel ?? this.tableUnitPriceLabel,
        tableSubtotalLabel: tableSubtotalLabel ?? this.tableSubtotalLabel,
        catCodeLabel: catCodeLabel ?? this.catCodeLabel,
        logo: logo ?? this.logo,
        showLogo: showLogo ?? this.showLogo,
        showBusinessName: showBusinessName ?? this.showBusinessName,
        showLocationName: showLocationName ?? this.showLocationName,
        showLandmark: showLandmark ?? this.showLandmark,
        showCity: showCity ?? this.showCity,
        showState: showState ?? this.showState,
        showZipCode: showZipCode ?? this.showZipCode,
        showCountry: showCountry ?? this.showCountry,
        showMobileNumber: showMobileNumber ?? this.showMobileNumber,
        showAlternateNumber: showAlternateNumber ?? this.showAlternateNumber,
        showEmail: showEmail ?? this.showEmail,
        showTax1: showTax1 ?? this.showTax1,
        showTax2: showTax2 ?? this.showTax2,
        showBarcode: showBarcode ?? this.showBarcode,
        showPayments: showPayments ?? this.showPayments,
        showCustomer: showCustomer ?? this.showCustomer,
        customerLabel: customerLabel ?? this.customerLabel,
        commissionAgentLabel: commissionAgentLabel ?? this.commissionAgentLabel,
        showCommissionAgent: showCommissionAgent ?? this.showCommissionAgent,
        showRewardPoint: showRewardPoint ?? this.showRewardPoint,
        highlightColor: highlightColor ?? this.highlightColor,
        footerText: footerText ?? this.footerText,
        moduleInfo: moduleInfo ?? this.moduleInfo,
        commonSettings: commonSettings ?? this.commonSettings,
        isDefault: isDefault ?? this.isDefault,
        businessId: businessId ?? this.businessId,
        showLetterHead: showLetterHead ?? this.showLetterHead,
        letterHead: letterHead ?? this.letterHead,
        showQrCode: showQrCode ?? this.showQrCode,
        qrCodeFields: qrCodeFields ?? this.qrCodeFields,
        design: design ?? this.design,
        cnHeading: cnHeading ?? this.cnHeading,
        cnNoLabel: cnNoLabel ?? this.cnNoLabel,
        cnAmountLabel: cnAmountLabel ?? this.cnAmountLabel,
        tableTaxHeadings: tableTaxHeadings ?? this.tableTaxHeadings,
        showPreviousBal: showPreviousBal ?? this.showPreviousBal,
        prevBalLabel: prevBalLabel ?? this.prevBalLabel,
        changeReturnLabel: changeReturnLabel ?? this.changeReturnLabel,
        productCustomFields: productCustomFields ?? this.productCustomFields,
        contactCustomFields: contactCustomFields ?? this.contactCustomFields,
        locationCustomFields: locationCustomFields ?? this.locationCustomFields,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        print: print ?? this.print,
      );

  factory InvoiceLayout.fromJson(Map<String, dynamic> json) => InvoiceLayout(
        id: json["id"],
        name: json["name"],
        headerText: json["header_text"],
        invoiceNoPrefix: json["invoice_no_prefix"],
        quotationNoPrefix: json["quotation_no_prefix"],
        invoiceHeading: json["invoice_heading"],
        subHeadingLine1: json["sub_heading_line1"],
        subHeadingLine2: json["sub_heading_line2"],
        subHeadingLine3: json["sub_heading_line3"],
        subHeadingLine4: json["sub_heading_line4"],
        subHeadingLine5: json["sub_heading_line5"],
        invoiceHeadingNotPaid: json["invoice_heading_not_paid"],
        invoiceHeadingPaid: json["invoice_heading_paid"],
        quotationHeading: json["quotation_heading"],
        subTotalLabel: json["sub_total_label"],
        discountLabel: json["discount_label"],
        taxLabel: json["tax_label"],
        totalLabel: json["total_label"],
        roundOffLabel: json["round_off_label"],
        totalDueLabel: json["total_due_label"],
        paidLabel: json["paid_label"],
        showClientId: json["show_client_id"],
        clientIdLabel: json["client_id_label"],
        clientTaxLabel: json["client_tax_label"],
        dateLabel: json["date_label"],
        dateTimeFormat: json["date_time_format"],
        showTime: json["show_time"],
        showBrand: json["show_brand"],
        showSku: json["show_sku"],
        showCatCode: json["show_cat_code"],
        showExpiry: json["show_expiry"],
        showLot: json["show_lot"],
        showImage: json["show_image"],
        showSaleDescription: json["show_sale_description"],
        salesPersonLabel: json["sales_person_label"],
        showSalesPerson: json["show_sales_person"],
        tableProductLabel: json["table_product_label"],
        tableQtyLabel: json["table_qty_label"],
        tableUnitPriceLabel: json["table_unit_price_label"],
        tableSubtotalLabel: json["table_subtotal_label"],
        catCodeLabel: json["cat_code_label"],
        logo: json["logo"],
        showLogo: json["show_logo"],
        showBusinessName: json["show_business_name"],
        showLocationName: json["show_location_name"],
        showLandmark: json["show_landmark"],
        showCity: json["show_city"],
        showState: json["show_state"],
        showZipCode: json["show_zip_code"],
        showCountry: json["show_country"],
        showMobileNumber: json["show_mobile_number"],
        showAlternateNumber: json["show_alternate_number"],
        showEmail: json["show_email"],
        showTax1: json["show_tax_1"],
        showTax2: json["show_tax_2"],
        showBarcode: json["show_barcode"],
        showPayments: json["show_payments"],
        showCustomer: json["show_customer"],
        customerLabel: json["customer_label"],
        commissionAgentLabel: json["commission_agent_label"],
        showCommissionAgent: json["show_commission_agent"],
        showRewardPoint: json["show_reward_point"],
        highlightColor: json["highlight_color"],
        footerText: json["footer_text"],
        moduleInfo: json["module_info"],
        commonSettings: json["common_settings"] == null
            ? null
            : CommonSettings.fromJson(json["common_settings"]),
        isDefault: json["is_default"],
        businessId: json["business_id"],
        showLetterHead: json["show_letter_head"],
        letterHead: json["letter_head"],
        showQrCode: json["show_qr_code"],
        qrCodeFields: json["qr_code_fields"] == null
            ? []
            : List<String>.from(json["qr_code_fields"]!.map((x) => x)),
        design: json["design"],
        cnHeading: json["cn_heading"],
        cnNoLabel: json["cn_no_label"],
        cnAmountLabel: json["cn_amount_label"],
        tableTaxHeadings: json["table_tax_headings"],
        showPreviousBal: json["show_previous_bal"],
        prevBalLabel: json["prev_bal_label"],
        changeReturnLabel: json["change_return_label"],
        productCustomFields: json["product_custom_fields"],
        contactCustomFields: json["contact_custom_fields"],
        locationCustomFields: json["location_custom_fields"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        print: json["print"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "header_text": headerText,
        "invoice_no_prefix": invoiceNoPrefix,
        "quotation_no_prefix": quotationNoPrefix,
        "invoice_heading": invoiceHeading,
        "sub_heading_line1": subHeadingLine1,
        "sub_heading_line2": subHeadingLine2,
        "sub_heading_line3": subHeadingLine3,
        "sub_heading_line4": subHeadingLine4,
        "sub_heading_line5": subHeadingLine5,
        "invoice_heading_not_paid": invoiceHeadingNotPaid,
        "invoice_heading_paid": invoiceHeadingPaid,
        "quotation_heading": quotationHeading,
        "sub_total_label": subTotalLabel,
        "discount_label": discountLabel,
        "tax_label": taxLabel,
        "total_label": totalLabel,
        "round_off_label": roundOffLabel,
        "total_due_label": totalDueLabel,
        "paid_label": paidLabel,
        "show_client_id": showClientId,
        "client_id_label": clientIdLabel,
        "client_tax_label": clientTaxLabel,
        "date_label": dateLabel,
        "date_time_format": dateTimeFormat,
        "show_time": showTime,
        "show_brand": showBrand,
        "show_sku": showSku,
        "show_cat_code": showCatCode,
        "show_expiry": showExpiry,
        "show_lot": showLot,
        "show_image": showImage,
        "show_sale_description": showSaleDescription,
        "sales_person_label": salesPersonLabel,
        "show_sales_person": showSalesPerson,
        "table_product_label": tableProductLabel,
        "table_qty_label": tableQtyLabel,
        "table_unit_price_label": tableUnitPriceLabel,
        "table_subtotal_label": tableSubtotalLabel,
        "cat_code_label": catCodeLabel,
        "logo": logo,
        "show_logo": showLogo,
        "show_business_name": showBusinessName,
        "show_location_name": showLocationName,
        "show_landmark": showLandmark,
        "show_city": showCity,
        "show_state": showState,
        "show_zip_code": showZipCode,
        "show_country": showCountry,
        "show_mobile_number": showMobileNumber,
        "show_alternate_number": showAlternateNumber,
        "show_email": showEmail,
        "show_tax_1": showTax1,
        "show_tax_2": showTax2,
        "show_barcode": showBarcode,
        "show_payments": showPayments,
        "show_customer": showCustomer,
        "customer_label": customerLabel,
        "commission_agent_label": commissionAgentLabel,
        "show_commission_agent": showCommissionAgent,
        "show_reward_point": showRewardPoint,
        "highlight_color": highlightColor,
        "footer_text": footerText,
        "module_info": moduleInfo,
        "common_settings": commonSettings?.toJson(),
        "is_default": isDefault,
        "business_id": businessId,
        "show_letter_head": showLetterHead,
        "letter_head": letterHead,
        "show_qr_code": showQrCode,
        "qr_code_fields": qrCodeFields == null
            ? []
            : List<dynamic>.from(qrCodeFields!.map((x) => x)),
        "design": design,
        "cn_heading": cnHeading,
        "cn_no_label": cnNoLabel,
        "cn_amount_label": cnAmountLabel,
        "table_tax_headings": tableTaxHeadings,
        "show_previous_bal": showPreviousBal,
        "prev_bal_label": prevBalLabel,
        "change_return_label": changeReturnLabel,
        "product_custom_fields": productCustomFields,
        "contact_custom_fields": contactCustomFields,
        "location_custom_fields": locationCustomFields,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "print": print,
      };
}

class CommonSettings {
  CommonSettings({
    this.proformaHeading,
    this.salesOrderHeading,
    this.dueDateLabel,
    this.totalQuantityLabel,
    this.itemDiscountLabel,
    this.discountedUnitPriceLabel,
    this.totalItemsLabel,
    this.numToWordFormat,
    this.taxSummaryLabel,
    this.showQrCodeLabel,
  });

  String? proformaHeading;
  String? salesOrderHeading;
  String? dueDateLabel;
  String? totalQuantityLabel;
  String? itemDiscountLabel;
  String? discountedUnitPriceLabel;
  dynamic totalItemsLabel;
  String? numToWordFormat;
  String? taxSummaryLabel;
  String? showQrCodeLabel;

  CommonSettings copyWith({
    String? proformaHeading,
    String? salesOrderHeading,
    String? dueDateLabel,
    String? totalQuantityLabel,
    String? itemDiscountLabel,
    String? discountedUnitPriceLabel,
    dynamic totalItemsLabel,
    String? numToWordFormat,
    String? taxSummaryLabel,
    String? showQrCodeLabel,
  }) =>
      CommonSettings(
        proformaHeading: proformaHeading ?? this.proformaHeading,
        salesOrderHeading: salesOrderHeading ?? this.salesOrderHeading,
        dueDateLabel: dueDateLabel ?? this.dueDateLabel,
        totalQuantityLabel: totalQuantityLabel ?? this.totalQuantityLabel,
        itemDiscountLabel: itemDiscountLabel ?? this.itemDiscountLabel,
        discountedUnitPriceLabel:
            discountedUnitPriceLabel ?? this.discountedUnitPriceLabel,
        totalItemsLabel: totalItemsLabel ?? this.totalItemsLabel,
        numToWordFormat: numToWordFormat ?? this.numToWordFormat,
        taxSummaryLabel: taxSummaryLabel ?? this.taxSummaryLabel,
        showQrCodeLabel: showQrCodeLabel ?? this.showQrCodeLabel,
      );

  factory CommonSettings.fromJson(Map<String, dynamic> json) => CommonSettings(
        proformaHeading: json["proforma_heading"],
        salesOrderHeading: json["sales_order_heading"],
        dueDateLabel: json["due_date_label"],
        totalQuantityLabel: json["total_quantity_label"],
        itemDiscountLabel: json["item_discount_label"],
        discountedUnitPriceLabel: json["discounted_unit_price_label"],
        totalItemsLabel: json["total_items_label"],
        numToWordFormat: json["num_to_word_format"],
        taxSummaryLabel: json["tax_summary_label"],
        showQrCodeLabel: json["show_qr_code_label"],
      );

  Map<String, dynamic> toJson() => {
        "proforma_heading": proformaHeading,
        "sales_order_heading": salesOrderHeading,
        "due_date_label": dueDateLabel,
        "total_quantity_label": totalQuantityLabel,
        "item_discount_label": itemDiscountLabel,
        "discounted_unit_price_label": discountedUnitPriceLabel,
        "total_items_label": totalItemsLabel,
        "num_to_word_format": numToWordFormat,
        "tax_summary_label": taxSummaryLabel,
        "show_qr_code_label": showQrCodeLabel,
      };
}

class InvoiceSchema {
  InvoiceSchema({
    this.id,
    this.businessId,
    this.name,
    this.schemeType,
    this.prefix,
    this.startNumber,
    this.invoiceCount,
    this.totalDigits,
    this.isDefault,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? businessId;
  String? name;
  String? schemeType;
  String? prefix;
  int? startNumber;
  int? invoiceCount;
  int? totalDigits;
  int? isDefault;
  DateTime? createdAt;
  DateTime? updatedAt;

  InvoiceSchema copyWith({
    int? id,
    int? businessId,
    String? name,
    String? schemeType,
    String? prefix,
    int? startNumber,
    int? invoiceCount,
    int? totalDigits,
    int? isDefault,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      InvoiceSchema(
        id: id ?? this.id,
        businessId: businessId ?? this.businessId,
        name: name ?? this.name,
        schemeType: schemeType ?? this.schemeType,
        prefix: prefix ?? this.prefix,
        startNumber: startNumber ?? this.startNumber,
        invoiceCount: invoiceCount ?? this.invoiceCount,
        totalDigits: totalDigits ?? this.totalDigits,
        isDefault: isDefault ?? this.isDefault,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory InvoiceSchema.fromJson(Map<String, dynamic> json) => InvoiceSchema(
        id: json["id"],
        businessId: json["business_id"],
        name: json["name"],
        schemeType: json["scheme_type"],
        prefix: json["prefix"],
        startNumber: json["start_number"],
        invoiceCount: json["invoice_count"],
        totalDigits: json["total_digits"],
        isDefault: json["is_default"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "business_id": businessId,
        "name": name,
        "scheme_type": schemeType,
        "prefix": prefix,
        "start_number": startNumber,
        "invoice_count": invoiceCount,
        "total_digits": totalDigits,
        "is_default": isDefault,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class Kitchen {
  Kitchen({
    this.id,
    this.businessId,
    this.locationId,
    this.name,
    this.description,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? businessId;
  int? locationId;
  String? name;
  String? description;
  DateTime? createdAt;
  DateTime? updatedAt;

  Kitchen copyWith({
    int? id,
    int? businessId,
    int? locationId,
    String? name,
    String? description,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      Kitchen(
        id: id ?? this.id,
        businessId: businessId ?? this.businessId,
        locationId: locationId ?? this.locationId,
        name: name ?? this.name,
        description: description ?? this.description,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory Kitchen.fromJson(Map<String, dynamic> json) => Kitchen(
        id: json["id"],
        businessId: json["business_id"],
        locationId: json["location_id"],
        name: json["name"],
        description: json["description"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "business_id": businessId,
        "location_id": locationId,
        "name": name,
        "description": description,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
