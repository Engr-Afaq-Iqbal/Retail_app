// To parse this JSON data, do
//
//     final showProductListModel = showProductListModelFromJson(jsonString);

import 'dart:convert';

ShowProductListModel showProductListModelFromJson(String str) =>
    ShowProductListModel.fromJson(json.decode(str));

String showProductListModelToJson(ShowProductListModel data) =>
    json.encode(data.toJson());

class ShowProductListModel {
  List<Category>? categories;
  List<Kitchen>? kitchens;
  List<Kitchen>? typeOfProducts;
  List<Brand>? brands;
  List<Category>? units;
  Taxes? taxes;
  List<BarcodeType>? barcodeTypes;
  int? defaultProfitPercent;
  TaxAttributes? taxAttributes;
  String? barcodeDefault;
  Map<String, String>? businessLocations;
  List<dynamic>? subCategories;
  dynamic rackDetails;
  ProductTypes? productTypes;
  CommonSettings? commonSettings;
  List<Kitchen>? warranties;
  PosModuleData? posModuleData;
  dynamic duplicateProduct;
  int? sellingPriceGroupCount;

  ShowProductListModel({
    this.categories,
    this.kitchens,
    this.typeOfProducts,
    this.brands,
    this.units,
    this.taxes,
    this.barcodeTypes,
    this.defaultProfitPercent,
    this.taxAttributes,
    this.barcodeDefault,
    this.businessLocations,
    this.subCategories,
    this.rackDetails,
    this.productTypes,
    this.commonSettings,
    this.warranties,
    this.posModuleData,
    this.duplicateProduct,
    this.sellingPriceGroupCount,
  });

  factory ShowProductListModel.fromJson(Map<String, dynamic> json) =>
      ShowProductListModel(
        categories: json["categories"] == null
            ? []
            : List<Category>.from(
                json["categories"]!.map((x) => Category.fromJson(x))),
        kitchens: json["kitchens"] == null
            ? []
            : List<Kitchen>.from(
                json["kitchens"]!.map((x) => Kitchen.fromJson(x))),
        typeOfProducts: json["type_of_products"] == null
            ? []
            : List<Kitchen>.from(
                json["type_of_products"]!.map((x) => Kitchen.fromJson(x))),
        brands: json["brands"] == null
            ? []
            : List<Brand>.from(json["brands"]!.map((x) => Brand.fromJson(x))),
        units: json["units"] == null
            ? []
            : List<Category>.from(
                json["units"]!.map((x) => Category.fromJson(x))),
        taxes: json["taxes"] == null ? null : Taxes.fromJson(json["taxes"]),
        barcodeTypes: json["barcode_types"] == null
            ? []
            : List<BarcodeType>.from(
                json["barcode_types"]!.map((x) => BarcodeType.fromJson(x))),
        defaultProfitPercent: json["default_profit_percent"],
        taxAttributes: json["tax_attributes"] == null
            ? null
            : TaxAttributes.fromJson(json["tax_attributes"]),
        barcodeDefault: json["barcode_default"],
        businessLocations: Map.from(json["business_locations"]!)
            .map((k, v) => MapEntry<String, String>(k, v)),
        subCategories: json["sub_categories"] == null
            ? []
            : List<dynamic>.from(json["sub_categories"]!.map((x) => x)),
        rackDetails: json["rack_details"],
        productTypes: json["product_types"] == null
            ? null
            : ProductTypes.fromJson(json["product_types"]),
        commonSettings: json["common_settings"] == null
            ? null
            : CommonSettings.fromJson(json["common_settings"]),
        warranties: json["warranties"] == null
            ? []
            : List<Kitchen>.from(
                json["warranties"]!.map((x) => Kitchen.fromJson(x))),
        posModuleData: json["pos_module_data"] == null
            ? null
            : PosModuleData.fromJson(json["pos_module_data"]),
        duplicateProduct: json["duplicate_product"],
        sellingPriceGroupCount: json["selling_price_group_count"],
      );

  Map<String, dynamic> toJson() => {
        "categories": categories == null
            ? []
            : List<dynamic>.from(categories!.map((x) => x.toJson())),
        "kitchens": kitchens == null
            ? []
            : List<dynamic>.from(kitchens!.map((x) => x.toJson())),
        "type_of_products": typeOfProducts == null
            ? []
            : List<dynamic>.from(typeOfProducts!.map((x) => x.toJson())),
        "brands": brands == null
            ? []
            : List<dynamic>.from(brands!.map((x) => x.toJson())),
        "units": units == null
            ? []
            : List<dynamic>.from(units!.map((x) => x.toJson())),
        "taxes": taxes?.toJson(),
        "barcode_types": barcodeTypes == null
            ? []
            : List<dynamic>.from(barcodeTypes!.map((x) => x.toJson())),
        "default_profit_percent": defaultProfitPercent,
        "tax_attributes": taxAttributes?.toJson(),
        "barcode_default": barcodeDefault,
        "business_locations": Map.from(businessLocations!)
            .map((k, v) => MapEntry<String, dynamic>(k, v)),
        "sub_categories": subCategories == null
            ? []
            : List<dynamic>.from(subCategories!.map((x) => x)),
        "rack_details": rackDetails,
        "product_types": productTypes?.toJson(),
        "common_settings": commonSettings?.toJson(),
        "warranties": warranties == null
            ? []
            : List<dynamic>.from(warranties!.map((x) => x.toJson())),
        "pos_module_data": posModuleData?.toJson(),
        "duplicate_product": duplicateProduct,
        "selling_price_group_count": sellingPriceGroupCount,
      };
}

class BarcodeType {
  String? key;
  String? value;

  BarcodeType({
    this.key,
    this.value,
  });

  factory BarcodeType.fromJson(Map<String, dynamic> json) => BarcodeType(
        key: json["key"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "key": key,
        "value": value,
      };
}

class Brand {
  int? id;
  int? businessId;
  String? name;
  dynamic description;
  int? createdBy;
  int? useForRepair;
  dynamic deletedAt;
  DateTime? createdAt;
  DateTime? updatedAt;

  Brand({
    this.id,
    this.businessId,
    this.name,
    this.description,
    this.createdBy,
    this.useForRepair,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory Brand.fromJson(Map<String, dynamic> json) => Brand(
        id: json["id"],
        businessId: json["business_id"],
        name: json["name"],
        description: json["description"],
        createdBy: json["created_by"],
        useForRepair: json["use_for_repair"],
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "business_id": businessId,
        "name": name,
        "description": description,
        "created_by": createdBy,
        "use_for_repair": useForRepair,
        "deleted_at": deletedAt,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class Category {
  String? name;
  int? id;

  Category({
    this.name,
    this.id,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        name: json["name"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
      };
}

class CommonSettings {
  String? enableProductWarranty;
  String? defaultCreditLimit;
  String? enablePurchaseOrder;
  String? defaultDatatablePageEntries;

  CommonSettings({
    this.enableProductWarranty,
    this.defaultCreditLimit,
    this.enablePurchaseOrder,
    this.defaultDatatablePageEntries,
  });

  factory CommonSettings.fromJson(Map<String, dynamic> json) => CommonSettings(
        enableProductWarranty: json["enable_product_warranty"],
        defaultCreditLimit: json["default_credit_limit"],
        enablePurchaseOrder: json["enable_purchase_order"],
        defaultDatatablePageEntries: json["default_datatable_page_entries"],
      );

  Map<String, dynamic> toJson() => {
        "enable_product_warranty": enableProductWarranty,
        "default_credit_limit": defaultCreditLimit,
        "enable_purchase_order": enablePurchaseOrder,
        "default_datatable_page_entries": defaultDatatablePageEntries,
      };
}

class Kitchen {
  int? id;
  int? businessId;
  int? locationId;
  String? name;
  String? description;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic color;
  int? duration;
  String? durationType;

  Kitchen({
    this.id,
    this.businessId,
    this.locationId,
    this.name,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.color,
    this.duration,
    this.durationType,
  });

  factory Kitchen.fromJson(Map<String, dynamic> json) => Kitchen(
        id: json["id"],
        businessId: json["business_id"],
        locationId: json["location_id"],
        name: json["name"],
        description: json["description"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        color: json["color"],
        duration: json["duration"],
        durationType: json["duration_type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "business_id": businessId,
        "location_id": locationId,
        "name": name,
        "description": description,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "color": color,
        "duration": duration,
        "duration_type": durationType,
      };
}

class PosModuleData {
  List<dynamic>? repair;

  PosModuleData({
    this.repair,
  });

  factory PosModuleData.fromJson(Map<String, dynamic> json) => PosModuleData(
        repair: json["Repair"] == null
            ? []
            : List<dynamic>.from(json["Repair"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "Repair":
            repair == null ? [] : List<dynamic>.from(repair!.map((x) => x)),
      };
}

class ProductTypes {
  String? single;
  String? variable;
  String? combo;

  ProductTypes({
    this.single,
    this.variable,
    this.combo,
  });

  factory ProductTypes.fromJson(Map<String, dynamic> json) => ProductTypes(
        single: json["single"],
        variable: json["variable"],
        combo: json["combo"],
      );

  Map<String, dynamic> toJson() => {
        "single": single,
        "variable": variable,
        "combo": combo,
      };
}

class TaxAttributes {
  The13? the13;

  TaxAttributes({
    this.the13,
  });

  factory TaxAttributes.fromJson(Map<String, dynamic> json) => TaxAttributes(
        the13: json["13"] == null ? null : The13.fromJson(json["13"]),
      );

  Map<String, dynamic> toJson() => {
        "13": the13?.toJson(),
      };
}

class The13 {
  int? dataRate;

  The13({
    this.dataRate,
  });

  factory The13.fromJson(Map<String, dynamic> json) => The13(
        dataRate: json["data-rate"],
      );

  Map<String, dynamic> toJson() => {
        "data-rate": dataRate,
      };
}

class Taxes {
  String? the13;
  String? empty;

  Taxes({
    this.the13,
    this.empty,
  });

  factory Taxes.fromJson(Map<String, dynamic> json) => Taxes(
        the13: json["13"],
        empty: json[""],
      );

  Map<String, dynamic> toJson() => {
        "13": the13,
        "": empty,
      };
}
