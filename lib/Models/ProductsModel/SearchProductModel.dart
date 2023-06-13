// To parse this JSON data, do
//
//     final searchProductModel = searchProductModelFromJson(jsonString);

import 'dart:convert';

List<SearchProductModel> searchProductModelFromJson(String str) =>
    List<SearchProductModel>.from(
        json.decode(str).map((x) => SearchProductModel.fromJson(x)));

String searchProductModelToJson(List<SearchProductModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SearchProductModel {
  int? productId;
  String? name;
  Type? type;
  int? enableStock;
  int? variationId;
  Variation? variation;
  String? qtyAvailable;
  String? sellingPrice;
  String? subSku;
  String? unit;
  String? imageUrl;

  SearchProductModel({
    this.productId,
    this.name,
    this.type,
    this.enableStock,
    this.variationId,
    this.variation,
    this.qtyAvailable,
    this.sellingPrice,
    this.subSku,
    this.unit,
    this.imageUrl,
  });

  factory SearchProductModel.fromJson(Map<String, dynamic> json) =>
      SearchProductModel(
        productId: json["product_id"],
        name: json["name"],
        type: typeValues.map[json["type"]],
        enableStock: json["enable_stock"],
        variationId: json["variation_id"],
        variation: variationValues.map[json["variation"]],
        qtyAvailable: json["qty_available"],
        sellingPrice: json["selling_price"],
        subSku: json["sub_sku"],
        unit: json["unit"],
        imageUrl: json["image_url"],
      );

  Map<String, dynamic> toJson() => {
        "product_id": productId,
        "name": name,
        "type": typeValues.reverse[type],
        "enable_stock": enableStock,
        "variation_id": variationId,
        "variation": variationValues.reverse[variation],
        "qty_available": qtyAvailable,
        "selling_price": sellingPrice,
        "sub_sku": subSku,
        "unit": unit,
        "image_url": imageUrl,
      };
}

enum Type { SINGLE }

final typeValues = EnumValues({"single": Type.SINGLE});

// enum Unit { PC_S, KG }
//
// final unitValues = EnumValues({"KG": Unit.KG, "Pc(s)": Unit.PC_S});

enum Variation { DUMMY }

final variationValues = EnumValues({"DUMMY": Variation.DUMMY});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
