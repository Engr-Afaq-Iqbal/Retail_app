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
  Unit? unit;
  int? unitId;
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
    this.unitId,
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
        unit: unitValues.map[json["unit"]],
        unitId: json["unit_id"],
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
    "unit": unitValues.reverse[unit],
    "unit_id": unitId,
    "image_url": imageUrl,
  };
}

enum Type { COMBO, SINGLE, VARIABLE }

final typeValues = EnumValues(
    {"combo": Type.COMBO, "single": Type.SINGLE, "variable": Type.VARIABLE});

enum Unit { GM, KG, PC_S }

final unitValues =
EnumValues({"gm": Unit.GM, "KG": Unit.KG, "Pc(s)": Unit.PC_S});

enum Variation { BLUE, DUMMY, GREEN, L, M, RED, S, WHITE, XL, XXL, YELLOW }

final variationValues = EnumValues({
  "Blue": Variation.BLUE,
  "DUMMY": Variation.DUMMY,
  "Green": Variation.GREEN,
  "L": Variation.L,
  "M": Variation.M,
  "Red": Variation.RED,
  "S": Variation.S,
  "White": Variation.WHITE,
  "XL": Variation.XL,
  "XXL": Variation.XXL,
  "Yellow": Variation.YELLOW
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
