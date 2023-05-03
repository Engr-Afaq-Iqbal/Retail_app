// To parse this JSON data, do
//
//     final expenseCategoryModel = expenseCategoryModelFromJson(jsonString);

import 'dart:convert';

import '/Models/ExpenseModels/PaymentMethodAccountModel.dart';
import 'ExpenseCategoryDataModel.dart';

ExpenseCategoryModel? expenseCategoryModelFromJson(String str) =>
    ExpenseCategoryModel.fromJson(json.decode(str));

String expenseCategoryModelToJson(ExpenseCategoryModel? data) =>
    json.encode(data!.toJson());

class ExpenseCategoryModel {
  ExpenseCategoryModel({
    this.paymentMethodsWithAccount = const [],
    this.expenseCategoriesData = const [],
    this.businessLocations,
    this.users,
    this.taxes,
    this.paymentLine,
    this.paymentTypes,
    this.blAttributes,
    this.contacts,
  });

  late List<PaymentMethodAccountModel?> paymentMethodsWithAccount;
  late List<ExpenseCategoryDataModel?> expenseCategoriesData;
  Map? businessLocations;
  Map? users;
  Taxes? taxes;
  PaymentLine? paymentLine;
  Map? paymentTypes;
  Map? blAttributes;
  Map? contacts;

  ExpenseCategoryModel copyWith({
    List<PaymentMethodAccountModel?>? paymentMethodsWithAccount,
    List<ExpenseCategoryDataModel?>? expenseCategoriesData,
    Map? businessLocations,
    Map? users,
    Taxes? taxes,
    PaymentLine? paymentLine,
    Map? paymentTypes,
    Map? blAttributes,
    Map? contacts,
  }) =>
      ExpenseCategoryModel(
        paymentMethodsWithAccount:
            paymentMethodsWithAccount ?? this.paymentMethodsWithAccount,
        expenseCategoriesData:
            expenseCategoriesData ?? this.expenseCategoriesData,
        businessLocations: businessLocations ?? this.businessLocations,
        users: users ?? this.users,
        taxes: taxes ?? this.taxes,
        paymentLine: paymentLine ?? this.paymentLine,
        paymentTypes: paymentTypes ?? this.paymentTypes,
        blAttributes: blAttributes ?? this.blAttributes,
        contacts: contacts ?? this.contacts,
      );

  ExpenseCategoryModel.fromJson(Map<String, dynamic> json) {
    paymentMethodsWithAccount = json["account"] == null
        ? []
        : List<PaymentMethodAccountModel?>.from(
            json["account"]!.map((x) => paymentMethodAccountModelFromJson(x)),
          );
    expenseCategoriesData = json["expense_categories"] == null
        ? []
        : List<ExpenseCategoryDataModel?>.from(
            json["expense_categories"]!
                .map((x) => expenseCategoryDataModelFromJson(x)),
          );
    businessLocations = json["business_locations"];
    users = json["users"];
    taxes = json["taxes"] == null ? null : Taxes.fromJson(json["taxes"]);
    paymentLine = json["payment_line"] == null
        ? null
        : PaymentLine.fromJson(json["payment_line"]);
    paymentTypes = json["payment_types"];
    blAttributes = json["bl_attributes"];
    contacts = json["contacts"];
  }

  Map<String, dynamic> toJson() => {
        "account": paymentMethodsWithAccount.isEmpty
            ? []
            : List<dynamic>.from(paymentMethodsWithAccount
                .map((x) => paymentMethodAccountModelToJson(x!))),
        "expense_categories": expenseCategoriesData.isEmpty
            ? []
            : List<dynamic>.from(expenseCategoriesData
                .map((x) => expenseCategoryDataModelToJson(x!))),
        "business_locations": businessLocations,
        "users": users,
        "taxes": taxes,
        "payment_line": paymentLine,
        "payment_types": paymentTypes,
        "bl_attributes": blAttributes,
        "contacts": contacts,
      };
}

class PaymentLine {
  PaymentLine({
    this.method,
    this.amount,
    this.note,
    this.cardTransactionNumber,
    this.cardNumber,
    this.cardType,
    this.cardHolderName,
    this.cardMonth,
    this.cardYear,
    this.cardSecurity,
    this.chequeNumber,
    this.bankAccountNumber,
    this.isReturn,
    this.transactionNo,
  });

  String? method;
  int? amount;
  String? note;
  String? cardTransactionNumber;
  String? cardNumber;
  String? cardType;
  String? cardHolderName;
  String? cardMonth;
  String? cardYear;
  String? cardSecurity;
  String? chequeNumber;
  String? bankAccountNumber;
  int? isReturn;
  String? transactionNo;

  PaymentLine copyWith({
    String? method,
    int? amount,
    String? note,
    String? cardTransactionNumber,
    String? cardNumber,
    String? cardType,
    String? cardHolderName,
    String? cardMonth,
    String? cardYear,
    String? cardSecurity,
    String? chequeNumber,
    String? bankAccountNumber,
    int? isReturn,
    String? transactionNo,
  }) =>
      PaymentLine(
        method: method ?? this.method,
        amount: amount ?? this.amount,
        note: note ?? this.note,
        cardTransactionNumber:
            cardTransactionNumber ?? this.cardTransactionNumber,
        cardNumber: cardNumber ?? this.cardNumber,
        cardType: cardType ?? this.cardType,
        cardHolderName: cardHolderName ?? this.cardHolderName,
        cardMonth: cardMonth ?? this.cardMonth,
        cardYear: cardYear ?? this.cardYear,
        cardSecurity: cardSecurity ?? this.cardSecurity,
        chequeNumber: chequeNumber ?? this.chequeNumber,
        bankAccountNumber: bankAccountNumber ?? this.bankAccountNumber,
        isReturn: isReturn ?? this.isReturn,
        transactionNo: transactionNo ?? this.transactionNo,
      );

  factory PaymentLine.fromJson(Map<String, dynamic> json) => PaymentLine(
        method: json["method"],
        amount: json["amount"],
        note: json["note"],
        cardTransactionNumber: json["card_transaction_number"],
        cardNumber: json["card_number"],
        cardType: json["card_type"],
        cardHolderName: json["card_holder_name"],
        cardMonth: json["card_month"],
        cardYear: json["card_year"],
        cardSecurity: json["card_security"],
        chequeNumber: json["cheque_number"],
        bankAccountNumber: json["bank_account_number"],
        isReturn: json["is_return"],
        transactionNo: json["transaction_no"],
      );

  Map<String, dynamic> toJson() => {
        "method": method,
        "amount": amount,
        "note": note,
        "card_transaction_number": cardTransactionNumber,
        "card_number": cardNumber,
        "card_type": cardType,
        "card_holder_name": cardHolderName,
        "card_month": cardMonth,
        "card_year": cardYear,
        "card_security": cardSecurity,
        "cheque_number": chequeNumber,
        "bank_account_number": bankAccountNumber,
        "is_return": isReturn,
        "transaction_no": transactionNo,
      };
}

class Taxes {
  Taxes({
    this.taxRates,
    this.attributes,
  });

  Map? taxRates;
  Map? attributes;

  Taxes copyWith({
    Map? taxRates,
    Map? attributes,
  }) =>
      Taxes(
        taxRates: taxRates ?? this.taxRates,
        attributes: attributes ?? this.attributes,
      );

  factory Taxes.fromJson(Map<String, dynamic> json) => Taxes(
        taxRates: json["tax_rates"],
        attributes: json["attributes"],
      );

  Map<String, dynamic> toJson() => {
        "tax_rates": taxRates,
        "attributes": attributes,
      };
}
