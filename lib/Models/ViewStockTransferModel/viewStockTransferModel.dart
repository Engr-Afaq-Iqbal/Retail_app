// To parse this JSON data, do
//
//     final viewStockTransferModel = viewStockTransferModelFromJson(jsonString);

import 'dart:convert';

ViewStockTransferModel viewStockTransferModelFromJson(String str) =>
    ViewStockTransferModel.fromJson(json.decode(str));

String viewStockTransferModelToJson(ViewStockTransferModel data) =>
    json.encode(data.toJson());

class ViewStockTransferModel {
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

  ViewStockTransferModel({
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

  factory ViewStockTransferModel.fromJson(Map<String, dynamic> json) =>
      ViewStockTransferModel(
        currentPage: json["current_page"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
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
  String locationFrom;
  String locationTo;
  String finalTotal;
  String shippingCharges;
  dynamic additionalNotes;
  int dtRowId;
  String status;

  Datum({
    required this.id,
    required this.transactionDate,
    required this.refNo,
    required this.locationFrom,
    required this.locationTo,
    required this.finalTotal,
    required this.shippingCharges,
    this.additionalNotes,
    required this.dtRowId,
    required this.status,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        transactionDate: DateTime.parse(json["transaction_date"]),
        refNo: json["ref_no"],
        locationFrom: json["location_from"],
        locationTo: json["location_to"],
        finalTotal: json["final_total"],
        shippingCharges: json["shipping_charges"],
        additionalNotes: json["additional_notes"],
        dtRowId: json["DT_RowId"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "transaction_date": transactionDate.toIso8601String(),
        "ref_no": refNo,
        "location_from": locationFrom,
        "location_to": locationTo,
        "final_total": finalTotal,
        "shipping_charges": shippingCharges,
        "additional_notes": additionalNotes,
        "DT_RowId": dtRowId,
        "status": status,
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
