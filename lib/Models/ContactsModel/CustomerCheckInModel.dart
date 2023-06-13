// To parse this JSON data, do
//
//     final customerCheckInModel = customerCheckInModelFromJson(jsonString);

import 'dart:convert';

CustomerCheckInModel customerCheckInModelFromJson(String str) =>
    CustomerCheckInModel.fromJson(json.decode(str));

String customerCheckInModelToJson(CustomerCheckInModel data) =>
    json.encode(data.toJson());

class CustomerCheckInModel {
  String? contactId;
  String? contactStatus;
  DateTime? updatedAt;
  DateTime? createdAt;
  int? id;

  CustomerCheckInModel({
    this.contactId,
    this.contactStatus,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  factory CustomerCheckInModel.fromJson(Map<String, dynamic> json) =>
      CustomerCheckInModel(
        contactId: json["contact_id"],
        contactStatus: json["contact_status"],
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "contact_id": contactId,
        "contact_status": contactStatus,
        "updated_at": updatedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "id": id,
      };
}
