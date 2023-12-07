// // To parse this JSON data, do
// //
// //     final paymentMethodModel = paymentMethodModelFromJson(jsonString);

// import 'dart:convert';

import '/Config/const.dart';

// PaymentMethodModel paymentMethodModelFromJson(String str) =>
//     PaymentMethodModel.fromJson(json.decode(str));
//
// String paymentMethodModelToJson(PaymentMethodModel data) =>
//     json.encode(data.toJson());
//
// class PaymentMethodModel {
//   PaymentMethodModel({
//     this.account,
//   });
//
//   List<AccountElement>? account;
//
//   factory PaymentMethodModel.fromJson(Map<String, dynamic> json) =>
//       PaymentMethodModel(
//         account: json["account"] == null
//             ? []
//             : List<AccountElement>.from(
//                 json["account"]!.map((x) => AccountElement.fromJson(x))),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "account": account == null
//             ? []
//             : List<dynamic>.from(account!.map((x) => x.toJson())),
//       };
// }
//
// class AccountElement {
//   AccountElement({
//     this.paymentMethod,
//     this.account,
//   });
//
//   String? paymentMethod;
//   AccountAccount? account;
//
//   factory AccountElement.fromJson(Map<String, dynamic> json) => AccountElement(
//         paymentMethod: json["payment_method"],
//         account: json["account"] == null
//             ? null
//             : AccountAccount.fromJson(json["account"]),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "payment_method": paymentMethod,
//         "account": account?.toJson(),
//       };
// }
//
// class AccountAccount {
//   AccountAccount({
//     this.name,
//     this.id,
//     this.balance,
//   });
//
//   String? name;
//   int? id;
//   String? balance;
//
//   factory AccountAccount.fromJson(Map<String, dynamic> json) => AccountAccount(
//         name: json["name"],
//         id: json["id"],
//         balance: json["balance"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "name": name,
//         "id": id,
//         "balance": balance,
//       };
// }

class PaymentAccount {
  PaymentAccount({
    this.paymentMethod,
    this.paymentMethodName,
    this.account,
    this.isEnabled = false,
  });

  String? paymentMethod;
  String? paymentMethodName;
  Account? account;
  bool isEnabled;

  factory PaymentAccount.fromJson(Map<String, dynamic> json) => PaymentAccount(
        paymentMethod: json["payment_method"],
        paymentMethodName: json["payment_method_name"],
        account:
            json["account"] == null ? null : Account.fromJson(json["account"]),
        isEnabled: AppConst.intToBool(json["is_enabled"]) ?? false,
      );

  Map<String, dynamic> toJson() => {
        "payment_method": paymentMethod,
        "payment_method_name": paymentMethodName,
        "account": account?.toJson(),
        "is_enabled": isEnabled,
      };
}

class Account {
  Account({
    this.name,
    this.id,
    this.balance,
  });

  String? name;
  int? id;
  String? balance;

  factory Account.fromJson(Map<String, dynamic> json) => Account(
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
