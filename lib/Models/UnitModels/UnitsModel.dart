// To parse this JSON data, do
//
//     final unitsModel = unitsModelFromJson(jsonString);

import 'dart:convert';

UnitsModel unitsModelFromJson(String str) =>
    UnitsModel.fromJson(json.decode(str));

String unitsModelToJson(UnitsModel data) => json.encode(data.toJson());

class UnitsModel {
  List<Datum>? data;

  UnitsModel({
    this.data,
  });

  factory UnitsModel.fromJson(Map<String, dynamic> json) => UnitsModel(
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
  String? actualName;
  String? shortName;
  int? allowDecimal;
  int? baseUnitId;
  String? baseUnitMultiplier;
  int? createdBy;
  dynamic deletedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  Datum? baseUnit;

  Datum({
    this.id,
    this.businessId,
    this.actualName,
    this.shortName,
    this.allowDecimal,
    this.baseUnitId,
    this.baseUnitMultiplier,
    this.createdBy,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.baseUnit,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        businessId: json["business_id"],
        actualName: json["actual_name"],
        shortName: json["short_name"],
        allowDecimal: json["allow_decimal"],
        baseUnitId: json["base_unit_id"],
        baseUnitMultiplier: json["base_unit_multiplier"],
        createdBy: json["created_by"],
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        baseUnit: json["base_unit"] == null
            ? null
            : Datum.fromJson(json["base_unit"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "business_id": businessId,
        "actual_name": actualName,
        "short_name": shortName,
        "allow_decimal": allowDecimal,
        "base_unit_id": baseUnitId,
        "base_unit_multiplier": baseUnitMultiplier,
        "created_by": createdBy,
        "deleted_at": deletedAt,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "base_unit": baseUnit?.toJson(),
      };
}
