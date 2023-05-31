// To parse this JSON data, do
//
//     final listQuotationModel = listQuotationModelFromJson(jsonString);

import 'dart:convert';

ListQuotationModel listQuotationModelFromJson(String str) =>
    ListQuotationModel.fromJson(json.decode(str));

String listQuotationModelToJson(ListQuotationModel data) =>
    json.encode(data.toJson());

class ListQuotationModel {
  int? currentPage;
  List<Datum>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Link>? links;
  dynamic nextPageUrl;
  String? path;
  int? perPage;
  dynamic prevPageUrl;
  int? to;
  int? total;

  ListQuotationModel({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  factory ListQuotationModel.fromJson(Map<String, dynamic> json) =>
      ListQuotationModel(
        currentPage: json["current_page"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        links: json["links"] == null
            ? []
            : List<Link>.from(json["links"]!.map((x) => Link.fromJson(x))),
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "links": links == null
            ? []
            : List<dynamic>.from(links!.map((x) => x.toJson())),
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
      };
}

class Datum {
  int? id;
  DateTime? transactionDate;
  String? invoiceNo;
  String? name;
  String? mobile;
  dynamic supplierBusinessName;
  String? businessLocation;
  int? isDirectSale;
  String? subStatus;
  int? totalItems;
  String? totalQuantity;
  String? addedBy;
  int? isExport;
  dynamic woocommerceOrderId;

  Datum({
    this.id,
    this.transactionDate,
    this.invoiceNo,
    this.name,
    this.mobile,
    this.supplierBusinessName,
    this.businessLocation,
    this.isDirectSale,
    this.subStatus,
    this.totalItems,
    this.totalQuantity,
    this.addedBy,
    this.isExport,
    this.woocommerceOrderId,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        transactionDate: json["transaction_date"] == null
            ? null
            : DateTime.parse(json["transaction_date"]),
        invoiceNo: json["invoice_no"],
        name: json["name"],
        mobile: json["mobile"],
        supplierBusinessName: json["supplier_business_name"],
        businessLocation: json["business_location"],
        isDirectSale: json["is_direct_sale"],
        subStatus: json["sub_status"],
        totalItems: json["total_items"],
        totalQuantity: json["total_quantity"],
        addedBy: json["added_by"],
        isExport: json["is_export"],
        woocommerceOrderId: json["woocommerce_order_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "transaction_date": transactionDate?.toIso8601String(),
        "invoice_no": invoiceNo,
        "name": name,
        "mobile": mobile,
        "supplier_business_name": supplierBusinessName,
        "business_location": businessLocation,
        "is_direct_sale": isDirectSale,
        "sub_status": subStatus,
        "total_items": totalItems,
        "total_quantity": totalQuantity,
        "added_by": addedBy,
        "is_export": isExport,
        "woocommerce_order_id": woocommerceOrderId,
      };
}

class Link {
  String? url;
  String? label;
  bool? active;

  Link({
    this.url,
    this.label,
    this.active,
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
