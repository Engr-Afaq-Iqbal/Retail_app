// To parse this JSON data, do
//
//     final userRegisterDataModel = userRegisterDataModelFromJson(jsonString);

import 'dart:convert';

import '../../Config/utils.dart';

RegisterStatusModel registerStatusModelFromJson(String str) =>
    RegisterStatusModel.fromJson(json.decode(str));

String userRegisterDataModelToJson(RegisterStatusModel data) =>
    json.encode(data.toJson());

class RegisterStatusModel {
  RegisterStatusModel({
    this.registerStatusDataList = const [],
    this.links,
    this.meta,
  });

  List<RegisterStatusDataModel> registerStatusDataList;
  Links? links;
  Meta? meta;

  factory RegisterStatusModel.fromJson(Map<String, dynamic> json) =>
      RegisterStatusModel(
        registerStatusDataList: json["data"] == null
            ? []
            : List<RegisterStatusDataModel>.from(
                json["data"].map((x) => RegisterStatusDataModel.fromJson(x))),
        links: json["links"] == null ? null : Links.fromJson(json["links"]),
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "data": registerStatusDataList.isNotEmpty
            ? null
            : List<dynamic>.from(registerStatusDataList.map((x) => x.toJson())),
        "links": links == null ? null : links?.toJson(),
        "meta": meta == null ? null : meta?.toJson(),
      };
}

class RegisterStatusDataModel {
  RegisterStatusDataModel({
    this.id,
    this.businessId,
    this.locationId,
    this.userId,
    this.status,
    this.closedAt,
    this.closingAmount,
    this.totalCardSlips,
    this.totalCheques,
    this.denominations,
    this.closingNote,
    this.createdAt,
    this.updatedAt,
    this.cashRegisterTransactions = const [],
  });

  int? id;
  int? businessId;
  int? locationId;
  int? userId;
  String? status;
  dynamic closedAt;
  String? closingAmount;
  int? totalCardSlips;
  int? totalCheques;
  dynamic denominations;
  dynamic closingNote;
  DateTime? createdAt;
  DateTime? updatedAt;
  late List<CashRegisterTransaction> cashRegisterTransactions;

  RegisterStatusDataModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    businessId = json["business_id"];
    locationId = json["location_id"];
    userId = json["user_id"];
    status = json["status"];
    closedAt = json["closed_at"];
    closingAmount = json["closing_amount"];
    totalCardSlips = json["total_card_slips"];
    totalCheques = json["total_cheques"];
    denominations = json["denominations"];
    closingNote = json["closing_note"];
    try {
      if (json["created_at"] != null)
        createdAt = DateTime.tryParse(json["created_at"]);
    } catch (e) {
      logger.e(e);
    }
    try {
      if (json["updated_at"] != null)
        updatedAt = DateTime.tryParse(json["updated_at"]);
    } catch (e) {
      logger.e(e);
    }
    try {
      if (json["cash_register_transactions"] != null)
        cashRegisterTransactions = List<CashRegisterTransaction>.from(
            json["cash_register_transactions"]
                .map((x) => CashRegisterTransaction.fromJson(x)));
    } catch (e) {
      logger.e(e);
    }
  }

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "business_id": businessId == null ? null : businessId,
        "location_id": locationId == null ? null : locationId,
        "user_id": userId == null ? null : userId,
        "status": status == null ? null : status,
        "closed_at": closedAt,
        "closing_amount": closingAmount == null ? null : closingAmount,
        "total_card_slips": totalCardSlips == null ? null : totalCardSlips,
        "total_cheques": totalCheques == null ? null : totalCheques,
        "denominations": denominations,
        "closing_note": closingNote,
        "created_at": createdAt == null ? null : createdAt?.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt?.toIso8601String(),
        "cash_register_transactions": cashRegisterTransactions.isEmpty
            ? null
            : List<dynamic>.from(
                cashRegisterTransactions.map((x) => x.toJson())),
      };
}

class CashRegisterTransaction {
  CashRegisterTransaction({
    this.id,
    this.cashRegisterId,
    this.amount,
    this.payMethod,
    this.type,
    this.transactionType,
    this.transactionId,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? cashRegisterId;
  String? amount;
  String? payMethod;
  String? type;
  String? transactionType;
  dynamic transactionId;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory CashRegisterTransaction.fromJson(Map<String, dynamic> json) =>
      CashRegisterTransaction(
        id: json["id"],
        cashRegisterId: json["cash_register_id"],
        amount: json["amount"],
        payMethod: json["pay_method"],
        type: json["type"],
        transactionType: json["transaction_type"],
        transactionId: json["transaction_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.tryParse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.tryParse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "cash_register_id": cashRegisterId == null ? null : cashRegisterId,
        "amount": amount == null ? null : amount,
        "pay_method": payMethod == null ? null : payMethod,
        "type": type == null ? null : type,
        "transaction_type": transactionType == null ? null : transactionType,
        "transaction_id": transactionId,
        "created_at": createdAt == null ? null : createdAt?.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt?.toIso8601String(),
      };
}

class Links {
  Links({
    this.first,
    this.last,
    this.prev,
    this.next,
  });

  String? first;
  String? last;
  dynamic prev;
  dynamic next;

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        first: json["first"] == null ? null : json["first"],
        last: json["last"] == null ? null : json["last"],
        prev: json["prev"],
        next: json["next"],
      );

  Map<String, dynamic> toJson() => {
        "first": first == null ? null : first,
        "last": last == null ? null : last,
        "prev": prev,
        "next": next,
      };
}

class Meta {
  Meta({
    this.currentPage,
    this.from,
    this.lastPage,
    this.path,
    this.perPage,
    this.to,
    this.total,
  });

  int? currentPage;
  int? from;
  int? lastPage;
  String? path;
  int? perPage;
  int? to;
  int? total;

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        currentPage: json["current_page"],
        from: json["from"],
        lastPage: json["last_page"],
        path: json["path"],
        perPage: json["per_page"],
        to: json["to"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage == null ? null : currentPage,
        "from": from == null ? null : from,
        "last_page": lastPage == null ? null : lastPage,
        "path": path == null ? null : path,
        "per_page": perPage == null ? null : perPage,
        "to": to == null ? null : to,
        "total": total == null ? null : total,
      };
}
