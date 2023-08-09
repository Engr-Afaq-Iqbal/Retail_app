import '/Config/enums.dart';
import 'ProductTaxModel.dart';
import 'ProductVariationAndModifierModel.dart';

ProductModel productModelFromJson(Map<String, dynamic> src) =>
    ProductModel.fromJson(src);

Map<String, dynamic> productModelToJson(ProductModel data) => data.toJson();

class ProductModel {
  ProductModel({
    required this.id,
    required this.name,
    this.quantity = 0,
    this.productTotalPrice = 0.0,
    required this.businessId,
    required this.type,
    this.unitId,
    this.secondaryUnitId,
    this.subUnitIds,
    this.brandId,
    this.categoryId,
    this.subCategoryId,
    this.tax,
    this.taxType,
    this.enableStock,
    this.alertQuantity,
    this.sku,
    this.barcodeType,
    this.expiryPeriod,
    this.expiryPeriodType,
    this.enableSrNo,
    this.weight,
    this.productCustomField1,
    this.productCustomField2,
    this.productCustomField3,
    this.productCustomField4,
    this.image,
    this.productDescription,
    this.createdBy,
    this.warrantyId,
    this.isInactive,
    this.notForSelling,
    this.createdAt,
    this.updatedAt,
    this.imageUrl,
    this.productVariations = const [],
    this.productTax,
    this.brand,
    this.modifier = const [],
    this.modifierSets = const [],
    this.variations = const [],
    this.typeOfProduct,
  });

  ProductModel copyWith({
    int? id,
    String? name,
    int? quantity,
    double? productTotalPrice,
    int? businessId,
    String? type,
    int? unitId,
    int? secondaryUnitId,
    dynamic subUnitIds,
    int? brandId,
    int? categoryId,
    int? subCategoryId,
    int? tax,
    TaxType? taxType,
    int? enableStock,
    String? alertQuantity,
    String? sku,
    String? barcodeType,
    dynamic expiryPeriod,
    dynamic expiryPeriodType,
    int? enableSrNo,
    String? weight,
    String? productCustomField1,
    String? productCustomField2,
    String? productCustomField3,
    String? productCustomField4,
    String? image,
    String? productDescription,
    int? createdBy,
    dynamic warrantyId,
    int? isInactive,
    int? notForSelling,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? imageUrl,
    List<ProductVariation>? productVariations,
    ProductTaxModel? productTax,
    dynamic brand,
    List<ModifierModel>? modifier,
    List<ProductModel>? modifierSets,
    List<VariationModels>? variations,
    Kitchen? typeOfProduct,
  }) =>
      ProductModel(
          id: id ?? this.id,
          name: name ?? this.name,
          quantity: quantity ?? this.quantity,
          productTotalPrice: productTotalPrice ?? this.productTotalPrice,
          businessId: businessId ?? this.businessId,
          type: type ?? this.type,
          unitId: unitId ?? this.unitId,
          secondaryUnitId: secondaryUnitId ?? this.secondaryUnitId,
          subUnitIds: subUnitIds ?? this.subUnitIds,
          brandId: brandId ?? this.brandId,
          categoryId: categoryId ?? this.categoryId,
          subCategoryId: subCategoryId ?? this.subCategoryId,
          tax: tax ?? this.tax,
          taxType: taxType ?? this.taxType,
          enableStock: enableStock ?? this.enableStock,
          alertQuantity: alertQuantity ?? this.alertQuantity,
          sku: sku ?? this.sku,
          barcodeType: barcodeType ?? this.barcodeType,
          expiryPeriod: expiryPeriod ?? this.expiryPeriod,
          expiryPeriodType: expiryPeriodType ?? this.expiryPeriodType,
          enableSrNo: enableSrNo ?? this.enableSrNo,
          weight: weight ?? this.weight,
          productCustomField1: productCustomField1 ?? this.productCustomField1,
          productCustomField2: productCustomField2 ?? this.productCustomField2,
          productCustomField3: productCustomField3 ?? this.productCustomField3,
          productCustomField4: productCustomField4 ?? this.productCustomField4,
          image: image ?? this.image,
          productDescription: productDescription ?? this.productDescription,
          createdBy: createdBy ?? this.createdBy,
          warrantyId: warrantyId ?? this.warrantyId,
          isInactive: isInactive ?? this.isInactive,
          notForSelling: notForSelling ?? this.notForSelling,
          createdAt: createdAt ?? this.createdAt,
          updatedAt: updatedAt ?? this.updatedAt,
          imageUrl: imageUrl ?? this.imageUrl,
          productVariations: productVariations ?? this.productVariations,
          productTax: productTax ?? this.productTax,
          brand: brand ?? this.brand,
          modifier: modifier ?? this.modifier,
          modifierSets: modifierSets ?? this.modifierSets,
          variations: variations ?? this.variations,
          typeOfProduct: typeOfProduct ?? this.typeOfProduct);

  final int id;
  final String name;
  int quantity;
  double productTotalPrice;
  final int businessId;
  final String type;
  final int? unitId;
  final int? secondaryUnitId;
  final dynamic subUnitIds;
  final int? brandId;
  final int? categoryId;
  final int? subCategoryId;
  final int? tax;
  final TaxType? taxType;
  final int? enableStock;
  final String? alertQuantity;
  final String? sku;
  final String? barcodeType;
  final dynamic expiryPeriod;
  final dynamic expiryPeriodType;
  final int? enableSrNo;
  final String? weight;
  final String? productCustomField1;
  final String? productCustomField2;
  final String? productCustomField3;
  final String? productCustomField4;
  final String? image;
  final String? productDescription;
  final int? createdBy;
  final dynamic warrantyId;
  final int? isInactive;
  final int? notForSelling;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? imageUrl;
  final List<ProductVariation> productVariations;
  final ProductTaxModel? productTax;
  final dynamic brand;
  final List<ModifierModel> modifier;
  final List<ProductModel> modifierSets;
  final List<VariationModels> variations;
  final Kitchen? typeOfProduct;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        name: json["name"],
        businessId: json["business_id"],
        type: json["type"],
        unitId: json["unit_id"],
        secondaryUnitId: json["secondary_unit_id"],
        subUnitIds: json["sub_unit_ids"],
        brandId: json["brand_id"],
        categoryId: json["category_id"],
        subCategoryId: json["sub_category_id"],
        tax: json["tax"],
        taxType: taxTypeValues.map[json["tax_type"]],
        enableStock: json["enable_stock"],
        alertQuantity: json["alert_quantity"],
        sku: json["sku"],
        barcodeType: json["barcode_type"],
        expiryPeriod: json["expiry_period"],
        expiryPeriodType: json["expiry_period_type"],
        enableSrNo: json["enable_sr_no"],
        weight: json["weight"],
        productCustomField1: json["product_custom_field1"],
        productCustomField2: json["product_custom_field2"],
        productCustomField3: json["product_custom_field3"],
        productCustomField4: json["product_custom_field4"],
        image: json["image"],
        productDescription: json["product_description"],
        createdBy: json["created_by"],
        warrantyId: json["warranty_id"],
        isInactive: json["is_inactive"],
        notForSelling: json["not_for_selling"],
        createdAt: json["created_at"] != null
            ? DateTime.tryParse('${json["created_at"]}')
            : null,
        updatedAt: json["updated_at"] != null
            ? DateTime.tryParse('${json["updated_at"]}')
            : null,
        imageUrl: json["image_url"],
        productVariations: json["product_variations"] == null
            ? []
            : List<ProductVariation>.from(json["product_variations"]
                .map((x) => ProductVariation.fromJson(x))),
        productTax: json["product_tax"] == null
            ? null
            : productTaxModelFromJson(json["product_tax"]),
        brand: json["brand"],
        modifier: json["modifier"] == null
            ? []
            : List<ModifierModel>.from(
                json["modifier"].map((x) => ModifierModel.fromJson(x))),
        modifierSets: json["modifier_sets"] == null
            ? []
            : List<ProductModel>.from(
                json["modifier_sets"].map((x) => ProductModel.fromJson(x))),
        variations: json["variations"] == null
            ? []
            : List<VariationModels>.from(
                json["variations"].map((x) => VariationModels.fromJson(x))),
        typeOfProduct: json["type_of_product"] == null
            ? null
            : Kitchen.fromJson(json["type_of_product"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "business_id": businessId,
        "type": type,
        "unit_id": unitId,
        "secondary_unit_id": secondaryUnitId,
        "sub_unit_ids": subUnitIds,
        "brand_id": brandId,
        "category_id": categoryId,
        "sub_category_id": subCategoryId,
        "tax": tax,
        "tax_type": taxTypeValues.reverse?[taxType],
        "enable_stock": enableStock,
        "alert_quantity": alertQuantity,
        "sku": sku,
        "barcode_type": barcodeType,
        "expiry_period": expiryPeriod,
        "expiry_period_type": expiryPeriodType,
        "enable_sr_no": enableSrNo,
        "weight": weight,
        "product_custom_field1": productCustomField1,
        "product_custom_field2": productCustomField2,
        "product_custom_field3": productCustomField3,
        "product_custom_field4": productCustomField4,
        "image": image,
        "product_description": productDescription,
        "created_by": createdBy,
        "warranty_id": warrantyId,
        "is_inactive": isInactive,
        "not_for_selling": notForSelling,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "image_url": imageUrl,
        "product_variations":
            List<dynamic>.from(productVariations.map((x) => x.toJson())),
        "product_tax": productTax?.toJson(),
        "brand": brand,
        "modifier": List<dynamic>.from(modifier.map((x) => x.toJson())),
        "modifier_sets":
            List<dynamic>.from(modifierSets.map((x) => x.toJson())),
        "variations": List<dynamic>.from(variations.map((x) => x.toJson())),
      };
}

enum PurpleName { KITCHEN_1, KITCHEN_12, KITCHEN_2, TEST_PRODUCT, VEG, VEG_1 }

class Kitchen {
  int? id;
  int? businessId;
  int? locationId;
  PurpleName? name;
  String? description;
  DateTime? createdAt;
  DateTime? updatedAt;
  KitchenPrinter? kitchenPrinter;
  dynamic color;

  Kitchen({
    this.id,
    this.businessId,
    this.locationId,
    this.name,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.kitchenPrinter,
    this.color,
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
        kitchenPrinter: json["kitchen_printer"] == null
            ? null
            : KitchenPrinter.fromJson(json["kitchen_printer"]),
        color: json["color"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "business_id": businessId,
        "location_id": locationId,
        "name": name,
        "description": description,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "kitchen_printer": kitchenPrinter?.toJson(),
        "color": color,
      };
}

class KitchenPrinter {
  int? id;
  int? receiptPrinterType;
  int? printerId;
  int? invoiceLayoutId;
  int? invoiceSchemeId;
  int? printReceiptOnInvoice;
  int? kitchenId;
  int? locationId;
  int? businessId;
  dynamic createdAt;
  dynamic updatedAt;
  Printer? printer;

  KitchenPrinter({
    this.id,
    this.receiptPrinterType,
    this.printerId,
    this.invoiceLayoutId,
    this.invoiceSchemeId,
    this.printReceiptOnInvoice,
    this.kitchenId,
    this.locationId,
    this.businessId,
    this.createdAt,
    this.updatedAt,
    this.printer,
  });

  factory KitchenPrinter.fromJson(Map<String, dynamic> json) => KitchenPrinter(
        id: json["id"],
        receiptPrinterType: json["receipt_printer_type"],
        printerId: json["printer_id"],
        invoiceLayoutId: json["invoice_layout_id"],
        invoiceSchemeId: json["invoice_scheme_id"],
        printReceiptOnInvoice: json["print_receipt_on_invoice"],
        kitchenId: json["kitchen_id"],
        locationId: json["location_id"],
        businessId: json["business_id"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        printer:
            json["printer"] == null ? null : Printer.fromJson(json["printer"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "receipt_printer_type": receiptPrinterType,
        "printer_id": printerId,
        "invoice_layout_id": invoiceLayoutId,
        "invoice_scheme_id": invoiceSchemeId,
        "print_receipt_on_invoice": printReceiptOnInvoice,
        "kitchen_id": kitchenId,
        "location_id": locationId,
        "business_id": businessId,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "printer": printer?.toJson(),
      };
}

class Printer {
  int? id;
  int? businessId;
  String? name;
  String? connectionType;
  String? capabilityProfile;
  String? charPerLine;
  String? ipAddress;
  String? port;
  String? path;
  int? createdBy;
  DateTime? createdAt;
  DateTime? updatedAt;

  Printer({
    this.id,
    this.businessId,
    this.name,
    this.connectionType,
    this.capabilityProfile,
    this.charPerLine,
    this.ipAddress,
    this.port,
    this.path,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
  });

  factory Printer.fromJson(Map<String, dynamic> json) => Printer(
        id: json["id"],
        businessId: json["business_id"],
        name: json["name"],
        connectionType: json["connection_type"],
        capabilityProfile: json["capability_profile"],
        charPerLine: json["char_per_line"],
        ipAddress: json["ip_address"],
        port: json["port"],
        path: json["path"],
        createdBy: json["created_by"],
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
        "connection_type": connectionType,
        "capability_profile": capabilityProfile,
        "char_per_line": charPerLine,
        "ip_address": ipAddress,
        "port": port,
        "path": path,
        "created_by": createdBy,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
