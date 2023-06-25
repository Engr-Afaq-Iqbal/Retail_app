// To parse this JSON data, do
//
//     final loggedInUserDetail = loggedInUserDetailFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/material.dart';

LoggedInUserDetail loggedInUserDetailFromJson(String str) =>
    LoggedInUserDetail.fromJson(json.decode(str));

String loggedInUserDetailToJson(LoggedInUserDetail data) =>
    json.encode(data.toJson());

class LoggedInUserDetail {
  LoggedInUserDetail({
    required this.staffUser,
  });

  StaffUserModel staffUser;

  factory LoggedInUserDetail.fromJson(Map<String, dynamic> json) =>
      LoggedInUserDetail(
        staffUser: staffUserModelFromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": staffUserModelToJson(staffUser),
      };
}

StaffUserModel staffUserModelFromJson(Map<String, dynamic> str) =>
    StaffUserModel.fromJson(str);

Map<String, dynamic> staffUserModelToJson(StaffUserModel data) => data.toJson();

class StaffUserModel {
  StaffUserModel({
    required this.id,
    this.userType,
    this.surname,
    this.firstName,
    this.lastName,
    this.username,
    this.email,
    this.language,
    this.contactNo,
    this.address,
    this.businessId,
    this.availableAt,
    this.pausedAt,
    this.essentialsDepartmentId,
    this.essentialsDesignationId,
    this.essentialsSalary,
    this.essentialsPayPeriod,
    this.essentialsPayCycle,
    this.maxSalesDiscountPercent,
    this.allowLogin,
    this.status,
    this.crmContactId,
    this.isCmmsnAgnt,
    this.cmmsnPercent,
    this.selectedContacts,
    this.dob,
    this.gender,
    this.maritalStatus,
    this.bloodGroup,
    this.contactNumber,
    this.altNumber,
    this.familyNumber,
    this.fbLink,
    this.twitterLink,
    this.socialMedia1,
    this.socialMedia2,
    this.permanentAddress,
    this.currentAddress,
    this.guardianName,
    this.customField1,
    this.customField2,
    this.customField3,
    this.customField4,
    this.bankDetails,
    this.idProofName,
    this.idProofNumber,
    this.crmDepartment,
    this.crmDesignation,
    this.locationId,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.isAdmin,
    this.business,
    this.media,
    this.appSetting,
  });

  late int id;
  String? userType;
  String? surname;
  String? firstName;
  String? lastName;
  String? username;
  String? email;
  String? language;
  dynamic contactNo;
  dynamic address;
  int? businessId;
  dynamic availableAt;
  dynamic pausedAt;
  dynamic essentialsDepartmentId;
  dynamic essentialsDesignationId;
  dynamic essentialsSalary;
  String? essentialsPayPeriod;
  dynamic essentialsPayCycle;
  dynamic maxSalesDiscountPercent;
  int? allowLogin;
  String? status;
  dynamic crmContactId;
  int? isCmmsnAgnt;
  String? cmmsnPercent;
  int? selectedContacts;
  dynamic dob;
  dynamic gender;
  dynamic maritalStatus;
  dynamic bloodGroup;
  dynamic contactNumber;
  dynamic altNumber;
  dynamic familyNumber;
  dynamic fbLink;
  dynamic twitterLink;
  dynamic socialMedia1;
  dynamic socialMedia2;
  dynamic permanentAddress;
  dynamic currentAddress;
  dynamic guardianName;
  dynamic customField1;
  dynamic customField2;
  dynamic customField3;
  dynamic customField4;
  BankDetails? bankDetails;
  dynamic idProofName;
  dynamic idProofNumber;
  dynamic crmDepartment;
  dynamic crmDesignation;
  dynamic locationId;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;
  bool? isAdmin;
  Business? business;
  Media? media;
  AppSetting? appSetting;

  StaffUserModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    userType = json["user_type"];
    surname = json["surname"];
    firstName = json["first_name"];
    lastName = json["last_name"];
    username = json["username"];
    email = json["email"];
    language = json["language"];
    contactNo = json["contact_no"];
    address = json["address"];
    businessId = json["business_id"];
    availableAt = json["available_at"];
    pausedAt = json["paused_at"];
    essentialsDepartmentId = json["essentials_department_id"];
    essentialsDesignationId = json["essentials_designation_id"];
    essentialsSalary = json["essentials_salary"];
    essentialsPayPeriod = json["essentials_pay_period"];
    essentialsPayCycle = json["essentials_pay_cycle"];
    maxSalesDiscountPercent = json["max_sales_discount_percent"];
    allowLogin = json["allow_login"];
    status = json["status"];
    crmContactId = json["crm_contact_id"];
    isCmmsnAgnt = json["is_cmmsn_agnt"];
    cmmsnPercent = json["cmmsn_percent"];
    selectedContacts = json["selected_contacts"];
    dob = json["dob"];
    gender = json["gender"];
    maritalStatus = json["marital_status"];
    bloodGroup = json["blood_group"];
    contactNumber = json["contact_number"];
    altNumber = json["alt_number"];
    familyNumber = json["family_number"];
    fbLink = json["fb_link"];
    twitterLink = json["twitter_link"];
    socialMedia1 = json["social_media_1"];
    socialMedia2 = json["social_media_2"];
    permanentAddress = json["permanent_address"];
    currentAddress = json["current_address"];
    guardianName = json["guardian_name"];
    customField1 = json["custom_field_1"];
    customField2 = json["custom_field_2"];
    customField3 = json["custom_field_3"];
    customField4 = json["custom_field_4"];
    try {
      bankDetails = json["bank_details"] == null
          ? null
          : BankDetails.fromJson(json["bank_details"]);
    } catch (e) {
      try {
        bankDetails = json["bank_details"] == null
            ? null
            : BankDetails.fromJson(jsonDecode(json["bank_details"]));
      } catch (_e) {
        debugPrint('Error -> StaffUserModel -> bankDetails : $e');
        debugPrint(
            'Error -> StaffUserModel -> bankDetails -> jsonDecoding : $_e');
      }
    }
    idProofName = json["id_proof_name"];
    idProofNumber = json["id_proof_number"];
    crmDepartment = json["crm_department"];
    crmDesignation = json["crm_designation"];
    locationId = json["location_id"];
    deletedAt = json["deleted_at"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
    isAdmin = json["is_admin"];
    try {
      business =
          json["business"] != null ? Business.fromJson(json["business"]) : null;
    } catch (e) {
      debugPrint('Error -> StaffUserModel -> business : $e');
    }
    ;
    media = json["media"] == null ? null : Media.fromJson(json["media"]);
    // try {
    //
    // } catch (e) {
    //   debugPrint('Error -> StaffUserModel -> media : $e');
    // }
    appSetting = json["app_setting"] == null
        ? null
        : AppSetting.fromJson(json["app_setting"]);
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_type": userType,
        "surname": surname,
        "first_name": firstName,
        "last_name": lastName,
        "username": username,
        "email": email,
        "language": language,
        "contact_no": contactNo,
        "address": address,
        "business_id": businessId,
        "available_at": availableAt,
        "paused_at": pausedAt,
        "essentials_department_id": essentialsDepartmentId,
        "essentials_designation_id": essentialsDesignationId,
        "essentials_salary": essentialsSalary,
        "essentials_pay_period": essentialsPayPeriod,
        "essentials_pay_cycle": essentialsPayCycle,
        "max_sales_discount_percent": maxSalesDiscountPercent,
        "allow_login": allowLogin,
        "status": status,
        "crm_contact_id": crmContactId,
        "is_cmmsn_agnt": isCmmsnAgnt,
        "cmmsn_percent": cmmsnPercent,
        "selected_contacts": selectedContacts,
        "dob": dob,
        "gender": gender,
        "marital_status": maritalStatus,
        "blood_group": bloodGroup,
        "contact_number": contactNumber,
        "alt_number": altNumber,
        "family_number": familyNumber,
        "fb_link": fbLink,
        "twitter_link": twitterLink,
        "social_media_1": socialMedia1,
        "social_media_2": socialMedia2,
        "permanent_address": permanentAddress,
        "current_address": currentAddress,
        "guardian_name": guardianName,
        "custom_field_1": customField1,
        "custom_field_2": customField2,
        "custom_field_3": customField3,
        "custom_field_4": customField4,
        "bank_details": bankDetails?.toJson(),
        "id_proof_name": idProofName,
        "id_proof_number": idProofNumber,
        "crm_department": crmDepartment,
        "crm_designation": crmDesignation,
        "location_id": locationId,
        "deleted_at": deletedAt,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "is_admin": isAdmin,
        "business": business?.toJson(),
        "media": media?.toJson(),
        "app_setting": appSetting?.toJson(),
      };
}

class Business {
  Business({
    required this.id,
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
  });

  int id;
  String? name;
  int? currencyId;
  String? startDate;
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
  String? keyboardShortcuts;
  String? posSettings;
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
  List<String> enabledModules;
  String? dateFormat;
  String? timeFormat;
  int? currencyPrecision;
  int? quantityPrecision;
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
  String? customLabels;
  CommonSettings? commonSettings;
  int? isActive;
  String? createdAt;
  String? updatedAt;

  factory Business.fromJson(Map<String, dynamic> json) => Business(
        id: json["id"],
        name: json["name"],
        currencyId: json["currency_id"],
        startDate: json["start_date"],
        taxNumber1: json["tax_number_1"],
        taxLabel1: json["tax_label_1"],
        taxNumber2: json["tax_number_2"],
        taxLabel2: json["tax_label_2"],
        codeLabel1: json["code_label_1"],
        code1: json["code_1"],
        codeLabel2: json["code_label_2"],
        code2: json["code_2"],
        defaultSalesTax: json["default_sales_tax"],
        defaultProfitPercent: json["default_profit_percent"],
        ownerId: json["owner_id"],
        timeZone: json["time_zone"],
        fyStartMonth: json["fy_start_month"],
        accountingMethod: json["accounting_method"],
        defaultSalesDiscount: json["default_sales_discount"],
        sellPriceTax: json["sell_price_tax"],
        logo: json["logo"],
        skuPrefix: json["sku_prefix"],
        enableProductExpiry: json["enable_product_expiry"],
        expiryType: json["expiry_type"],
        onProductExpiry: json["on_product_expiry"],
        stopSellingBefore: json["stop_selling_before"],
        enableTooltip: json["enable_tooltip"],
        purchaseInDiffCurrency: json["purchase_in_diff_currency"],
        purchaseCurrencyId: json["purchase_currency_id"],
        pExchangeRate: json["p_exchange_rate"],
        transactionEditDays: json["transaction_edit_days"],
        stockExpiryAlertDays: json["stock_expiry_alert_days"],
        keyboardShortcuts: json["keyboard_shortcuts"],
        posSettings: json["pos_settings"],
        manufacturingSettings: json["manufacturing_settings"],
        woocommerceSkippedOrders: json["woocommerce_skipped_orders"],
        woocommerceWhOcSecret: json["woocommerce_wh_oc_secret"],
        woocommerceWhOuSecret: json["woocommerce_wh_ou_secret"],
        woocommerceWhOdSecret: json["woocommerce_wh_od_secret"],
        woocommerceWhOrSecret: json["woocommerce_wh_or_secret"],
        essentialsSettings: json["essentials_settings"],
        weighingScaleSetting: json["weighing_scale_setting"] != null
            ? WeighingScaleSetting.fromJson(json["weighing_scale_setting"])
            : null,
        enableBrand: json["enable_brand"],
        enableCategory: json["enable_category"],
        enableSubCategory: json["enable_sub_category"],
        enablePriceTax: json["enable_price_tax"],
        enablePurchaseStatus: json["enable_purchase_status"],
        enableLotNumber: json["enable_lot_number"],
        defaultUnit: json["default_unit"],
        enableSubUnits: json["enable_sub_units"],
        enableRacks: json["enable_racks"],
        enableRow: json["enable_row"],
        enablePosition: json["enable_position"],
        enableEditingProductFromPurchase:
            json["enable_editing_product_from_purchase"],
        salesCmsnAgnt: json["sales_cmsn_agnt"],
        itemAdditionMethod: json["item_addition_method"],
        enableInlineTax: json["enable_inline_tax"],
        currencySymbolPlacement: json["currency_symbol_placement"],
        enabledModules:
            List<String>.from(json["enabled_modules"].map((x) => x)),
        dateFormat: json["date_format"],
        timeFormat: json["time_format"],
        currencyPrecision: json["currency_precision"],
        quantityPrecision: json["quantity_precision"],
        refNoPrefixes: json["ref_no_prefixes"] != null
            ? RefNoPrefixes.fromJson(json["ref_no_prefixes"])
            : null,
        themeColor: json["theme_color"],
        createdBy: json["created_by"],
        assetSettings: json["asset_settings"],
        repairSettings: json["repair_settings"],
        crmSettings: json["crm_settings"],
        enableRp: json["enable_rp"],
        rpName: json["rp_name"],
        amountForUnitRp: json["amount_for_unit_rp"],
        minOrderTotalForRp: json["min_order_total_for_rp"],
        maxRpPerOrder: json["max_rp_per_order"],
        redeemAmountPerUnitRp: json["redeem_amount_per_unit_rp"],
        minOrderTotalForRedeem: json["min_order_total_for_redeem"],
        minRedeemPoint: json["min_redeem_point"],
        maxRedeemPoint: json["max_redeem_point"],
        rpExpiryPeriod: json["rp_expiry_period"],
        rpExpiryType: json["rp_expiry_type"],
        emailSettings: json["email_settings"] != null
            ? EmailSettings.fromJson(json["email_settings"])
            : null,
        smsSettings: json["sms_settings"] != null
            ? SmsSettings.fromJson(json["sms_settings"])
            : null,
        customLabels: json["custom_labels"],
        commonSettings: json["common_settings"] != null
            ? CommonSettings.fromJson(json["common_settings"])
            : null,
        isActive: json["is_active"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "currency_id": currencyId,
        "start_date": "$startDate",
        "tax_number_1": taxNumber1,
        "tax_label_1": taxLabel1,
        "tax_number_2": taxNumber2,
        "tax_label_2": taxLabel2,
        "code_label_1": codeLabel1,
        "code_1": code1,
        "code_label_2": codeLabel2,
        "code_2": code2,
        "default_sales_tax": defaultSalesTax,
        "default_profit_percent": defaultProfitPercent,
        "owner_id": ownerId,
        "time_zone": timeZone,
        "fy_start_month": fyStartMonth,
        "accounting_method": accountingMethod,
        "default_sales_discount": defaultSalesDiscount,
        "sell_price_tax": sellPriceTax,
        "logo": logo,
        "sku_prefix": skuPrefix,
        "enable_product_expiry": enableProductExpiry,
        "expiry_type": expiryType,
        "on_product_expiry": onProductExpiry,
        "stop_selling_before": stopSellingBefore,
        "enable_tooltip": enableTooltip,
        "purchase_in_diff_currency": purchaseInDiffCurrency,
        "purchase_currency_id": purchaseCurrencyId,
        "p_exchange_rate": pExchangeRate,
        "transaction_edit_days": transactionEditDays,
        "stock_expiry_alert_days": stockExpiryAlertDays,
        "keyboard_shortcuts": keyboardShortcuts,
        "pos_settings": posSettings,
        "manufacturing_settings": manufacturingSettings,
        "woocommerce_skipped_orders": woocommerceSkippedOrders,
        "woocommerce_wh_oc_secret": woocommerceWhOcSecret,
        "woocommerce_wh_ou_secret": woocommerceWhOuSecret,
        "woocommerce_wh_od_secret": woocommerceWhOdSecret,
        "woocommerce_wh_or_secret": woocommerceWhOrSecret,
        "essentials_settings": essentialsSettings,
        "weighing_scale_setting": weighingScaleSetting?.toJson(),
        "enable_brand": enableBrand,
        "enable_category": enableCategory,
        "enable_sub_category": enableSubCategory,
        "enable_price_tax": enablePriceTax,
        "enable_purchase_status": enablePurchaseStatus,
        "enable_lot_number": enableLotNumber,
        "default_unit": defaultUnit,
        "enable_sub_units": enableSubUnits,
        "enable_racks": enableRacks,
        "enable_row": enableRow,
        "enable_position": enablePosition,
        "enable_editing_product_from_purchase":
            enableEditingProductFromPurchase,
        "sales_cmsn_agnt": salesCmsnAgnt,
        "item_addition_method": itemAdditionMethod,
        "enable_inline_tax": enableInlineTax,
        "currency_symbol_placement": currencySymbolPlacement,
        "enabled_modules": List<dynamic>.from(enabledModules.map((x) => x)),
        "date_format": dateFormat,
        "time_format": timeFormat,
        "currency_precision": currencyPrecision,
        "quantity_precision": quantityPrecision,
        "ref_no_prefixes": refNoPrefixes?.toJson(),
        "theme_color": themeColor,
        "created_by": createdBy,
        "asset_settings": assetSettings,
        "repair_settings": repairSettings,
        "crm_settings": crmSettings,
        "enable_rp": enableRp,
        "rp_name": rpName,
        "amount_for_unit_rp": amountForUnitRp,
        "min_order_total_for_rp": minOrderTotalForRp,
        "max_rp_per_order": maxRpPerOrder,
        "redeem_amount_per_unit_rp": redeemAmountPerUnitRp,
        "min_order_total_for_redeem": minOrderTotalForRedeem,
        "min_redeem_point": minRedeemPoint,
        "max_redeem_point": maxRedeemPoint,
        "rp_expiry_period": rpExpiryPeriod,
        "rp_expiry_type": rpExpiryType,
        "email_settings": emailSettings?.toJson(),
        "sms_settings": smsSettings?.toJson(),
        "custom_labels": customLabels,
        "common_settings": commonSettings?.toJson(),
        "is_active": isActive,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}

class CommonSettings {
  CommonSettings({
    this.enableProductWarranty,
    this.defaultCreditLimit,
    this.enablePurchaseOrder,
    this.defaultDatatablePageEntries,
  });

  String? enableProductWarranty;
  String? defaultCreditLimit;
  String? enablePurchaseOrder;
  String? defaultDatatablePageEntries;

  factory CommonSettings.fromJson(Map<String, dynamic> json) => CommonSettings(
        enableProductWarranty: json["enable_product_warranty"],
        defaultCreditLimit: json["default_credit_limit"],
        enablePurchaseOrder: json["enable_purchase_order"],
        defaultDatatablePageEntries: json["default_datatable_page_entries"],
      );

  Map<String, dynamic> toJson() => {
        "enable_product_warranty": enableProductWarranty,
        "default_credit_limit": defaultCreditLimit,
        "enable_purchase_order": enablePurchaseOrder,
        "default_datatable_page_entries": defaultDatatablePageEntries,
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

  String? mailDriver;
  dynamic mailHost;
  dynamic mailPort;
  dynamic mailUsername;
  dynamic mailPassword;
  dynamic mailEncryption;
  dynamic mailFromAddress;
  dynamic mailFromName;

  factory EmailSettings.fromJson(Map<String, dynamic> json) => EmailSettings(
        mailDriver: json["mail_driver"],
        mailHost: json["mail_host"],
        mailPort: json["mail_port"],
        mailUsername: json["mail_username"],
        mailPassword: json["mail_password"],
        mailEncryption: json["mail_encryption"],
        mailFromAddress: json["mail_from_address"],
        mailFromName: json["mail_from_name"],
      );

  Map<String, dynamic> toJson() => {
        "mail_driver": mailDriver,
        "mail_host": mailHost,
        "mail_port": mailPort,
        "mail_username": mailUsername,
        "mail_password": mailPassword,
        "mail_encryption": mailEncryption,
        "mail_from_address": mailFromAddress,
        "mail_from_name": mailFromName,
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

  String? purchase;
  dynamic purchaseReturn;
  dynamic purchaseRequisition;
  dynamic purchaseOrder;
  String? stockTransfer;
  String? stockAdjustment;
  String? sellReturn;
  String? expense;
  String? contacts;
  String? purchasePayment;
  String? sellPayment;
  dynamic expensePayment;
  String? businessLocation;
  dynamic username;
  dynamic subscription;
  dynamic draft;
  dynamic salesOrder;

  factory RefNoPrefixes.fromJson(Map<String, dynamic> json) => RefNoPrefixes(
        purchase: json["purchase"],
        purchaseReturn: json["purchase_return"],
        purchaseRequisition: json["purchase_requisition"],
        purchaseOrder: json["purchase_order"],
        stockTransfer: json["stock_transfer"],
        stockAdjustment: json["stock_adjustment"],
        sellReturn: json["sell_return"],
        expense: json["expense"],
        contacts: json["contacts"],
        purchasePayment: json["purchase_payment"],
        sellPayment: json["sell_payment"],
        expensePayment: json["expense_payment"],
        businessLocation: json["business_location"],
        username: json["username"],
        subscription: json["subscription"],
        draft: json["draft"],
        salesOrder: json["sales_order"],
      );

  Map<String, dynamic> toJson() => {
        "purchase": purchase,
        "purchase_return": purchaseReturn,
        "purchase_requisition": purchaseRequisition,
        "purchase_order": purchaseOrder,
        "stock_transfer": stockTransfer,
        "stock_adjustment": stockAdjustment,
        "sell_return": sellReturn,
        "expense": expense,
        "contacts": contacts,
        "purchase_payment": purchasePayment,
        "sell_payment": sellPayment,
        "expense_payment": expensePayment,
        "business_location": businessLocation,
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

  String? smsService;
  dynamic nexmoKey;
  dynamic nexmoSecret;
  dynamic nexmoFrom;
  dynamic twilioSid;
  dynamic twilioToken;
  dynamic twilioFrom;
  dynamic url;
  String? sendToParamName;
  String? msgParamName;
  String? requestMethod;
  dynamic header1;
  dynamic headerVal1;
  dynamic header2;
  dynamic headerVal2;
  dynamic header3;
  dynamic headerVal3;
  dynamic param1;
  dynamic paramVal1;
  dynamic param2;
  dynamic paramVal2;
  dynamic param3;
  dynamic paramVal3;
  dynamic param4;
  dynamic paramVal4;
  dynamic param5;
  dynamic paramVal5;
  dynamic param6;
  dynamic paramVal6;
  dynamic param7;
  dynamic paramVal7;
  dynamic param8;
  dynamic paramVal8;
  dynamic param9;
  dynamic paramVal9;
  dynamic param10;
  dynamic paramVal10;

  factory SmsSettings.fromJson(Map<String, dynamic> json) => SmsSettings(
        smsService: json["sms_service"],
        nexmoKey: json["nexmo_key"],
        nexmoSecret: json["nexmo_secret"],
        nexmoFrom: json["nexmo_from"],
        twilioSid: json["twilio_sid"],
        twilioToken: json["twilio_token"],
        twilioFrom: json["twilio_from"],
        url: json["url"],
        sendToParamName: json["send_to_param_name"],
        msgParamName: json["msg_param_name"],
        requestMethod: json["request_method"],
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
        "sms_service": smsService,
        "nexmo_key": nexmoKey,
        "nexmo_secret": nexmoSecret,
        "nexmo_from": nexmoFrom,
        "twilio_sid": twilioSid,
        "twilio_token": twilioToken,
        "twilio_from": twilioFrom,
        "url": url,
        "send_to_param_name": sendToParamName,
        "msg_param_name": msgParamName,
        "request_method": requestMethod,
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

  dynamic labelPrefix;
  String? productSkuLength;
  String? qtyLength;
  String? qtyLengthDecimal;

  factory WeighingScaleSetting.fromJson(Map<String, dynamic> json) =>
      WeighingScaleSetting(
        labelPrefix: json["label_prefix"],
        productSkuLength: json["product_sku_length"],
        qtyLength: json["qty_length"],
        qtyLengthDecimal: json["qty_length_decimal"],
      );

  Map<String, dynamic> toJson() => {
        "label_prefix": labelPrefix,
        "product_sku_length": productSkuLength,
        "qty_length": qtyLength,
        "qty_length_decimal": qtyLengthDecimal,
      };
}

class BankDetails {
  BankDetails({
    this.accountHolderName,
    this.accountNumber,
    this.bankName,
    this.bankCode,
    this.branch,
    this.taxPayerId,
  });

  dynamic accountHolderName;
  dynamic accountNumber;
  dynamic bankName;
  dynamic bankCode;
  dynamic branch;
  dynamic taxPayerId;

  factory BankDetails.fromJson(Map<String, dynamic> json) => BankDetails(
        accountHolderName: json["account_holder_name"],
        accountNumber: json["account_number"],
        bankName: json["bank_name"],
        bankCode: json["bank_code"],
        branch: json["branch"],
        taxPayerId: json["tax_payer_id"],
      );

  Map<String, dynamic> toJson() => {
        "account_holder_name": accountHolderName,
        "account_number": accountNumber,
        "bank_name": bankName,
        "bank_code": bankCode,
        "branch": branch,
        "tax_payer_id": taxPayerId,
      };
}

class Media {
  Media({
    this.id,
    this.businessId,
    this.fileName,
    this.description,
    this.uploadedBy,
    this.modelType,
    this.woocommerceMediaId,
    this.modelMediaType,
    this.modelId,
    this.createdAt,
    this.updatedAt,
    this.displayName,
    this.displayUrl,
  });

  int? id;
  int? businessId;
  String? fileName;
  dynamic description;
  int? uploadedBy;
  String? modelType;
  dynamic woocommerceMediaId;
  dynamic modelMediaType;
  int? modelId;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? displayName;
  String? displayUrl;

  factory Media.fromJson(Map<String, dynamic> json) => Media(
        id: json["id"],
        businessId: json["business_id"],
        fileName: json["file_name"],
        description: json["description"],
        uploadedBy: json["uploaded_by"],
        modelType: json["model_type"],
        woocommerceMediaId: json["woocommerce_media_id"],
        modelMediaType: json["model_media_type"],
        modelId: json["model_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        displayName: json["display_name"],
        displayUrl: json["display_url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "business_id": businessId,
        "file_name": fileName,
        "description": description,
        "uploaded_by": uploadedBy,
        "model_type": modelType,
        "woocommerce_media_id": woocommerceMediaId,
        "model_media_type": modelMediaType,
        "model_id": modelId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "display_name": displayName,
        "display_url": displayUrl,
      };
}

class AppSetting {
  int? id;
  String? themeSelection;
  String? lang;
  String? printerId;
  int? autoPrinter;
  int? userId;
  DateTime? createdAt;
  DateTime? updatedAt;

  AppSetting({
    this.id,
    this.themeSelection,
    this.lang,
    this.printerId,
    this.autoPrinter,
    this.userId,
    this.createdAt,
    this.updatedAt,
  });

  factory AppSetting.fromJson(Map<String, dynamic> json) => AppSetting(
        id: json["id"],
        themeSelection: json["theme_selection"],
        lang: json["lang"],
        printerId: json["printer_id"],
        autoPrinter: json["auto_printer"],
        userId: json["user_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "theme_selection": themeSelection,
        "lang": lang,
        "printer_id": printerId,
        "auto_printer": autoPrinter,
        "user_id": userId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
