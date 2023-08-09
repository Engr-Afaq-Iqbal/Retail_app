import 'ProductModel.dart';

class ModifierModel {
  ModifierModel({
    required this.modifierSetId,
    required this.productId,
    required this.productModifier,
  });

  final int modifierSetId;
  final int productId;
  final ProductModel productModifier;

  ModifierModel copyWith({
    int? modifierSetId,
    int? productId,
    ProductModel? productModifier,
  }) =>
      ModifierModel(
        modifierSetId: modifierSetId ?? this.modifierSetId,
        productId: productId ?? this.productId,
        productModifier: productModifier ?? this.productModifier,
      );

  factory ModifierModel.fromJson(Map<String, dynamic> json) => ModifierModel(
        modifierSetId: json["modifier_set_id"],
        productId: json["product_id"],
        productModifier: ProductModel.fromJson(json["productmodifier"]),
      );

  Map<String, dynamic> toJson() => {
        "modifier_set_id": modifierSetId,
        "product_id": productId,
        "productmodifier": productModifier.toJson(),
      };
}

class ProductVariation {
  ProductVariation({
    required this.id,
    this.variationTemplateId,
    this.name,
    required this.productId,
    this.isDummy,
    this.createdAt,
    this.updatedAt,
    this.variations = const [],
  });

  final int id;
  final dynamic variationTemplateId;
  final String? name;
  final int productId;
  final int? isDummy;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<VariationModels> variations;

  // ProductVariation copyWith({
  //   int id,
  //   dynamic variationTemplateId,
  //   String name,
  //   int productId,
  //   int isDummy,
  //   DateTime createdAt,
  //   DateTime updatedAt,
  //   List<Variation> variations,
  // }) =>
  //     ProductVariation(
  //       id: id ?? this.id,
  //       variationTemplateId: variationTemplateId ?? this.variationTemplateId,
  //       name: name ?? this.name,
  //       productId: productId ?? this.productId,
  //       isDummy: isDummy ?? this.isDummy,
  //       createdAt: createdAt ?? this.createdAt,
  //       updatedAt: updatedAt ?? this.updatedAt,
  //       variations: variations ?? this.variations,
  //     );

  factory ProductVariation.fromJson(Map<String, dynamic> json) =>
      ProductVariation(
        id: json["id"],
        variationTemplateId: json["variation_template_id"],
        name: json["name"],
        productId: json["product_id"],
        isDummy: json["is_dummy"],
        createdAt: DateTime.tryParse('${json["created_at"]}'),
        updatedAt: DateTime.tryParse('${json["updated_at"]}'),
        variations: json["variations"] == null
            ? []
            : List<VariationModels>.from(
                json["variations"].map((x) => VariationModels.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "variation_template_id": variationTemplateId,
        "name": name,
        "product_id": productId,
        "is_dummy": isDummy,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "variations": List<dynamic>.from(variations.map((x) => x.toJson())),
      };
}

class VariationModels {
  final int id;
  final String name;
  int productVariationQuantity;
  final int productId;
  final String subSku;
  final int productVariationId;
  final dynamic variationValueId;
  final String? defaultPurchasePrice;
  final String? dppIncTax;
  final String? profitPercent;
  final String? defaultSellPrice;
  final String? sellPriceIncTax;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;
  final List<dynamic> comboVariations;
  final List<VariationLocationDetail> variationLocationDetails;

  VariationModels({
    required this.id,
    required this.name,
    this.productVariationQuantity = 0,
    required this.productId,
    required this.subSku,
    required this.productVariationId,
    this.variationValueId,
    this.defaultPurchasePrice,
    this.dppIncTax,
    this.profitPercent,
    this.defaultSellPrice,
    this.sellPriceIncTax,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.comboVariations = const [],
    this.variationLocationDetails = const [],
  });

  VariationModels copyWith({
    int? productId,
    int? id,
    String? name,
    String? subSku,
    int? productVariationId,
    int? productVariationQuantity,
    String? defaultPurchasePrice,
    String? dppIncTax,
    String? profitPercent,
    String? defaultSellPrice,
    String? sellPriceIncTax,
  }) =>
      VariationModels(
        productId: productId ?? this.productId,
        id: id ?? this.id,
        name: name ?? this.name,
        subSku: subSku ?? this.subSku,
        productVariationId: productVariationId ?? this.productVariationId,
        defaultPurchasePrice: defaultPurchasePrice ?? this.defaultPurchasePrice,
        productVariationQuantity:
            productVariationQuantity ?? this.productVariationQuantity,
        dppIncTax: dppIncTax ?? this.dppIncTax,
        profitPercent: profitPercent ?? this.profitPercent,
        defaultSellPrice: defaultSellPrice ?? this.defaultSellPrice,
        sellPriceIncTax: sellPriceIncTax ?? this.sellPriceIncTax,
      );

  factory VariationModels.fromJson(Map<String, dynamic> json) =>
      VariationModels(
        productId: json["product_id"],
        id: json["id"],
        name: json["name"] ?? 'Variation Name Missing!',
        subSku: json["sub_sku"],
        productVariationId: json["product_variation_id"],
        variationValueId: json["variation_value_id"],
        defaultPurchasePrice: json["default_purchase_price"],
        dppIncTax: json["dpp_inc_tax"],
        profitPercent: json["profit_percent"],
        defaultSellPrice: json["default_sell_price"],
        sellPriceIncTax: json["sell_price_inc_tax"],
        createdAt: DateTime.tryParse('${json["created_at"]}'),
        updatedAt: DateTime.tryParse('${json["updated_at"]}'),
        deletedAt: DateTime.tryParse('${json["deleted_at"]}'),
        comboVariations: json["combo_variations"] == null
            ? []
            : List<dynamic>.from(json["combo_variations"].map((x) => x)),
        variationLocationDetails: json["variation_location_details"] == null
            ? []
            : List<VariationLocationDetail>.from(
                json["variation_location_details"]
                    .map((x) => VariationLocationDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "product_id": productId,
        "id": id,
        "name": name,
        "sub_sku": subSku,
        "product_variation_id": productVariationId,
        "variation_value_id": variationValueId,
        "default_purchase_price": defaultPurchasePrice,
        "dpp_inc_tax": dppIncTax,
        "profit_percent": profitPercent,
        "default_sell_price": defaultSellPrice,
        "sell_price_inc_tax": sellPriceIncTax,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "deleted_at": deletedAt?.toIso8601String(),
        "combo_variations": comboVariations.isEmpty
            ? null
            : List<dynamic>.from(comboVariations.map((x) => x)),
        "variation_location_details": variationLocationDetails.isEmpty
            ? null
            : List<dynamic>.from(
                variationLocationDetails.map((x) => x.toJson())),
      };
}

class VariationLocationDetail {
  VariationLocationDetail({
    required this.id,
    required this.productId,
    required this.productVariationId,
    required this.variationId,
    this.locationId,
    this.qtyAvailable,
    this.createdAt,
    this.updatedAt,
  });

  final int id;
  final int productId;
  final int productVariationId;
  final int variationId;
  final int? locationId;
  final String? qtyAvailable;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory VariationLocationDetail.fromJson(Map<String, dynamic> json) =>
      VariationLocationDetail(
        id: json["id"],
        productId: json["product_id"],
        productVariationId: json["product_variation_id"],
        variationId: json["variation_id"],
        locationId: json["location_id"],
        qtyAvailable: json["qty_available"],
        createdAt: DateTime.tryParse('${json["created_at"]}'),
        updatedAt: DateTime.tryParse('${json["updated_at"]}'),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "product_variation_id": productVariationId,
        "variation_id": variationId,
        "location_id": locationId,
        "qty_available": qtyAvailable,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
