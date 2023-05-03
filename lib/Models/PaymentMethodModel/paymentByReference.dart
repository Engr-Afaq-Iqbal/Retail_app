// To parse this JSON data, do
//
//     final paymentByReferenceModel = paymentByReferenceModelFromJson(jsonString);

import 'dart:convert';

PaymentByReferenceModel paymentByReferenceModelFromJson(String str) =>
    PaymentByReferenceModel.fromJson(json.decode(str));

String paymentByReferenceModelToJson(PaymentByReferenceModel data) =>
    json.encode(data.toJson());

class PaymentByReferenceModel {
  PaymentByReferenceModel({
    this.purchases,
    this.suppliers,
  });

  List<Purchase>? purchases;
  List<Purchase>? suppliers;

  factory PaymentByReferenceModel.fromJson(Map<String, dynamic> json) =>
      PaymentByReferenceModel(
        purchases: json["purchases"] == null
            ? []
            : List<Purchase>.from(
                json["purchases"]!.map((x) => Purchase.fromJson(x))),
        suppliers: json["suppliers"] == null
            ? []
            : List<Purchase>.from(
                json["suppliers"]!.map((x) => Purchase.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "purchases": purchases == null
            ? []
            : List<dynamic>.from(purchases!.map((x) => x.toJson())),
        "suppliers": suppliers == null
            ? []
            : List<dynamic>.from(suppliers!.map((x) => x.toJson())),
      };
}

class Purchase {
  Purchase({
    this.id,
    this.document,
    this.transactionDate,
    this.refNo,
    this.name,
    this.supplierBusinessName,
    this.status,
    this.paymentStatus,
    this.finalTotal,
    this.locationName,
    this.payTermNumber,
    this.payTermType,
    this.returnTransactionId,
    this.amountPaid,
    this.returnPaid,
    this.returnExists,
    this.amountReturn,
    this.addedBy,
    this.paymentLines,
    this.contactId,
  });

  int? id;
  dynamic document;
  DateTime? transactionDate;
  String? refNo;
  String? name;
  String? supplierBusinessName;
  String? status;
  String? paymentStatus;
  String? finalTotal;
  String? locationName;
  dynamic payTermNumber;
  dynamic payTermType;
  dynamic returnTransactionId;
  String? amountPaid;
  dynamic returnPaid;
  int? returnExists;
  String? amountReturn;
  String? addedBy;
  List<PaymentLine>? paymentLines;
  int? contactId;

  factory Purchase.fromJson(Map<String, dynamic> json) => Purchase(
        id: json["id"],
        document: json["document"],
        transactionDate: json["transaction_date"] == null
            ? null
            : DateTime.parse(json["transaction_date"]),
        refNo: json["ref_no"],
        name: json["name"],
        supplierBusinessName: json["supplier_business_name"],
        status: json["status"],
        paymentStatus: json["payment_status"],
        finalTotal: json["final_total"],
        locationName: json["location_name"],
        payTermNumber: json["pay_term_number"],
        payTermType: json["pay_term_type"],
        returnTransactionId: json["return_transaction_id"],
        amountPaid: json["amount_paid"],
        returnPaid: json["return_paid"],
        returnExists: json["return_exists"],
        amountReturn: json["amount_return"],
        addedBy: json["added_by"],
        paymentLines: json["payment_lines"] == null
            ? []
            : List<PaymentLine>.from(
                json["payment_lines"]!.map((x) => PaymentLine.fromJson(x))),
        contactId: json["contact_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "document": document,
        "transaction_date": transactionDate?.toIso8601String(),
        "ref_no": refNo,
        "name": name,
        "supplier_business_name": supplierBusinessName,
        "status": status,
        "payment_status": paymentStatus,
        "final_total": finalTotal,
        "location_name": locationName,
        "pay_term_number": payTermNumber,
        "pay_term_type": payTermType,
        "return_transaction_id": returnTransactionId,
        "amount_paid": amountPaid,
        "return_paid": returnPaid,
        "return_exists": returnExists,
        "amount_return": amountReturn,
        "added_by": addedBy,
        "payment_lines": paymentLines == null
            ? []
            : List<dynamic>.from(paymentLines!.map((x) => x.toJson())),
        "contact_id": contactId,
      };
}

class PaymentLine {
  PaymentLine({
    this.id,
    this.transactionId,
    this.businessId,
    this.isReturn,
    this.amount,
    this.method,
    this.paymentType,
    this.transactionNo,
    this.cardTransactionNumber,
    this.cardNumber,
    this.cardType,
    this.cardHolderName,
    this.cardMonth,
    this.cardYear,
    this.cardSecurity,
    this.chequeNumber,
    this.bankAccountNumber,
    this.paidOn,
    this.createdBy,
    this.paidThroughLink,
    this.gateway,
    this.isAdvance,
    this.paymentFor,
    this.parentId,
    this.note,
    this.document,
    this.paymentRefNo,
    this.accountId,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? transactionId;
  int? businessId;
  int? isReturn;
  String? amount;
  String? method;
  dynamic paymentType;
  dynamic transactionNo;
  dynamic cardTransactionNumber;
  dynamic cardNumber;
  String? cardType;
  dynamic cardHolderName;
  dynamic cardMonth;
  dynamic cardYear;
  dynamic cardSecurity;
  dynamic chequeNumber;
  dynamic bankAccountNumber;
  DateTime? paidOn;
  int? createdBy;
  int? paidThroughLink;
  dynamic gateway;
  int? isAdvance;
  int? paymentFor;
  dynamic parentId;
  dynamic note;
  dynamic document;
  String? paymentRefNo;
  int? accountId;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory PaymentLine.fromJson(Map<String, dynamic> json) => PaymentLine(
        id: json["id"],
        transactionId: json["transaction_id"],
        businessId: json["business_id"],
        isReturn: json["is_return"],
        amount: json["amount"],
        method: json["method"],
        paymentType: json["payment_type"],
        transactionNo: json["transaction_no"],
        cardTransactionNumber: json["card_transaction_number"],
        cardNumber: json["card_number"],
        cardType: json["card_type"],
        cardHolderName: json["card_holder_name"],
        cardMonth: json["card_month"],
        cardYear: json["card_year"],
        cardSecurity: json["card_security"],
        chequeNumber: json["cheque_number"],
        bankAccountNumber: json["bank_account_number"],
        paidOn:
            json["paid_on"] == null ? null : DateTime.parse(json["paid_on"]),
        createdBy: json["created_by"],
        paidThroughLink: json["paid_through_link"],
        gateway: json["gateway"],
        isAdvance: json["is_advance"],
        paymentFor: json["payment_for"],
        parentId: json["parent_id"],
        note: json["note"],
        document: json["document"],
        paymentRefNo: json["payment_ref_no"],
        accountId: json["account_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "transaction_id": transactionId,
        "business_id": businessId,
        "is_return": isReturn,
        "amount": amount,
        "method": method,
        "payment_type": paymentType,
        "transaction_no": transactionNo,
        "card_transaction_number": cardTransactionNumber,
        "card_number": cardNumber,
        "card_type": cardType,
        "card_holder_name": cardHolderName,
        "card_month": cardMonth,
        "card_year": cardYear,
        "card_security": cardSecurity,
        "cheque_number": chequeNumber,
        "bank_account_number": bankAccountNumber,
        "paid_on": paidOn?.toIso8601String(),
        "created_by": createdBy,
        "paid_through_link": paidThroughLink,
        "gateway": gateway,
        "is_advance": isAdvance,
        "payment_for": paymentFor,
        "parent_id": parentId,
        "note": note,
        "document": document,
        "payment_ref_no": paymentRefNo,
        "account_id": accountId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
