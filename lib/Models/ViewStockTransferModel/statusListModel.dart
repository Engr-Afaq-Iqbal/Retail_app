// To parse this JSON data, do
//
//     final statusListModel = statusListModelFromJson(jsonString);

import 'dart:convert';

List<StatusListModel> statusListModelFromJson(String str) =>
    List<StatusListModel>.from(
        json.decode(str).map((x) => StatusListModel.fromJson(x)));

String statusListModelToJson(List<StatusListModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StatusListModel {
  String? key;
  String? value;

  StatusListModel({
    this.key,
    this.value,
  });

  factory StatusListModel.fromJson(Map<String, dynamic> json) =>
      StatusListModel(
        key: json["key"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "key": key,
        "value": value,
      };
}
