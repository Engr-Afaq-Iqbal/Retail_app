// To parse this JSON data, do
//
//     final customerCheckOutModel = customerCheckOutModelFromJson(jsonString);

import 'dart:convert';

CustomerCheckOutModel customerCheckOutModelFromJson(String str) =>
    CustomerCheckOutModel.fromJson(json.decode(str));

String customerCheckOutModelToJson(CustomerCheckOutModel data) =>
    json.encode(data.toJson());

class CustomerCheckOutModel {
  int? id;
  int? contactId;
  String? contactStatus;
  DateTime? createdAt;
  DateTime? updatedAt;

  CustomerCheckOutModel({
    this.id,
    this.contactId,
    this.contactStatus,
    this.createdAt,
    this.updatedAt,
  });

  factory CustomerCheckOutModel.fromJson(Map<String, dynamic> json) =>
      CustomerCheckOutModel(
        id: json["id"],
        contactId: json["contact_id"],
        contactStatus: json["contact_status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "contact_id": contactId,
        "contact_status": contactStatus,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
