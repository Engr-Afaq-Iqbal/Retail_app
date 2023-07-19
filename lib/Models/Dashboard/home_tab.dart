// To parse this JSON data, do
//
//     final homeTabModel = homeTabModelFromJson(jsonString);

import 'dart:convert';

HomeTabModel homeTabModelFromJson(String str) =>
    HomeTabModel.fromJson(json.decode(str));

String homeTabModelToJson(HomeTabModel data) => json.encode(data.toJson());

class HomeTabModel {
  String totalPurchaseIncTax;
  String totalPurchaseExcTax;
  double purchaseDue;
  String totalShippingCharges;
  String totalAdditionalExpense;
  String totalPurchase;
  String totalPurchaseReturn;
  int totalPurchaseReturnPaid;
  String totalSellReturnPaid;
  String totalSell;
  String totalSellReturn;
  double invoiceDue;
  double totalExpense;
  double net;

  HomeTabModel({
    required this.totalPurchaseIncTax,
    required this.totalPurchaseExcTax,
    required this.purchaseDue,
    required this.totalShippingCharges,
    required this.totalAdditionalExpense,
    required this.totalPurchase,
    required this.totalPurchaseReturn,
    required this.totalPurchaseReturnPaid,
    required this.totalSellReturnPaid,
    required this.totalSell,
    required this.totalSellReturn,
    required this.invoiceDue,
    required this.totalExpense,
    required this.net,
  });

  factory HomeTabModel.fromJson(Map<String, dynamic> json) => HomeTabModel(
        totalPurchaseIncTax: json["total_purchase_inc_tax"] != null
            ? '${json["total_purchase_inc_tax"]}'
            : '',
        totalPurchaseExcTax: json["total_purchase_exc_tax"] != null
            ? '${json["total_purchase_exc_tax"]}'
            : '',
        purchaseDue: json["purchase_due"]?.toDouble(),
        totalShippingCharges: json["total_shipping_charges"] != null
            ? '${json["total_shipping_charges"]}'
            : '',
        totalAdditionalExpense: json["total_additional_expense"] != null
            ? '${json["total_additional_expense"]}'
            : '',
        totalPurchase:
            json["total_purchase"] != null ? '${json["total_purchase"]}' : '',
        totalPurchaseReturn: json["total_purchase_return"] != null
            ? '${json["total_purchase_return"]}'
            : '0.00',
        totalPurchaseReturnPaid: json["total_purchase_return_paid"] != null
            ? json["total_purchase_return_paid"]
            : '',
        totalSellReturnPaid: json["total_sell_return_paid"] != null
            ? '${json["total_sell_return_paid"]}'
            : '',
        totalSell: json["total_sell"] != null ? '${json["total_sell"]}' : '',
        totalSellReturn: json["total_sell_return"] != null
            ? '${json["total_sell_return"]}'
            : '',
        invoiceDue: json["invoice_due"]?.toDouble(),
        totalExpense: json["total_expense"]?.toDouble(),
        net: json["net"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "total_purchase_inc_tax": totalPurchaseIncTax,
        "total_purchase_exc_tax": totalPurchaseExcTax,
        "purchase_due": purchaseDue,
        "total_shipping_charges": totalShippingCharges,
        "total_additional_expense": totalAdditionalExpense,
        "total_purchase": totalPurchase,
        "total_purchase_return": totalPurchaseReturn,
        "total_purchase_return_paid": totalPurchaseReturnPaid,
        "total_sell_return_paid": totalSellReturnPaid,
        "total_sell": totalSell,
        "total_sell_return": totalSellReturn,
        "invoice_due": invoiceDue,
        "total_expense": totalExpense,
        "net": net,
      };
}
