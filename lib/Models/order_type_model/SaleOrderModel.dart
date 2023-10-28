// To parse this JSON data, do
//
//     final allSellOrderModel = allSellOrderModelFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/Models/order_type_model/payment_line_model.dart';

import '/Config/enums.dart';
import '/Models/AuthModels/loggged_in_user_detail.dart';
import '/Models/ProductsModel/ProductTaxModel.dart';
import '/Models/TableManagementModel/table_management_model.dart';
import '/Models/business_n_register/BusinessModel.dart';
import '/Models/order_type_model/customer_contact_model.dart';
import 'SellLineModel.dart';
import 'order_service_model.dart';
import '/Config/utils.dart';

// import '/Models/order_type_model/payment_line_model.dart';

SaleOrderModel saleOrderModelFromJson(String str) =>
    SaleOrderModel.fromJson(json.decode(str));

String saleOrderModelToJson(SaleOrderModel data) => json.encode(data.toJson());

class SaleOrderModel {
  SaleOrderModel({
    this.saleOrdersData = const [],
    this.links,
    this.meta,
  });

  List<SaleOrderDataModel> saleOrdersData;
  Links? links;
  Meta? meta;

  factory SaleOrderModel.fromJson(Map<String, dynamic> json) => SaleOrderModel(
    saleOrdersData: json["data"] == null
        ? []
        : List<SaleOrderDataModel>.from(
        json["data"].map((x) => saleOrderDataModelFromJson(x))),
    links: json["links"] == null ? null : Links.fromJson(json["links"]),
    meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
  );

  Map<String, dynamic> toJson() => {
    "data": saleOrdersData.isEmpty
        ? null
        : List<dynamic>.from(
        saleOrdersData.map((x) => saleOrderDataModelToJson(x))),
    "links": links == null ? null : links?.toJson(),
    "meta": meta == null ? null : meta?.toJson(),
  };
}

SaleOrderDataModel saleOrderDataModelFromJson(Map<String, dynamic> src) =>
    SaleOrderDataModel.fromJson(src);

Map<String, dynamic> saleOrderDataModelToJson(SaleOrderDataModel data) =>
    data.toJson();

class SaleOrderDataModel {
  SaleOrderDataModel({
    this.id,
    this.businessId,
    this.locationId,
    this.location,
    this.resTableId,
    this.resWaiterId,
    this.resOrderStatus,
    this.resOrderStatusColorValue,
    this.type,
    this.subType,
    this.status,
    this.subStatus,
    this.isQuotation = false,
    this.paymentStatus,
    this.paymentStatusColorValue,
    this.adjustmentType,
    this.contactId,
    this.customerGroupId,
    this.invoiceNo,
    this.refNo,
    this.source,
    this.subscriptionNo,
    this.subscriptionRepeatOn,
    this.transactionDate,
    this.totalBeforeTax,
    this.taxId,
    this.productTaxInfo,
    this.taxAmount,
    this.discountType,
    this.discountAmount,
    this.rpRedeemed,
    this.rpRedeemedAmount,
    this.shippingDetails,
    this.shippingAddress,
    this.deliveryDate,
    this.shippingStatus,
    this.deliveredTo,
    this.shippingCharges,
    this.shippingCustomField1,
    this.shippingCustomField2,
    this.shippingCustomField3,
    this.shippingCustomField4,
    this.shippingCustomField5,
    this.additionalNotes,
    this.staffNote,
    this.isExport = false,
    this.exportCustomFieldsInfo,
    this.roundOffAmount,
    this.additionalExpenseKey1,
    this.additionalExpenseValue1,
    this.additionalExpenseKey2,
    this.additionalExpenseValue2,
    this.additionalExpenseKey3,
    this.additionalExpenseValue3,
    this.additionalExpenseKey4,
    this.additionalExpenseValue4,
    this.finalTotal,
    this.expenseCategoryId,
    this.expenseSubCategoryId,
    this.expenseFor,
    this.commissionAgent,
    this.document,
    this.isDirectSale = false,
    this.isSuspend = false,
    this.exchangeRate,
    this.totalAmountRecovered,
    this.transferParentId,
    this.returnParentId,
    this.openingStockProductId,
    this.createdBy,
    this.purchaseRequisitionIds,
    this.repairCompletedOn,
    this.repairWarrantyId,
    this.repairBrandId,
    this.repairStatusId,
    this.repairModelId,
    this.repairJobSheetId,
    this.repairDefects,
    this.repairSerialNo,
    this.repairChecklist,
    this.repairSecurityPwd,
    this.repairSecurityPattern,
    this.repairDueDate,
    this.repairDeviceId,
    this.repairUpdatesNotif,
    this.mfgParentProductionPurchaseId,
    this.mfgWastedUnits,
    this.mfgProductionCost,
    this.mfgProductionCostType,
    this.mfgIsFinal,
    this.crmIsOrderRequest,
    this.woocommerceOrderId,
    this.essentialsDuration,
    this.essentialsDurationUnit,
    this.essentialsAmountPerUnitDuration,
    this.essentialsAllowances,
    this.essentialsDeductions,
    this.preferPaymentMethod,
    this.preferPaymentAccount,
    this.salesOrderIds,
    this.purchaseOrderIds,
    this.customField1,
    this.customField2,
    this.customField3,
    this.customField4,
    this.importBatch,
    this.importTime,
    this.typesOfServiceId,
    this.packingCharge,
    this.packingChargeType,
    this.serviceCustomField1,
    this.serviceCustomField2,
    this.serviceCustomField3,
    this.serviceCustomField4,
    this.serviceCustomField5,
    this.serviceCustomField6,
    this.isCreatedFromApi = false,
    this.rpEarned,
    this.orderAddresses,
    this.isRecurring = false,
    this.recurInterval,
    this.recurIntervalType,
    this.recurRepetitions,
    this.recurStoppedOn,
    this.recurParentId,
    this.invoiceToken,
    this.payTermNumber,
    this.payTermType,
    this.pjtProjectId,
    this.pjtTitle,
    this.sellingPriceGroupId,
    // this.createdAt,
    // this.updatedAt,
    this.tableData,
    this.serviceStaff,
    this.typesOfService,
    this.salesPerson,
    this.sellLines = const [],
    this.paymentLines = const [],
    this.contact,
    this.invoiceUrl,
    this.paymentLink,
    this.totalPaid,
    this.sellDue,
    this.sellReturnDue,
    this.totalItemTax,
    this.paymentMethod,
    this.isSelected = false,
  });

  int? id;
  int? businessId;
  int? locationId;
  BusinessLocationModel? location;
  int? resTableId;
  int? resWaiterId;
  OrderStatus? resOrderStatus;
  int? resOrderStatusColorValue;
  DatumType? type;
  dynamic subType;
  Status? status;
  dynamic subStatus;
  late bool isQuotation;
  PaymentStatus? paymentStatus;
  int? paymentStatusColorValue;
  dynamic adjustmentType;
  String? contactId;
  int? customerGroupId;
  String? invoiceNo;
  String? refNo;
  dynamic source;
  dynamic subscriptionNo;
  dynamic subscriptionRepeatOn;
  DateTime? transactionDate;
  String? totalBeforeTax;
  int? taxId;
  ProductTaxModel? productTaxInfo;
  String? taxAmount;
  TType? discountType;
  String? discountAmount;
  int? rpRedeemed;
  String? rpRedeemedAmount;
  dynamic shippingDetails;
  dynamic shippingAddress;
  dynamic deliveryDate;
  dynamic shippingStatus;
  dynamic deliveredTo;
  String? shippingCharges;
  dynamic shippingCustomField1;
  dynamic shippingCustomField2;
  dynamic shippingCustomField3;
  dynamic shippingCustomField4;
  dynamic shippingCustomField5;
  dynamic additionalNotes;
  dynamic staffNote;
  late bool isExport;
  dynamic exportCustomFieldsInfo;
  String? roundOffAmount;
  dynamic additionalExpenseKey1;
  String? additionalExpenseValue1;
  dynamic additionalExpenseKey2;
  String? additionalExpenseValue2;
  dynamic additionalExpenseKey3;
  String? additionalExpenseValue3;
  dynamic additionalExpenseKey4;
  String? additionalExpenseValue4;
  String? finalTotal;
  dynamic expenseCategoryId;
  dynamic expenseSubCategoryId;
  dynamic expenseFor;
  dynamic commissionAgent;
  dynamic document;
  late bool isDirectSale;
  late bool isSuspend;
  String? exchangeRate;
  String? totalAmountRecovered;
  dynamic transferParentId;
  dynamic returnParentId;
  dynamic openingStockProductId;
  int? createdBy;
  dynamic purchaseRequisitionIds;
  dynamic repairCompletedOn;
  dynamic repairWarrantyId;
  dynamic repairBrandId;
  dynamic repairStatusId;
  dynamic repairModelId;
  dynamic repairJobSheetId;
  dynamic repairDefects;
  dynamic repairSerialNo;
  dynamic repairChecklist;
  dynamic repairSecurityPwd;
  dynamic repairSecurityPattern;
  dynamic repairDueDate;
  dynamic repairDeviceId;
  int? repairUpdatesNotif;
  dynamic mfgParentProductionPurchaseId;
  dynamic mfgWastedUnits;
  String? mfgProductionCost;
  TType? mfgProductionCostType;
  int? mfgIsFinal;
  int? crmIsOrderRequest;
  dynamic woocommerceOrderId;
  String? essentialsDuration;
  dynamic essentialsDurationUnit;
  String? essentialsAmountPerUnitDuration;
  dynamic essentialsAllowances;
  dynamic essentialsDeductions;
  dynamic preferPaymentMethod;
  dynamic preferPaymentAccount;
  dynamic salesOrderIds;
  dynamic purchaseOrderIds;
  dynamic customField1;
  dynamic customField2;
  dynamic customField3;
  dynamic customField4;
  dynamic importBatch;
  dynamic importTime;
  dynamic typesOfServiceId;
  String? packingCharge;
  dynamic packingChargeType;
  dynamic serviceCustomField1;
  dynamic serviceCustomField2;
  dynamic serviceCustomField3;
  dynamic serviceCustomField4;
  dynamic serviceCustomField5;
  dynamic serviceCustomField6;
  late bool isCreatedFromApi;
  int? rpEarned;
  dynamic orderAddresses;
  late bool isRecurring;
  int? recurInterval;
  RecurIntervalType? recurIntervalType;
  int? recurRepetitions;
  dynamic recurStoppedOn;
  dynamic recurParentId;
  String? invoiceToken;
  dynamic payTermNumber;
  dynamic payTermType;
  dynamic pjtProjectId;
  dynamic pjtTitle;
  int? sellingPriceGroupId;
  // DateTime? createdAt;
  // DateTime? updatedAt;
  TableDataModel? tableData;
  StaffUserModel? serviceStaff;
  OrderServiceDataModel? typesOfService;
  StaffUserModel? salesPerson;
  late List<SellLine> sellLines;
  late List<PaymentLine> paymentLines;
  ContactDataModel? contact;
  String? invoiceUrl;
  String? paymentLink;
  String? totalPaid;
  double? sellDue;
  double? sellReturnDue;
  double? totalItemTax;
  String? paymentMethod;
  late bool isSelected;

  SaleOrderDataModel.fromJson(Map<String, dynamic> json) {
    id = json["id"] == null ? null : json["id"];
    businessId = json["business_id"] == null ? null : json["business_id"];
    locationId = json["location_id"] == null ? null : json["location_id"];
    location = json['location'] == null
        ? null
        : businessLocationModelFromJson(json['location']);
    resTableId = json["res_table_id"] == null ? null : json["res_table_id"];
    resWaiterId = json["res_waiter_id"];
    try {
      resOrderStatus = json["res_order_status"] == null
          ? null
          : orderStatusValues
          .map[json["res_order_status"].toString().capitalize];
    } catch (e) {
      debugPrint('SaleOrderData -> res_order_status -> Error => $e');
    }
    try {
      resOrderStatusColorValue = json["res_order_status"] == null
          ? 0xFFF2F4F4
          : int.tryParse(
          '${orderStatusColors.reverse?[resOrderStatus] ?? 0xFFF2F4F4}');
    } catch (e) {
      debugPrint('SaleOrderData -> resOrderStatusColor -> Error => $e');
    }
    type = json["type"] == null ? null : datumTypeValues.map[json["type"]];
    subType = json["sub_type"];
    status = json["status"] == null ? null : statusValues.map[json["status"]];
    subStatus = json["sub_status"];
    try {
      isQuotation = (int.tryParse('${json["is_quotation"]}') == 1);
    } catch (_e) {
      isQuotation = false;
      debugPrint('isQuotation -> SaleOrderDataModel -> Error => $_e');
    }
    try {
      paymentStatus = json["payment_status"] == null
          ? null
          : paymentStatusValues
          .map[json["payment_status"].toString().capitalize];
    } catch (_e) {
      debugPrint('SaleOrderModel -> paymentStatus -> Error => $_e');
    }

    try {
      if (json["payment_status"] != null)
        paymentStatusColorValue = int.tryParse(
            '${paymentStatusColors.reverse?[paymentStatus] ?? 0xFFF2F4F4}');
    } catch (_e) {
      debugPrint('SaleOrderModel -> paymentStatusColor -> Error => $_e');
    }

    adjustmentType = json["adjustment_type"];
    contactId = json["contact_id"] != null ? '${json["contact_id"]}' : null;
    customerGroupId = json["customer_group_id"];
    invoiceNo = json["invoice_no"];
    refNo = json["ref_no"];
    source = json["source"];
    subscriptionNo = json["subscription_no"];
    subscriptionRepeatOn = json["subscription_repeat_on"];
    try {
      transactionDate = json["transaction_date"] == null
          ? null
          : DateTime.parse(json["transaction_date"]);
    } catch (e) {
      logger.e('SaleOrderModel -> transaction_date -> Error => $e');
    }
    totalBeforeTax = json["total_before_tax"];
    taxId = json["tax_id"];
    try {
      productTaxInfo =
      json['tax'] == null ? null : productTaxModelFromJson(json["tax"]);
    } catch (e) {
      logger.e('SaleOrderModel -> tax -> Error => $e');
    }
    taxAmount = json["tax_amount"];
    discountType = json["discount_type"] == null
        ? null
        : tTypeValues.map[json["discount_type"]];
    discountAmount = json["discount_amount"];
    rpRedeemed = json["rp_redeemed"];
    rpRedeemedAmount = json["rp_redeemed_amount"];
    shippingDetails = json["shipping_details"];
    shippingAddress = json["shipping_address"];
    deliveryDate = json["delivery_date"];
    shippingStatus = json["shipping_status"];
    deliveredTo = json["delivered_to"];
    shippingCharges = json["shipping_charges"];
    shippingCustomField1 = json["shipping_custom_field_1"];
    shippingCustomField2 = json["shipping_custom_field_2"];
    shippingCustomField3 = json["shipping_custom_field_3"];
    shippingCustomField4 = json["shipping_custom_field_4"];
    shippingCustomField5 = json["shipping_custom_field_5"];
    additionalNotes = json["additional_notes"];
    staffNote = json["staff_note"];
    try {
      isExport = (int.tryParse('${json["is_export"]}') == 1);
    } catch (_e) {
      isExport = false;
      logger.e('SaleOrderModel -> isExport -> Error => $_e');
    }
    exportCustomFieldsInfo = json["export_custom_fields_info"];
    try {
      roundOffAmount =
      json["round_off_amount"] == null ? null : json["round_off_amount"];
    } catch (e) {
      logger.e('SaleOrderModel -> round_off_amount -> Error => $e');
    }
    additionalExpenseKey1 = json["additional_expense_key_1"];
    try {
      additionalExpenseValue1 = json["additional_expense_value_1"] == null
          ? null
          : json["additional_expense_value_1"];
    } catch (e) {
      logger.e('SaleOrderModel -> additional_expense_value_1 -> Error => $e');
    }
    additionalExpenseKey2 = json["additional_expense_key_2"];
    try {
      additionalExpenseValue2 = json["additional_expense_value_2"] == null
          ? null
          : json["additional_expense_value_2"];
    } catch (e) {
      logger.e('SaleOrderModel -> additional_expense_value_2 -> Error => $e');
    }
    additionalExpenseKey3 = json["additional_expense_key_3"];
    try {
      additionalExpenseValue3 = json["additional_expense_value_3"] == null
          ? null
          : json["additional_expense_value_3"];
    } catch (e) {
      logger.e('SaleOrderModel -> additional_expense_value_3 -> Error => $e');
    }
    additionalExpenseKey4 = json["additional_expense_key_4"];
    try {
      additionalExpenseValue4 = json["additional_expense_value_4"] == null
          ? null
          : json["additional_expense_value_4"];
    } catch (e) {
      logger.e('SaleOrderModel -> additional_expense_value_4 -> Error => $e');
    }
    finalTotal = json["final_total"] == null ? null : json["final_total"];
    expenseCategoryId = json["expense_category_id"];
    expenseSubCategoryId = json["expense_sub_category_id"];
    expenseFor = json["expense_for"];
    commissionAgent = json["commission_agent"];
    document = json["document"];
    try {
      isDirectSale = (int.tryParse('${json["is_direct_sale"]}') == 1);
    } catch (_e) {
      isDirectSale = false;
      debugPrint('SaleOrderDataModel -> isDirectSale -> Error => $_e');
    }
    try {
      isSuspend = (int.tryParse('${json["is_suspend"]}') == 1);
    } catch (_e) {
      isSuspend = false;
      debugPrint('isSuspend -> SaleOrderDataModel -> Error => $_e');
    }
    exchangeRate = json["exchange_rate"] == null ? null : json["exchange_rate"];
    totalAmountRecovered = json["total_amount_recovered"];
    transferParentId = json["transfer_parent_id"];
    returnParentId = json["return_parent_id"];
    openingStockProductId = json["opening_stock_product_id"];
    createdBy = json["created_by"] == null ? null : json["created_by"];
    purchaseRequisitionIds = json["purchase_requisition_ids"];
    repairCompletedOn = json["repair_completed_on"];
    repairWarrantyId = json["repair_warranty_id"];
    repairBrandId = json["repair_brand_id"];
    repairStatusId = json["repair_status_id"];
    repairModelId = json["repair_model_id"];
    repairJobSheetId = json["repair_job_sheet_id"];
    repairDefects = json["repair_defects"];
    repairSerialNo = json["repair_serial_no"];
    repairChecklist = json["repair_checklist"];
    repairSecurityPwd = json["repair_security_pwd"];
    repairSecurityPattern = json["repair_security_pattern"];
    repairDueDate = json["repair_due_date"];
    repairDeviceId = json["repair_device_id"];
    repairUpdatesNotif = json["repair_updates_notif"] == null
        ? null
        : json["repair_updates_notif"];
    mfgParentProductionPurchaseId = json["mfg_parent_production_purchase_id"];
    mfgWastedUnits = json["mfg_wasted_units"];
    mfgProductionCost = json["mfg_production_cost"] == null
        ? null
        : json["mfg_production_cost"];
    mfgProductionCostType = json["mfg_production_cost_type"] == null
        ? null
        : tTypeValues.map[json["mfg_production_cost_type"]];
    mfgIsFinal = json["mfg_is_final"] == null ? null : json["mfg_is_final"];
    crmIsOrderRequest = json["crm_is_order_request"] == null
        ? null
        : json["crm_is_order_request"];
    woocommerceOrderId = json["woocommerce_order_id"];
    essentialsDuration = json["essentials_duration"] == null
        ? null
        : json["essentials_duration"];
    essentialsDurationUnit = json["essentials_duration_unit"];
    essentialsAmountPerUnitDuration =
    json["essentials_amount_per_unit_duration"] == null
        ? null
        : json["essentials_amount_per_unit_duration"];
    essentialsAllowances = json["essentials_allowances"];
    essentialsDeductions = json["essentials_deductions"];
    preferPaymentMethod = json["prefer_payment_method"];
    preferPaymentAccount = json["prefer_payment_account"];
    salesOrderIds = json["sales_order_ids"];
    purchaseOrderIds = json["purchase_order_ids"];
    customField1 = json["custom_field_1"];
    customField2 = json["custom_field_2"];
    customField3 = json["custom_field_3"];
    customField4 = json["custom_field_4"];
    importBatch = json["import_batch"];
    importTime = json["import_time"];
    typesOfServiceId = json["types_of_service_id"];
    packingCharge =
    json["packing_charge"] == null ? null : json["packing_charge"];
    packingChargeType = json["packing_charge_type"];
    serviceCustomField1 = json["service_custom_field_1"];
    serviceCustomField2 = json["service_custom_field_2"];
    serviceCustomField3 = json["service_custom_field_3"];
    serviceCustomField4 = json["service_custom_field_4"];
    serviceCustomField5 = json["service_custom_field_5"];
    serviceCustomField6 = json["service_custom_field_6"];
    try {
      isCreatedFromApi = (int.tryParse('${json["is_created_from_api"]}') == 1);
    } catch (_e) {
      isCreatedFromApi = false;
      debugPrint('isCreatedFromApi -> SaleOrderDataModel -> Error => $_e');
    }
    rpEarned = json["rp_earned"] == null ? null : json["rp_earned"];
    orderAddresses = json["order_addresses"];
    try {
      isRecurring = (int.tryParse('${json["is_recurring"]}') == 1);
    } catch (_e) {
      isRecurring = false;
      debugPrint('isRecurring -> SaleOrderDataModel -> Error => $_e');
    }
    recurInterval =
    json["recur_interval"] == null ? null : json["recur_interval"];
    try {
      recurIntervalType = json["recur_interval_type"] == null
          ? null
          : recurIntervalTypeValues.map[json["recur_interval_type"]];
    } catch (e) {
      logger.e('SaleOrderDataModel -> recur_interval_type -> Error => $e');
    }
    recurRepetitions =
    json["recur_repetitions"] == null ? null : json["recur_repetitions"];
    recurStoppedOn = json["recur_stopped_on"];
    recurParentId = json["recur_parent_id"];
    invoiceToken = json["invoice_token"] == null ? null : json["invoice_token"];
    payTermNumber = json["pay_term_number"];
    payTermType = json["pay_term_type"];
    pjtProjectId = json["pjt_project_id"];
    pjtTitle = json["pjt_title"];
    sellingPriceGroupId = json["selling_price_group_id"] == null
        ? null
        : json["selling_price_group_id"];
    // createdAt =
    //     json["created_at"] == null ? null : DateTime.parse(json["created_at"]);
    // updatedAt =
    //     json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]);
    try {
      tableData =
      json["table"] == null ? null : tableDataModelFromJson(json["table"]);
    } catch (e) {
      logger.e('SaleOrderDataModel -> table -> Error => $e');
    }

    try {
      serviceStaff = json["service_staff"] == null
          ? null
          : staffUserModelFromJson(json["service_staff"]);
    } catch (e) {
      logger.e('SaleOrderDataModel -> service_staff -> Error => $e');
    }

    try {
      typesOfService = json["types_of_service"] == null
          ? null
          : orderServiceDataModelFromJson(json["types_of_service"]);
    } catch (e) {
      logger.e('SaleOrderDataModel -> types_of_service -> Error => $e');
    }

    try {
      salesPerson = json["sales_person"] == null
          ? null
          : staffUserModelFromJson(json["sales_person"]);
    } catch (e) {
      logger.e('SaleOrderDataModel -> sales_person -> Error => $e');
    }

    try {
      sellLines = json["sell_lines"] == null
          ? []
          : List<SellLine>.from(
          json["sell_lines"].map((x) => SellLine.fromJson(x)));
    } catch (e) {
      logger.e('SaleOrderDataModel -> sell_lines -> Error => $e');
    }

    try {
      paymentLines = json["payment_lines"] == null
          ? []
          : List<PaymentLine>.from(
          json["payment_lines"].map((x) => PaymentLine.fromJson(x)));
    } catch (e) {
      logger.e('SaleOrderDataModel -> payment_lines -> Error => $e');
    }

    try {
      contact = json['contact'] == null
          ? null
          : contactDataModelFromJson(json['contact']);
    } catch (e) {
      logger.e('SaleOrderDataModel -> contact -> Error => $e');
    }

    invoiceUrl = json["invoice_url"] == null ? null : json["invoice_url"];
    paymentLink = json["payment_link"] == null ? null : json["payment_link"];
    totalPaid = json["total_paid"] == null ? null : json["total_paid"];
    try {
      sellDue = json["sell_due"] == null
          ? null
          : double.tryParse('${json["sell_due"]}');
    } catch (e) {
      logger.e('SaleOrderDataModel -> sell_due -> Error => $e');
    }

    try {
      sellReturnDue = json["sell_return_due"] == null
          ? null
          : double.tryParse('${json["sell_return_due"]}');
    } catch (e) {
      logger.e('SaleOrderDataModel -> sell_return_due -> Error => $e');
    }

    try {
      totalItemTax = json["total_item_tax"] == null
          ? null
          : double.tryParse('${json["total_item_tax"]}');
    } catch (e) {
      logger.e('SaleOrderDataModel -> total_item_tax -> Error => $e');
    }

    paymentMethod =
    json["payment_method"] == null ? null : json["payment_method"];
    isSelected = false;
  }

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "business_id": businessId == null ? null : businessId,
    "location_id": locationId == null ? null : locationId,
    "locationd":
    location == null ? null : businessLocationModelToJson(location!),
    "res_table_id": resTableId == null ? null : resTableId,
    "res_waiter_id": resWaiterId,
    "res_order_status": resOrderStatus == null
        ? null
        : orderStatusValues.reverse?[resOrderStatus],
    "type": type == null ? null : datumTypeValues.reverse?[type],
    "sub_type": subType,
    "status": status == null ? null : statusValues.reverse?[status],
    "sub_status": subStatus,
    "is_quotation": isQuotation,
    "payment_status": paymentStatus == null
        ? null
        : paymentStatusValues.reverse?[paymentStatus],
    "adjustment_type": adjustmentType,
    "contact_id": contactId == null ? null : contactId,
    "customer_group_id": customerGroupId,
    "invoice_no": invoiceNo == null ? null : invoiceNo,
    "ref_no": refNo == null ? null : refNo,
    "source": source,
    "subscription_no": subscriptionNo,
    "subscription_repeat_on": subscriptionRepeatOn,
    "transaction_date":
    transactionDate == null ? null : transactionDate?.toIso8601String(),
    "total_before_tax": totalBeforeTax == null ? null : totalBeforeTax,
    "tax_id": taxId == null ? null : taxId,
    "tax_amount": taxAmount == null ? null : taxAmount,
    "discount_type":
    discountType == null ? null : tTypeValues.reverse?[discountType],
    "discount_amount": discountAmount == null ? null : discountAmount,
    "rp_redeemed": rpRedeemed == null ? null : rpRedeemed,
    "rp_redeemed_amount":
    rpRedeemedAmount == null ? null : rpRedeemedAmount,
    "shipping_details": shippingDetails,
    "shipping_address": shippingAddress,
    "delivery_date": deliveryDate,
    "shipping_status": shippingStatus,
    "delivered_to": deliveredTo,
    "shipping_charges": shippingCharges == null ? null : shippingCharges,
    "shipping_custom_field_1": shippingCustomField1,
    "shipping_custom_field_2": shippingCustomField2,
    "shipping_custom_field_3": shippingCustomField3,
    "shipping_custom_field_4": shippingCustomField4,
    "shipping_custom_field_5": shippingCustomField5,
    "additional_notes": additionalNotes,
    "staff_note": staffNote,
    "is_export": isExport,
    "export_custom_fields_info": exportCustomFieldsInfo,
    "round_off_amount": roundOffAmount == null ? null : roundOffAmount,
    "additional_expense_key_1": additionalExpenseKey1,
    "additional_expense_value_1":
    additionalExpenseValue1 == null ? null : additionalExpenseValue1,
    "additional_expense_key_2": additionalExpenseKey2,
    "additional_expense_value_2":
    additionalExpenseValue2 == null ? null : additionalExpenseValue2,
    "additional_expense_key_3": additionalExpenseKey3,
    "additional_expense_value_3":
    additionalExpenseValue3 == null ? null : additionalExpenseValue3,
    "additional_expense_key_4": additionalExpenseKey4,
    "additional_expense_value_4":
    additionalExpenseValue4 == null ? null : additionalExpenseValue4,
    "final_total": finalTotal == null ? null : finalTotal,
    "expense_category_id": expenseCategoryId,
    "expense_sub_category_id": expenseSubCategoryId,
    "expense_for": expenseFor,
    "commission_agent": commissionAgent,
    "document": document,
    "is_direct_sale": isDirectSale,
    "is_suspend": isSuspend,
    "exchange_rate": exchangeRate == null ? null : exchangeRate,
    "total_amount_recovered": totalAmountRecovered,
    "transfer_parent_id": transferParentId,
    "return_parent_id": returnParentId,
    "opening_stock_product_id": openingStockProductId,
    "created_by": createdBy == null ? null : createdBy,
    "purchase_requisition_ids": purchaseRequisitionIds,
    "repair_completed_on": repairCompletedOn,
    "repair_warranty_id": repairWarrantyId,
    "repair_brand_id": repairBrandId,
    "repair_status_id": repairStatusId,
    "repair_model_id": repairModelId,
    "repair_job_sheet_id": repairJobSheetId,
    "repair_defects": repairDefects,
    "repair_serial_no": repairSerialNo,
    "repair_checklist": repairChecklist,
    "repair_security_pwd": repairSecurityPwd,
    "repair_security_pattern": repairSecurityPattern,
    "repair_due_date": repairDueDate,
    "repair_device_id": repairDeviceId,
    "repair_updates_notif":
    repairUpdatesNotif == null ? null : repairUpdatesNotif,
    "mfg_parent_production_purchase_id": mfgParentProductionPurchaseId,
    "mfg_wasted_units": mfgWastedUnits,
    "mfg_production_cost":
    mfgProductionCost == null ? null : mfgProductionCost,
    "mfg_production_cost_type": mfgProductionCostType == null
        ? null
        : tTypeValues.reverse?[mfgProductionCostType],
    "mfg_is_final": mfgIsFinal == null ? null : mfgIsFinal,
    "crm_is_order_request":
    crmIsOrderRequest == null ? null : crmIsOrderRequest,
    "woocommerce_order_id": woocommerceOrderId,
    "essentials_duration":
    essentialsDuration == null ? null : essentialsDuration,
    "essentials_duration_unit": essentialsDurationUnit,
    "essentials_amount_per_unit_duration":
    essentialsAmountPerUnitDuration == null
        ? null
        : essentialsAmountPerUnitDuration,
    "essentials_allowances": essentialsAllowances,
    "essentials_deductions": essentialsDeductions,
    "prefer_payment_method": preferPaymentMethod,
    "prefer_payment_account": preferPaymentAccount,
    "sales_order_ids": salesOrderIds,
    "purchase_order_ids": purchaseOrderIds,
    "custom_field_1": customField1,
    "custom_field_2": customField2,
    "custom_field_3": customField3,
    "custom_field_4": customField4,
    "import_batch": importBatch,
    "import_time": importTime,
    "types_of_service_id": typesOfServiceId,
    "packing_charge": packingCharge == null ? null : packingCharge,
    "packing_charge_type": packingChargeType,
    "service_custom_field_1": serviceCustomField1,
    "service_custom_field_2": serviceCustomField2,
    "service_custom_field_3": serviceCustomField3,
    "service_custom_field_4": serviceCustomField4,
    "service_custom_field_5": serviceCustomField5,
    "service_custom_field_6": serviceCustomField6,
    "is_created_from_api": isCreatedFromApi,
    "rp_earned": rpEarned == null ? null : rpEarned,
    "order_addresses": orderAddresses,
    "is_recurring": isRecurring,
    "recur_interval": recurInterval == null ? null : recurInterval,
    "recur_interval_type": recurIntervalType == null
        ? null
        : recurIntervalTypeValues.reverse?[recurIntervalType],
    "recur_repetitions": recurRepetitions == null ? null : recurRepetitions,
    "recur_stopped_on": recurStoppedOn,
    "recur_parent_id": recurParentId,
    "invoice_token": invoiceToken == null ? null : invoiceToken,
    "pay_term_number": payTermNumber,
    "pay_term_type": payTermType,
    "pjt_project_id": pjtProjectId,
    "pjt_title": pjtTitle,
    "selling_price_group_id":
    sellingPriceGroupId == null ? null : sellingPriceGroupId,
    // "created_at": createdAt == null ? null : createdAt?.toIso8601String(),
    // "updated_at": updatedAt == null ? null : updatedAt?.toIso8601String(),
    "table": tableData == null ? null : tableDataModelToJson(tableData!),
    "service_staff":
    serviceStaff == null ? null : staffUserModelToJson(serviceStaff!),
    "types_of_service": typesOfService == null
        ? null
        : orderServiceDataModelToJson(typesOfService!),
    "sales_person":
    salesPerson == null ? null : staffUserModelToJson(salesPerson!),
    "sell_lines": sellLines.isEmpty
        ? null
        : List<dynamic>.from(sellLines.map((x) => x.toJson())),
    "payment_lines":
    List<dynamic>.from(paymentLines.map((x) => x.toJson())),
    "contact": contact == null ? null : contactDataModelToJson(contact!),
    "invoice_url": invoiceUrl == null ? null : invoiceUrl,
    "payment_link": paymentLink == null ? null : paymentLink,
    "total_paid": totalPaid == null ? null : totalPaid,
    "sell_due": sellDue == null ? null : sellDue,
    "sell_return_due": sellReturnDue == null ? null : sellReturnDue,
    "total_item_tax": totalItemTax == null ? null : totalItemTax,
    "payment_method": paymentMethod == null ? null : paymentMethod,
  };
}

// SaleOrderDataModel saleOrderDataModelFromJson(Map<String, dynamic> src) =>
//     SaleOrderDataModel.fromJson(src);
//
// Map<String, dynamic> saleOrderDataModelToJson(SaleOrderDataModel data) =>
//     data.toJson();
//
// class SaleOrderDataModel {
//   SaleOrderDataModel({
//     this.id,
//     this.businessId,
//     this.locationId,
//     this.location,
//     this.resTableId,
//     this.resWaiterId,
//     this.resOrderStatus,
//     this.resOrderStatusColorValue,
//     this.type,
//     this.subType,
//     this.status,
//     this.subStatus,
//     this.isQuotation = false,
//     this.paymentStatus,
//     this.paymentStatusColorValue,
//     this.adjustmentType,
//     this.contactId,
//     this.customerGroupId,
//     this.invoiceNo,
//     this.refNo,
//     this.source,
//     this.subscriptionNo,
//     this.subscriptionRepeatOn,
//     this.transactionDate,
//     this.totalBeforeTax,
//     this.taxId,
//     this.productTaxInfo,
//     this.taxAmount,
//     this.discountType,
//     this.discountAmount,
//     this.rpRedeemed,
//     this.rpRedeemedAmount,
//     this.shippingDetails,
//     this.shippingAddress,
//     this.deliveryDate,
//     this.shippingStatus,
//     this.deliveredTo,
//     this.shippingCharges,
//     this.shippingCustomField1,
//     this.shippingCustomField2,
//     this.shippingCustomField3,
//     this.shippingCustomField4,
//     this.shippingCustomField5,
//     this.additionalNotes,
//     this.staffNote,
//     this.isExport = false,
//     this.exportCustomFieldsInfo,
//     this.roundOffAmount,
//     this.additionalExpenseKey1,
//     this.additionalExpenseValue1,
//     this.additionalExpenseKey2,
//     this.additionalExpenseValue2,
//     this.additionalExpenseKey3,
//     this.additionalExpenseValue3,
//     this.additionalExpenseKey4,
//     this.additionalExpenseValue4,
//     this.finalTotal,
//     this.expenseCategoryId,
//     this.expenseSubCategoryId,
//     this.expenseFor,
//     this.commissionAgent,
//     this.document,
//     this.isDirectSale = false,
//     this.isSuspend = false,
//     this.exchangeRate,
//     this.totalAmountRecovered,
//     this.transferParentId,
//     this.returnParentId,
//     this.openingStockProductId,
//     this.createdBy,
//     this.purchaseRequisitionIds,
//     this.repairCompletedOn,
//     this.repairWarrantyId,
//     this.repairBrandId,
//     this.repairStatusId,
//     this.repairModelId,
//     this.repairJobSheetId,
//     this.repairDefects,
//     this.repairSerialNo,
//     this.repairChecklist,
//     this.repairSecurityPwd,
//     this.repairSecurityPattern,
//     this.repairDueDate,
//     this.repairDeviceId,
//     this.repairUpdatesNotif,
//     this.mfgParentProductionPurchaseId,
//     this.mfgWastedUnits,
//     this.mfgProductionCost,
//     this.mfgProductionCostType,
//     this.mfgIsFinal,
//     this.crmIsOrderRequest,
//     this.woocommerceOrderId,
//     this.essentialsDuration,
//     this.essentialsDurationUnit,
//     this.essentialsAmountPerUnitDuration,
//     this.essentialsAllowances,
//     this.essentialsDeductions,
//     this.preferPaymentMethod,
//     this.preferPaymentAccount,
//     this.salesOrderIds,
//     this.purchaseOrderIds,
//     this.customField1,
//     this.customField2,
//     this.customField3,
//     this.customField4,
//     this.importBatch,
//     this.importTime,
//     this.typesOfServiceId,
//     this.packingCharge,
//     this.packingChargeType,
//     this.serviceCustomField1,
//     this.serviceCustomField2,
//     this.serviceCustomField3,
//     this.serviceCustomField4,
//     this.serviceCustomField5,
//     this.serviceCustomField6,
//     this.isCreatedFromApi = false,
//     this.rpEarned,
//     this.orderAddresses,
//     this.isRecurring = false,
//     this.recurInterval,
//     this.recurIntervalType,
//     this.recurRepetitions,
//     this.recurStoppedOn,
//     this.recurParentId,
//     this.invoiceToken,
//     this.payTermNumber,
//     this.payTermType,
//     this.pjtProjectId,
//     this.pjtTitle,
//     this.sellingPriceGroupId,
//     // this.createdAt,
//     // this.updatedAt,
//     this.tableData,
//     this.serviceStaff,
//     this.typesOfService,
//     this.salesPerson,
//     this.sellLines = const [],
//     // this.paymentLines = const [],
//     this.contact,
//     this.invoiceUrl,
//     this.paymentLink,
//     this.totalPaid,
//     this.sellDue,
//     this.sellReturnDue,
//     this.totalItemTax,
//     this.paymentMethod,
//     this.isSelected = false,
//   });
//
//   int? id;
//   int? businessId;
//   int? locationId;
//   BusinessLocationModel? location;
//   int? resTableId;
//   int? resWaiterId;
//   OrderStatus? resOrderStatus;
//   int? resOrderStatusColorValue;
//   DatumType? type;
//   dynamic subType;
//   Status? status;
//   dynamic subStatus;
//   late bool isQuotation;
//   PaymentStatus? paymentStatus;
//   int? paymentStatusColorValue;
//   dynamic adjustmentType;
//   String? contactId;
//   int? customerGroupId;
//   String? invoiceNo;
//   String? refNo;
//   dynamic source;
//   dynamic subscriptionNo;
//   dynamic subscriptionRepeatOn;
//   DateTime? transactionDate;
//   String? totalBeforeTax;
//   int? taxId;
//   ProductTaxModel? productTaxInfo;
//   String? taxAmount;
//   TType? discountType;
//   String? discountAmount;
//   int? rpRedeemed;
//   String? rpRedeemedAmount;
//   dynamic shippingDetails;
//   dynamic shippingAddress;
//   dynamic deliveryDate;
//   dynamic shippingStatus;
//   dynamic deliveredTo;
//   String? shippingCharges;
//   dynamic shippingCustomField1;
//   dynamic shippingCustomField2;
//   dynamic shippingCustomField3;
//   dynamic shippingCustomField4;
//   dynamic shippingCustomField5;
//   dynamic additionalNotes;
//   dynamic staffNote;
//   late bool isExport;
//   dynamic exportCustomFieldsInfo;
//   String? roundOffAmount;
//   dynamic additionalExpenseKey1;
//   String? additionalExpenseValue1;
//   dynamic additionalExpenseKey2;
//   String? additionalExpenseValue2;
//   dynamic additionalExpenseKey3;
//   String? additionalExpenseValue3;
//   dynamic additionalExpenseKey4;
//   String? additionalExpenseValue4;
//   String? finalTotal;
//   dynamic expenseCategoryId;
//   dynamic expenseSubCategoryId;
//   dynamic expenseFor;
//   dynamic commissionAgent;
//   dynamic document;
//   late bool isDirectSale;
//   late bool isSuspend;
//   String? exchangeRate;
//   String? totalAmountRecovered;
//   dynamic transferParentId;
//   dynamic returnParentId;
//   dynamic openingStockProductId;
//   int? createdBy;
//   dynamic purchaseRequisitionIds;
//   dynamic repairCompletedOn;
//   dynamic repairWarrantyId;
//   dynamic repairBrandId;
//   dynamic repairStatusId;
//   dynamic repairModelId;
//   dynamic repairJobSheetId;
//   dynamic repairDefects;
//   dynamic repairSerialNo;
//   dynamic repairChecklist;
//   dynamic repairSecurityPwd;
//   dynamic repairSecurityPattern;
//   dynamic repairDueDate;
//   dynamic repairDeviceId;
//   int? repairUpdatesNotif;
//   dynamic mfgParentProductionPurchaseId;
//   dynamic mfgWastedUnits;
//   String? mfgProductionCost;
//   TType? mfgProductionCostType;
//   int? mfgIsFinal;
//   int? crmIsOrderRequest;
//   dynamic woocommerceOrderId;
//   String? essentialsDuration;
//   dynamic essentialsDurationUnit;
//   String? essentialsAmountPerUnitDuration;
//   dynamic essentialsAllowances;
//   dynamic essentialsDeductions;
//   dynamic preferPaymentMethod;
//   dynamic preferPaymentAccount;
//   dynamic salesOrderIds;
//   dynamic purchaseOrderIds;
//   dynamic customField1;
//   dynamic customField2;
//   dynamic customField3;
//   dynamic customField4;
//   dynamic importBatch;
//   dynamic importTime;
//   dynamic typesOfServiceId;
//   String? packingCharge;
//   dynamic packingChargeType;
//   dynamic serviceCustomField1;
//   dynamic serviceCustomField2;
//   dynamic serviceCustomField3;
//   dynamic serviceCustomField4;
//   dynamic serviceCustomField5;
//   dynamic serviceCustomField6;
//   late bool isCreatedFromApi;
//   int? rpEarned;
//   dynamic orderAddresses;
//   late bool isRecurring;
//   int? recurInterval;
//   RecurIntervalType? recurIntervalType;
//   int? recurRepetitions;
//   dynamic recurStoppedOn;
//   dynamic recurParentId;
//   String? invoiceToken;
//   dynamic payTermNumber;
//   dynamic payTermType;
//   dynamic pjtProjectId;
//   dynamic pjtTitle;
//   int? sellingPriceGroupId;
//   // DateTime? createdAt;
//   // DateTime? updatedAt;
//   TableDataModel? tableData;
//   StaffUserModel? serviceStaff;
//   OrderServiceDataModel? typesOfService;
//   StaffUserModel? salesPerson;
//   late List<SellLine> sellLines;
//   //late List<PaymentLine> paymentLines;
//   ContactDataModel? contact;
//   String? invoiceUrl;
//   String? paymentLink;
//   String? totalPaid;
//   double? sellDue;
//   double? sellReturnDue;
//   double? totalItemTax;
//   String? paymentMethod;
//   late bool isSelected;
//
//   SaleOrderDataModel.fromJson(Map<String, dynamic> json) {
//     id = json["id"] == null ? null : json["id"];
//     businessId = json["business_id"] == null ? null : json["business_id"];
//     locationId = json["location_id"] == null ? null : json["location_id"];
//     location = json['location'] == null
//         ? null
//         : businessLocationModelFromJson(json['location']);
//     resTableId = json["res_table_id"] == null ? null : json["res_table_id"];
//     resWaiterId = json["res_waiter_id"];
//     try {
//       resOrderStatus = json["res_order_status"] == null
//           ? null
//           : orderStatusValues
//               .map[json["res_order_status"].toString().capitalize];
//     } catch (e) {
//       debugPrint('SaleOrderData -> res_order_status -> Error => $e');
//     }
//     try {
//       resOrderStatusColorValue = json["res_order_status"] == null
//           ? 0xFFF2F4F4
//           : int.tryParse(
//               '${orderStatusColors.reverse?[resOrderStatus] ?? 0xFFF2F4F4}');
//     } catch (e) {
//       debugPrint('SaleOrderData -> resOrderStatusColor -> Error => $e');
//     }
//     type = json["type"] == null ? null : datumTypeValues.map[json["type"]];
//     subType = json["sub_type"];
//     status = json["status"] == null ? null : statusValues.map[json["status"]];
//     subStatus = json["sub_status"];
//     try {
//       isQuotation = (int.tryParse('${json["is_quotation"]}') == 1);
//     } catch (_e) {
//       isQuotation = false;
//       debugPrint('isQuotation -> SaleOrderDataModel -> Error => $_e');
//     }
//     try {
//       paymentStatus = json["payment_status"] == null
//           ? null
//           : paymentStatusValues
//               .map[json["payment_status"].toString().capitalize];
//     } catch (_e) {
//       debugPrint('SaleOrderModel -> paymentStatus -> Error => $_e');
//     }
//
//     try {
//       if (json["payment_status"] != null)
//         paymentStatusColorValue = int.tryParse(
//             '${paymentStatusColors.reverse?[paymentStatus] ?? 0xFFF2F4F4}');
//     } catch (_e) {
//       debugPrint('SaleOrderModel -> paymentStatusColor -> Error => $_e');
//     }
//
//     adjustmentType = json["adjustment_type"];
//     contactId = json["contact_id"] != null ? '${json["contact_id"]}' : null;
//     customerGroupId = json["customer_group_id"];
//     invoiceNo = json["invoice_no"];
//     refNo = json["ref_no"];
//     source = json["source"];
//     subscriptionNo = json["subscription_no"];
//     subscriptionRepeatOn = json["subscription_repeat_on"];
//     try {
//       transactionDate = json["transaction_date"] == null
//           ? null
//           : DateTime.parse(json["transaction_date"]);
//     } catch (e) {
//       logger.e('SaleOrderModel -> transaction_date -> Error => $e');
//     }
//     totalBeforeTax = json["total_before_tax"];
//     taxId = json["tax_id"];
//     try {
//       productTaxInfo =
//           json['tax'] == null ? null : productTaxModelFromJson(json["tax"]);
//     } catch (e) {
//       logger.e('SaleOrderModel -> tax -> Error => $e');
//     }
//     taxAmount = json["tax_amount"];
//     discountType = json["discount_type"] == null
//         ? null
//         : tTypeValues.map[json["discount_type"]];
//     discountAmount = json["discount_amount"];
//     rpRedeemed = json["rp_redeemed"];
//     rpRedeemedAmount = json["rp_redeemed_amount"];
//     shippingDetails = json["shipping_details"];
//     shippingAddress = json["shipping_address"];
//     deliveryDate = json["delivery_date"];
//     shippingStatus = json["shipping_status"];
//     deliveredTo = json["delivered_to"];
//     shippingCharges = json["shipping_charges"];
//     shippingCustomField1 = json["shipping_custom_field_1"];
//     shippingCustomField2 = json["shipping_custom_field_2"];
//     shippingCustomField3 = json["shipping_custom_field_3"];
//     shippingCustomField4 = json["shipping_custom_field_4"];
//     shippingCustomField5 = json["shipping_custom_field_5"];
//     additionalNotes = json["additional_notes"];
//     staffNote = json["staff_note"];
//     try {
//       isExport = (int.tryParse('${json["is_export"]}') == 1);
//     } catch (_e) {
//       isExport = false;
//       logger.e('SaleOrderModel -> isExport -> Error => $_e');
//     }
//     exportCustomFieldsInfo = json["export_custom_fields_info"];
//     try {
//       roundOffAmount =
//           json["round_off_amount"] == null ? null : json["round_off_amount"];
//     } catch (e) {
//       logger.e('SaleOrderModel -> round_off_amount -> Error => $e');
//     }
//     additionalExpenseKey1 = json["additional_expense_key_1"];
//     try {
//       additionalExpenseValue1 = json["additional_expense_value_1"] == null
//           ? null
//           : json["additional_expense_value_1"];
//     } catch (e) {
//       logger.e('SaleOrderModel -> additional_expense_value_1 -> Error => $e');
//     }
//     additionalExpenseKey2 = json["additional_expense_key_2"];
//     try {
//       additionalExpenseValue2 = json["additional_expense_value_2"] == null
//           ? null
//           : json["additional_expense_value_2"];
//     } catch (e) {
//       logger.e('SaleOrderModel -> additional_expense_value_2 -> Error => $e');
//     }
//     additionalExpenseKey3 = json["additional_expense_key_3"];
//     try {
//       additionalExpenseValue3 = json["additional_expense_value_3"] == null
//           ? null
//           : json["additional_expense_value_3"];
//     } catch (e) {
//       logger.e('SaleOrderModel -> additional_expense_value_3 -> Error => $e');
//     }
//     additionalExpenseKey4 = json["additional_expense_key_4"];
//     try {
//       additionalExpenseValue4 = json["additional_expense_value_4"] == null
//           ? null
//           : json["additional_expense_value_4"];
//     } catch (e) {
//       logger.e('SaleOrderModel -> additional_expense_value_4 -> Error => $e');
//     }
//     finalTotal = json["final_total"] == null ? null : json["final_total"];
//     expenseCategoryId = json["expense_category_id"];
//     expenseSubCategoryId = json["expense_sub_category_id"];
//     expenseFor = json["expense_for"];
//     commissionAgent = json["commission_agent"];
//     document = json["document"];
//     try {
//       isDirectSale = (int.tryParse('${json["is_direct_sale"]}') == 1);
//     } catch (_e) {
//       isDirectSale = false;
//       debugPrint('SaleOrderDataModel -> isDirectSale -> Error => $_e');
//     }
//     try {
//       isSuspend = (int.tryParse('${json["is_suspend"]}') == 1);
//     } catch (_e) {
//       isSuspend = false;
//       debugPrint('isSuspend -> SaleOrderDataModel -> Error => $_e');
//     }
//     exchangeRate = json["exchange_rate"] == null ? null : json["exchange_rate"];
//     totalAmountRecovered = json["total_amount_recovered"];
//     transferParentId = json["transfer_parent_id"];
//     returnParentId = json["return_parent_id"];
//     openingStockProductId = json["opening_stock_product_id"];
//     createdBy = json["created_by"] == null ? null : json["created_by"];
//     purchaseRequisitionIds = json["purchase_requisition_ids"];
//     repairCompletedOn = json["repair_completed_on"];
//     repairWarrantyId = json["repair_warranty_id"];
//     repairBrandId = json["repair_brand_id"];
//     repairStatusId = json["repair_status_id"];
//     repairModelId = json["repair_model_id"];
//     repairJobSheetId = json["repair_job_sheet_id"];
//     repairDefects = json["repair_defects"];
//     repairSerialNo = json["repair_serial_no"];
//     repairChecklist = json["repair_checklist"];
//     repairSecurityPwd = json["repair_security_pwd"];
//     repairSecurityPattern = json["repair_security_pattern"];
//     repairDueDate = json["repair_due_date"];
//     repairDeviceId = json["repair_device_id"];
//     repairUpdatesNotif = json["repair_updates_notif"] == null
//         ? null
//         : json["repair_updates_notif"];
//     mfgParentProductionPurchaseId = json["mfg_parent_production_purchase_id"];
//     mfgWastedUnits = json["mfg_wasted_units"];
//     mfgProductionCost = json["mfg_production_cost"] == null
//         ? null
//         : json["mfg_production_cost"];
//     mfgProductionCostType = json["mfg_production_cost_type"] == null
//         ? null
//         : tTypeValues.map[json["mfg_production_cost_type"]];
//     mfgIsFinal = json["mfg_is_final"] == null ? null : json["mfg_is_final"];
//     crmIsOrderRequest = json["crm_is_order_request"] == null
//         ? null
//         : json["crm_is_order_request"];
//     woocommerceOrderId = json["woocommerce_order_id"];
//     essentialsDuration = json["essentials_duration"] == null
//         ? null
//         : json["essentials_duration"];
//     essentialsDurationUnit = json["essentials_duration_unit"];
//     essentialsAmountPerUnitDuration =
//         json["essentials_amount_per_unit_duration"] == null
//             ? null
//             : json["essentials_amount_per_unit_duration"];
//     essentialsAllowances = json["essentials_allowances"];
//     essentialsDeductions = json["essentials_deductions"];
//     preferPaymentMethod = json["prefer_payment_method"];
//     preferPaymentAccount = json["prefer_payment_account"];
//     salesOrderIds = json["sales_order_ids"];
//     purchaseOrderIds = json["purchase_order_ids"];
//     customField1 = json["custom_field_1"];
//     customField2 = json["custom_field_2"];
//     customField3 = json["custom_field_3"];
//     customField4 = json["custom_field_4"];
//     importBatch = json["import_batch"];
//     importTime = json["import_time"];
//     typesOfServiceId = json["types_of_service_id"];
//     packingCharge =
//         json["packing_charge"] == null ? null : json["packing_charge"];
//     packingChargeType = json["packing_charge_type"];
//     serviceCustomField1 = json["service_custom_field_1"];
//     serviceCustomField2 = json["service_custom_field_2"];
//     serviceCustomField3 = json["service_custom_field_3"];
//     serviceCustomField4 = json["service_custom_field_4"];
//     serviceCustomField5 = json["service_custom_field_5"];
//     serviceCustomField6 = json["service_custom_field_6"];
//     try {
//       isCreatedFromApi = (int.tryParse('${json["is_created_from_api"]}') == 1);
//     } catch (_e) {
//       isCreatedFromApi = false;
//       debugPrint('isCreatedFromApi -> SaleOrderDataModel -> Error => $_e');
//     }
//     rpEarned = json["rp_earned"] == null ? null : json["rp_earned"];
//     orderAddresses = json["order_addresses"];
//     try {
//       isRecurring = (int.tryParse('${json["is_recurring"]}') == 1);
//     } catch (_e) {
//       isRecurring = false;
//       debugPrint('isRecurring -> SaleOrderDataModel -> Error => $_e');
//     }
//     recurInterval =
//         json["recur_interval"] == null ? null : json["recur_interval"];
//     try {
//       recurIntervalType = json["recur_interval_type"] == null
//           ? null
//           : recurIntervalTypeValues.map[json["recur_interval_type"]];
//     } catch (e) {
//       logger.e('SaleOrderDataModel -> recur_interval_type -> Error => $e');
//     }
//     recurRepetitions =
//         json["recur_repetitions"] == null ? null : json["recur_repetitions"];
//     recurStoppedOn = json["recur_stopped_on"];
//     recurParentId = json["recur_parent_id"];
//     invoiceToken = json["invoice_token"] == null ? null : json["invoice_token"];
//     payTermNumber = json["pay_term_number"];
//     payTermType = json["pay_term_type"];
//     pjtProjectId = json["pjt_project_id"];
//     pjtTitle = json["pjt_title"];
//     sellingPriceGroupId = json["selling_price_group_id"] == null
//         ? null
//         : json["selling_price_group_id"];
//     // createdAt =
//     //     json["created_at"] == null ? null : DateTime.parse(json["created_at"]);
//     // updatedAt =
//     //     json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]);
//     try {
//       tableData =
//           json["table"] == null ? null : tableDataModelFromJson(json["table"]);
//     } catch (e) {
//       logger.e('SaleOrderDataModel -> table -> Error => $e');
//     }
//
//     try {
//       serviceStaff = json["service_staff"] == null
//           ? null
//           : staffUserModelFromJson(json["service_staff"]);
//     } catch (e) {
//       logger.e('SaleOrderDataModel -> service_staff -> Error => $e');
//     }
//
//     try {
//       typesOfService = json["types_of_service"] == null
//           ? null
//           : orderServiceDataModelFromJson(json["types_of_service"]);
//     } catch (e) {
//       logger.e('SaleOrderDataModel -> types_of_service -> Error => $e');
//     }
//
//     try {
//       salesPerson = json["sales_person"] == null
//           ? null
//           : staffUserModelFromJson(json["sales_person"]);
//     } catch (e) {
//       logger.e('SaleOrderDataModel -> sales_person -> Error => $e');
//     }
//
//     try {
//       sellLines = json["sell_lines"] == null
//           ? []
//           : List<SellLine>.from(
//               json["sell_lines"].map((x) => SellLine.fromJson(x)));
//     } catch (e) {
//       logger.e('SaleOrderDataModel -> sell_lines -> Error => $e');
//     }
//
//     // try {
//     //   paymentLines = json["payment_lines"] == null
//     //       ? []
//     //       : List<PaymentLine>.from(
//     //       json["payment_lines"].map((x) => PaymentLine.fromJson(x)));
//     // } catch (e) {
//     //   logger.e('SaleOrderDataModel -> payment_lines -> Error => $e');
//     // }
//
//     try {
//       contact = json['contact'] == null
//           ? null
//           : contactDataModelFromJson(json['contact']);
//     } catch (e) {
//       logger.e('SaleOrderDataModel -> contact -> Error => $e');
//     }
//
//     invoiceUrl = json["invoice_url"] == null ? null : json["invoice_url"];
//     paymentLink = json["payment_link"] == null ? null : json["payment_link"];
//     totalPaid = json["total_paid"] == null ? null : json["total_paid"];
//     try {
//       sellDue = json["sell_due"] == null
//           ? null
//           : double.tryParse('${json["sell_due"]}');
//     } catch (e) {
//       logger.e('SaleOrderDataModel -> sell_due -> Error => $e');
//     }
//
//     try {
//       sellReturnDue = json["sell_return_due"] == null
//           ? null
//           : double.tryParse('${json["sell_return_due"]}');
//     } catch (e) {
//       logger.e('SaleOrderDataModel -> sell_return_due -> Error => $e');
//     }
//
//     try {
//       totalItemTax = json["total_item_tax"] == null
//           ? null
//           : double.tryParse('${json["total_item_tax"]}');
//     } catch (e) {
//       logger.e('SaleOrderDataModel -> total_item_tax -> Error => $e');
//     }
//
//     paymentMethod =
//         json["payment_method"] == null ? null : json["payment_method"];
//     isSelected = false;
//   }
//
//   Map<String, dynamic> toJson() => {
//         "id": id == null ? null : id,
//         "business_id": businessId == null ? null : businessId,
//         "location_id": locationId == null ? null : locationId,
//         "locationd":
//             location == null ? null : businessLocationModelToJson(location!),
//         "res_table_id": resTableId == null ? null : resTableId,
//         "res_waiter_id": resWaiterId,
//         "res_order_status": resOrderStatus == null
//             ? null
//             : orderStatusValues.reverse?[resOrderStatus],
//         "type": type == null ? null : datumTypeValues.reverse?[type],
//         "sub_type": subType,
//         "status": status == null ? null : statusValues.reverse?[status],
//         "sub_status": subStatus,
//         "is_quotation": isQuotation,
//         "payment_status": paymentStatus == null
//             ? null
//             : paymentStatusValues.reverse?[paymentStatus],
//         "adjustment_type": adjustmentType,
//         "contact_id": contactId == null ? null : contactId,
//         "customer_group_id": customerGroupId,
//         "invoice_no": invoiceNo == null ? null : invoiceNo,
//         "ref_no": refNo == null ? null : refNo,
//         "source": source,
//         "subscription_no": subscriptionNo,
//         "subscription_repeat_on": subscriptionRepeatOn,
//         "transaction_date":
//             transactionDate == null ? null : transactionDate?.toIso8601String(),
//         "total_before_tax": totalBeforeTax == null ? null : totalBeforeTax,
//         "tax_id": taxId == null ? null : taxId,
//         "tax_amount": taxAmount == null ? null : taxAmount,
//         "discount_type":
//             discountType == null ? null : tTypeValues.reverse?[discountType],
//         "discount_amount": discountAmount == null ? null : discountAmount,
//         "rp_redeemed": rpRedeemed == null ? null : rpRedeemed,
//         "rp_redeemed_amount":
//             rpRedeemedAmount == null ? null : rpRedeemedAmount,
//         "shipping_details": shippingDetails,
//         "shipping_address": shippingAddress,
//         "delivery_date": deliveryDate,
//         "shipping_status": shippingStatus,
//         "delivered_to": deliveredTo,
//         "shipping_charges": shippingCharges == null ? null : shippingCharges,
//         "shipping_custom_field_1": shippingCustomField1,
//         "shipping_custom_field_2": shippingCustomField2,
//         "shipping_custom_field_3": shippingCustomField3,
//         "shipping_custom_field_4": shippingCustomField4,
//         "shipping_custom_field_5": shippingCustomField5,
//         "additional_notes": additionalNotes,
//         "staff_note": staffNote,
//         "is_export": isExport,
//         "export_custom_fields_info": exportCustomFieldsInfo,
//         "round_off_amount": roundOffAmount == null ? null : roundOffAmount,
//         "additional_expense_key_1": additionalExpenseKey1,
//         "additional_expense_value_1":
//             additionalExpenseValue1 == null ? null : additionalExpenseValue1,
//         "additional_expense_key_2": additionalExpenseKey2,
//         "additional_expense_value_2":
//             additionalExpenseValue2 == null ? null : additionalExpenseValue2,
//         "additional_expense_key_3": additionalExpenseKey3,
//         "additional_expense_value_3":
//             additionalExpenseValue3 == null ? null : additionalExpenseValue3,
//         "additional_expense_key_4": additionalExpenseKey4,
//         "additional_expense_value_4":
//             additionalExpenseValue4 == null ? null : additionalExpenseValue4,
//         "final_total": finalTotal == null ? null : finalTotal,
//         "expense_category_id": expenseCategoryId,
//         "expense_sub_category_id": expenseSubCategoryId,
//         "expense_for": expenseFor,
//         "commission_agent": commissionAgent,
//         "document": document,
//         "is_direct_sale": isDirectSale,
//         "is_suspend": isSuspend,
//         "exchange_rate": exchangeRate == null ? null : exchangeRate,
//         "total_amount_recovered": totalAmountRecovered,
//         "transfer_parent_id": transferParentId,
//         "return_parent_id": returnParentId,
//         "opening_stock_product_id": openingStockProductId,
//         "created_by": createdBy == null ? null : createdBy,
//         "purchase_requisition_ids": purchaseRequisitionIds,
//         "repair_completed_on": repairCompletedOn,
//         "repair_warranty_id": repairWarrantyId,
//         "repair_brand_id": repairBrandId,
//         "repair_status_id": repairStatusId,
//         "repair_model_id": repairModelId,
//         "repair_job_sheet_id": repairJobSheetId,
//         "repair_defects": repairDefects,
//         "repair_serial_no": repairSerialNo,
//         "repair_checklist": repairChecklist,
//         "repair_security_pwd": repairSecurityPwd,
//         "repair_security_pattern": repairSecurityPattern,
//         "repair_due_date": repairDueDate,
//         "repair_device_id": repairDeviceId,
//         "repair_updates_notif":
//             repairUpdatesNotif == null ? null : repairUpdatesNotif,
//         "mfg_parent_production_purchase_id": mfgParentProductionPurchaseId,
//         "mfg_wasted_units": mfgWastedUnits,
//         "mfg_production_cost":
//             mfgProductionCost == null ? null : mfgProductionCost,
//         "mfg_production_cost_type": mfgProductionCostType == null
//             ? null
//             : tTypeValues.reverse?[mfgProductionCostType],
//         "mfg_is_final": mfgIsFinal == null ? null : mfgIsFinal,
//         "crm_is_order_request":
//             crmIsOrderRequest == null ? null : crmIsOrderRequest,
//         "woocommerce_order_id": woocommerceOrderId,
//         "essentials_duration":
//             essentialsDuration == null ? null : essentialsDuration,
//         "essentials_duration_unit": essentialsDurationUnit,
//         "essentials_amount_per_unit_duration":
//             essentialsAmountPerUnitDuration == null
//                 ? null
//                 : essentialsAmountPerUnitDuration,
//         "essentials_allowances": essentialsAllowances,
//         "essentials_deductions": essentialsDeductions,
//         "prefer_payment_method": preferPaymentMethod,
//         "prefer_payment_account": preferPaymentAccount,
//         "sales_order_ids": salesOrderIds,
//         "purchase_order_ids": purchaseOrderIds,
//         "custom_field_1": customField1,
//         "custom_field_2": customField2,
//         "custom_field_3": customField3,
//         "custom_field_4": customField4,
//         "import_batch": importBatch,
//         "import_time": importTime,
//         "types_of_service_id": typesOfServiceId,
//         "packing_charge": packingCharge == null ? null : packingCharge,
//         "packing_charge_type": packingChargeType,
//         "service_custom_field_1": serviceCustomField1,
//         "service_custom_field_2": serviceCustomField2,
//         "service_custom_field_3": serviceCustomField3,
//         "service_custom_field_4": serviceCustomField4,
//         "service_custom_field_5": serviceCustomField5,
//         "service_custom_field_6": serviceCustomField6,
//         "is_created_from_api": isCreatedFromApi,
//         "rp_earned": rpEarned == null ? null : rpEarned,
//         "order_addresses": orderAddresses,
//         "is_recurring": isRecurring,
//         "recur_interval": recurInterval == null ? null : recurInterval,
//         "recur_interval_type": recurIntervalType == null
//             ? null
//             : recurIntervalTypeValues.reverse?[recurIntervalType],
//         "recur_repetitions": recurRepetitions == null ? null : recurRepetitions,
//         "recur_stopped_on": recurStoppedOn,
//         "recur_parent_id": recurParentId,
//         "invoice_token": invoiceToken == null ? null : invoiceToken,
//         "pay_term_number": payTermNumber,
//         "pay_term_type": payTermType,
//         "pjt_project_id": pjtProjectId,
//         "pjt_title": pjtTitle,
//         "selling_price_group_id":
//             sellingPriceGroupId == null ? null : sellingPriceGroupId,
//         // "created_at": createdAt == null ? null : createdAt?.toIso8601String(),
//         // "updated_at": updatedAt == null ? null : updatedAt?.toIso8601String(),
//         "table": tableData == null ? null : tableDataModelToJson(tableData!),
//         "service_staff":
//             serviceStaff == null ? null : staffUserModelToJson(serviceStaff!),
//         "types_of_service": typesOfService == null
//             ? null
//             : orderServiceDataModelToJson(typesOfService!),
//         "sales_person":
//             salesPerson == null ? null : staffUserModelToJson(salesPerson!),
//         "sell_lines": sellLines.isEmpty
//             ? null
//             : List<dynamic>.from(sellLines.map((x) => x.toJson())),
//         // "payment_lines":
//         // List<dynamic>.from(paymentLines.map((x) => x.toJson())),
//         "contact": contact == null ? null : contactDataModelToJson(contact!),
//         "invoice_url": invoiceUrl == null ? null : invoiceUrl,
//         "payment_link": paymentLink == null ? null : paymentLink,
//         "total_paid": totalPaid == null ? null : totalPaid,
//         "sell_due": sellDue == null ? null : sellDue,
//         "sell_return_due": sellReturnDue == null ? null : sellReturnDue,
//         "total_item_tax": totalItemTax == null ? null : totalItemTax,
//         "payment_method": paymentMethod == null ? null : paymentMethod,
//       };
// }
