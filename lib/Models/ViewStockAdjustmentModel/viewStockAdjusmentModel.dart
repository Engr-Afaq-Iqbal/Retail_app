// To parse this JSON data, do
//
//     final viewStockAdjustmentModel = viewStockAdjustmentModelFromJson(jsonString);

import 'dart:convert';

ViewStockAdjustmentModel viewStockAdjustmentModelFromJson(String str) =>
    ViewStockAdjustmentModel.fromJson(json.decode(str));

String viewStockAdjustmentModelToJson(ViewStockAdjustmentModel data) =>
    json.encode(data.toJson());

class ViewStockAdjustmentModel {
  int currentPage;
  List<Datum> data;
  String firstPageUrl;
  int from;
  int lastPage;
  String lastPageUrl;
  List<Link> links;
  dynamic nextPageUrl;
  String path;
  int perPage;
  dynamic prevPageUrl;
  int to;
  int total;

  ViewStockAdjustmentModel({
    required this.currentPage,
    required this.data,
    required this.firstPageUrl,
    required this.from,
    required this.lastPage,
    required this.lastPageUrl,
    required this.links,
    this.nextPageUrl,
    required this.path,
    required this.perPage,
    this.prevPageUrl,
    required this.to,
    required this.total,
  });

  factory ViewStockAdjustmentModel.fromJson(Map<String, dynamic> json) =>
      ViewStockAdjustmentModel(
        currentPage: json["current_page"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"] ?? 0,
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"] ?? 0,
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "links": List<dynamic>.from(links.map((x) => x.toJson())),
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
      };
}

class Datum {
  int id;
  DateTime transactionDate;
  String refNo;
  String locationName;
  String adjustmentType;
  String finalTotal;
  String totalAmountRecovered;
  dynamic additionalNotes;
  int dtRowId;
  String addedBy;

  Datum({
    required this.id,
    required this.transactionDate,
    required this.refNo,
    required this.locationName,
    required this.adjustmentType,
    required this.finalTotal,
    required this.totalAmountRecovered,
    this.additionalNotes,
    required this.dtRowId,
    required this.addedBy,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"] != null ? json["id"] : '',
        transactionDate: DateTime.parse(
            json["transaction_date"] != null ? json["transaction_date"] : ''),
        refNo: json["ref_no"] != null ? json["ref_no"] : '',
        locationName:
            json["location_name"] != null ? json["location_name"] : '',
        adjustmentType:
            json["adjustment_type"] != null ? json["adjustment_type"] : '',
        finalTotal: json["final_total"] != null ? json["final_total"] : '',
        totalAmountRecovered: json["total_amount_recovered"] != null
            ? json["total_amount_recovered"]
            : '',
        additionalNotes:
            json["additional_notes"] != null ? json["additional_notes"] : '',
        dtRowId: json["DT_RowId"] != null ? json["DT_RowId"] : '',
        addedBy: json["added_by"] != null ? json["added_by"] : '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "transaction_date": transactionDate.toIso8601String(),
        "ref_no": refNo,
        "location_name": locationName,
        "adjustment_type": adjustmentType,
        "final_total": finalTotal,
        "total_amount_recovered": totalAmountRecovered,
        "additional_notes": additionalNotes,
        "DT_RowId": dtRowId,
        "added_by": addedBy,
      };
}

class Link {
  String? url;
  String label;
  bool active;

  Link({
    this.url,
    required this.label,
    required this.active,
  });

  factory Link.fromJson(Map<String, dynamic> json) => Link(
        url: json["url"],
        label: json["label"],
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "label": label,
        "active": active,
      };
}
