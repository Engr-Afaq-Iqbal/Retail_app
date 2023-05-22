// To parse this JSON data, do
//
//     final saleReturnListModel = saleReturnListModelFromJson(jsonString);

import 'dart:convert';

SaleReturnListModel saleReturnListModelFromJson(String str) =>
    SaleReturnListModel.fromJson(json.decode(str));

String saleReturnListModelToJson(SaleReturnListModel data) =>
    json.encode(data.toJson());

class SaleReturnListModel {
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

  SaleReturnListModel({
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

  factory SaleReturnListModel.fromJson(Map<String, dynamic> json) =>
      SaleReturnListModel(
        currentPage: json["current_page"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        firstPageUrl: json["first_page_url"],
        from: int.tryParse('${json["from"]}'),
        lastPage: int.tryParse('${json["last_page"]}'),
        lastPageUrl: json["last_page_url"],
        links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: int.tryParse('${json["per_page"]}'),
        prevPageUrl: json["prev_page_url"],
        to: int.tryParse('${json["to"]}'),
        total: int.tryParse('${json["total"]}'),
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
  int id;
  DateTime transactionDate;
  String invoiceNo;
  String name;
  dynamic supplierBusinessName;
  String finalTotal;
  String paymentStatus;
  String businessLocation;
  String parentSale;
  int parentSaleId;
  dynamic amountPaid;
  double due;

  Datum({
    required this.id,
    required this.transactionDate,
    required this.invoiceNo,
    required this.name,
    this.supplierBusinessName,
    required this.finalTotal,
    required this.paymentStatus,
    required this.businessLocation,
    required this.parentSale,
    required this.parentSaleId,
    this.amountPaid,
    required this.due,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        transactionDate: DateTime.parse(json["transaction_date"]),
        invoiceNo: json["invoice_no"],
        name: json["name"],
        supplierBusinessName: json["supplier_business_name"],
        finalTotal: json["final_total"],
        paymentStatus: json["payment_status"],
        businessLocation: json["business_location"],
        parentSale: json["parent_sale"],
        parentSaleId: json["parent_sale_id"],
        amountPaid: json["amount_paid"],
        due: json["due"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "transaction_date": transactionDate.toIso8601String(),
        "invoice_no": invoiceNo,
        "name": name,
        "supplier_business_name": supplierBusinessName,
        "final_total": finalTotal,
        "payment_status": paymentStatus,
        "business_location": businessLocation,
        "parent_sale": parentSale,
        "parent_sale_id": parentSaleId,
        "amount_paid": amountPaid,
        "due": due,
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
