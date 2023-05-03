// To parse this JSON data, do
//
//     final createContactResponseModel = createContactResponseModelFromJson(jsonString);

import 'dart:convert';

CreateContactResponseModel createContactResponseModelFromJson(String str) =>
    CreateContactResponseModel.fromJson(json.decode(str));

String createContactResponseModelToJson(CreateContactResponseModel data) =>
    json.encode(data.toJson());

class CreateContactResponseModel {
  CreateContactResponseModel({
    required this.data,
  });

  final CreateContactModel data;

  factory CreateContactResponseModel.fromJson(Map<String, dynamic> json) =>
      CreateContactResponseModel(
        data: CreateContactModel.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class CreateContactModel {
  CreateContactModel({
    required this.id,
    this.type,
    this.firstName,
    required this.mobile,
    required this.businessId,
    this.createdBy,
    this.creditLimit,
    required this.name,
    required this.contactId,
  });

  final int id;
  final String? type;
  final String? firstName;
  final String mobile;
  final int businessId;
  final int? createdBy;
  final dynamic creditLimit;
  final String name;
  final String contactId;

  factory CreateContactModel.fromJson(Map<String, dynamic> json) =>
      CreateContactModel(
        id: json["id"],
        type: json["type"],
        firstName: json["first_name"],
        mobile: json["mobile"],
        businessId: json["business_id"],
        createdBy: json["created_by"],
        creditLimit: json["credit_limit"],
        name: json["name"],
        contactId: json["contact_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "first_name": firstName,
        "mobile": mobile,
        "business_id": businessId,
        "created_by": createdBy,
        "credit_limit": creditLimit,
        "name": name,
        "contact_id": contactId,
      };
}
