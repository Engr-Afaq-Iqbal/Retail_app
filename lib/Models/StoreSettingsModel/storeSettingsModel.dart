// To parse this JSON data, do
//
//     final storeSettingsModel = storeSettingsModelFromJson(jsonString);

import 'dart:convert';

StoreSettingsModel storeSettingsModelFromJson(String str) =>
    StoreSettingsModel.fromJson(json.decode(str));

String storeSettingsModelToJson(StoreSettingsModel data) =>
    json.encode(data.toJson());

class StoreSettingsModel {
  bool? success;
  Msg? msg;

  StoreSettingsModel({
    this.success,
    this.msg,
  });

  factory StoreSettingsModel.fromJson(Map<String, dynamic> json) =>
      StoreSettingsModel(
        success: json["success"],
        msg: json["msg"] == null ? null : Msg.fromJson(json["msg"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "msg": msg?.toJson(),
      };
}

class Msg {
  int? id;
  String? themeSelection;
  String? lang;
  String? printerId;
  String? autoPrinter;
  int? userId;
  DateTime? createdAt;
  DateTime? updatedAt;

  Msg({
    this.id,
    this.themeSelection,
    this.lang,
    this.printerId,
    this.autoPrinter,
    this.userId,
    this.createdAt,
    this.updatedAt,
  });

  factory Msg.fromJson(Map<String, dynamic> json) => Msg(
        id: json["id"],
        themeSelection: json["theme_selection"],
        lang: json["lang"],
        printerId: json["printer_id"],
        autoPrinter: json["auto_printer"],
        userId: json["user_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "theme_selection": themeSelection,
        "lang": lang,
        "printer_id": printerId,
        "auto_printer": autoPrinter,
        "user_id": userId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
