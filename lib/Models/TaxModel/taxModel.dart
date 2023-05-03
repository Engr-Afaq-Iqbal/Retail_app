// To parse this JSON data, do
//
//     final listTaxModel = listTaxModelFromJson(jsonString);

import 'dart:convert';

ListTaxModel listTaxModelFromJson(String str) =>
    ListTaxModel.fromJson(json.decode(str));

String listTaxModelToJson(ListTaxModel data) => json.encode(data.toJson());

class ListTaxModel {
  ListTaxModel({
    this.data,
  });

  List<Datum>? data;

  factory ListTaxModel.fromJson(Map<String, dynamic> json) => ListTaxModel(
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
  Datum({
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

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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
