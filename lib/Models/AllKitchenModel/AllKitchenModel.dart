// To parse this JSON data, do
//
//     final allKitchenModel = allKitchenModelFromJson(jsonString);

import 'dart:convert';

AllKitchenModel allKitchenModelFromJson(String str) =>
    AllKitchenModel.fromJson(json.decode(str));

String allKitchenModelToJson(AllKitchenModel data) =>
    json.encode(data.toJson());

class AllKitchenModel {
  List<Order>? orders;
  List<Kitchen>? kitchens;

  AllKitchenModel({
    this.orders,
    this.kitchens,
  });

  factory AllKitchenModel.fromJson(Map<String, dynamic> json) =>
      AllKitchenModel(
        orders: json["orders"] == null
            ? []
            : List<Order>.from(json["orders"]!.map((x) => Order.fromJson(x))),
        kitchens: json["kitchens"] == null
            ? []
            : List<Kitchen>.from(
            json["kitchens"]!.map((x) => Kitchen.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
    "orders": orders == null
        ? []
        : List<dynamic>.from(orders!.map((x) => x.toJson())),
    "kitchens": kitchens == null
        ? []
        : List<dynamic>.from(kitchens!.map((x) => x.toJson())),
  };
}

class Kitchen {
  int? id;
  int? businessId;
  int? locationId;
  String? name;
  String? description;
  DateTime? createdAt;
  DateTime? updatedAt;

  Kitchen({
    this.id,
    this.businessId,
    this.locationId,
    this.name,
    this.description,
    this.createdAt,
    this.updatedAt,
  });

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

class Order {
  int? id;
  int? businessId;
  int? locationId;
  int? resTableId;
  int? resWaiterId;
  dynamic resOrderStatus;
  OrderType? type;
  dynamic subType;
  Status? status;
  dynamic subStatus;
  int? isQuotation;
  PaymentStatus? paymentStatus;
  dynamic adjustmentType;
  int? contactId;
  dynamic customerGroupId;
  String? invoiceNo;
  String? refNo;
  dynamic source;
  dynamic subscriptionNo;
  dynamic subscriptionRepeatOn;
  DateTime? transactionDate;
  String? totalBeforeTax;
  int? taxId;
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
  String? additionalNotes;
  dynamic staffNote;
  int? isExport;
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
  int? isDirectSale;
  int? isSuspend;
  String? exchangeRate;
  dynamic totalAmountRecovered;
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
  int? typesOfServiceId;
  String? packingCharge;
  Type? packingChargeType;
  dynamic serviceCustomField1;
  dynamic serviceCustomField2;
  dynamic serviceCustomField3;
  dynamic serviceCustomField4;
  dynamic serviceCustomField5;
  dynamic serviceCustomField6;
  int? isCreatedFromApi;
  int? rpEarned;
  dynamic orderAddresses;
  int? isRecurring;
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
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic kitchenId;
  dynamic remarks;
  CustomerName? customerName;
  BusinessLocation? businessLocation;
  String? tableName;
  TypesOfService? typesOfService;
  List<SellLine>? sellLines;

  Order({
    this.id,
    this.businessId,
    this.locationId,
    this.resTableId,
    this.resWaiterId,
    this.resOrderStatus,
    this.type,
    this.subType,
    this.status,
    this.subStatus,
    this.isQuotation,
    this.paymentStatus,
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
    this.isExport,
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
    this.isDirectSale,
    this.isSuspend,
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
    this.isCreatedFromApi,
    this.rpEarned,
    this.orderAddresses,
    this.isRecurring,
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
    this.createdAt,
    this.updatedAt,
    this.kitchenId,
    this.remarks,
    this.customerName,
    this.businessLocation,
    this.tableName,
    this.typesOfService,
    this.sellLines,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
    id: json["id"],
    businessId: json["business_id"],
    locationId: json["location_id"],
    resTableId: json["res_table_id"],
    resWaiterId: json["res_waiter_id"],
    resOrderStatus: json["res_order_status"],
    type: orderTypeValues.map[json["type"]],
    subType: json["sub_type"],
    status: statusValues.map[json["status"]],
    subStatus: json["sub_status"],
    isQuotation: json["is_quotation"],
    paymentStatus: paymentStatusValues.map[json["payment_status"]],
    adjustmentType: json["adjustment_type"],
    contactId: json["contact_id"],
    customerGroupId: json["customer_group_id"],
    invoiceNo: json["invoice_no"],
    refNo: json["ref_no"],
    source: json["source"],
    subscriptionNo: json["subscription_no"],
    subscriptionRepeatOn: json["subscription_repeat_on"],
    transactionDate: json["transaction_date"] == null
        ? null
        : DateTime.parse(json["transaction_date"]),
    totalBeforeTax: json["total_before_tax"],
    taxId: json["tax_id"],
    taxAmount: json["tax_amount"],
    discountType: tTypeValues.map[json["discount_type"]],
    discountAmount: json["discount_amount"],
    rpRedeemed: json["rp_redeemed"],
    rpRedeemedAmount: json["rp_redeemed_amount"],
    shippingDetails: json["shipping_details"],
    shippingAddress: json["shipping_address"],
    deliveryDate: json["delivery_date"],
    shippingStatus: json["shipping_status"],
    deliveredTo: json["delivered_to"],
    shippingCharges: json["shipping_charges"],
    shippingCustomField1: json["shipping_custom_field_1"],
    shippingCustomField2: json["shipping_custom_field_2"],
    shippingCustomField3: json["shipping_custom_field_3"],
    shippingCustomField4: json["shipping_custom_field_4"],
    shippingCustomField5: json["shipping_custom_field_5"],
    additionalNotes: json["additional_notes"],
    staffNote: json["staff_note"],
    isExport: json["is_export"],
    exportCustomFieldsInfo: json["export_custom_fields_info"],
    roundOffAmount: json["round_off_amount"],
    additionalExpenseKey1: json["additional_expense_key_1"],
    additionalExpenseValue1: json["additional_expense_value_1"],
    additionalExpenseKey2: json["additional_expense_key_2"],
    additionalExpenseValue2: json["additional_expense_value_2"],
    additionalExpenseKey3: json["additional_expense_key_3"],
    additionalExpenseValue3: json["additional_expense_value_3"],
    additionalExpenseKey4: json["additional_expense_key_4"],
    additionalExpenseValue4: json["additional_expense_value_4"],
    finalTotal: json["final_total"],
    expenseCategoryId: json["expense_category_id"],
    expenseSubCategoryId: json["expense_sub_category_id"],
    expenseFor: json["expense_for"],
    commissionAgent: json["commission_agent"],
    document: json["document"],
    isDirectSale: json["is_direct_sale"],
    isSuspend: json["is_suspend"],
    exchangeRate: json["exchange_rate"],
    totalAmountRecovered: json["total_amount_recovered"],
    transferParentId: json["transfer_parent_id"],
    returnParentId: json["return_parent_id"],
    openingStockProductId: json["opening_stock_product_id"],
    createdBy: json["created_by"],
    purchaseRequisitionIds: json["purchase_requisition_ids"],
    repairCompletedOn: json["repair_completed_on"],
    repairWarrantyId: json["repair_warranty_id"],
    repairBrandId: json["repair_brand_id"],
    repairStatusId: json["repair_status_id"],
    repairModelId: json["repair_model_id"],
    repairJobSheetId: json["repair_job_sheet_id"],
    repairDefects: json["repair_defects"],
    repairSerialNo: json["repair_serial_no"],
    repairChecklist: json["repair_checklist"],
    repairSecurityPwd: json["repair_security_pwd"],
    repairSecurityPattern: json["repair_security_pattern"],
    repairDueDate: json["repair_due_date"],
    repairDeviceId: json["repair_device_id"],
    repairUpdatesNotif: json["repair_updates_notif"],
    mfgParentProductionPurchaseId:
    json["mfg_parent_production_purchase_id"],
    mfgWastedUnits: json["mfg_wasted_units"],
    mfgProductionCost: json["mfg_production_cost"],
    mfgProductionCostType:
    tTypeValues.map[json["mfg_production_cost_type"]],
    mfgIsFinal: json["mfg_is_final"],
    crmIsOrderRequest: json["crm_is_order_request"],
    woocommerceOrderId: json["woocommerce_order_id"],
    essentialsDuration: json["essentials_duration"],
    essentialsDurationUnit: json["essentials_duration_unit"],
    essentialsAmountPerUnitDuration:
    json["essentials_amount_per_unit_duration"],
    essentialsAllowances: json["essentials_allowances"],
    essentialsDeductions: json["essentials_deductions"],
    preferPaymentMethod: json["prefer_payment_method"],
    preferPaymentAccount: json["prefer_payment_account"],
    salesOrderIds: json["sales_order_ids"],
    purchaseOrderIds: json["purchase_order_ids"],
    customField1: json["custom_field_1"],
    customField2: json["custom_field_2"],
    customField3: json["custom_field_3"],
    customField4: json["custom_field_4"],
    importBatch: json["import_batch"],
    importTime: json["import_time"],
    typesOfServiceId: json["types_of_service_id"],
    packingCharge: json["packing_charge"],
    packingChargeType: typeValues.map[json["packing_charge_type"]],
    serviceCustomField1: json["service_custom_field_1"],
    serviceCustomField2: json["service_custom_field_2"],
    serviceCustomField3: json["service_custom_field_3"],
    serviceCustomField4: json["service_custom_field_4"],
    serviceCustomField5: json["service_custom_field_5"],
    serviceCustomField6: json["service_custom_field_6"],
    isCreatedFromApi: json["is_created_from_api"],
    rpEarned: json["rp_earned"],
    orderAddresses: json["order_addresses"],
    isRecurring: json["is_recurring"],
    recurInterval: json["recur_interval"],
    recurIntervalType:
    recurIntervalTypeValues.map[json["recur_interval_type"]],
    recurRepetitions: json["recur_repetitions"],
    recurStoppedOn: json["recur_stopped_on"],
    recurParentId: json["recur_parent_id"],
    invoiceToken: json["invoice_token"],
    payTermNumber: json["pay_term_number"],
    payTermType: json["pay_term_type"],
    pjtProjectId: json["pjt_project_id"],
    pjtTitle: json["pjt_title"],
    sellingPriceGroupId: json["selling_price_group_id"],
    createdAt: json["created_at"] == null
        ? null
        : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null
        ? null
        : DateTime.parse(json["updated_at"]),
    kitchenId: json["kitchen_id"],
    remarks: json["remarks"],
    customerName: customerNameValues.map[json["customer_name"]],
    businessLocation: businessLocationValues.map[json["business_location"]],
    tableName: json["table_name"],
    typesOfService: json["types_of_service"] == null
        ? null
        : TypesOfService.fromJson(json["types_of_service"]),
    sellLines: json["sell_lines"] == null
        ? []
        : List<SellLine>.from(
        json["sell_lines"]!.map((x) => SellLine.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "business_id": businessId,
    "location_id": locationId,
    "res_table_id": resTableId,
    "res_waiter_id": resWaiterId,
    "res_order_status": resOrderStatus,
    "type": orderTypeValues.reverse[type],
    "sub_type": subType,
    "status": statusValues.reverse[status],
    "sub_status": subStatus,
    "is_quotation": isQuotation,
    "payment_status": paymentStatusValues.reverse[paymentStatus],
    "adjustment_type": adjustmentType,
    "contact_id": contactId,
    "customer_group_id": customerGroupId,
    "invoice_no": invoiceNo,
    "ref_no": refNo,
    "source": source,
    "subscription_no": subscriptionNo,
    "subscription_repeat_on": subscriptionRepeatOn,
    "transaction_date": transactionDate?.toIso8601String(),
    "total_before_tax": totalBeforeTax,
    "tax_id": taxId,
    "tax_amount": taxAmount,
    "discount_type": tTypeValues.reverse[discountType],
    "discount_amount": discountAmount,
    "rp_redeemed": rpRedeemed,
    "rp_redeemed_amount": rpRedeemedAmount,
    "shipping_details": shippingDetails,
    "shipping_address": shippingAddress,
    "delivery_date": deliveryDate,
    "shipping_status": shippingStatus,
    "delivered_to": deliveredTo,
    "shipping_charges": shippingCharges,
    "shipping_custom_field_1": shippingCustomField1,
    "shipping_custom_field_2": shippingCustomField2,
    "shipping_custom_field_3": shippingCustomField3,
    "shipping_custom_field_4": shippingCustomField4,
    "shipping_custom_field_5": shippingCustomField5,
    "additional_notes": additionalNotes,
    "staff_note": staffNote,
    "is_export": isExport,
    "export_custom_fields_info": exportCustomFieldsInfo,
    "round_off_amount": roundOffAmount,
    "additional_expense_key_1": additionalExpenseKey1,
    "additional_expense_value_1": additionalExpenseValue1,
    "additional_expense_key_2": additionalExpenseKey2,
    "additional_expense_value_2": additionalExpenseValue2,
    "additional_expense_key_3": additionalExpenseKey3,
    "additional_expense_value_3": additionalExpenseValue3,
    "additional_expense_key_4": additionalExpenseKey4,
    "additional_expense_value_4": additionalExpenseValue4,
    "final_total": finalTotal,
    "expense_category_id": expenseCategoryId,
    "expense_sub_category_id": expenseSubCategoryId,
    "expense_for": expenseFor,
    "commission_agent": commissionAgent,
    "document": document,
    "is_direct_sale": isDirectSale,
    "is_suspend": isSuspend,
    "exchange_rate": exchangeRate,
    "total_amount_recovered": totalAmountRecovered,
    "transfer_parent_id": transferParentId,
    "return_parent_id": returnParentId,
    "opening_stock_product_id": openingStockProductId,
    "created_by": createdBy,
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
    "repair_updates_notif": repairUpdatesNotif,
    "mfg_parent_production_purchase_id": mfgParentProductionPurchaseId,
    "mfg_wasted_units": mfgWastedUnits,
    "mfg_production_cost": mfgProductionCost,
    "mfg_production_cost_type": tTypeValues.reverse[mfgProductionCostType],
    "mfg_is_final": mfgIsFinal,
    "crm_is_order_request": crmIsOrderRequest,
    "woocommerce_order_id": woocommerceOrderId,
    "essentials_duration": essentialsDuration,
    "essentials_duration_unit": essentialsDurationUnit,
    "essentials_amount_per_unit_duration": essentialsAmountPerUnitDuration,
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
    "packing_charge": packingCharge,
    "packing_charge_type": typeValues.reverse[packingChargeType],
    "service_custom_field_1": serviceCustomField1,
    "service_custom_field_2": serviceCustomField2,
    "service_custom_field_3": serviceCustomField3,
    "service_custom_field_4": serviceCustomField4,
    "service_custom_field_5": serviceCustomField5,
    "service_custom_field_6": serviceCustomField6,
    "is_created_from_api": isCreatedFromApi,
    "rp_earned": rpEarned,
    "order_addresses": orderAddresses,
    "is_recurring": isRecurring,
    "recur_interval": recurInterval,
    "recur_interval_type":
    recurIntervalTypeValues.reverse[recurIntervalType],
    "recur_repetitions": recurRepetitions,
    "recur_stopped_on": recurStoppedOn,
    "recur_parent_id": recurParentId,
    "invoice_token": invoiceToken,
    "pay_term_number": payTermNumber,
    "pay_term_type": payTermType,
    "pjt_project_id": pjtProjectId,
    "pjt_title": pjtTitle,
    "selling_price_group_id": sellingPriceGroupId,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "kitchen_id": kitchenId,
    "remarks": remarks,
    "customer_name": customerNameValues.reverse[customerName],
    "business_location": businessLocationValues.reverse[businessLocation],
    "table_name": tableName,
    "types_of_service": typesOfService?.toJson(),
    "sell_lines": sellLines == null
        ? []
        : List<dynamic>.from(sellLines!.map((x) => x.toJson())),
  };
}

enum BusinessLocation { RESTAURANT }

final businessLocationValues =
EnumValues({"Restaurant": BusinessLocation.RESTAURANT});

enum CustomerName { WALK_IN, WALK_IN_CUSTOMER }

final customerNameValues = EnumValues({
  "Walk-In": CustomerName.WALK_IN,
  "Walk-In Customer": CustomerName.WALK_IN_CUSTOMER
});

enum TType { PERCENTAGE }

final tTypeValues = EnumValues({"percentage": TType.PERCENTAGE});

enum Type { FIXED, EMPTY }

final typeValues = EnumValues({"": Type.EMPTY, "fixed": Type.FIXED});

enum PaymentStatus { DUE, PAID }

final paymentStatusValues =
EnumValues({"due": PaymentStatus.DUE, "paid": PaymentStatus.PAID});

enum RecurIntervalType { DAYS }

final recurIntervalTypeValues = EnumValues({"days": RecurIntervalType.DAYS});

class SellLine {
  int? id;
  int? transactionId;
  int? productId;
  int? variationId;
  int? quantity;
  String? secondaryUnitQuantity;
  String? mfgWastePercent;
  dynamic mfgIngredientGroupId;
  String? quantityReturned;
  String? unitPriceBeforeDiscount;
  String? unitPrice;
  Type? lineDiscountType;
  String? lineDiscountAmount;
  String? unitPriceIncTax;
  String? itemTax;
  int? taxId;
  dynamic discountId;
  dynamic lotNoLineId;
  String? sellLineNote;
  dynamic woocommerceLineItemsId;
  dynamic soLineId;
  String? soQuantityInvoiced;
  dynamic resServiceStaffId;
  ResLineOrderStatus? resLineOrderStatus;
  int? parentSellLineId;
  ChildrenType? childrenType;
  int? subUnitId;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? modifierInput;
  int? kitchenId;
  String? remarks;
  List<Modifiersfilter>? modifiersfilter;
  ProductKitchen? product;

  SellLine({
    this.id,
    this.transactionId,
    this.productId,
    this.variationId,
    this.quantity,
    this.secondaryUnitQuantity,
    this.mfgWastePercent,
    this.mfgIngredientGroupId,
    this.quantityReturned,
    this.unitPriceBeforeDiscount,
    this.unitPrice,
    this.lineDiscountType,
    this.lineDiscountAmount,
    this.unitPriceIncTax,
    this.itemTax,
    this.taxId,
    this.discountId,
    this.lotNoLineId,
    this.sellLineNote,
    this.woocommerceLineItemsId,
    this.soLineId,
    this.soQuantityInvoiced,
    this.resServiceStaffId,
    this.resLineOrderStatus,
    this.parentSellLineId,
    this.childrenType,
    this.subUnitId,
    this.createdAt,
    this.updatedAt,
    this.modifierInput,
    this.kitchenId,
    this.remarks,
    this.modifiersfilter,
    this.product,
  });

  factory SellLine.fromJson(Map<String, dynamic> json) => SellLine(
    id: json["id"],
    transactionId: json["transaction_id"],
    productId: json["product_id"],
    variationId: json["variation_id"],
    quantity: json["quantity"],
    secondaryUnitQuantity: json["secondary_unit_quantity"],
    mfgWastePercent: json["mfg_waste_percent"],
    mfgIngredientGroupId: json["mfg_ingredient_group_id"],
    quantityReturned: json["quantity_returned"],
    unitPriceBeforeDiscount: json["unit_price_before_discount"],
    unitPrice: json["unit_price"],
    lineDiscountType: typeValues.map[json["line_discount_type"]],
    lineDiscountAmount: json["line_discount_amount"],
    unitPriceIncTax: json["unit_price_inc_tax"],
    itemTax: json["item_tax"],
    taxId: json["tax_id"],
    discountId: json["discount_id"],
    lotNoLineId: json["lot_no_line_id"],
    sellLineNote: json["sell_line_note"],
    woocommerceLineItemsId: json["woocommerce_line_items_id"],
    soLineId: json["so_line_id"],
    soQuantityInvoiced: json["so_quantity_invoiced"],
    resServiceStaffId: json["res_service_staff_id"],
    resLineOrderStatus:
    resLineOrderStatusValues.map[json["res_line_order_status"]],
    parentSellLineId: json["parent_sell_line_id"],
    childrenType: childrenTypeValues.map[json["children_type"]],
    subUnitId: json["sub_unit_id"],
    createdAt: json["created_at"] == null
        ? null
        : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null
        ? null
        : DateTime.parse(json["updated_at"]),
    modifierInput: json["modifier_input"],
    kitchenId: json["kitchen_id"],
    remarks: json["remarks"],
    modifiersfilter: json["modifiersfilter"] == null
        ? []
        : List<Modifiersfilter>.from(json["modifiersfilter"]
        .map((x) => Modifiersfilter.fromJson(x))),
    product: json["product"] == null
        ? null
        : ProductKitchen.fromJson(json["product"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "transaction_id": transactionId,
    "product_id": productId,
    "variation_id": variationId,
    "quantity": quantity,
    "secondary_unit_quantity": secondaryUnitQuantity,
    "mfg_waste_percent": mfgWastePercent,
    "mfg_ingredient_group_id": mfgIngredientGroupId,
    "quantity_returned": quantityReturned,
    "unit_price_before_discount": unitPriceBeforeDiscount,
    "unit_price": unitPrice,
    "line_discount_type": typeValues.reverse[lineDiscountType],
    "line_discount_amount": lineDiscountAmount,
    "unit_price_inc_tax": unitPriceIncTax,
    "item_tax": itemTax,
    "tax_id": taxId,
    "discount_id": discountId,
    "lot_no_line_id": lotNoLineId,
    "sell_line_note": sellLineNote,
    "woocommerce_line_items_id": woocommerceLineItemsId,
    "so_line_id": soLineId,
    "so_quantity_invoiced": soQuantityInvoiced,
    "res_service_staff_id": resServiceStaffId,
    "res_line_order_status":
    resLineOrderStatusValues.reverse[resLineOrderStatus],
    "parent_sell_line_id": parentSellLineId,
    "children_type": childrenTypeValues.reverse[childrenType],
    "sub_unit_id": subUnitId,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "modifier_input": modifierInput,
    "kitchen_id": kitchenId,
    "remarks": remarks,
    "modifiersfilter": modifiersfilter == null
        ? []
        : List<dynamic>.from(modifiersfilter!.map((x) => x.toJson())),
    "product": product?.toJson(),
  };
}

enum ChildrenType { EMPTY, MODIFIER }

final childrenTypeValues =
EnumValues({"": ChildrenType.EMPTY, "modifier": ChildrenType.MODIFIER});

class Modifiersfilter {
  int? id;
  int? transactionId;
  int? productId;
  int? variationId;
  int? quantity;
  String? secondaryUnitQuantity;
  String? mfgWastePercent;
  dynamic mfgIngredientGroupId;
  String? quantityReturned;
  String? unitPriceBeforeDiscount;
  String? unitPrice;
  dynamic lineDiscountType;
  String? lineDiscountAmount;
  String? unitPriceIncTax;
  String? itemTax;
  dynamic taxId;
  dynamic discountId;
  dynamic lotNoLineId;
  dynamic sellLineNote;
  dynamic woocommerceLineItemsId;
  dynamic soLineId;
  String? soQuantityInvoiced;
  dynamic resServiceStaffId;
  ResLineOrderStatus? resLineOrderStatus;
  int? parentSellLineId;
  ChildrenType? childrenType;
  dynamic subUnitId;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic modifierInput;
  dynamic kitchenId;
  dynamic remarks;
  ProductKitchen? product;
  Variations? variations;

  Modifiersfilter({
    this.id,
    this.transactionId,
    this.productId,
    this.variationId,
    this.quantity,
    this.secondaryUnitQuantity,
    this.mfgWastePercent,
    this.mfgIngredientGroupId,
    this.quantityReturned,
    this.unitPriceBeforeDiscount,
    this.unitPrice,
    this.lineDiscountType,
    this.lineDiscountAmount,
    this.unitPriceIncTax,
    this.itemTax,
    this.taxId,
    this.discountId,
    this.lotNoLineId,
    this.sellLineNote,
    this.woocommerceLineItemsId,
    this.soLineId,
    this.soQuantityInvoiced,
    this.resServiceStaffId,
    this.resLineOrderStatus,
    this.parentSellLineId,
    this.childrenType,
    this.subUnitId,
    this.createdAt,
    this.updatedAt,
    this.modifierInput,
    this.kitchenId,
    this.remarks,
    this.product,
    this.variations,
  });

  factory Modifiersfilter.fromJson(Map<String, dynamic> json) =>
      Modifiersfilter(
        id: json["id"],
        transactionId: json["transaction_id"],
        productId: json["product_id"],
        variationId: json["variation_id"],
        quantity: json["quantity"],
        secondaryUnitQuantity: json["secondary_unit_quantity"],
        mfgWastePercent: json["mfg_waste_percent"],
        mfgIngredientGroupId: json["mfg_ingredient_group_id"],
        quantityReturned: json["quantity_returned"],
        unitPriceBeforeDiscount: json["unit_price_before_discount"],
        unitPrice: json["unit_price"],
        lineDiscountType: json["line_discount_type"],
        lineDiscountAmount: json["line_discount_amount"],
        unitPriceIncTax: json["unit_price_inc_tax"],
        itemTax: json["item_tax"],
        taxId: json["tax_id"],
        discountId: json["discount_id"],
        lotNoLineId: json["lot_no_line_id"],
        sellLineNote: json["sell_line_note"],
        woocommerceLineItemsId: json["woocommerce_line_items_id"],
        soLineId: json["so_line_id"],
        soQuantityInvoiced: json["so_quantity_invoiced"],
        resServiceStaffId: json["res_service_staff_id"],
        resLineOrderStatus:
        resLineOrderStatusValues.map[json["res_line_order_status"]]!,
        parentSellLineId: json["parent_sell_line_id"],
        childrenType: childrenTypeValues.map[json["children_type"]]!,
        subUnitId: json["sub_unit_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        modifierInput: json["modifier_input"],
        kitchenId: json["kitchen_id"],
        remarks: json["remarks"],
        product: json["product"] == null
            ? null
            : ProductKitchen.fromJson(json["product"]),
        variations: json["variations"] == null
            ? null
            : Variations.fromJson(json["variations"]),
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "transaction_id": transactionId,
    "product_id": productId,
    "variation_id": variationId,
    "quantity": quantity,
    "secondary_unit_quantity": secondaryUnitQuantity,
    "mfg_waste_percent": mfgWastePercent,
    "mfg_ingredient_group_id": mfgIngredientGroupId,
    "quantity_returned": quantityReturned,
    "unit_price_before_discount": unitPriceBeforeDiscount,
    "unit_price": unitPrice,
    "line_discount_type": lineDiscountType,
    "line_discount_amount": lineDiscountAmount,
    "unit_price_inc_tax": unitPriceIncTax,
    "item_tax": itemTax,
    "tax_id": taxId,
    "discount_id": discountId,
    "lot_no_line_id": lotNoLineId,
    "sell_line_note": sellLineNote,
    "woocommerce_line_items_id": woocommerceLineItemsId,
    "so_line_id": soLineId,
    "so_quantity_invoiced": soQuantityInvoiced,
    "res_service_staff_id": resServiceStaffId,
    "res_line_order_status":
    resLineOrderStatusValues.reverse[resLineOrderStatus],
    "parent_sell_line_id": parentSellLineId,
    "children_type": childrenTypeValues.reverse[childrenType],
    "sub_unit_id": subUnitId,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "modifier_input": modifierInput,
    "kitchen_id": kitchenId,
    "remarks": remarks,
    "product": product?.toJson(),
    "variations": variations?.toJson(),
  };
}

class ProductKitchen {
  int? id;
  String? name;
  int? businessId;
  ProductType? type;
  int? unitId;
  dynamic secondaryUnitId;
  dynamic subUnitIds;
  dynamic brandId;
  int? categoryId;
  dynamic subCategoryId;
  int? tax;
  TaxType? taxType;
  int? enableStock;
  String? alertQuantity;
  String? sku;
  BarcodeType? barcodeType;
  dynamic expiryPeriod;
  dynamic expiryPeriodType;
  int? enableSrNo;
  String? weight;
  String? productCustomField1;
  String? productCustomField2;
  String? productCustomField3;
  String? productCustomField4;
  String? image;
  dynamic woocommerceMediaId;
  dynamic productDescription;
  int? createdBy;
  dynamic preparationTimeInMinutes;
  dynamic woocommerceProductId;
  int? woocommerceDisableSync;
  dynamic warrantyId;
  int? isInactive;
  dynamic repairModelId;
  int? notForSelling;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? kitchenId;
  int? typeOfProduct;
  int? modifierStatus;
  int? inputField;
  String? imageUrl;

  ProductKitchen({
    this.id,
    this.name,
    this.businessId,
    this.type,
    this.unitId,
    this.secondaryUnitId,
    this.subUnitIds,
    this.brandId,
    this.categoryId,
    this.subCategoryId,
    this.tax,
    this.taxType,
    this.enableStock,
    this.alertQuantity,
    this.sku,
    this.barcodeType,
    this.expiryPeriod,
    this.expiryPeriodType,
    this.enableSrNo,
    this.weight,
    this.productCustomField1,
    this.productCustomField2,
    this.productCustomField3,
    this.productCustomField4,
    this.image,
    this.woocommerceMediaId,
    this.productDescription,
    this.createdBy,
    this.preparationTimeInMinutes,
    this.woocommerceProductId,
    this.woocommerceDisableSync,
    this.warrantyId,
    this.isInactive,
    this.repairModelId,
    this.notForSelling,
    this.createdAt,
    this.updatedAt,
    this.kitchenId,
    this.typeOfProduct,
    this.modifierStatus,
    this.inputField,
    this.imageUrl,
  });

  factory ProductKitchen.fromJson(Map<String, dynamic> json) => ProductKitchen(
    id: json["id"],
    name: json["name"],
    businessId: json["business_id"],
    type: productTypeValues.map[json["type"]]!,
    unitId: json["unit_id"],
    secondaryUnitId: json["secondary_unit_id"],
    subUnitIds: json["sub_unit_ids"],
    brandId: json["brand_id"],
    categoryId: json["category_id"],
    subCategoryId: json["sub_category_id"],
    tax: json["tax"],
    taxType: taxTypeValues.map[json["tax_type"]]!,
    enableStock: json["enable_stock"],
    alertQuantity: json["alert_quantity"],
    sku: json["sku"],
    barcodeType: barcodeTypeValues.map[json["barcode_type"]]!,
    expiryPeriod: json["expiry_period"],
    expiryPeriodType: json["expiry_period_type"],
    enableSrNo: json["enable_sr_no"],
    weight: json["weight"],
    productCustomField1: json["product_custom_field1"],
    productCustomField2: json["product_custom_field2"],
    productCustomField3: json["product_custom_field3"],
    productCustomField4: json["product_custom_field4"],
    image: json["image"],
    woocommerceMediaId: json["woocommerce_media_id"],
    productDescription: json["product_description"],
    createdBy: json["created_by"],
    preparationTimeInMinutes: json["preparation_time_in_minutes"],
    woocommerceProductId: json["woocommerce_product_id"],
    woocommerceDisableSync: json["woocommerce_disable_sync"],
    warrantyId: json["warranty_id"],
    isInactive: json["is_inactive"],
    repairModelId: json["repair_model_id"],
    notForSelling: json["not_for_selling"],
    createdAt: json["created_at"] == null
        ? null
        : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null
        ? null
        : DateTime.parse(json["updated_at"]),
    kitchenId: json["kitchen_id"],
    typeOfProduct: json["type_of_product"],
    modifierStatus: json["modifier_status"],
    inputField: json["input_field"],
    imageUrl: json["image_url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "business_id": businessId,
    "type": productTypeValues.reverse[type],
    "unit_id": unitId,
    "secondary_unit_id": secondaryUnitId,
    "sub_unit_ids": subUnitIds,
    "brand_id": brandId,
    "category_id": categoryId,
    "sub_category_id": subCategoryId,
    "tax": tax,
    "tax_type": taxTypeValues.reverse[taxType],
    "enable_stock": enableStock,
    "alert_quantity": alertQuantity,
    "sku": sku,
    "barcode_type": barcodeTypeValues.reverse[barcodeType],
    "expiry_period": expiryPeriod,
    "expiry_period_type": expiryPeriodType,
    "enable_sr_no": enableSrNo,
    "weight": weight,
    "product_custom_field1": productCustomField1,
    "product_custom_field2": productCustomField2,
    "product_custom_field3": productCustomField3,
    "product_custom_field4": productCustomField4,
    "image": image,
    "woocommerce_media_id": woocommerceMediaId,
    "product_description": productDescription,
    "created_by": createdBy,
    "preparation_time_in_minutes": preparationTimeInMinutes,
    "woocommerce_product_id": woocommerceProductId,
    "woocommerce_disable_sync": woocommerceDisableSync,
    "warranty_id": warrantyId,
    "is_inactive": isInactive,
    "repair_model_id": repairModelId,
    "not_for_selling": notForSelling,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "kitchen_id": kitchenId,
    "type_of_product": typeOfProduct,
    "modifier_status": modifierStatus,
    "input_field": inputField,
    "image_url": imageUrl,
  };
}

enum BarcodeType { C128 }

final barcodeTypeValues = EnumValues({"C128": BarcodeType.C128});

enum TaxType { INCLUSIVE, EXCLUSIVE }

final taxTypeValues = EnumValues(
    {"exclusive": TaxType.EXCLUSIVE, "inclusive": TaxType.INCLUSIVE});

enum ProductType { MODIFIER, SINGLE }

final productTypeValues = EnumValues(
    {"modifier": ProductType.MODIFIER, "single": ProductType.SINGLE});

enum ResLineOrderStatus { SERVED, COOKED }

final resLineOrderStatusValues = EnumValues(
    {"cooked": ResLineOrderStatus.COOKED, "served": ResLineOrderStatus.SERVED});

class Variations {
  int? id;
  String? name;
  int? productId;
  String? subSku;
  int? productVariationId;
  dynamic woocommerceVariationId;
  dynamic variationValueId;
  String? defaultPurchasePrice;
  String? dppIncTax;
  String? profitPercent;
  String? defaultSellPrice;
  String? sellPriceIncTax;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  dynamic comboVariations;

  Variations({
    this.id,
    this.name,
    this.productId,
    this.subSku,
    this.productVariationId,
    this.woocommerceVariationId,
    this.variationValueId,
    this.defaultPurchasePrice,
    this.dppIncTax,
    this.profitPercent,
    this.defaultSellPrice,
    this.sellPriceIncTax,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.comboVariations,
  });

  factory Variations.fromJson(Map<String, dynamic> json) => Variations(
    id: json["id"],
    name: json["name"],
    productId: json["product_id"],
    subSku: json["sub_sku"],
    productVariationId: json["product_variation_id"],
    woocommerceVariationId: json["woocommerce_variation_id"],
    variationValueId: json["variation_value_id"],
    defaultPurchasePrice: json["default_purchase_price"],
    dppIncTax: json["dpp_inc_tax"],
    profitPercent: json["profit_percent"],
    defaultSellPrice: json["default_sell_price"],
    sellPriceIncTax: json["sell_price_inc_tax"],
    createdAt: json["created_at"] == null
        ? null
        : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null
        ? null
        : DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    comboVariations: json["combo_variations"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "product_id": productId,
    "sub_sku": subSku,
    "product_variation_id": productVariationId,
    "woocommerce_variation_id": woocommerceVariationId,
    "variation_value_id": variationValueId,
    "default_purchase_price": defaultPurchasePrice,
    "dpp_inc_tax": dppIncTax,
    "profit_percent": profitPercent,
    "default_sell_price": defaultSellPrice,
    "sell_price_inc_tax": sellPriceIncTax,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "deleted_at": deletedAt,
    "combo_variations": comboVariations,
  };
}

enum Status { FINAL }

final statusValues = EnumValues({"final": Status.FINAL});

enum OrderType { SELL }

final orderTypeValues = EnumValues({"sell": OrderType.SELL});

class TypesOfService {
  int? id;
  Name? name;
  dynamic description;
  int? businessId;
  Map<String, String>? locationPriceGroup;
  String? packingCharge;
  Type? packingChargeType;
  int? enableCustomFields;
  DateTime? createdAt;
  DateTime? updatedAt;
  Color? color;

  TypesOfService({
    this.id,
    this.name,
    this.description,
    this.businessId,
    this.locationPriceGroup,
    this.packingCharge,
    this.packingChargeType,
    this.enableCustomFields,
    this.createdAt,
    this.updatedAt,
    this.color,
  });

  factory TypesOfService.fromJson(Map<String, dynamic> json) => TypesOfService(
    id: json["id"],
    name: nameValues.map[json["name"]]!,
    description: json["description"],
    businessId: json["business_id"],
    locationPriceGroup: Map.from(json["location_price_group"]!)
        .map((k, v) => MapEntry<String, String>(k, v)),
    packingCharge: json["packing_charge"],
    packingChargeType: typeValues.map[json["packing_charge_type"]]!,
    enableCustomFields: json["enable_custom_fields"],
    createdAt: json["created_at"] == null
        ? null
        : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null
        ? null
        : DateTime.parse(json["updated_at"]),
    color: colorValuesKitchen.map[json["color"]]!,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": nameValues.reverse[name],
    "description": description,
    "business_id": businessId,
    "location_price_group": Map.from(locationPriceGroup!)
        .map((k, v) => MapEntry<String, dynamic>(k, v)),
    "packing_charge": packingCharge,
    "packing_charge_type": typeValues.reverse[packingChargeType],
    "enable_custom_fields": enableCustomFields,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "color": colorValuesKitchen.reverse[color],
  };
}

enum Color { DF0_C0_C, THE_15_CB6_D }

final colorValuesKitchen =
EnumValues({"#df0c0c": Color.DF0_C0_C, "#15cb6d": Color.THE_15_CB6_D});

enum Name { TAKE_AWAY, DINE_IN }

final nameValues =
EnumValues({"Dine-In": Name.DINE_IN, "Take-Away": Name.TAKE_AWAY});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
