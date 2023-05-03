// To parse this JSON data, do
//
//     final businessModel = businessModelFromJson(jsonString);

/// TODO:
import 'dart:convert';

import 'package:flutter/material.dart';

import '/Config/utils.dart';
import '/Models/PaymentMethodModel/paymentMethodModel.dart';

BusinessModel businessModelFromJson(String str) =>
    BusinessModel.fromJson(json.decode(str));

String businessModelToJson(BusinessModel data) => json.encode(data.toJson());

class BusinessModel {
  BusinessModel({
    this.businessData,
  });

  final BusinessDataModel? businessData;

  factory BusinessModel.fromJson(Map<String, dynamic> json) => BusinessModel(
        businessData: json["data"] == null
            ? null
            : BusinessDataModel.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": businessData == null ? null : businessData?.toJson(),
      };
}

class BusinessDataModel {
  BusinessDataModel({
    this.id,
    this.name,
    this.currencyId,
    this.startDate,
    this.taxNumber1,
    this.taxLabel1,
    this.taxNumber2,
    this.taxLabel2,
    this.codeLabel1,
    this.code1,
    this.codeLabel2,
    this.code2,
    this.defaultSalesTax,
    this.defaultProfitPercent,
    this.ownerId,
    this.timeZone,
    this.fyStartMonth,
    this.accountingMethod,
    this.defaultSalesDiscount,
    this.sellPriceTax,
    this.logo,
    this.skuPrefix,
    this.enableProductExpiry,
    this.expiryType,
    this.onProductExpiry,
    this.stopSellingBefore,
    this.enableTooltip,
    this.purchaseInDiffCurrency,
    this.purchaseCurrencyId,
    this.pExchangeRate,
    this.transactionEditDays,
    this.stockExpiryAlertDays,
    this.keyboardShortcuts,
    this.posSettings,
    this.manufacturingSettings,
    this.woocommerceSkippedOrders,
    this.woocommerceWhOcSecret,
    this.woocommerceWhOuSecret,
    this.woocommerceWhOdSecret,
    this.woocommerceWhOrSecret,
    this.essentialsSettings,
    this.weighingScaleSetting,
    this.enableBrand,
    this.enableCategory,
    this.enableSubCategory,
    this.enablePriceTax,
    this.enablePurchaseStatus,
    this.enableLotNumber,
    this.defaultUnit,
    this.enableSubUnits,
    this.enableRacks,
    this.enableRow,
    this.enablePosition,
    this.enableEditingProductFromPurchase,
    this.salesCmsnAgnt,
    this.itemAdditionMethod,
    this.enableInlineTax,
    this.currencySymbolPlacement,
    this.enabledModules = const [],
    this.dateFormat,
    this.timeFormat,
    this.currencyPrecision,
    this.quantityPrecision,
    this.refNoPrefixes,
    this.themeColor,
    this.createdBy,
    this.assetSettings,
    this.repairSettings,
    this.crmSettings,
    this.enableRp,
    this.rpName,
    this.amountForUnitRp,
    this.minOrderTotalForRp,
    this.maxRpPerOrder,
    this.redeemAmountPerUnitRp,
    this.minOrderTotalForRedeem,
    this.minRedeemPoint,
    this.maxRedeemPoint,
    this.rpExpiryPeriod,
    this.rpExpiryType,
    this.emailSettings,
    this.smsSettings,
    this.customLabels,
    this.commonSettings,
    this.isActive,
    this.createdAt,
    this.updatedAt,
    this.locations = const [],
    this.currency,
    this.printers = const [],
  });

  int? id;
  String? name;
  int? currencyId;
  DateTime? startDate;
  String? taxNumber1;
  String? taxLabel1;
  dynamic taxNumber2;
  dynamic taxLabel2;
  dynamic codeLabel1;
  dynamic code1;
  dynamic codeLabel2;
  dynamic code2;
  int? defaultSalesTax;
  int? defaultProfitPercent;
  int? ownerId;
  String? timeZone;
  int? fyStartMonth;
  String? accountingMethod;
  String? defaultSalesDiscount;
  String? sellPriceTax;
  String? logo;
  dynamic skuPrefix;
  int? enableProductExpiry;
  String? expiryType;
  String? onProductExpiry;
  int? stopSellingBefore;
  int? enableTooltip;
  int? purchaseInDiffCurrency;
  dynamic purchaseCurrencyId;
  String? pExchangeRate;
  int? transactionEditDays;
  int? stockExpiryAlertDays;
  KeyboardShortcuts? keyboardShortcuts;
  PosSettings? posSettings;
  dynamic manufacturingSettings;
  dynamic woocommerceSkippedOrders;
  dynamic woocommerceWhOcSecret;
  dynamic woocommerceWhOuSecret;
  dynamic woocommerceWhOdSecret;
  dynamic woocommerceWhOrSecret;
  dynamic essentialsSettings;
  WeighingScaleSetting? weighingScaleSetting;
  int? enableBrand;
  int? enableCategory;
  int? enableSubCategory;
  int? enablePriceTax;
  int? enablePurchaseStatus;
  int? enableLotNumber;
  int? defaultUnit;
  int? enableSubUnits;
  int? enableRacks;
  int? enableRow;
  int? enablePosition;
  int? enableEditingProductFromPurchase;
  dynamic salesCmsnAgnt;
  int? itemAdditionMethod;
  int? enableInlineTax;
  String? currencySymbolPlacement;
  List<String> enabledModules = [];
  String? dateFormat;
  String? timeFormat;
  dynamic currencyPrecision;
  dynamic quantityPrecision;
  RefNoPrefixes? refNoPrefixes;
  String? themeColor;
  int? createdBy;
  dynamic assetSettings;
  dynamic repairSettings;
  dynamic crmSettings;
  int? enableRp;
  dynamic rpName;
  String? amountForUnitRp;
  String? minOrderTotalForRp;
  int? maxRpPerOrder;
  String? redeemAmountPerUnitRp;
  String? minOrderTotalForRedeem;
  dynamic minRedeemPoint;
  dynamic maxRedeemPoint;
  int? rpExpiryPeriod;
  String? rpExpiryType;
  EmailSettings? emailSettings;
  SmsSettings? smsSettings;
  CustomLabels? customLabels;
  CommonSettings? commonSettings;
  int? isActive;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<BusinessLocationModel> locations = [];
  Currency? currency;
  List<Printer> printers = [];

  BusinessDataModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    currencyId = json["currency_id"];
    try {
      if (json["start_date"] != null)
        startDate = DateTime.tryParse(json["start_date"]);
    } catch (e) {
      logger.e(e);
    }
    taxNumber1 = json["tax_number_1"];
    taxLabel1 = json["tax_label_1"];
    taxNumber2 = json["tax_number_2"];
    taxLabel2 = json["tax_label_2"];
    codeLabel1 = json["code_label_1"];
    code1 = json["code_1"];
    codeLabel2 = json["code_label_2"];
    code2 = json["code_2"];
    defaultSalesTax = json["default_sales_tax"];
    defaultProfitPercent = json["default_profit_percent"];
    ownerId = json["owner_id"];
    timeZone = json["time_zone"];
    fyStartMonth = json["fy_start_month"];
    accountingMethod = json["accounting_method"];
    defaultSalesDiscount = json["default_sales_discount"];
    sellPriceTax = json["sell_price_tax"];
    logo = json["logo"];
    skuPrefix = json["sku_prefix"];
    enableProductExpiry = json["enable_product_expiry"];
    expiryType = json["expiry_type"];
    onProductExpiry = json["on_product_expiry"];
    stopSellingBefore = json["stop_selling_before"];
    enableTooltip = json["enable_tooltip"];
    purchaseInDiffCurrency = json["purchase_in_diff_currency"];
    purchaseCurrencyId = json["purchase_currency_id"];
    pExchangeRate = json["p_exchange_rate"];
    transactionEditDays = json["transaction_edit_days"];
    stockExpiryAlertDays = json["stock_expiry_alert_days"];
    try {
      if (json["keyboard_shortcuts"] != null)
        keyboardShortcuts =
            KeyboardShortcuts.fromJson(json["keyboard_shortcuts"]);
    } catch (e) {
      logger.e(e);
    }

    try {
      if (json["pos_settings"] != null)
        posSettings = PosSettings.fromJson(json["pos_settings"]);
    } on Exception catch (e) {
      logger.e(e);
    }
    manufacturingSettings = json["manufacturing_settings"];
    woocommerceSkippedOrders = json["woocommerce_skipped_orders"];
    woocommerceWhOcSecret = json["woocommerce_wh_oc_secret"];
    woocommerceWhOuSecret = json["woocommerce_wh_ou_secret"];
    woocommerceWhOdSecret = json["woocommerce_wh_od_secret"];
    woocommerceWhOrSecret = json["woocommerce_wh_or_secret"];
    essentialsSettings = json["essentials_settings"];
    try {
      if (json["weighing_scale_setting"] != null)
        weighingScaleSetting =
            WeighingScaleSetting.fromJson(json["weighing_scale_setting"]);
    } catch (e) {
      logger.e(e);
    }
    enableBrand = json["enable_brand"];
    enableCategory = json["enable_category"];
    enableSubCategory = json["enable_sub_category"];
    enablePriceTax = json["enable_price_tax"];
    enablePurchaseStatus = json["enable_purchase_status"];
    enableLotNumber = json["enable_lot_number"];
    defaultUnit = json["default_unit"];
    enableSubUnits = json["enable_sub_units"];
    enableRacks = json["enable_racks"];
    enableRow = json["enable_row"];
    enablePosition = json["enable_position"];
    enableEditingProductFromPurchase =
        json["enable_editing_product_from_purchase"];
    salesCmsnAgnt = json["sales_cmsn_agnt"];
    itemAdditionMethod = json["item_addition_method"];
    enableInlineTax = int.tryParse('${json["enable_inline_tax"]}');
    currencySymbolPlacement = json["currency_symbol_placement"];
    try {
      if (json["enabled_modules"] != null)
        enabledModules =
            List<String>.from(json["enabled_modules"].map((x) => x));
    } catch (e) {
      logger.e(e);
    }
    dateFormat = json["date_format"];
    timeFormat = json["time_format"];
    currencyPrecision = json["currency_precision"];
    quantityPrecision = json["quantity_precision"];
    try {
      if (json["ref_no_prefixes"] != null)
        refNoPrefixes = RefNoPrefixes.fromJson(json["ref_no_prefixes"]);
    } catch (e) {
      logger.e(e);
    }
    themeColor = json["theme_color"];
    createdBy = json["created_by"];
    assetSettings = json["asset_settings"];
    repairSettings = json["repair_settings"];
    crmSettings = json["crm_settings"];
    enableRp = json["enable_rp"];
    rpName = json["rp_name"];
    amountForUnitRp = json["amount_for_unit_rp"];
    minOrderTotalForRp = json["min_order_total_for_rp"];
    maxRpPerOrder = json["max_rp_per_order"];
    redeemAmountPerUnitRp = json["redeem_amount_per_unit_rp"];
    minOrderTotalForRedeem = json["min_order_total_for_redeem"];
    minRedeemPoint = json["min_redeem_point"];
    maxRedeemPoint = json["max_redeem_point"];
    rpExpiryPeriod = json["rp_expiry_period"];
    rpExpiryType = json["rp_expiry_type"];
    try {
      if (json["email_settings"] != null)
        emailSettings = EmailSettings.fromJson(json["email_settings"]);
    } catch (e) {
      logger.e(e);
    }
    try {
      if (json["sms_settings"] != null)
        smsSettings = SmsSettings.fromJson(json["sms_settings"]);
    } catch (e) {
      logger.e(e);
    }
    try {
      if (json["custom_labels"] != null)
        customLabels = CustomLabels.fromJson(json["custom_labels"]);
    } catch (e) {
      logger.e(e);
    }
    try {
      if (json["common_settings"] != null)
        commonSettings = CommonSettings.fromJson(json["common_settings"]);
    } catch (e) {
      logger.e(e);
    }
    isActive = json["is_active"];
    try {
      if (json["created_at"] != null)
        createdAt = DateTime.tryParse(json["created_at"]);
    } catch (e) {
      logger.e(e);
    }
    try {
      if (json["updated_at"] != null)
        updatedAt = DateTime.tryParse(json["updated_at"]);
    } catch (e) {
      logger.e(e);
    }
    try {
      if (json["locations"] != null)
        locations = List<BusinessLocationModel>.from(
            json["locations"].map((x) => businessLocationModelFromJson(x)));
    } catch (e) {
      logger.e(e);
    }
    try {
      if (json["currency"] != null)
        currency = Currency.fromJson(json["currency"]);
    } catch (e) {
      logger.e(e);
    }
    try {
      if (json["printers"] != null)
        printers = List<Printer>.from(
            json["printers"].map((x) => Printer.fromJson(x)));
    } catch (e) {
      logger.e(e);
    }
    ;
  }

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "currency_id": currencyId == null ? null : currencyId,
        "start_date": startDate == null
            ? null
            : "${startDate?.year.toString().padLeft(4, '0')}-${startDate?.month.toString().padLeft(2, '0')}-${startDate?.day.toString().padLeft(2, '0')}",
        "tax_number_1": taxNumber1 == null ? null : taxNumber1,
        "tax_label_1": taxLabel1 == null ? null : taxLabel1,
        "tax_number_2": taxNumber2,
        "tax_label_2": taxLabel2,
        "code_label_1": codeLabel1,
        "code_1": code1,
        "code_label_2": codeLabel2,
        "code_2": code2,
        "default_sales_tax": defaultSalesTax == null ? null : defaultSalesTax,
        "default_profit_percent":
            defaultProfitPercent == null ? null : defaultProfitPercent,
        "owner_id": ownerId == null ? null : ownerId,
        "time_zone": timeZone == null ? null : timeZone,
        "fy_start_month": fyStartMonth == null ? null : fyStartMonth,
        "accounting_method": accountingMethod == null ? null : accountingMethod,
        "default_sales_discount":
            defaultSalesDiscount == null ? null : defaultSalesDiscount,
        "sell_price_tax": sellPriceTax == null ? null : sellPriceTax,
        "logo": logo == null ? null : logo,
        "sku_prefix": skuPrefix,
        "enable_product_expiry":
            enableProductExpiry == null ? null : enableProductExpiry,
        "expiry_type": expiryType == null ? null : expiryType,
        "on_product_expiry": onProductExpiry == null ? null : onProductExpiry,
        "stop_selling_before":
            stopSellingBefore == null ? null : stopSellingBefore,
        "enable_tooltip": enableTooltip == null ? null : enableTooltip,
        "purchase_in_diff_currency":
            purchaseInDiffCurrency == null ? null : purchaseInDiffCurrency,
        "purchase_currency_id": purchaseCurrencyId,
        "p_exchange_rate": pExchangeRate == null ? null : pExchangeRate,
        "transaction_edit_days":
            transactionEditDays == null ? null : transactionEditDays,
        "stock_expiry_alert_days":
            stockExpiryAlertDays == null ? null : stockExpiryAlertDays,
        "keyboard_shortcuts":
            keyboardShortcuts == null ? null : keyboardShortcuts?.toJson(),
        "pos_settings": posSettings == null ? null : posSettings?.toJson(),
        "manufacturing_settings": manufacturingSettings,
        "woocommerce_skipped_orders": woocommerceSkippedOrders,
        "woocommerce_wh_oc_secret": woocommerceWhOcSecret,
        "woocommerce_wh_ou_secret": woocommerceWhOuSecret,
        "woocommerce_wh_od_secret": woocommerceWhOdSecret,
        "woocommerce_wh_or_secret": woocommerceWhOrSecret,
        "essentials_settings": essentialsSettings,
        "weighing_scale_setting": weighingScaleSetting == null
            ? null
            : weighingScaleSetting?.toJson(),
        "enable_brand": enableBrand == null ? null : enableBrand,
        "enable_category": enableCategory == null ? null : enableCategory,
        "enable_sub_category":
            enableSubCategory == null ? null : enableSubCategory,
        "enable_price_tax": enablePriceTax == null ? null : enablePriceTax,
        "enable_purchase_status":
            enablePurchaseStatus == null ? null : enablePurchaseStatus,
        "enable_lot_number": enableLotNumber == null ? null : enableLotNumber,
        "default_unit": defaultUnit == null ? null : defaultUnit,
        "enable_sub_units": enableSubUnits == null ? null : enableSubUnits,
        "enable_racks": enableRacks == null ? null : enableRacks,
        "enable_row": enableRow == null ? null : enableRow,
        "enable_position": enablePosition == null ? null : enablePosition,
        "enable_editing_product_from_purchase":
            enableEditingProductFromPurchase == null
                ? null
                : enableEditingProductFromPurchase,
        "sales_cmsn_agnt": salesCmsnAgnt,
        "item_addition_method":
            itemAdditionMethod == null ? null : itemAdditionMethod,
        "enable_inline_tax": enableInlineTax == null ? null : enableInlineTax,
        "currency_symbol_placement":
            currencySymbolPlacement == null ? null : currencySymbolPlacement,
        "enabled_modules": enabledModules.isEmpty
            ? null
            : List<dynamic>.from(enabledModules.map((x) => x)),
        "date_format": dateFormat == null ? null : dateFormat,
        "time_format": timeFormat == null ? null : timeFormat,
        "currency_precision": currencyPrecision,
        "quantity_precision": quantityPrecision,
        "ref_no_prefixes":
            refNoPrefixes == null ? null : refNoPrefixes?.toJson(),
        "theme_color": themeColor == null ? null : themeColor,
        "created_by": createdBy == null ? null : createdBy,
        "asset_settings": assetSettings,
        "repair_settings": repairSettings,
        "crm_settings": crmSettings,
        "enable_rp": enableRp == null ? null : enableRp,
        "rp_name": rpName,
        "amount_for_unit_rp": amountForUnitRp == null ? null : amountForUnitRp,
        "min_order_total_for_rp":
            minOrderTotalForRp == null ? null : minOrderTotalForRp,
        "max_rp_per_order": maxRpPerOrder == null ? null : maxRpPerOrder,
        "redeem_amount_per_unit_rp":
            redeemAmountPerUnitRp == null ? null : redeemAmountPerUnitRp,
        "min_order_total_for_redeem":
            minOrderTotalForRedeem == null ? null : minOrderTotalForRedeem,
        "min_redeem_point": minRedeemPoint,
        "max_redeem_point": maxRedeemPoint,
        "rp_expiry_period": rpExpiryPeriod == null ? null : rpExpiryPeriod,
        "rp_expiry_type": rpExpiryType == null ? null : rpExpiryType,
        "email_settings":
            emailSettings == null ? null : emailSettings?.toJson(),
        "sms_settings": smsSettings == null ? null : smsSettings?.toJson(),
        "custom_labels": customLabels == null ? null : customLabels?.toJson(),
        "common_settings":
            commonSettings == null ? null : commonSettings?.toJson(),
        "is_active": isActive == null ? null : isActive,
        "created_at": createdAt == null ? null : createdAt?.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt?.toIso8601String(),
        "locations": locations.isEmpty
            ? null
            : List<dynamic>.from(
                locations.map((x) => businessLocationModelToJson(x))),
        "currency": currency == null ? null : currency?.toJson(),
        "printers": printers.isEmpty
            ? null
            : List<dynamic>.from(printers.map((x) => x.toJson())),
      };
}

class CommonSettings {
  CommonSettings({
    this.enableProductWarranty,
    this.defaultCreditLimit,
    this.enablePurchaseOrder,
    this.defaultDatatablePageEntries,
  });

  final String? enableProductWarranty;
  final String? defaultCreditLimit;
  final String? enablePurchaseOrder;
  final String? defaultDatatablePageEntries;

  factory CommonSettings.fromJson(Map<String, dynamic> json) => CommonSettings(
        enableProductWarranty: json["enable_product_warranty"] == null
            ? null
            : json["enable_product_warranty"],
        defaultCreditLimit: json["default_credit_limit"] == null
            ? null
            : json["default_credit_limit"],
        enablePurchaseOrder: json["enable_purchase_order"] == null
            ? null
            : json["enable_purchase_order"],
        defaultDatatablePageEntries:
            json["default_datatable_page_entries"] == null
                ? null
                : json["default_datatable_page_entries"],
      );

  Map<String, dynamic> toJson() => {
        "enable_product_warranty":
            enableProductWarranty == null ? null : enableProductWarranty,
        "default_credit_limit":
            defaultCreditLimit == null ? null : defaultCreditLimit,
        "enable_purchase_order":
            enablePurchaseOrder == null ? null : enablePurchaseOrder,
        "default_datatable_page_entries": defaultDatatablePageEntries == null
            ? null
            : defaultDatatablePageEntries,
      };
}

class Currency {
  Currency({
    this.id,
    this.country,
    this.currency,
    this.code,
    this.symbol,
    this.thousandSeparator,
    this.decimalSeparator,
    this.createdAt,
    this.updatedAt,
  });

  final int? id;
  final String? country;
  final String? currency;
  final String? code;
  final String? symbol;
  final String? thousandSeparator;
  final String? decimalSeparator;
  final dynamic createdAt;
  final dynamic updatedAt;

  factory Currency.fromJson(Map<String, dynamic> json) => Currency(
        id: json["id"] == null ? null : json["id"],
        country: json["country"] == null ? null : json["country"],
        currency: json["currency"] == null ? null : json["currency"],
        code: json["code"] == null ? null : json["code"],
        symbol: json["symbol"] == null ? null : json["symbol"],
        thousandSeparator: json["thousand_separator"] == null
            ? null
            : json["thousand_separator"],
        decimalSeparator: json["decimal_separator"] == null
            ? null
            : json["decimal_separator"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "country": country == null ? null : country,
        "currency": currency == null ? null : currency,
        "code": code == null ? null : code,
        "symbol": symbol == null ? null : symbol,
        "thousand_separator":
            thousandSeparator == null ? null : thousandSeparator,
        "decimal_separator": decimalSeparator == null ? null : decimalSeparator,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}

class CustomLabels {
  CustomLabels({
    this.payments,
    this.contact,
    this.product,
    this.location,
    this.user,
    this.purchase,
    this.purchaseShipping,
    this.sell,
    this.shipping,
    this.typesOfService,
  });

  final Payments? payments;
  final ContactFields? contact;
  final ProductClass? product;
  final ProductClass? location;
  final ProductClass? user;
  final ProductClass? purchase;
  final ProductClass? purchaseShipping;
  final ProductClass? sell;
  final ProductClass? shipping;
  final ProductClass? typesOfService;

  factory CustomLabels.fromJson(Map<String, dynamic> json) => CustomLabels(
        payments: json["payments"] == null
            ? null
            : Payments.fromJson(json["payments"]),
        contact: json["contact"] == null
            ? null
            : ContactFields.fromJson(json["contact"]),
        product: json["product"] == null
            ? null
            : ProductClass.fromJson(json["product"]),
        location: json["location"] == null
            ? null
            : ProductClass.fromJson(json["location"]),
        user: json["user"] == null ? null : ProductClass.fromJson(json["user"]),
        purchase: json["purchase"] == null
            ? null
            : ProductClass.fromJson(json["purchase"]),
        purchaseShipping: json["purchase_shipping"] == null
            ? null
            : ProductClass.fromJson(json["purchase_shipping"]),
        sell: json["sell"] == null ? null : ProductClass.fromJson(json["sell"]),
        shipping: json["shipping"] == null
            ? null
            : ProductClass.fromJson(json["shipping"]),
        typesOfService: json["types_of_service"] == null
            ? null
            : ProductClass.fromJson(json["types_of_service"]),
      );

  Map<String, dynamic> toJson() => {
        "payments": payments == null ? null : payments?.toJson(),
        "contact": contact == null ? null : contact?.toJson(),
        "product": product == null ? null : product?.toJson(),
        "location": location == null ? null : location?.toJson(),
        "user": user == null ? null : user?.toJson(),
        "purchase": purchase == null ? null : purchase?.toJson(),
        "purchase_shipping":
            purchaseShipping == null ? null : purchaseShipping?.toJson(),
        "sell": sell == null ? null : sell?.toJson(),
        "shipping": shipping == null ? null : shipping?.toJson(),
        "types_of_service":
            typesOfService == null ? null : typesOfService?.toJson(),
      };
}

class ContactFields {
  ContactFields({
    this.customField1,
    this.customField2,
    this.customField3,
    this.customField4,
    this.customField5,
    this.customField6,
    this.customField7,
    this.customField8,
    this.customField9,
    this.customField10,
  });

  final String? customField1;
  final String? customField2;
  final String? customField3;
  final dynamic customField4;
  final dynamic customField5;
  final dynamic customField6;
  final dynamic customField7;
  final dynamic customField8;
  final dynamic customField9;
  final dynamic customField10;

  factory ContactFields.fromJson(Map<String, dynamic> json) => ContactFields(
        customField1:
            json["custom_field_1"] == null ? null : json["custom_field_1"],
        customField2:
            json["custom_field_2"] == null ? null : json["custom_field_2"],
        customField3:
            json["custom_field_3"] == null ? null : json["custom_field_3"],
        customField4: json["custom_field_4"],
        customField5: json["custom_field_5"],
        customField6: json["custom_field_6"],
        customField7: json["custom_field_7"],
        customField8: json["custom_field_8"],
        customField9: json["custom_field_9"],
        customField10: json["custom_field_10"],
      );

  Map<String, dynamic> toJson() => {
        "custom_field_1": customField1 == null ? null : customField1,
        "custom_field_2": customField2 == null ? null : customField2,
        "custom_field_3": customField3 == null ? null : customField3,
        "custom_field_4": customField4,
        "custom_field_5": customField5,
        "custom_field_6": customField6,
        "custom_field_7": customField7,
        "custom_field_8": customField8,
        "custom_field_9": customField9,
        "custom_field_10": customField10,
      };
}

class ProductClass {
  ProductClass({
    this.customField1,
    this.customField2,
    this.customField3,
    this.customField4,
    this.customField5,
    this.customField6,
  });

  final dynamic customField1;
  final dynamic customField2;
  final dynamic customField3;
  final dynamic customField4;
  final dynamic customField5;
  final dynamic customField6;

  factory ProductClass.fromJson(Map<String, dynamic> json) => ProductClass(
        customField1: json["custom_field_1"],
        customField2: json["custom_field_2"],
        customField3: json["custom_field_3"],
        customField4: json["custom_field_4"],
        customField5: json["custom_field_5"],
        customField6: json["custom_field_6"],
      );

  Map<String, dynamic> toJson() => {
        "custom_field_1": customField1,
        "custom_field_2": customField2,
        "custom_field_3": customField3,
        "custom_field_4": customField4,
        "custom_field_5": customField5,
        "custom_field_6": customField6,
      };
}

class Payments {
  Payments({
    this.customPay1,
    this.customPay2,
    this.customPay3,
    this.customPay4,
    this.customPay5,
    this.customPay6,
    this.customPay7,
  });

  final String? customPay1;
  final String? customPay2;
  final String? customPay3;
  final dynamic customPay4;
  final dynamic customPay5;
  final dynamic customPay6;
  final dynamic customPay7;

  factory Payments.fromJson(Map<String, dynamic> json) => Payments(
        customPay1: json["custom_pay_1"] == null ? null : json["custom_pay_1"],
        customPay2: json["custom_pay_2"] == null ? null : json["custom_pay_2"],
        customPay3: json["custom_pay_3"] == null ? null : json["custom_pay_3"],
        customPay4: json["custom_pay_4"],
        customPay5: json["custom_pay_5"],
        customPay6: json["custom_pay_6"],
        customPay7: json["custom_pay_7"],
      );

  Map<String, dynamic> toJson() => {
        "custom_pay_1": customPay1 == null ? null : customPay1,
        "custom_pay_2": customPay2 == null ? null : customPay2,
        "custom_pay_3": customPay3 == null ? null : customPay3,
        "custom_pay_4": customPay4,
        "custom_pay_5": customPay5,
        "custom_pay_6": customPay6,
        "custom_pay_7": customPay7,
      };
}

class EmailSettings {
  EmailSettings({
    this.mailDriver,
    this.mailHost,
    this.mailPort,
    this.mailUsername,
    this.mailPassword,
    this.mailEncryption,
    this.mailFromAddress,
    this.mailFromName,
  });

  final String? mailDriver;
  final dynamic mailHost;
  final dynamic mailPort;
  final dynamic mailUsername;
  final dynamic mailPassword;
  final dynamic mailEncryption;
  final dynamic mailFromAddress;
  final dynamic mailFromName;

  factory EmailSettings.fromJson(Map<String, dynamic> json) => EmailSettings(
        mailDriver: json["mail_driver"] == null ? null : json["mail_driver"],
        mailHost: json["mail_host"],
        mailPort: json["mail_port"],
        mailUsername: json["mail_username"],
        mailPassword: json["mail_password"],
        mailEncryption: json["mail_encryption"],
        mailFromAddress: json["mail_from_address"],
        mailFromName: json["mail_from_name"],
      );

  Map<String, dynamic> toJson() => {
        "mail_driver": mailDriver == null ? null : mailDriver,
        "mail_host": mailHost,
        "mail_port": mailPort,
        "mail_username": mailUsername,
        "mail_password": mailPassword,
        "mail_encryption": mailEncryption,
        "mail_from_address": mailFromAddress,
        "mail_from_name": mailFromName,
      };
}

class KeyboardShortcuts {
  KeyboardShortcuts({
    this.pos,
  });

  final PointOfSaleModel? pos;

  factory KeyboardShortcuts.fromJson(Map<String, dynamic> json) =>
      KeyboardShortcuts(
        pos:
            json["pos"] == null ? null : PointOfSaleModel.fromJson(json["pos"]),
      );

  Map<String, dynamic> toJson() => {
        "pos": pos == null ? null : pos?.toJson(),
      };
}

class PointOfSaleModel {
  PointOfSaleModel({
    this.expressCheckout,
    this.checkout,
    this.draft,
    this.cancel,
    this.recentProductQuantity,
    this.weighingScale,
    this.editDiscount,
    this.editOrderTax,
    this.addPaymentRow,
    this.finalizePayment,
    this.addNewProduct,
  });

  final String? expressCheckout;
  final String? checkout;
  final String? draft;
  final String? cancel;
  final String? recentProductQuantity;
  final dynamic weighingScale;
  final String? editDiscount;
  final String? editOrderTax;
  final String? addPaymentRow;
  final String? finalizePayment;
  final String? addNewProduct;

  factory PointOfSaleModel.fromJson(Map<String, dynamic> json) =>
      PointOfSaleModel(
        expressCheckout:
            json["express_checkout"] == null ? null : json["express_checkout"],
        checkout:
            json["pay_n_ckeckout"] == null ? null : json["pay_n_ckeckout"],
        draft: json["draft"] == null ? null : json["draft"],
        cancel: json["cancel"] == null ? null : json["cancel"],
        recentProductQuantity: json["recent_product_quantity"] == null
            ? null
            : json["recent_product_quantity"],
        weighingScale: json["weighing_scale"],
        editDiscount:
            json["edit_discount"] == null ? null : json["edit_discount"],
        editOrderTax:
            json["edit_order_tax"] == null ? null : json["edit_order_tax"],
        addPaymentRow:
            json["add_payment_row"] == null ? null : json["add_payment_row"],
        finalizePayment:
            json["finalize_payment"] == null ? null : json["finalize_payment"],
        addNewProduct:
            json["add_new_product"] == null ? null : json["add_new_product"],
      );

  Map<String, dynamic> toJson() => {
        "express_checkout": expressCheckout == null ? null : expressCheckout,
        "pay_n_ckeckout": checkout == null ? null : checkout,
        "draft": draft == null ? null : draft,
        "cancel": cancel == null ? null : cancel,
        "recent_product_quantity":
            recentProductQuantity == null ? null : recentProductQuantity,
        "weighing_scale": weighingScale,
        "edit_discount": editDiscount == null ? null : editDiscount,
        "edit_order_tax": editOrderTax == null ? null : editOrderTax,
        "add_payment_row": addPaymentRow == null ? null : addPaymentRow,
        "finalize_payment": finalizePayment == null ? null : finalizePayment,
        "add_new_product": addNewProduct == null ? null : addNewProduct,
      };
}

BusinessLocationModel businessLocationModelFromJson(Map<String, dynamic> bl) =>
    BusinessLocationModel.fromJson(bl);

Map<String, dynamic> businessLocationModelToJson(BusinessLocationModel data) =>
    data.toJson();

class BusinessLocationModel {
  BusinessLocationModel({
    this.id,
    this.isSelected = false,
    this.businessId,
    this.locationId,
    this.name,
    this.landmark,
    this.country,
    this.state,
    this.city,
    this.zipCode,
    this.invoiceSchemeId,
    this.invoiceLayoutId,
    this.saleInvoiceLayoutId,
    this.sellingPriceGroupId,
    this.printReceiptOnInvoice,
    this.receiptPrinterType,
    this.printerId,
    this.mobile,
    this.alternateNumber,
    this.email,
    this.website,
    this.featuredProducts = const [],
    this.isActive,
    this.defaultPaymentAccounts,
    this.customField1,
    this.customField2,
    this.customField3,
    this.customField4,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.paymentAccount,
  });

  int? id;
  bool isSelected = false;
  int? businessId;
  String? locationId;
  String? name;
  String? landmark;
  String? country;
  String? state;
  String? city;
  String? zipCode;
  int? invoiceSchemeId;
  int? invoiceLayoutId;
  int? saleInvoiceLayoutId;
  int? sellingPriceGroupId;
  int? printReceiptOnInvoice;
  String? receiptPrinterType;
  dynamic printerId;
  String? mobile;
  dynamic alternateNumber;
  dynamic email;
  String? website;
  List<String> featuredProducts = [];
  int? isActive;
  DefaultPaymentAccounts? defaultPaymentAccounts;
  dynamic customField1;
  dynamic customField2;
  dynamic customField3;
  dynamic customField4;
  dynamic deletedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<PaymentAccount>? paymentAccount;

  BusinessLocationModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    businessId = json["business_id"];
    locationId = json["location_id"];
    name = json["name"];
    landmark = json["landmark"];
    country = json["country"];
    state = json["state"];
    city = json["city"];
    zipCode = json["zip_code"];
    invoiceSchemeId = json["invoice_scheme_id"];
    invoiceLayoutId = json["invoice_layout_id"];
    saleInvoiceLayoutId = json["sale_invoice_layout_id"];
    sellingPriceGroupId = json["selling_price_group_id"];
    printReceiptOnInvoice = json["print_receipt_on_invoice"];
    receiptPrinterType = json["receipt_printer_type"];
    printerId = json["printer_id"];
    mobile = json["mobile"];
    alternateNumber = json["alternate_number"];
    email = json["email"];
    website = json["website"];
    if (json["featured_products"] != null)
      try {
        featuredProducts =
            List<String>.from(json["featured_products"].map((x) => x));
      } catch (_e) {
        logger.e('Error: Business Location Model -> featured_products -> $_e');
      }
    isActive = json["is_active"];
    if (json["default_payment_accounts"] != null)
      try {
        defaultPaymentAccounts =
            DefaultPaymentAccounts.fromJson(json["default_payment_accounts"]);
      } catch (_e) {
        try {
          defaultPaymentAccounts = DefaultPaymentAccounts.fromJson(
              jsonDecode(json["default_payment_accounts"]));
        } catch (e) {
          logger.e(
              'Error: Business Location Model -> default_payment_accounts -> $_e');
          logger.e(
              'Error: Business Location Model -> default_payment_accounts -> 2nd try -> $e');
        }
      }
    customField1 = json["custom_field1"];
    customField2 = json["custom_field2"];
    customField3 = json["custom_field3"];
    customField4 = json["custom_field4"];
    deletedAt = json["deleted_at"];

    if (json["created_at"] != null)
      try {
        createdAt = DateTime.tryParse('${json["created_at"]}');
      } catch (_e) {
        debugPrint('Error: Business Location Model -> created_at -> $_e');
      }
    if (json["updated_at"] != null)
      try {
        updatedAt = DateTime.tryParse('${json["updated_at"]}');
      } catch (_e) {
        debugPrint('Error: Business Location Model -> updated_at -> $_e');
      }
    paymentAccount = json["payment_account"] == null
        ? []
        : List<PaymentAccount>.from(
            json["payment_account"]!.map((x) => PaymentAccount.fromJson(x)));
  }

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "business_id": businessId == null ? null : businessId,
        "location_id": locationId == null ? null : locationId,
        "name": name == null ? null : name,
        "landmark": landmark == null ? null : landmark,
        "country": country == null ? null : country,
        "state": state == null ? null : state,
        "city": city == null ? null : city,
        "zip_code": zipCode == null ? null : zipCode,
        "invoice_scheme_id": invoiceSchemeId == null ? null : invoiceSchemeId,
        "invoice_layout_id": invoiceLayoutId == null ? null : invoiceLayoutId,
        "sale_invoice_layout_id":
            saleInvoiceLayoutId == null ? null : saleInvoiceLayoutId,
        "selling_price_group_id":
            sellingPriceGroupId == null ? null : sellingPriceGroupId,
        "print_receipt_on_invoice":
            printReceiptOnInvoice == null ? null : printReceiptOnInvoice,
        "receipt_printer_type":
            receiptPrinterType == null ? null : receiptPrinterType,
        "printer_id": printerId,
        "mobile": mobile == null ? null : mobile,
        "alternate_number": alternateNumber,
        "email": email,
        "website": website == null ? null : website,
        "featured_products": featuredProducts.isEmpty
            ? null
            : List<dynamic>.from(featuredProducts.map((x) => x)),
        "is_active": isActive == null ? null : isActive,
        "default_payment_accounts": defaultPaymentAccounts == null
            ? null
            : defaultPaymentAccounts?.toJson(),
        "custom_field1": customField1,
        "custom_field2": customField2,
        "custom_field3": customField3,
        "custom_field4": customField4,
        "deleted_at": deletedAt,
        "created_at": createdAt == null ? null : createdAt?.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt?.toIso8601String(),
        "payment_account": paymentAccount == null
            ? []
            : List<dynamic>.from(paymentAccount!.map((x) => x.toJson())),
      };
}

class DefaultPaymentAccounts {
  DefaultPaymentAccounts({
    this.cash,
    this.card,
    this.cheque,
    this.bankTransfer,
    this.other,
    this.customPay1,
    this.customPay2,
    this.customPay3,
    this.customPay4,
    this.customPay5,
    this.customPay6,
    this.customPay7,
  });

  BankTransfer? cash;
  BankTransfer? card;
  BankTransfer? cheque;
  BankTransfer? bankTransfer;
  CustomPay4? other;
  BankTransfer? customPay1;
  BankTransfer? customPay2;
  BankTransfer? customPay3;
  CustomPay4? customPay4;
  CustomPay4? customPay5;
  CustomPay4? customPay6;
  CustomPay4? customPay7;

  DefaultPaymentAccounts.fromJson(Map<String, dynamic> json) {
    cash = json["cash"] == null ? null : BankTransfer.fromJson(json["cash"]);
    card = json["card"] == null ? null : BankTransfer.fromJson(json["card"]);
    cheque =
        json["cheque"] == null ? null : BankTransfer.fromJson(json["cheque"]);
    bankTransfer = json["bank_transfer"] == null
        ? null
        : BankTransfer.fromJson(json["bank_transfer"]);
    other = json["other"] == null ? null : CustomPay4.fromJson(json["other"]);
    customPay1 = json["custom_pay_1"] == null
        ? null
        : BankTransfer.fromJson(json["custom_pay_1"]);
    customPay2 = json["custom_pay_2"] == null
        ? null
        : BankTransfer.fromJson(json["custom_pay_2"]);
    customPay3 = json["custom_pay_3"] == null
        ? null
        : BankTransfer.fromJson(json["custom_pay_3"]);
    customPay4 = json["custom_pay_4"] == null
        ? null
        : CustomPay4.fromJson(json["custom_pay_4"]);
    customPay5 = json["custom_pay_5"] == null
        ? null
        : CustomPay4.fromJson(json["custom_pay_5"]);
    customPay6 = json["custom_pay_6"] == null
        ? null
        : CustomPay4.fromJson(json["custom_pay_6"]);
    customPay7 = json["custom_pay_7"] == null
        ? null
        : CustomPay4.fromJson(json["custom_pay_7"]);
  }

  Map<String, dynamic> toJson() => {
        "cash": cash == null ? null : cash?.toJson(),
        "card": card == null ? null : card?.toJson(),
        "cheque": cheque == null ? null : cheque?.toJson(),
        "bank_transfer": bankTransfer == null ? null : bankTransfer?.toJson(),
        "other": other == null ? null : other?.toJson(),
        "custom_pay_1": customPay1 == null ? null : customPay1?.toJson(),
        "custom_pay_2": customPay2 == null ? null : customPay2?.toJson(),
        "custom_pay_3": customPay3 == null ? null : customPay3?.toJson(),
        "custom_pay_4": customPay4 == null ? null : customPay4?.toJson(),
        "custom_pay_5": customPay5 == null ? null : customPay5?.toJson(),
        "custom_pay_6": customPay6 == null ? null : customPay6?.toJson(),
        "custom_pay_7": customPay7 == null ? null : customPay7?.toJson(),
      };
}

class BankTransfer {
  BankTransfer({
    this.isEnabled,
    this.account,
  });

  final String? isEnabled;
  final String? account;

  factory BankTransfer.fromJson(Map<String, dynamic> json) => BankTransfer(
        isEnabled: json["is_enabled"] == null ? null : json["is_enabled"],
        account: json["account"] == null ? null : json["account"],
      );

  Map<String, dynamic> toJson() => {
        "is_enabled": isEnabled == null ? null : isEnabled,
        "account": account == null ? null : account,
      };
}

class CustomPay4 {
  CustomPay4({
    this.account,
  });

  final dynamic account;

  factory CustomPay4.fromJson(Map<String, dynamic> json) => CustomPay4(
        account: json["account"],
      );

  Map<String, dynamic> toJson() => {
        "account": account,
      };
}

class PosSettings {
  PosSettings({
    this.amountRoundingMethod,
    this.allowOverselling,
    this.enableSalesOrder,
    this.cmmsnCalculationType,
    this.razorPayKeyId,
    this.razorPayKeySecret,
    this.stripePublicKey,
    this.stripeSecretKey,
    this.disableDraft,
    this.disableExpressCheckout,
    this.disableSuspend,
    this.showPricingOnProductSuggestion,
    this.printInvoiceKot,
    this.showOrderInPos,
    this.showCategoryPos,
    this.cashDenominations,
    this.enableCashDenominationOn,
    this.disablePayCheckout,
    this.hideProductSuggestion,
    this.hideRecentTrans,
    this.disableDiscount,
    this.disableOrderTax,
    this.isPosSubtotalEditable,
  });

  final dynamic amountRoundingMethod;
  final int? allowOverselling;
  final int? enableSalesOrder;
  final String? cmmsnCalculationType;
  final dynamic razorPayKeyId;
  final dynamic razorPayKeySecret;
  final dynamic stripePublicKey;
  final dynamic stripeSecretKey;
  final int? disableDraft;
  final int? disableExpressCheckout;
  final int? disableSuspend;
  final int? showPricingOnProductSuggestion;
  final int? printInvoiceKot;
  final int? showOrderInPos;
  final int? showCategoryPos;
  final dynamic cashDenominations;
  final dynamic enableCashDenominationOn;
  final int? disablePayCheckout;
  final int? hideProductSuggestion;
  final int? hideRecentTrans;
  final int? disableDiscount;
  final int? disableOrderTax;
  final int? isPosSubtotalEditable;

  factory PosSettings.fromJson(Map<String, dynamic> json) => PosSettings(
        amountRoundingMethod: json["amount_rounding_method"],
        allowOverselling: json["allow_overselling"] == null
            ? null
            : int.tryParse('${json["allow_overselling"]}'),
        enableSalesOrder: json["enable_sales_order"] == null
            ? null
            : int.tryParse('${json["enable_sales_order"]}'),
        cmmsnCalculationType: json["cmmsn_calculation_type"] == null
            ? null
            : json["cmmsn_calculation_type"],
        razorPayKeyId: json["razor_pay_key_id"],
        razorPayKeySecret: json["razor_pay_key_secret"],
        stripePublicKey: json["stripe_public_key"],
        stripeSecretKey: json["stripe_secret_key"],
        disableDraft: json["disable_draft"] == null
            ? null
            : int.tryParse('${json["disable_draft"]}'),
        disableExpressCheckout: json["disable_express_checkout"] == null
            ? null
            : int.tryParse('${json["disable_express_checkout"]}'),
        disableSuspend: json["disable_suspend"] == null
            ? null
            : int.tryParse('${json["disable_suspend"]}'),
        showPricingOnProductSuggestion:
            json["show_pricing_on_product_sugesstion"] == null
                ? null
                : int.tryParse('${json["show_pricing_on_product_sugesstion"]}'),
        printInvoiceKot: json["print_invoice_kot"] == null
            ? null
            : int.tryParse('${json["print_invoice_kot"]}'),
        showOrderInPos: json["show_order_in_pos"] == null
            ? null
            : int.tryParse('${json["show_order_in_pos"]}'),
        showCategoryPos: json["show_category_pos"] == null
            ? null
            : int.tryParse('${json["show_category_pos"]}'),
        cashDenominations: json["cash_denominations"],
        enableCashDenominationOn: json["enable_cash_denomination_on"],
        disablePayCheckout: json["disable_pay_checkout"] == null
            ? null
            : int.tryParse('${json["disable_pay_checkout"]}'),
        hideProductSuggestion: json["hide_product_suggestion"] == null
            ? null
            : int.tryParse('${json["hide_product_suggestion"]}'),
        hideRecentTrans: json["hide_recent_trans"] == null
            ? null
            : int.tryParse('${json["hide_recent_trans"]}'),
        disableDiscount: json["disable_discount"] == null
            ? null
            : int.tryParse('${json["disable_discount"]}'),
        disableOrderTax: json["disable_order_tax"] == null
            ? null
            : int.tryParse('${json["disable_order_tax"]}'),
        isPosSubtotalEditable: json["is_pos_subtotal_editable"] == null
            ? null
            : int.tryParse('${json["is_pos_subtotal_editable"]}'),
      );

  Map<String, dynamic> toJson() => {
        "amount_rounding_method": amountRoundingMethod,
        "allow_overselling": allowOverselling == null ? null : allowOverselling,
        "enable_sales_order":
            enableSalesOrder == null ? null : enableSalesOrder,
        "cmmsn_calculation_type":
            cmmsnCalculationType == null ? null : cmmsnCalculationType,
        "razor_pay_key_id": razorPayKeyId,
        "razor_pay_key_secret": razorPayKeySecret,
        "stripe_public_key": stripePublicKey,
        "stripe_secret_key": stripeSecretKey,
        "disable_draft": disableDraft == null ? null : disableDraft,
        "disable_express_checkout":
            disableExpressCheckout == null ? null : disableExpressCheckout,
        "disable_suspend": disableSuspend == null ? null : disableSuspend,
        "show_pricing_on_product_sugesstion": showPricingOnProductSuggestion,
        "print_invoice_kot": printInvoiceKot == null ? null : printInvoiceKot,
        "show_order_in_pos": showOrderInPos == null ? null : showOrderInPos,
        "show_category_pos": showCategoryPos == null ? null : showCategoryPos,
        "cash_denominations": cashDenominations,
        "enable_cash_denomination_on":
            enableCashDenominationOn == null ? null : enableCashDenominationOn,
        "disable_pay_checkout":
            disablePayCheckout == null ? null : disablePayCheckout,
        "hide_product_suggestion":
            hideProductSuggestion == null ? null : hideProductSuggestion,
        "hide_recent_trans": hideRecentTrans == null ? null : hideRecentTrans,
        "disable_discount": disableDiscount == null ? null : disableDiscount,
        "disable_order_tax": disableOrderTax == null ? null : disableOrderTax,
        "is_pos_subtotal_editable":
            isPosSubtotalEditable == null ? null : isPosSubtotalEditable,
      };
}

class Printer {
  Printer({
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
  });

  final int? id;
  final int? businessId;
  final String? name;
  final String? connectionType;
  final String? capabilityProfile;
  final String? charPerLine;
  final String? ipAddress;
  final String? port;
  final String? path;
  final int? createdBy;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory Printer.fromJson(Map<String, dynamic> json) => Printer(
        id: json["id"] == null ? null : json["id"],
        businessId: json["business_id"] == null ? null : json["business_id"],
        name: json["name"] == null ? null : json["name"],
        connectionType:
            json["connection_type"] == null ? null : json["connection_type"],
        capabilityProfile: json["capability_profile"] == null
            ? null
            : json["capability_profile"],
        charPerLine:
            json["char_per_line"] == null ? null : json["char_per_line"],
        ipAddress: json["ip_address"] == null ? null : json["ip_address"],
        port: json["port"] == null ? null : json["port"],
        path: json["path"] == null ? null : json["path"],
        createdBy: json["created_by"] == null ? null : json["created_by"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.tryParse('${json["created_at"]}'),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.tryParse('${json["updated_at"]}'),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "business_id": businessId == null ? null : businessId,
        "name": name == null ? null : name,
        "connection_type": connectionType == null ? null : connectionType,
        "capability_profile":
            capabilityProfile == null ? null : capabilityProfile,
        "char_per_line": charPerLine == null ? null : charPerLine,
        "ip_address": ipAddress == null ? null : ipAddress,
        "port": port == null ? null : port,
        "path": path == null ? null : path,
        "created_by": createdBy == null ? null : createdBy,
        "created_at": createdAt == null ? null : createdAt?.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt?.toIso8601String(),
      };
}

class RefNoPrefixes {
  RefNoPrefixes({
    this.purchase,
    this.purchaseReturn,
    this.purchaseRequisition,
    this.purchaseOrder,
    this.stockTransfer,
    this.stockAdjustment,
    this.sellReturn,
    this.expense,
    this.contacts,
    this.purchasePayment,
    this.sellPayment,
    this.expensePayment,
    this.businessLocation,
    this.username,
    this.subscription,
    this.draft,
    this.salesOrder,
  });

  final String? purchase;
  final dynamic purchaseReturn;
  final dynamic purchaseRequisition;
  final dynamic purchaseOrder;
  final String? stockTransfer;
  final String? stockAdjustment;
  final String? sellReturn;
  final String? expense;
  final String? contacts;
  final String? purchasePayment;
  final String? sellPayment;
  final dynamic expensePayment;
  final String? businessLocation;
  final dynamic username;
  final dynamic subscription;
  final dynamic draft;
  final dynamic salesOrder;

  factory RefNoPrefixes.fromJson(Map<String, dynamic> json) => RefNoPrefixes(
        purchase: json["purchase"] == null ? null : json["purchase"],
        purchaseReturn: json["purchase_return"],
        purchaseRequisition: json["purchase_requisition"],
        purchaseOrder: json["purchase_order"],
        stockTransfer:
            json["stock_transfer"] == null ? null : json["stock_transfer"],
        stockAdjustment:
            json["stock_adjustment"] == null ? null : json["stock_adjustment"],
        sellReturn: json["sell_return"] == null ? null : json["sell_return"],
        expense: json["expense"] == null ? null : json["expense"],
        contacts: json["contacts"] == null ? null : json["contacts"],
        purchasePayment:
            json["purchase_payment"] == null ? null : json["purchase_payment"],
        sellPayment: json["sell_payment"] == null ? null : json["sell_payment"],
        expensePayment: json["expense_payment"],
        businessLocation: json["business_location"] == null
            ? null
            : json["business_location"],
        username: json["username"],
        subscription: json["subscription"],
        draft: json["draft"],
        salesOrder: json["sales_order"],
      );

  Map<String, dynamic> toJson() => {
        "purchase": purchase == null ? null : purchase,
        "purchase_return": purchaseReturn,
        "purchase_requisition": purchaseRequisition,
        "purchase_order": purchaseOrder,
        "stock_transfer": stockTransfer == null ? null : stockTransfer,
        "stock_adjustment": stockAdjustment == null ? null : stockAdjustment,
        "sell_return": sellReturn == null ? null : sellReturn,
        "expense": expense == null ? null : expense,
        "contacts": contacts == null ? null : contacts,
        "purchase_payment": purchasePayment == null ? null : purchasePayment,
        "sell_payment": sellPayment == null ? null : sellPayment,
        "expense_payment": expensePayment,
        "business_location": businessLocation == null ? null : businessLocation,
        "username": username,
        "subscription": subscription,
        "draft": draft,
        "sales_order": salesOrder,
      };
}

class SmsSettings {
  SmsSettings({
    this.smsService,
    this.nexmoKey,
    this.nexmoSecret,
    this.nexmoFrom,
    this.twilioSid,
    this.twilioToken,
    this.twilioFrom,
    this.url,
    this.sendToParamName,
    this.msgParamName,
    this.requestMethod,
    this.header1,
    this.headerVal1,
    this.header2,
    this.headerVal2,
    this.header3,
    this.headerVal3,
    this.param1,
    this.paramVal1,
    this.param2,
    this.paramVal2,
    this.param3,
    this.paramVal3,
    this.param4,
    this.paramVal4,
    this.param5,
    this.paramVal5,
    this.param6,
    this.paramVal6,
    this.param7,
    this.paramVal7,
    this.param8,
    this.paramVal8,
    this.param9,
    this.paramVal9,
    this.param10,
    this.paramVal10,
  });

  final String? smsService;
  final dynamic nexmoKey;
  final dynamic nexmoSecret;
  final dynamic nexmoFrom;
  final dynamic twilioSid;
  final dynamic twilioToken;
  final dynamic twilioFrom;
  final dynamic url;
  final String? sendToParamName;
  final String? msgParamName;
  final String? requestMethod;
  final dynamic header1;
  final dynamic headerVal1;
  final dynamic header2;
  final dynamic headerVal2;
  final dynamic header3;
  final dynamic headerVal3;
  final dynamic param1;
  final dynamic paramVal1;
  final dynamic param2;
  final dynamic paramVal2;
  final dynamic param3;
  final dynamic paramVal3;
  final dynamic param4;
  final dynamic paramVal4;
  final dynamic param5;
  final dynamic paramVal5;
  final dynamic param6;
  final dynamic paramVal6;
  final dynamic param7;
  final dynamic paramVal7;
  final dynamic param8;
  final dynamic paramVal8;
  final dynamic param9;
  final dynamic paramVal9;
  final dynamic param10;
  final dynamic paramVal10;

  factory SmsSettings.fromJson(Map<String, dynamic> json) => SmsSettings(
        smsService: json["sms_service"] == null ? null : json["sms_service"],
        nexmoKey: json["nexmo_key"],
        nexmoSecret: json["nexmo_secret"],
        nexmoFrom: json["nexmo_from"],
        twilioSid: json["twilio_sid"],
        twilioToken: json["twilio_token"],
        twilioFrom: json["twilio_from"],
        url: json["url"],
        sendToParamName: json["send_to_param_name"] == null
            ? null
            : json["send_to_param_name"],
        msgParamName:
            json["msg_param_name"] == null ? null : json["msg_param_name"],
        requestMethod:
            json["request_method"] == null ? null : json["request_method"],
        header1: json["header_1"],
        headerVal1: json["header_val_1"],
        header2: json["header_2"],
        headerVal2: json["header_val_2"],
        header3: json["header_3"],
        headerVal3: json["header_val_3"],
        param1: json["param_1"],
        paramVal1: json["param_val_1"],
        param2: json["param_2"],
        paramVal2: json["param_val_2"],
        param3: json["param_3"],
        paramVal3: json["param_val_3"],
        param4: json["param_4"],
        paramVal4: json["param_val_4"],
        param5: json["param_5"],
        paramVal5: json["param_val_5"],
        param6: json["param_6"],
        paramVal6: json["param_val_6"],
        param7: json["param_7"],
        paramVal7: json["param_val_7"],
        param8: json["param_8"],
        paramVal8: json["param_val_8"],
        param9: json["param_9"],
        paramVal9: json["param_val_9"],
        param10: json["param_10"],
        paramVal10: json["param_val_10"],
      );

  Map<String, dynamic> toJson() => {
        "sms_service": smsService == null ? null : smsService,
        "nexmo_key": nexmoKey,
        "nexmo_secret": nexmoSecret,
        "nexmo_from": nexmoFrom,
        "twilio_sid": twilioSid,
        "twilio_token": twilioToken,
        "twilio_from": twilioFrom,
        "url": url,
        "send_to_param_name": sendToParamName == null ? null : sendToParamName,
        "msg_param_name": msgParamName == null ? null : msgParamName,
        "request_method": requestMethod == null ? null : requestMethod,
        "header_1": header1,
        "header_val_1": headerVal1,
        "header_2": header2,
        "header_val_2": headerVal2,
        "header_3": header3,
        "header_val_3": headerVal3,
        "param_1": param1,
        "param_val_1": paramVal1,
        "param_2": param2,
        "param_val_2": paramVal2,
        "param_3": param3,
        "param_val_3": paramVal3,
        "param_4": param4,
        "param_val_4": paramVal4,
        "param_5": param5,
        "param_val_5": paramVal5,
        "param_6": param6,
        "param_val_6": paramVal6,
        "param_7": param7,
        "param_val_7": paramVal7,
        "param_8": param8,
        "param_val_8": paramVal8,
        "param_9": param9,
        "param_val_9": paramVal9,
        "param_10": param10,
        "param_val_10": paramVal10,
      };
}

class WeighingScaleSetting {
  WeighingScaleSetting({
    this.labelPrefix,
    this.productSkuLength,
    this.qtyLength,
    this.qtyLengthDecimal,
  });

  final dynamic labelPrefix;
  final String? productSkuLength;
  final String? qtyLength;
  final String? qtyLengthDecimal;

  factory WeighingScaleSetting.fromJson(Map<String, dynamic> json) =>
      WeighingScaleSetting(
        labelPrefix: json["label_prefix"],
        productSkuLength: json["product_sku_length"] == null
            ? null
            : json["product_sku_length"],
        qtyLength: json["qty_length"] == null ? null : json["qty_length"],
        qtyLengthDecimal: json["qty_length_decimal"] == null
            ? null
            : json["qty_length_decimal"],
      );

  Map<String, dynamic> toJson() => {
        "label_prefix": labelPrefix,
        "product_sku_length":
            productSkuLength == null ? null : productSkuLength,
        "qty_length": qtyLength == null ? null : qtyLength,
        "qty_length_decimal":
            qtyLengthDecimal == null ? null : qtyLengthDecimal,
      };
}
