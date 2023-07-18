// To parse this JSON data, do
//
//     final paymentAccountModel = paymentAccountModelFromJson(jsonString);

import 'dart:convert';

PaymentAccountModel paymentAccountModelFromJson(String str) =>
    PaymentAccountModel.fromJson(json.decode(str));

String paymentAccountModelToJson(PaymentAccountModel data) =>
    json.encode(data.toJson());

class PaymentAccountModel {
  List<Datum>? data;

  PaymentAccountModel({
    this.data,
  });

  factory PaymentAccountModel.fromJson(Map<String, dynamic> json) =>
      PaymentAccountModel(
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
  String? name;
  String? accountNumber;
  List<AccountDetail>? accountDetails;
  int? accountTypeId;
  String? note;
  int? createdBy;
  int? isClosed;
  dynamic deletedAt;
  DateTime? createdAt;
  DateTime? updatedAt;

  Datum({
    this.id,
    this.businessId,
    this.name,
    this.accountNumber,
    this.accountDetails,
    this.accountTypeId,
    this.note,
    this.createdBy,
    this.isClosed,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        businessId: json["business_id"],
        name: json["name"],
        accountNumber: json["account_number"],
        accountDetails: json["account_details"] == null
            ? []
            : List<AccountDetail>.from(
                json["account_details"]!.map((x) => AccountDetail.fromJson(x))),
        accountTypeId: json["account_type_id"],
        note: json["note"],
        createdBy: json["created_by"],
        isClosed: json["is_closed"],
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
        "account_number": accountNumber,
        "account_details": accountDetails == null
            ? []
            : List<dynamic>.from(accountDetails!.map((x) => x.toJson())),
        "account_type_id": accountTypeId,
        "note": note,
        "created_by": createdBy,
        "is_closed": isClosed,
        "deleted_at": deletedAt,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class AccountDetail {
  String? label;
  String? value;

  AccountDetail({
    this.label,
    this.value,
  });

  factory AccountDetail.fromJson(Map<String, dynamic> json) => AccountDetail(
        label: json["label"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "label": label,
        "value": value,
      };
}
