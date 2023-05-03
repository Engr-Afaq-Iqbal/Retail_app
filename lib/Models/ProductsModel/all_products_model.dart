// To parse this JSON data, do
//
//     final categoriesProductsModel = categoriesProductsModelFromJson(jsonString);

import 'dart:convert';

import 'ProductModel.dart';

CategoriesProductsModel categoriesProductsModelFromJson(String str) =>
    CategoriesProductsModel.fromJson(json.decode(str));

String categoriesProductsModelToJson(CategoriesProductsModel data) =>
    json.encode(data.toJson());

class CategoriesProductsModel {
  CategoriesProductsModel({
    required this.currentPage,
    this.categories = const [],
    required this.firstPageUrl,
    required this.from,
    required this.lastPage,
    required this.lastPageUrl,
    this.nextPageUrl,
    required this.path,
    required this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  final int currentPage;
  final List<CategoryDataModel> categories;
  final String firstPageUrl;
  final int from;
  final int lastPage;
  final String lastPageUrl;
  final String? nextPageUrl;
  final String path;
  final int perPage;
  final String? prevPageUrl;
  final int? to;
  final int? total;

  factory CategoriesProductsModel.fromJson(Map<String, dynamic> json) =>
      CategoriesProductsModel(
        currentPage: json["current_page"],
        categories: List<CategoryDataModel>.from(
            json["data"].map((x) => CategoryDataModel.fromJson(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": List<dynamic>.from(categories.map((x) => x.toJson())),
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
      };
}

class CategoryDataModel {
  CategoryDataModel({
    required this.id,
    required this.name,
    required this.businessId,
    this.shortCode,
    required this.parentId,
    required this.createdBy,
    required this.categoryType,
    this.description,
    this.slug,
    this.color,
    this.image,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.products = const [],
  });

  final int id;
  final String name;
  final int businessId;
  final dynamic shortCode;
  final int parentId;
  final int createdBy;
  final String categoryType;
  final dynamic description;
  final dynamic slug;
  final dynamic color;
  final dynamic image;
  final DateTime? deletedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<ProductModel> products;

  factory CategoryDataModel.fromJson(Map<String, dynamic> json) =>
      CategoryDataModel(
        id: json["id"],
        name: json["name"],
        businessId: json["business_id"],
        shortCode: json["short_code"],
        parentId: json["parent_id"],
        createdBy: json["created_by"],
        categoryType: json["category_type"],
        description: json["description"],
        slug: json["slug"],
        color: json["color"],
        image: json["image"],
        deletedAt: DateTime.tryParse('${json["deleted_at"]}'),
        createdAt: DateTime.tryParse('${json["created_at"]}'),
        updatedAt: DateTime.tryParse('${json["updated_at"]}'),
        products: List<ProductModel>.from(
            json["products"].map((x) => ProductModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "business_id": businessId,
        "short_code": shortCode,
        "parent_id": parentId,
        "created_by": createdBy,
        "category_type": categoryType,
        "description": description,
        "slug": slug,
        "color": color,
        "image": image,
        "deleted_at": deletedAt,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
      };
}
