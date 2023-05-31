// To parse this JSON data, do
//
//     final getSpecificContactModel = getSpecificContactModelFromJson(jsonString);

import 'dart:convert';

GetSpecificContactModel getSpecificContactModelFromJson(String str) =>
    GetSpecificContactModel.fromJson(json.decode(str));

String getSpecificContactModelToJson(GetSpecificContactModel data) =>
    json.encode(data.toJson());

class GetSpecificContactModel {
  List<Datum>? data;

  GetSpecificContactModel({
    this.data,
  });

  factory GetSpecificContactModel.fromJson(Map<String, dynamic> json) =>
      GetSpecificContactModel(
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  int? id;
  int? businessId;
  String? type;
  dynamic supplierBusinessName;
  String? name;
  dynamic prefix;
  String? firstName;
  dynamic middleName;
  dynamic lastName;
  dynamic email;
  String? contactId;
  String? contactStatus;
  dynamic taxNumber;
  dynamic city;
  dynamic state;
  dynamic country;
  dynamic addressLine1;
  dynamic addressLine2;
  dynamic zipCode;
  dynamic dob;
  String? mobile;
  dynamic landline;
  dynamic alternateNumber;
  dynamic payTermNumber;
  dynamic payTermType;
  String? creditLimit;
  int? createdBy;
  dynamic convertedBy;
  dynamic convertedOn;
  String? balance;
  int? totalRp;
  int? totalRpUsed;
  int? totalRpExpired;
  int? isDefault;
  dynamic shippingAddress;
  dynamic shippingCustomFieldDetails;
  int? isExport;
  dynamic exportCustomField1;
  dynamic exportCustomField2;
  dynamic exportCustomField3;
  dynamic exportCustomField4;
  dynamic exportCustomField5;
  dynamic exportCustomField6;
  dynamic position;
  dynamic customerGroupId;
  dynamic crmSource;
  dynamic crmLifeStage;
  dynamic customField1;
  dynamic customField2;
  dynamic customField3;
  dynamic customField4;
  dynamic customField5;
  dynamic customField6;
  dynamic customField7;
  dynamic customField8;
  dynamic customField9;
  dynamic customField10;
  dynamic deletedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic customerGroup;
  String? openingBalance;
  String? openingBalancePaid;
  DateTime? maxTransactionDate;
  String? totalLedgerDiscount;
  DateTime? transactionDate;
  String? totalPurchase;
  String? purchasePaid;
  String? totalPurchaseReturn;
  String? purchaseReturnPaid;
  String? totalInvoice;
  String? invoiceReceived;
  String? totalSellReturn;
  String? sellReturnPaid;
  int? purchaseDue;
  double? sellDue;
  int? purchaseReturnDue;
  double? sellReturnDue;

  Datum({
    this.id,
    this.businessId,
    this.type,
    this.supplierBusinessName,
    this.name,
    this.prefix,
    this.firstName,
    this.middleName,
    this.lastName,
    this.email,
    this.contactId,
    this.contactStatus,
    this.taxNumber,
    this.city,
    this.state,
    this.country,
    this.addressLine1,
    this.addressLine2,
    this.zipCode,
    this.dob,
    this.mobile,
    this.landline,
    this.alternateNumber,
    this.payTermNumber,
    this.payTermType,
    this.creditLimit,
    this.createdBy,
    this.convertedBy,
    this.convertedOn,
    this.balance,
    this.totalRp,
    this.totalRpUsed,
    this.totalRpExpired,
    this.isDefault,
    this.shippingAddress,
    this.shippingCustomFieldDetails,
    this.isExport,
    this.exportCustomField1,
    this.exportCustomField2,
    this.exportCustomField3,
    this.exportCustomField4,
    this.exportCustomField5,
    this.exportCustomField6,
    this.position,
    this.customerGroupId,
    this.crmSource,
    this.crmLifeStage,
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
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.customerGroup,
    this.openingBalance,
    this.openingBalancePaid,
    this.maxTransactionDate,
    this.totalLedgerDiscount,
    this.transactionDate,
    this.totalPurchase,
    this.purchasePaid,
    this.totalPurchaseReturn,
    this.purchaseReturnPaid,
    this.totalInvoice,
    this.invoiceReceived,
    this.totalSellReturn,
    this.sellReturnPaid,
    this.purchaseDue,
    this.sellDue,
    this.purchaseReturnDue,
    this.sellReturnDue,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        businessId: json["business_id"],
        type: json["type"],
        supplierBusinessName: json["supplier_business_name"],
        name: json["name"],
        prefix: json["prefix"],
        firstName: json["first_name"],
        middleName: json["middle_name"],
        lastName: json["last_name"],
        email: json["email"],
        contactId: json["contact_id"],
        contactStatus: json["contact_status"],
        taxNumber: json["tax_number"],
        city: json["city"],
        state: json["state"],
        country: json["country"],
        addressLine1: json["address_line_1"],
        addressLine2: json["address_line_2"],
        zipCode: json["zip_code"],
        dob: json["dob"],
        mobile: json["mobile"],
        landline: json["landline"],
        alternateNumber: json["alternate_number"],
        payTermNumber: json["pay_term_number"],
        payTermType: json["pay_term_type"],
        creditLimit: json["credit_limit"],
        createdBy: json["created_by"],
        convertedBy: json["converted_by"],
        convertedOn: json["converted_on"],
        balance: json["balance"],
        totalRp: json["total_rp"],
        totalRpUsed: json["total_rp_used"],
        totalRpExpired: json["total_rp_expired"],
        isDefault: json["is_default"],
        shippingAddress: json["shipping_address"],
        shippingCustomFieldDetails: json["shipping_custom_field_details"],
        isExport: json["is_export"],
        exportCustomField1: json["export_custom_field_1"],
        exportCustomField2: json["export_custom_field_2"],
        exportCustomField3: json["export_custom_field_3"],
        exportCustomField4: json["export_custom_field_4"],
        exportCustomField5: json["export_custom_field_5"],
        exportCustomField6: json["export_custom_field_6"],
        position: json["position"],
        customerGroupId: json["customer_group_id"],
        crmSource: json["crm_source"],
        crmLifeStage: json["crm_life_stage"],
        customField1: json["custom_field1"],
        customField2: json["custom_field2"],
        customField3: json["custom_field3"],
        customField4: json["custom_field4"],
        customField5: json["custom_field5"],
        customField6: json["custom_field6"],
        customField7: json["custom_field7"],
        customField8: json["custom_field8"],
        customField9: json["custom_field9"],
        customField10: json["custom_field10"],
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        customerGroup: json["customer_group"],
        openingBalance: json["opening_balance"],
        openingBalancePaid: json["opening_balance_paid"],
        maxTransactionDate: json["max_transaction_date"] == null
            ? null
            : DateTime.parse(json["max_transaction_date"]),
        totalLedgerDiscount: json["total_ledger_discount"],
        transactionDate: json["transaction_date"] == null
            ? null
            : DateTime.parse(json["transaction_date"]),
        totalPurchase: json["total_purchase"],
        purchasePaid: json["purchase_paid"],
        totalPurchaseReturn: json["total_purchase_return"],
        purchaseReturnPaid: json["purchase_return_paid"],
        totalInvoice: json["total_invoice"],
        invoiceReceived: json["invoice_received"],
        totalSellReturn: json["total_sell_return"],
        sellReturnPaid: json["sell_return_paid"],
        purchaseDue: json["purchase_due"],
        sellDue: json["sell_due"]?.toDouble(),
        purchaseReturnDue: json["purchase_return_due"],
        sellReturnDue: json["sell_return_due"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "business_id": businessId,
        "type": type,
        "supplier_business_name": supplierBusinessName,
        "name": name,
        "prefix": prefix,
        "first_name": firstName,
        "middle_name": middleName,
        "last_name": lastName,
        "email": email,
        "contact_id": contactId,
        "contact_status": contactStatus,
        "tax_number": taxNumber,
        "city": city,
        "state": state,
        "country": country,
        "address_line_1": addressLine1,
        "address_line_2": addressLine2,
        "zip_code": zipCode,
        "dob": dob,
        "mobile": mobile,
        "landline": landline,
        "alternate_number": alternateNumber,
        "pay_term_number": payTermNumber,
        "pay_term_type": payTermType,
        "credit_limit": creditLimit,
        "created_by": createdBy,
        "converted_by": convertedBy,
        "converted_on": convertedOn,
        "balance": balance,
        "total_rp": totalRp,
        "total_rp_used": totalRpUsed,
        "total_rp_expired": totalRpExpired,
        "is_default": isDefault,
        "shipping_address": shippingAddress,
        "shipping_custom_field_details": shippingCustomFieldDetails,
        "is_export": isExport,
        "export_custom_field_1": exportCustomField1,
        "export_custom_field_2": exportCustomField2,
        "export_custom_field_3": exportCustomField3,
        "export_custom_field_4": exportCustomField4,
        "export_custom_field_5": exportCustomField5,
        "export_custom_field_6": exportCustomField6,
        "position": position,
        "customer_group_id": customerGroupId,
        "crm_source": crmSource,
        "crm_life_stage": crmLifeStage,
        "custom_field1": customField1,
        "custom_field2": customField2,
        "custom_field3": customField3,
        "custom_field4": customField4,
        "custom_field5": customField5,
        "custom_field6": customField6,
        "custom_field7": customField7,
        "custom_field8": customField8,
        "custom_field9": customField9,
        "custom_field10": customField10,
        "deleted_at": deletedAt,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "customer_group": customerGroup,
        "opening_balance": openingBalance,
        "opening_balance_paid": openingBalancePaid,
        "max_transaction_date":
            "${maxTransactionDate!.year.toString().padLeft(4, '0')}-${maxTransactionDate!.month.toString().padLeft(2, '0')}-${maxTransactionDate!.day.toString().padLeft(2, '0')}",
        "total_ledger_discount": totalLedgerDiscount,
        "transaction_date": transactionDate?.toIso8601String(),
        "total_purchase": totalPurchase,
        "purchase_paid": purchasePaid,
        "total_purchase_return": totalPurchaseReturn,
        "purchase_return_paid": purchaseReturnPaid,
        "total_invoice": totalInvoice,
        "invoice_received": invoiceReceived,
        "total_sell_return": totalSellReturn,
        "sell_return_paid": sellReturnPaid,
        "purchase_due": purchaseDue,
        "sell_due": sellDue,
        "purchase_return_due": purchaseReturnDue,
        "sell_return_due": sellReturnDue,
      };
}
