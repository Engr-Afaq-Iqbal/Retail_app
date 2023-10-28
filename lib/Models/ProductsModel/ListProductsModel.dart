// To parse this JSON data, do
//
//     final listProductsModel = listProductsModelFromJson(jsonString);

import 'dart:convert';
import '../../Models/ProductsModel/product.dart';

ListProductsModel listProductsModelFromJson(String str) =>
    ListProductsModel.fromJson(json.decode(str));

String listProductsModelToJson(ListProductsModel data) =>
    json.encode(data.toJson());

class ListProductsModel {
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

  ListProductsModel({
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

  factory ListProductsModel.fromJson(Map<String, dynamic> json) =>
      ListProductsModel(
        currentPage: json["current_page"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
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
  String? name;
  int? businessId;
  String? shortCode;
  int? parentId;
  int? createdBy;
  dynamic woocommerceCatId;
  CategoryType? categoryType;
  dynamic description;
  dynamic slug;
  dynamic deletedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  Color? color;
  String? image;
  dynamic standardPurity;
  List<Product>? products;

  Datum({
    this.id,
    this.name,
    this.businessId,
    this.shortCode,
    this.parentId,
    this.createdBy,
    this.woocommerceCatId,
    this.categoryType,
    this.description,
    this.slug,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.color,
    this.image,
    this.standardPurity,
    this.products,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    name: json["name"],
    businessId: json["business_id"],
    shortCode: json["short_code"],
    parentId: json["parent_id"],
    createdBy: json["created_by"],
    woocommerceCatId: json["woocommerce_cat_id"],
    categoryType: categoryTypeValues.map[json["category_type"]],
    description: json["description"],
    slug: json["slug"],
    deletedAt: json["deleted_at"],
    createdAt: json["created_at"] == null
        ? null
        : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null
        ? null
        : DateTime.parse(json["updated_at"]),
    color: colorValues.map[json["color"]],
    image: json["image"],
    standardPurity: json["standard_purity"],
    products: json["products"] == null
        ? []
        : List<Product>.from(
        json["products"].map((x) => Product.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "business_id": businessId,
    "short_code": shortCode,
    "parent_id": parentId,
    "created_by": createdBy,
    "woocommerce_cat_id": woocommerceCatId,
    "category_type": categoryTypeValues.reverse[categoryType],
    "description": description,
    "slug": slug,
    "deleted_at": deletedAt,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "color": colorValues.reverse[color],
    "image": image,
    "standard_purity": standardPurity,
    "products": products == null
        ? []
        : List<dynamic>.from(products!.map((x) => x.toJson())),
  };
}

enum CategoryType { PRODUCT }

final categoryTypeValues = EnumValues({"product": CategoryType.PRODUCT});

enum Color { THE_000000, THE_7_EB814 }

final colorValues =
EnumValues({"#000000": Color.THE_000000, "#7eb814": Color.THE_7_EB814});

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

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
