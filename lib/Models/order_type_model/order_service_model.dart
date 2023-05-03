// To parse this JSON data, do
//
//     final orderServiceDataModel = orderServiceDataModelFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/material.dart';

OrderServiceModel orderServiceModelFromJson(String str) =>
    OrderServiceModel.fromJson(json.decode(str));

String orderServiceModelToJson(OrderServiceModel data) =>
    json.encode(data.toJson());

class OrderServiceModel {
  OrderServiceModel({
    this.orderService = const [],
  });

  final List<OrderServiceDataModel> orderService;

  factory OrderServiceModel.fromJson(Map<String, dynamic> json) =>
      OrderServiceModel(
        orderService: List<OrderServiceDataModel>.from(
          json["data"].map((x) => orderServiceDataModelFromJson(x)),
        ),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(
          orderService.map((x) => orderServiceDataModelToJson(x)),
        ),
      };
}

OrderServiceDataModel orderServiceDataModelFromJson(Map<String, dynamic> str) =>
    OrderServiceDataModel.fromJson(str);

Map<String, dynamic> orderServiceDataModelToJson(OrderServiceDataModel data) =>
    data.toJson();

class OrderServiceDataModel {
  OrderServiceDataModel({
    required this.id,
    this.name,
    this.description,
    this.businessId,
    this.locationPriceGroup,
    this.packingCharge,
    this.packingChargeType,
    this.enableCustomFields,
    this.colorValue,
  });

  late int id;
  String? name;
  String? description;
  int? businessId;
  List? locationPriceGroup;
  String? packingCharge;
  String? packingChargeType;
  int? enableCustomFields;
  int? colorValue;

  // OrderServiceDataModel copyWith({
  //   int? id,
  //   String? name,
  //   String? description,
  //   int? businessId,
  //   Map<String, String>? locationPriceGroup,
  //   String? packingCharge,
  //   String? packingChargeType,
  //   int? enableCustomFields,
  //   DateTime? createdAt,
  //   DateTime? updatedAt,
  //   int? color,
  // }) =>
  //     OrderServiceDataModel(
  //       id: id ?? this.id,
  //       name: name ?? this.name,
  //       description: description ?? this.description,
  //       businessId: businessId ?? this.businessId,
  //       locationPriceGroup: locationPriceGroup ?? this.locationPriceGroup,
  //       packingCharge: packingCharge ?? this.packingCharge,
  //       packingChargeType: packingChargeType ?? this.packingChargeType,
  //       enableCustomFields: enableCustomFields ?? this.enableCustomFields,
  //       createdAt: createdAt ?? this.createdAt,
  //       updatedAt: updatedAt ?? this.updatedAt,
  //       color: color ?? this.color,
  //     );

  OrderServiceDataModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    description = json["description"];
    businessId = json["business_id"];
    try {
      locationPriceGroup = json["location_price_group"] != null
          // ? List.generate(.length, (index) => null)Map.from().map((k, v) => MapEntry<String, String>(k, v))
          ? List.from(json["location_price_group"].map((x) => x))
          : null;
    } catch (_e) {
      debugPrint('Order Type Service Data Model => $_e');
    }
    packingCharge = json["packing_charge"];
    packingChargeType = json["packing_charge_type"];
    enableCustomFields = json["enable_custom_fields"];
    colorValue = (json["color"] != null &&
            json["color"].toString().startsWith('#'))
        ? int.tryParse('${json["color"].toString().replaceAll('#', '0xff')}')
        : null;
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "business_id": businessId,
        "location_price_group": locationPriceGroup != null
            // ? Map.from(locationPriceGroup!).map((k, v) => MapEntry<String, dynamic>(k, v))
            ? List<dynamic>.from(locationPriceGroup!).toList()
            : null,
        "packing_charge": packingCharge,
        "packing_charge_type": packingChargeType,
        "enable_custom_fields": enableCustomFields,
        "color": colorValue.toString(),
      };
}
