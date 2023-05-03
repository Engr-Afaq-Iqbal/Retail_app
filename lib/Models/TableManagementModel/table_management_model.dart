// To parse this JSON data, do
//
//     final tableModel = tableModelFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/material.dart';

import '/Config/enums.dart';
import '/Models/order_type_model/SaleOrderModel.dart';

TableModel tableModelFromJson(String str) =>
    TableModel.fromJson(json.decode(str));

String tableModelToJson(TableModel data) => json.encode(data.toJson());

class TableModel {
  TableModel({
    this.tableData = const [],
  });

  final List<TableDataModel> tableData;

  factory TableModel.fromJson(Map<String, dynamic> json) => TableModel(
        tableData: List<TableDataModel>.from(
            json["data"].map((x) => tableDataModelFromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data":
            List<dynamic>.from(tableData.map((x) => tableDataModelToJson(x))),
      };
}

TableDataModel tableDataModelFromJson(Map<String, dynamic> x) =>
    TableDataModel.fromJson(x);

Map<String, dynamic> tableDataModelToJson(TableDataModel data) => data.toJson();

class TableDataModel {
  TableDataModel({
    required this.id,
    required this.businessId,
    required this.locationId,
    required this.name,
    this.description,
    this.sittingPerson,
    this.status,
    this.bgColor,
    this.numOfPerson,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
    this.order,
    this.startTime,
  });

  late int id;
  late int businessId;
  late int locationId;
  late String name;
  String? description;
  String? sittingPerson;
  TableStatus? status;
  int? bgColor;
  String? numOfPerson;
  int? createdBy;
  DateTime? createdAt;
  DateTime? updatedAt;
  SaleOrderDataModel? order;
  DateTime? startTime;

  TableDataModel copyWith({
    int? id,
    int? businessId,
    int? locationId,
    String? name,
    String? description,
    int? createdBy,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? cStatus,
    int? bgColor,
    String? numOfPerson,
    String? sittingPerson,
    SaleOrderDataModel? order,
    DateTime? startTime,
  }) =>
      TableDataModel(
        id: id ?? this.id,
        businessId: businessId ?? this.businessId,
        locationId: locationId ?? this.locationId,
        name: name ?? this.name,
        description: description ?? this.description,
        createdBy: createdBy ?? this.createdBy,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        status: cStatus != null ? tableStatusValues.map[cStatus] : this.status,
        bgColor: status == TableStatus.BUSY
            ? 0xFFFF0000
            : status == TableStatus.RESERVED
                ? 0xFFFFA500
                : status == TableStatus.FREE
                    ? 0xFFFFFFFF
                    : 0xFFC0C0C0,
        sittingPerson: sittingPerson ?? this.sittingPerson,
        numOfPerson: numOfPerson ?? this.numOfPerson,
        order: order ?? this.order,
        startTime: startTime ?? this.startTime,
      );

  TableDataModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    businessId = json["business_id"];
    locationId = json["location_id"];
    name = json["name"] ?? 'Table ${json["id"]}';
    description = json["description"];
    sittingPerson = json["sitting_person"];
    status = json["status"] == ''
        ? TableStatus.BUSY
        : tableStatusValues.map[json["status"]];
    try {
      bgColor = status == TableStatus.BUSY
          ? 0xFFFF0000
          : status == TableStatus.RESERVED
              ? 0xFFFFA500
              : status == TableStatus.FREE
                  ? 0xFFFFFFFF
                  : 0xFFC0C0C0;
    } catch (e) {
      debugPrint('Error -> TableDataModel -> bgColor : $e');
    }
    numOfPerson = json["number_of_person"];
    createdBy = json["created_by"];
    try {
      createdAt = json["created_at"] != null
          ? DateTime.tryParse(json["created_at"])
          : null;
    } catch (e) {
      debugPrint('Error -> TableDataModel -> createdAt : $e');
    }
    try {
      updatedAt = json["updated_at"] != null
          ? DateTime.tryParse(json["updated_at"])
          : null;
    } catch (e) {
      debugPrint('Error -> TableDataModel -> updateAt : $e');
    }
    try {
      order = json['transactions_order'] != null
          ? saleOrderDataModelFromJson(json['transactions_order'])
          : null;
    } catch (e) {
      debugPrint('Error -> TableDataModel -> order : $e');
    }
    try {
      startTime = json["start_time"] != null
          ? DateTime.tryParse(json["start_time"])
          : null;
    } catch (e) {
      debugPrint('Error -> TableDataModel -> startTime : $e');
    }
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "business_id": businessId,
        "location_id": locationId,
        "name": name,
        "description": description,
        "sitting_person": sittingPerson == null ? null : sittingPerson,
        "status": tableStatusValues.reverse?[status ?? TableStatus.BUSY],
        "number_of_person": numOfPerson == null ? null : numOfPerson,
        "created_by": createdBy,
        "created_at": createdAt == null ? null : createdAt?.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt?.toIso8601String(),
        "transactions_order":
            order == null ? null : saleOrderDataModelToJson(order!),
        "start_time": startTime == null ? null : startTime?.toIso8601String(),
      };
}
