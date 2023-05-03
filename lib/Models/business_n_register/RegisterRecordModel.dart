// To parse this JSON data, do
//
//     final registerRecordModel = registerRecordModelFromJson(jsonString);

import 'dart:convert';

RegisterRecordModel registerRecordModelFromJson(String str) =>
    RegisterRecordModel.fromJson(json.decode(str));

String registerRecordModelToJson(RegisterRecordModel data) =>
    json.encode(data.toJson());

class RegisterRecordModel {
  RegisterRecordModel({
    this.registerDetails,
    this.details,
    this.paymentTypes,
    this.dataHtml,
    this.totalPayment,
    this.creditSale,
    this.totalSale,
    this.totalExpense,
    this.totalRefund,
  });

  RegisterDetailsModel? registerDetails;
  DetailsModel? details;
  PaymentTypesModel? paymentTypes;
  DataHtml? dataHtml;
  double? totalPayment;
  String? creditSale;
  String? totalSale;
  String? totalExpense;
  String? totalRefund;

  factory RegisterRecordModel.fromJson(Map<String, dynamic> json) =>
      RegisterRecordModel(
        registerDetails: json["register_details"] == null
            ? null
            : RegisterDetailsModel.fromJson(json["register_details"]),
        details: json["details"] == null
            ? null
            : DetailsModel.fromJson(json["details"]),
        paymentTypes: json["payment_types"] == null
            ? null
            : PaymentTypesModel.fromJson(json["payment_types"]),
        dataHtml: json["data_html"] == null
            ? null
            : DataHtml.fromJson(json["data_html"]),
        totalPayment: json["total_payment"]?.toDouble(),
        creditSale: json["credit_sale"],
        totalSale: json["total_sale"],
        totalExpense: json["total_expense"],
        totalRefund: json["total_refund"],
      );

  Map<String, dynamic> toJson() => {
        "register_details":
            registerDetails == null ? null : registerDetails?.toJson(),
        "details": details == null ? null : details?.toJson(),
        "payment_types": paymentTypes == null ? null : paymentTypes?.toJson(),
        "data_html": dataHtml == null ? null : dataHtml?.toJson(),
        "total_payment": totalPayment,
        "credit_sale": creditSale,
        "total_sale": totalSale,
        "total_expense": totalExpense,
        "total_refund": totalRefund,
      };
}

class DetailsModel {
  DetailsModel({
    this.productDetailsByBrand = const [],
    this.transactionDetails,
    this.typesOfServiceDetails = const [],
    this.productDetails = const [],
  });

  List<ProductDetailsByBrandModel> productDetailsByBrand;
  TransactionDetails? transactionDetails;
  List<TypeOfServiceDetailsModel> typesOfServiceDetails;
  List<ProductDetailsModel> productDetails;

  factory DetailsModel.fromJson(Map<String, dynamic> json) {
    return DetailsModel(
      productDetailsByBrand: json["product_details_by_brand"] == null
          ? []
          : List<ProductDetailsByBrandModel>.from(
              json["product_details_by_brand"]
                  .map((x) => ProductDetailsByBrandModel.fromJson(x))),
      transactionDetails: json["transaction_details"] == null
          ? null
          : TransactionDetails.fromJson(json["transaction_details"]),
      typesOfServiceDetails: json["types_of_service_details"] == null
          ? []
          : List<TypeOfServiceDetailsModel>.from(
              json["types_of_service_details"]
                  .map((x) => TypeOfServiceDetailsModel.fromJson(x))),
      productDetails: json["product_details"] == null
          ? []
          : List<ProductDetailsModel>.from(json["product_details"]
              .map((x) => ProductDetailsModel.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "product_details_by_brand": productDetailsByBrand.isEmpty
            ? null
            : List<dynamic>.from(productDetailsByBrand.map((x) => x)),
        "transaction_details":
            transactionDetails == null ? null : transactionDetails?.toJson(),
        "types_of_service_details": typesOfServiceDetails.isEmpty
            ? null
            : List<dynamic>.from(typesOfServiceDetails.map((x) => x)),
        "product_details": productDetails.isEmpty
            ? null
            : List<dynamic>.from(productDetails.map((x) => x)),
      };
}

class TransactionDetails {
  TransactionDetails({
    this.totalTax,
    this.totalDiscount,
    this.totalSales,
    this.totalShippingCharges,
  });

  dynamic totalTax;
  dynamic totalDiscount;
  dynamic totalSales;
  dynamic totalShippingCharges;

  factory TransactionDetails.fromJson(Map<String, dynamic> json) =>
      TransactionDetails(
        totalTax: json["total_tax"],
        totalDiscount: json["total_discount"],
        totalSales: json["total_sales"],
        totalShippingCharges: json["total_shipping_charges"],
      );

  Map<String, dynamic> toJson() => {
        "total_tax": totalTax,
        "total_discount": totalDiscount,
        "total_sales": totalSales,
        "total_shipping_charges": totalShippingCharges,
      };
}

class PaymentTypesModel {
  PaymentTypesModel({
    this.advance,
    this.cash,
    this.card,
    this.cheque,
    this.bankTransfer,
    this.customPay1,
    this.customPay2,
    this.customPay3,
    this.customPay4,
    this.customPay5,
    this.customPay6,
    this.customPay7,
  });

  String? advance;
  String? cash;
  String? card;
  String? cheque;
  String? bankTransfer;
  String? customPay1;
  String? customPay2;
  String? customPay3;
  String? customPay4;
  String? customPay5;
  String? customPay6;
  String? customPay7;

  factory PaymentTypesModel.fromJson(Map<String, dynamic> json) =>
      PaymentTypesModel(
        advance: json["advance"],
        cash: json["cash"],
        card: json["card"],
        cheque: json["cheque"],
        bankTransfer: json["bank_transfer"],
        customPay1: json["custom_pay_1"],
        customPay2: json["custom_pay_2"],
        customPay3: json["custom_pay_3"],
        customPay4: json["custom_pay_4"],
        customPay5: json["custom_pay_5"],
        customPay6: json["custom_pay_6"],
        customPay7: json["custom_pay_7"],
      );

  Map<String, dynamic> toJson() => {
        "advance": advance,
        "cash": cash,
        "card": card,
        "cheque": cheque,
        "bank_transfer": bankTransfer,
        "custom_pay_1": customPay1,
        "custom_pay_2": customPay2,
        "custom_pay_3": customPay3,
        "custom_pay_4": customPay4,
        "custom_pay_5": customPay5,
        "custom_pay_6": customPay6,
        "custom_pay_7": customPay7,
      };
}

class RegisterDetailsModel {
  RegisterDetailsModel({
    this.openTime,
    this.closedAt,
    this.userId,
    this.closingNote,
    this.locationId,
    this.denominations,
    this.cashInHand,
    this.totalSale,
    this.totalExpense,
    this.totalCash,
    this.totalCashExpense,
    this.totalCheque,
    this.totalChequeExpense,
    this.totalCard,
    this.totalCardExpense,
    this.totalBankTransfer,
    this.totalBankTransferExpense,
    this.totalOther,
    this.totalOtherExpense,
    this.totalAdvance,
    this.totalAdvanceExpense,
    this.totalCustomPay1,
    this.totalCustomPay2,
    this.totalCustomPay3,
    this.totalCustomPay4,
    this.totalCustomPay5,
    this.totalCustomPay6,
    this.totalCustomPay7,
    this.totalCustomPay1Expense,
    this.totalCustomPay2Expense,
    this.totalCustomPay3Expense,
    this.totalCustomPay4Expense,
    this.totalCustomPay5Expense,
    this.totalCustomPay6Expense,
    this.totalCustomPay7Expense,
    this.totalRefund,
    this.totalCashRefund,
    this.totalChequeRefund,
    this.totalCardRefund,
    this.totalBankTransferRefund,
    this.totalOtherRefund,
    this.totalAdvanceRefund,
    this.totalCustomPay1Refund,
    this.totalCustomPay2Refund,
    this.totalCustomPay3Refund,
    this.totalCustomPay4Refund,
    this.totalCustomPay5Refund,
    this.totalCustomPay6Refund,
    this.totalCustomPay7Refund,
    this.totalCheques,
    this.totalCardSlips,
    this.userName,
    this.email,
    this.locationName,
  });

  DateTime? openTime;
  DateTime? closedAt;
  int? userId;
  String? closingNote;
  int? locationId;
  dynamic denominations;
  String? cashInHand;
  String? totalSale;
  String? totalExpense;
  String? totalCash;
  String? totalCashExpense;
  String? totalCheque;
  String? totalChequeExpense;
  String? totalCard;
  String? totalCardExpense;
  String? totalBankTransfer;
  String? totalBankTransferExpense;
  String? totalOther;
  String? totalOtherExpense;
  String? totalAdvance;
  String? totalAdvanceExpense;
  String? totalCustomPay1;
  String? totalCustomPay2;
  String? totalCustomPay3;
  String? totalCustomPay4;
  String? totalCustomPay5;
  String? totalCustomPay6;
  String? totalCustomPay7;
  String? totalCustomPay1Expense;
  String? totalCustomPay2Expense;
  String? totalCustomPay3Expense;
  String? totalCustomPay4Expense;
  String? totalCustomPay5Expense;
  String? totalCustomPay6Expense;
  String? totalCustomPay7Expense;
  String? totalRefund;
  String? totalCashRefund;
  String? totalChequeRefund;
  String? totalCardRefund;
  String? totalBankTransferRefund;
  String? totalOtherRefund;
  String? totalAdvanceRefund;
  String? totalCustomPay1Refund;
  String? totalCustomPay2Refund;
  String? totalCustomPay3Refund;
  String? totalCustomPay4Refund;
  String? totalCustomPay5Refund;
  String? totalCustomPay6Refund;
  String? totalCustomPay7Refund;
  String? totalCheques;
  String? totalCardSlips;
  String? userName;
  String? email;
  String? locationName;

  factory RegisterDetailsModel.fromJson(Map<String, dynamic> json) =>
      RegisterDetailsModel(
        openTime: json["open_time"] == null
            ? null
            : DateTime.tryParse('${json["open_time"]}'),
        closedAt: json["closed_at"] == null
            ? null
            : DateTime.tryParse('${json["closed_at"]}'),
        userId: json["user_id"] == null ? null : json["user_id"],
        closingNote: json["closing_note"],
        locationId: json["location_id"] == null ? null : json["location_id"],
        denominations: json["denominations"],
        cashInHand: json["cash_in_hand"] == null ? null : json["cash_in_hand"],
        totalSale: json["total_sale"] == null ? null : json["total_sale"],
        totalExpense:
            json["total_expense"] == null ? null : json["total_expense"],
        totalCash: json["total_cash"] == null ? null : json["total_cash"],
        totalCashExpense: json["total_cash_expense"] == null
            ? null
            : json["total_cash_expense"],
        totalCheque: json["total_cheque"] == null ? null : json["total_cheque"],
        totalChequeExpense: json["total_cheque_expense"] == null
            ? null
            : json["total_cheque_expense"],
        totalCard: json["total_card"] == null ? null : json["total_card"],
        totalCardExpense: json["total_card_expense"] == null
            ? null
            : json["total_card_expense"],
        totalBankTransfer: json["total_bank_transfer"] == null
            ? null
            : json["total_bank_transfer"],
        totalBankTransferExpense: json["total_bank_transfer_expense"] == null
            ? null
            : json["total_bank_transfer_expense"],
        totalOther: json["total_other"] == null ? null : json["total_other"],
        totalOtherExpense: json["total_other_expense"] == null
            ? null
            : json["total_other_expense"],
        totalAdvance:
            json["total_advance"] == null ? null : json["total_advance"],
        totalAdvanceExpense: json["total_advance_expense"] == null
            ? null
            : json["total_advance_expense"],
        totalCustomPay1: json["total_custom_pay_1"] == null
            ? null
            : json["total_custom_pay_1"],
        totalCustomPay2: json["total_custom_pay_2"] == null
            ? null
            : json["total_custom_pay_2"],
        totalCustomPay3: json["total_custom_pay_3"] == null
            ? null
            : json["total_custom_pay_3"],
        totalCustomPay4: json["total_custom_pay_4"] == null
            ? null
            : json["total_custom_pay_4"],
        totalCustomPay5: json["total_custom_pay_5"] == null
            ? null
            : json["total_custom_pay_5"],
        totalCustomPay6: json["total_custom_pay_6"] == null
            ? null
            : json["total_custom_pay_6"],
        totalCustomPay7: json["total_custom_pay_7"] == null
            ? null
            : json["total_custom_pay_7"],
        totalCustomPay1Expense: json["total_custom_pay_1_expense"] == null
            ? null
            : json["total_custom_pay_1_expense"],
        totalCustomPay2Expense: json["total_custom_pay_2_expense"] == null
            ? null
            : json["total_custom_pay_2_expense"],
        totalCustomPay3Expense: json["total_custom_pay_3_expense"] == null
            ? null
            : json["total_custom_pay_3_expense"],
        totalCustomPay4Expense: json["total_custom_pay_4_expense"] == null
            ? null
            : json["total_custom_pay_4_expense"],
        totalCustomPay5Expense: json["total_custom_pay_5_expense"] == null
            ? null
            : json["total_custom_pay_5_expense"],
        totalCustomPay6Expense: json["total_custom_pay_6_expense"] == null
            ? null
            : json["total_custom_pay_6_expense"],
        totalCustomPay7Expense: json["total_custom_pay_7_expense"] == null
            ? null
            : json["total_custom_pay_7_expense"],
        totalRefund: json["total_refund"] == null ? null : json["total_refund"],
        totalCashRefund: json["total_cash_refund"] == null
            ? null
            : json["total_cash_refund"],
        totalChequeRefund: json["total_cheque_refund"] == null
            ? null
            : json["total_cheque_refund"],
        totalCardRefund: json["total_card_refund"] == null
            ? null
            : json["total_card_refund"],
        totalBankTransferRefund: json["total_bank_transfer_refund"] == null
            ? null
            : json["total_bank_transfer_refund"],
        totalOtherRefund: json["total_other_refund"] == null
            ? null
            : json["total_other_refund"],
        totalAdvanceRefund: json["total_advance_refund"] == null
            ? null
            : json["total_advance_refund"],
        totalCustomPay1Refund: json["total_custom_pay_1_refund"] == null
            ? null
            : json["total_custom_pay_1_refund"],
        totalCustomPay2Refund: json["total_custom_pay_2_refund"] == null
            ? null
            : json["total_custom_pay_2_refund"],
        totalCustomPay3Refund: json["total_custom_pay_3_refund"] == null
            ? null
            : json["total_custom_pay_3_refund"],
        totalCustomPay4Refund: json["total_custom_pay_4_refund"] == null
            ? null
            : json["total_custom_pay_4_refund"],
        totalCustomPay5Refund: json["total_custom_pay_5_refund"] == null
            ? null
            : json["total_custom_pay_5_refund"],
        totalCustomPay6Refund: json["total_custom_pay_6_refund"] == null
            ? null
            : json["total_custom_pay_6_refund"],
        totalCustomPay7Refund: json["total_custom_pay_7_refund"] == null
            ? null
            : json["total_custom_pay_7_refund"],
        totalCheques:
            json["total_cheques"] == null ? null : json["total_cheques"],
        totalCardSlips:
            json["total_card_slips"] == null ? null : json["total_card_slips"],
        userName: json["user_name"] == null ? null : json["user_name"],
        email: json["email"] == null ? null : json["email"],
        locationName:
            json["location_name"] == null ? null : json["location_name"],
      );

  Map<String, dynamic> toJson() => {
        "open_time": openTime == null ? null : openTime?.toIso8601String(),
        "closed_at": closedAt == null ? null : closedAt?.toIso8601String(),
        "user_id": userId == null ? null : userId,
        "closing_note": closingNote,
        "location_id": locationId == null ? null : locationId,
        "denominations": denominations,
        "cash_in_hand": cashInHand == null ? null : cashInHand,
        "total_sale": totalSale == null ? null : totalSale,
        "total_expense": totalExpense == null ? null : totalExpense,
        "total_cash": totalCash == null ? null : totalCash,
        "total_cash_expense":
            totalCashExpense == null ? null : totalCashExpense,
        "total_cheque": totalCheque == null ? null : totalCheque,
        "total_cheque_expense":
            totalChequeExpense == null ? null : totalChequeExpense,
        "total_card": totalCard == null ? null : totalCard,
        "total_card_expense":
            totalCardExpense == null ? null : totalCardExpense,
        "total_bank_transfer":
            totalBankTransfer == null ? null : totalBankTransfer,
        "total_bank_transfer_expense":
            totalBankTransferExpense == null ? null : totalBankTransferExpense,
        "total_other": totalOther == null ? null : totalOther,
        "total_other_expense":
            totalOtherExpense == null ? null : totalOtherExpense,
        "total_advance": totalAdvance == null ? null : totalAdvance,
        "total_advance_expense":
            totalAdvanceExpense == null ? null : totalAdvanceExpense,
        "total_custom_pay_1": totalCustomPay1 == null ? null : totalCustomPay1,
        "total_custom_pay_2": totalCustomPay2 == null ? null : totalCustomPay2,
        "total_custom_pay_3": totalCustomPay3 == null ? null : totalCustomPay3,
        "total_custom_pay_4": totalCustomPay4 == null ? null : totalCustomPay4,
        "total_custom_pay_5": totalCustomPay5 == null ? null : totalCustomPay5,
        "total_custom_pay_6": totalCustomPay6 == null ? null : totalCustomPay6,
        "total_custom_pay_7": totalCustomPay7 == null ? null : totalCustomPay7,
        "total_custom_pay_1_expense":
            totalCustomPay1Expense == null ? null : totalCustomPay1Expense,
        "total_custom_pay_2_expense":
            totalCustomPay2Expense == null ? null : totalCustomPay2Expense,
        "total_custom_pay_3_expense":
            totalCustomPay3Expense == null ? null : totalCustomPay3Expense,
        "total_custom_pay_4_expense":
            totalCustomPay4Expense == null ? null : totalCustomPay4Expense,
        "total_custom_pay_5_expense":
            totalCustomPay5Expense == null ? null : totalCustomPay5Expense,
        "total_custom_pay_6_expense":
            totalCustomPay6Expense == null ? null : totalCustomPay6Expense,
        "total_custom_pay_7_expense":
            totalCustomPay7Expense == null ? null : totalCustomPay7Expense,
        "total_refund": totalRefund == null ? null : totalRefund,
        "total_cash_refund": totalCashRefund == null ? null : totalCashRefund,
        "total_cheque_refund":
            totalChequeRefund == null ? null : totalChequeRefund,
        "total_card_refund": totalCardRefund == null ? null : totalCardRefund,
        "total_bank_transfer_refund":
            totalBankTransferRefund == null ? null : totalBankTransferRefund,
        "total_other_refund":
            totalOtherRefund == null ? null : totalOtherRefund,
        "total_advance_refund":
            totalAdvanceRefund == null ? null : totalAdvanceRefund,
        "total_custom_pay_1_refund":
            totalCustomPay1Refund == null ? null : totalCustomPay1Refund,
        "total_custom_pay_2_refund":
            totalCustomPay2Refund == null ? null : totalCustomPay2Refund,
        "total_custom_pay_3_refund":
            totalCustomPay3Refund == null ? null : totalCustomPay3Refund,
        "total_custom_pay_4_refund":
            totalCustomPay4Refund == null ? null : totalCustomPay4Refund,
        "total_custom_pay_5_refund":
            totalCustomPay5Refund == null ? null : totalCustomPay5Refund,
        "total_custom_pay_6_refund":
            totalCustomPay6Refund == null ? null : totalCustomPay6Refund,
        "total_custom_pay_7_refund":
            totalCustomPay7Refund == null ? null : totalCustomPay7Refund,
        "total_cheques": totalCheques == null ? null : totalCheques,
        "total_card_slips": totalCardSlips == null ? null : totalCardSlips,
        "user_name": userName == null ? null : userName,
        "email": email == null ? null : email,
        "location_name": locationName == null ? null : locationName,
      };
}

class ProductDetailsByBrandModel {
  ProductDetailsByBrandModel({
    this.brandName,
    this.totalQuantity,
    this.totalAmount,
  });

  String? brandName;
  String? totalQuantity;
  String? totalAmount;

  factory ProductDetailsByBrandModel.fromJson(Map<String, dynamic> json) =>
      ProductDetailsByBrandModel(
        brandName: json["brand_name"],
        totalQuantity: json["total_quantity"],
        totalAmount: json["total_amount"] != null
            ? double.parse(json["total_amount"]).toStringAsFixed(2)
            : null,
      );

  Map<String, dynamic> toJson() => {
        "brand_name": brandName,
        "total_quantity": totalQuantity,
        "total_amount": totalAmount,
      };
}

class TypeOfServiceDetailsModel {
  TypeOfServiceDetailsModel({
    this.typeOfService,
    this.totalAmount,
  });

  String? typeOfService;

  String? totalAmount;

  factory TypeOfServiceDetailsModel.fromJson(Map<String, dynamic> json) =>
      TypeOfServiceDetailsModel(
        typeOfService: json["types_of_service_name"],
        totalAmount: json["total_sales"] != null
            ? double.parse(json["total_sales"]).toStringAsFixed(2)
            : null,
      );

  Map<String, dynamic> toJson() => {
        "types_of_service_name": typeOfService,
        "total_sales": totalAmount,
      };
}

class ProductDetailsModel {
  ProductDetailsModel({
    this.productName,
    this.productType,
    this.variationName,
    this.productVariationName,
    this.sku,
    this.totalQuantity,
    this.totalAmount,
  });

  String? productName;
  String? productType;
  String? variationName;
  String? productVariationName;
  String? sku;
  String? totalQuantity;
  String? totalAmount;

  factory ProductDetailsModel.fromJson(Map<String, dynamic> json) =>
      ProductDetailsModel(
        productName: json["product_name"],
        productType: json["product_type"],
        variationName: json["variation_name"],
        productVariationName: json["product_variation_name"],
        sku: json["sku"],
        totalQuantity: json["total_quantity"] != null
            ? double.parse('${json["total_quantity"]}').toInt().toString()
            : null,
        totalAmount: json["total_amount"] != null
            ? double.parse(json["total_amount"]).toStringAsFixed(2)
            : null,
      );

  Map<String, dynamic> toJson() => {
        "product_name": productName,
        "product_type": productType,
        "variation_name": variationName,
        "product_variation_name": productVariationName,
        "sku": sku,
        "total_quantity": totalQuantity,
        "total_amount": totalAmount,
      };
}

class DataHtml {
  DataHtml({
    this.html,
  });

  final String? html;

  factory DataHtml.fromJson(Map<String, dynamic> json) => DataHtml(
        html: json["html"] == null ? null : json["html"],
      );

  Map<String, dynamic> toJson() => {
        "html": html == null ? null : html,
      };
}
