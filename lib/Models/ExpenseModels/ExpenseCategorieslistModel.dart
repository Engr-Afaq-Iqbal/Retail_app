// To parse this JSON data, do
//
//     final expenseCategoriesListModel = expenseCategoriesListModelFromJson(jsonString);

import 'dart:convert';

ExpenseCategoriesListModel expenseCategoriesListModelFromJson(String str) =>
    ExpenseCategoriesListModel.fromJson(json.decode(str));

String expenseCategoriesListModelToJson(ExpenseCategoriesListModel data) =>
    json.encode(data.toJson());

class ExpenseCategoriesListModel {
  ExpenseCategoriesListModel({
    this.account,
    this.expenseCategories,
    this.businessLocations,
    this.users,
    this.taxes,
    this.paymentLine,
    this.paymentTypes,
    this.contacts,
  });

  List<AccountElement>? account;
  List<ExpenseCategory>? expenseCategories;
  List<BusinessLocation>? businessLocations;
  List<User>? users;
  List<Tax>? taxes;
  PaymentLine? paymentLine;
  PaymentTypes? paymentTypes;
  List<Contact>? contacts;

  factory ExpenseCategoriesListModel.fromJson(Map<String, dynamic> json) =>
      ExpenseCategoriesListModel(
        account: json["account"] == null
            ? []
            : List<AccountElement>.from(
                json["account"]!.map((x) => AccountElement.fromJson(x))),
        expenseCategories: json["expense_categories"] == null
            ? []
            : List<ExpenseCategory>.from(json["expense_categories"]!
                .map((x) => ExpenseCategory.fromJson(x))),
        businessLocations: json["business_locations"] == null
            ? []
            : List<BusinessLocation>.from(json["business_locations"]!
                .map((x) => BusinessLocation.fromJson(x))),
        users: json["users"] == null
            ? []
            : List<User>.from(json["users"]!.map((x) => User.fromJson(x))),
        taxes: json["taxes"] == null
            ? []
            : List<Tax>.from(json["taxes"]!.map((x) => Tax.fromJson(x))),
        paymentLine: json["payment_line"] == null
            ? null
            : PaymentLine.fromJson(json["payment_line"]),
        paymentTypes: json["payment_types"] == null
            ? null
            : PaymentTypes.fromJson(json["payment_types"]),
        contacts: json["contacts"] == null
            ? []
            : List<Contact>.from(
                json["contacts"]!.map((x) => Contact.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "account": account == null
            ? []
            : List<dynamic>.from(account!.map((x) => x.toJson())),
        "expense_categories": expenseCategories == null
            ? []
            : List<dynamic>.from(expenseCategories!.map((x) => x.toJson())),
        "business_locations": businessLocations == null
            ? []
            : List<dynamic>.from(businessLocations!.map((x) => x.toJson())),
        "users": users == null
            ? []
            : List<dynamic>.from(users!.map((x) => x.toJson())),
        "taxes": taxes == null
            ? []
            : List<dynamic>.from(taxes!.map((x) => x.toJson())),
        "payment_line": paymentLine?.toJson(),
        "payment_types": paymentTypes?.toJson(),
        "contacts": contacts == null
            ? []
            : List<dynamic>.from(contacts!.map((x) => x.toJson())),
      };
}

class AccountElement {
  AccountElement({
    this.paymentMethod,
    this.account,
  });

  String? paymentMethod;
  AccountAccount? account;

  factory AccountElement.fromJson(Map<String, dynamic> json) => AccountElement(
        paymentMethod: json["payment_method"],
        account: json["account"] == null
            ? null
            : AccountAccount.fromJson(json["account"]),
      );

  Map<String, dynamic> toJson() => {
        "payment_method": paymentMethod,
        "account": account?.toJson(),
      };
}

class AccountAccount {
  AccountAccount({
    this.name,
    this.id,
    this.balance,
  });

  String? name;
  int? id;
  String? balance;

  factory AccountAccount.fromJson(Map<String, dynamic> json) => AccountAccount(
        name: json["name"],
        id: json["id"],
        balance: json["balance"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
        "balance": balance,
      };
}

class BusinessLocation {
  BusinessLocation({
    this.name,
    this.id,
    this.receiptPrinterType,
    this.sellingPriceGroupId,
    this.defaultPaymentAccounts,
    this.invoiceSchemeId,
  });

  String? name;
  int? id;
  String? receiptPrinterType;
  int? sellingPriceGroupId;
  String? defaultPaymentAccounts;
  int? invoiceSchemeId;

  factory BusinessLocation.fromJson(Map<String, dynamic> json) =>
      BusinessLocation(
        name: json["name"],
        id: json["id"],
        receiptPrinterType: json["receipt_printer_type"],
        sellingPriceGroupId: json["selling_price_group_id"],
        defaultPaymentAccounts: json["default_payment_accounts"],
        invoiceSchemeId: json["invoice_scheme_id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
        "receipt_printer_type": receiptPrinterType,
        "selling_price_group_id": sellingPriceGroupId,
        "default_payment_accounts": defaultPaymentAccounts,
        "invoice_scheme_id": invoiceSchemeId,
      };
}

class Contact {
  Contact({
    this.supplier,
    this.id,
  });

  String? supplier;
  int? id;

  factory Contact.fromJson(Map<String, dynamic> json) => Contact(
        supplier: json["supplier"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "supplier": supplier,
        "id": id,
      };
}

class ExpenseCategory {
  ExpenseCategory({
    this.id,
    this.name,
    this.businessId,
    this.code,
    this.parentId,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? name;
  int? businessId;
  dynamic code;
  dynamic parentId;
  dynamic deletedAt;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory ExpenseCategory.fromJson(Map<String, dynamic> json) =>
      ExpenseCategory(
        id: json["id"],
        name: json["name"],
        businessId: json["business_id"],
        code: json["code"],
        parentId: json["parent_id"],
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "business_id": businessId,
        "code": code,
        "parent_id": parentId,
        "deleted_at": deletedAt,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
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

class PaymentTypes {
  PaymentTypes({
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

  String? cash;
  String? card;
  String? cheque;
  String? bankTransfer;
  String? other;
  String? customPay1;
  String? customPay2;
  String? customPay3;
  String? customPay4;
  String? customPay5;
  String? customPay6;
  String? customPay7;

  factory PaymentTypes.fromJson(Map<String, dynamic> json) => PaymentTypes(
        cash: json["cash"],
        card: json["card"],
        cheque: json["cheque"],
        bankTransfer: json["bank_transfer"],
        other: json["other"],
        customPay1: json["custom_pay_1"],
        customPay2: json["custom_pay_2"],
        customPay3: json["custom_pay_3"],
        customPay4: json["custom_pay_4"],
        customPay5: json["custom_pay_5"],
        customPay6: json["custom_pay_6"],
        customPay7: json["custom_pay_7"],
      );

  Map<String, dynamic> toJson() => {
        "cash": cash,
        "card": card,
        "cheque": cheque,
        "bank_transfer": bankTransfer,
        "other": other,
        "custom_pay_1": customPay1,
        "custom_pay_2": customPay2,
        "custom_pay_3": customPay3,
        "custom_pay_4": customPay4,
        "custom_pay_5": customPay5,
        "custom_pay_6": customPay6,
        "custom_pay_7": customPay7,
      };
}

class Tax {
  Tax({
    this.id,
    this.businessId,
    this.name,
    this.amount,
    this.isTaxGroup,
    this.forTaxGroup,
    this.createdBy,
    this.woocommerceTaxRateId,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? businessId;
  String? name;
  int? amount;
  int? isTaxGroup;
  int? forTaxGroup;
  int? createdBy;
  dynamic woocommerceTaxRateId;
  dynamic deletedAt;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Tax.fromJson(Map<String, dynamic> json) => Tax(
        id: json["id"],
        businessId: json["business_id"],
        name: json["name"],
        amount: json["amount"],
        isTaxGroup: json["is_tax_group"],
        forTaxGroup: json["for_tax_group"],
        createdBy: json["created_by"],
        woocommerceTaxRateId: json["woocommerce_tax_rate_id"],
        deletedAt: json["deleted_at"],
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
        "amount": amount,
        "is_tax_group": isTaxGroup,
        "for_tax_group": forTaxGroup,
        "created_by": createdBy,
        "woocommerce_tax_rate_id": woocommerceTaxRateId,
        "deleted_at": deletedAt,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class User {
  User({
    this.id,
    this.fullName,
  });

  int? id;
  String? fullName;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        fullName: json["full_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "full_name": fullName,
      };
}
