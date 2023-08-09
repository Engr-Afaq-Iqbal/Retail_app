// // To parse this JSON data, do
// //
// //     final listProductsModel = listProductsModelFromJson(jsonString);
//
// import 'dart:convert';
//
// ListProductsModel listProductsModelFromJson(String str) =>
//     ListProductsModel.fromJson(json.decode(str));
//
// String listProductsModelToJson(ListProductsModel data) =>
//     json.encode(data.toJson());
//
// class ListProductsModel {
//   int? currentPage;
//   List<Datum>? data;
//   String? firstPageUrl;
//   int? from;
//   int? lastPage;
//   String? lastPageUrl;
//   List<Link>? links;
//   dynamic nextPageUrl;
//   String? path;
//   int? perPage;
//   dynamic prevPageUrl;
//   int? to;
//   int? total;
//
//   ListProductsModel({
//     this.currentPage,
//     this.data,
//     this.firstPageUrl,
//     this.from,
//     this.lastPage,
//     this.lastPageUrl,
//     this.links,
//     this.nextPageUrl,
//     this.path,
//     this.perPage,
//     this.prevPageUrl,
//     this.to,
//     this.total,
//   });
//
//   factory ListProductsModel.fromJson(Map<String, dynamic> json) =>
//       ListProductsModel(
//         currentPage: json["current_page"],
//         data: json["data"] == null
//             ? []
//             : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
//         firstPageUrl: json["first_page_url"],
//         from: json["from"],
//         lastPage: json["last_page"],
//         lastPageUrl: json["last_page_url"],
//         links: json["links"] == null
//             ? []
//             : List<Link>.from(json["links"]!.map((x) => Link.fromJson(x))),
//         nextPageUrl: json["next_page_url"],
//         path: json["path"],
//         perPage: json["per_page"],
//         prevPageUrl: json["prev_page_url"],
//         to: json["to"],
//         total: json["total"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "current_page": currentPage,
//         "data": data == null
//             ? []
//             : List<dynamic>.from(data!.map((x) => x.toJson())),
//         "first_page_url": firstPageUrl,
//         "from": from,
//         "last_page": lastPage,
//         "last_page_url": lastPageUrl,
//         "links": links == null
//             ? []
//             : List<dynamic>.from(links!.map((x) => x.toJson())),
//         "next_page_url": nextPageUrl,
//         "path": path,
//         "per_page": perPage,
//         "prev_page_url": prevPageUrl,
//         "to": to,
//         "total": total,
//       };
// }
//
// class Datum {
//   int? id;
//   String? name;
//   int? businessId;
//   dynamic shortCode;
//   int? parentId;
//   int? createdBy;
//   dynamic woocommerceCatId;
//   CategoryType? categoryType;
//   dynamic description;
//   dynamic slug;
//   dynamic deletedAt;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//   Color? color;
//   String? image;
//   dynamic standardPurity;
//   List<Product>? products;
//
//   Datum({
//     this.id,
//     this.name,
//     this.businessId,
//     this.shortCode,
//     this.parentId,
//     this.createdBy,
//     this.woocommerceCatId,
//     this.categoryType,
//     this.description,
//     this.slug,
//     this.deletedAt,
//     this.createdAt,
//     this.updatedAt,
//     this.color,
//     this.image,
//     this.standardPurity,
//     this.products,
//   });
//
//   factory Datum.fromJson(Map<String, dynamic> json) => Datum(
//         id: json["id"],
//         name: json["name"],
//         businessId: json["business_id"],
//         shortCode: json["short_code"],
//         parentId: json["parent_id"],
//         createdBy: json["created_by"],
//         woocommerceCatId: json["woocommerce_cat_id"],
//         categoryType: categoryTypeValues.map[json["category_type"]]!,
//         description: json["description"],
//         slug: json["slug"],
//         deletedAt: json["deleted_at"],
//         createdAt: json["created_at"] == null
//             ? null
//             : DateTime.parse(json["created_at"]),
//         updatedAt: json["updated_at"] == null
//             ? null
//             : DateTime.parse(json["updated_at"]),
//         color: colorValues.map[json["color"]]!,
//         image: json["image"],
//         standardPurity: json["standard_purity"],
//         products: json["products"] == null
//             ? []
//             : List<Product>.from(
//                 json["products"]!.map((x) => Product.fromJson(x))),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//         "business_id": businessId,
//         "short_code": shortCode,
//         "parent_id": parentId,
//         "created_by": createdBy,
//         "woocommerce_cat_id": woocommerceCatId,
//         "category_type": categoryTypeValues.reverse[categoryType],
//         "description": description,
//         "slug": slug,
//         "deleted_at": deletedAt,
//         "created_at": createdAt?.toIso8601String(),
//         "updated_at": updatedAt?.toIso8601String(),
//         "color": colorValues.reverse[color],
//         "image": image,
//         "standard_purity": standardPurity,
//         "products": products == null
//             ? []
//             : List<dynamic>.from(products!.map((x) => x.toJson())),
//       };
// }
//
// enum CategoryType { PRODUCT }
//
// final categoryTypeValues = EnumValues({"product": CategoryType.PRODUCT});
//
// enum Color { THE_000000, THE_7_EB814 }
//
// final colorValues =
//     EnumValues({"#000000": Color.THE_000000, "#7eb814": Color.THE_7_EB814});
//
// class Modifier {
//   int? modifierSetId;
//   int? productId;
//   Product? productmodifier;
//
//   Modifier({
//     this.modifierSetId,
//     this.productId,
//     this.productmodifier,
//   });
//
//   factory Modifier.fromJson(Map<String, dynamic> json) => Modifier(
//         modifierSetId: json["modifier_set_id"],
//         productId: json["product_id"],
//         productmodifier: json["productmodifier"] == null
//             ? null
//             : Product.fromJson(json["productmodifier"]),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "modifier_set_id": modifierSetId,
//         "product_id": productId,
//         "productmodifier": productmodifier?.toJson(),
//       };
// }
//
// class Product {
//   int? id;
//   String? name;
//   int? businessId;
//   Type? type;
//   int? unitId;
//   dynamic secondaryUnitId;
//   String? subUnitIds;
//   int? brandId;
//   int? categoryId;
//   int? subCategoryId;
//   int? tax;
//   TaxType? taxType;
//   int? enableStock;
//   String? alertQuantity;
//   String? sku;
//   BarcodeType? barcodeType;
//   dynamic expiryPeriod;
//   dynamic expiryPeriodType;
//   int? enableSrNo;
//   String? weight;
//   ProductCustomField1? productCustomField1;
//   ProductCustomField? productCustomField2;
//   ProductCustomField? productCustomField3;
//   ProductCustomField4? productCustomField4;
//   String? image;
//   dynamic woocommerceMediaId;
//   String? productDescription;
//   int? createdBy;
//   dynamic preparationTimeInMinutes;
//   dynamic woocommerceProductId;
//   int? woocommerceDisableSync;
//   int? warrantyId;
//   int? isInactive;
//   dynamic repairModelId;
//   int? notForSelling;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//   int? kitchenId;
//   Kitchen? typeOfProduct;
//   int? modifierStatus;
//   int? inputField;
//   String? imageUrl;
//   Kitchen? kitchen;
//   List<ProductVariation>? productVariations;
//   ProductTax? productTax;
//   Brand? brand;
//   List<Modifier>? modifier;
//   List<Product>? modifierSets;
//   List<ProductLocation>? productLocations;
//   List<Variation>? variations;
//   ProductPivot? pivot;
//
//   Product({
//     this.id,
//     this.name,
//     this.businessId,
//     this.type,
//     this.unitId,
//     this.secondaryUnitId,
//     this.subUnitIds,
//     this.brandId,
//     this.categoryId,
//     this.subCategoryId,
//     this.tax,
//     this.taxType,
//     this.enableStock,
//     this.alertQuantity,
//     this.sku,
//     this.barcodeType,
//     this.expiryPeriod,
//     this.expiryPeriodType,
//     this.enableSrNo,
//     this.weight,
//     this.productCustomField1,
//     this.productCustomField2,
//     this.productCustomField3,
//     this.productCustomField4,
//     this.image,
//     this.woocommerceMediaId,
//     this.productDescription,
//     this.createdBy,
//     this.preparationTimeInMinutes,
//     this.woocommerceProductId,
//     this.woocommerceDisableSync,
//     this.warrantyId,
//     this.isInactive,
//     this.repairModelId,
//     this.notForSelling,
//     this.createdAt,
//     this.updatedAt,
//     this.kitchenId,
//     this.typeOfProduct,
//     this.modifierStatus,
//     this.inputField,
//     this.imageUrl,
//     this.kitchen,
//     this.productVariations,
//     this.productTax,
//     this.brand,
//     this.modifier,
//     this.modifierSets,
//     this.productLocations,
//     this.variations,
//     this.pivot,
//   });
//
//   factory Product.fromJson(Map<String, dynamic> json) => Product(
//         id: json["id"],
//         name: json["name"],
//         businessId: json["business_id"],
//         type: typeValues.map[json["type"]]!,
//         unitId: json["unit_id"],
//         secondaryUnitId: json["secondary_unit_id"],
//         subUnitIds: json["sub_unit_ids"],
//         brandId: json["brand_id"],
//         categoryId: json["category_id"],
//         subCategoryId: json["sub_category_id"],
//         tax: json["tax"],
//         taxType: taxTypeValues.map[json["tax_type"]]!,
//         enableStock: json["enable_stock"],
//         alertQuantity: json["alert_quantity"],
//         sku: json["sku"],
//         barcodeType: barcodeTypeValues.map[json["barcode_type"]]!,
//         expiryPeriod: json["expiry_period"],
//         expiryPeriodType: json["expiry_period_type"],
//         enableSrNo: json["enable_sr_no"],
//         weight: json["weight"],
//         productCustomField1:
//             productCustomField1Values.map[json["product_custom_field1"]]!,
//         productCustomField2:
//             productCustomFieldValues.map[json["product_custom_field2"]]!,
//         productCustomField3:
//             productCustomFieldValues.map[json["product_custom_field3"]]!,
//         productCustomField4:
//             productCustomField4Values.map[json["product_custom_field4"]]!,
//         image: json["image"],
//         woocommerceMediaId: json["woocommerce_media_id"],
//         productDescription: json["product_description"],
//         createdBy: json["created_by"],
//         preparationTimeInMinutes: json["preparation_time_in_minutes"],
//         woocommerceProductId: json["woocommerce_product_id"],
//         woocommerceDisableSync: json["woocommerce_disable_sync"],
//         warrantyId: json["warranty_id"],
//         isInactive: json["is_inactive"],
//         repairModelId: json["repair_model_id"],
//         notForSelling: json["not_for_selling"],
//         createdAt: json["created_at"] == null
//             ? null
//             : DateTime.parse(json["created_at"]),
//         updatedAt: json["updated_at"] == null
//             ? null
//             : DateTime.parse(json["updated_at"]),
//         kitchenId: json["kitchen_id"],
//         typeOfProduct: json["type_of_product"] == null
//             ? null
//             : Kitchen.fromJson(json["type_of_product"]),
//         modifierStatus: json["modifier_status"],
//         inputField: json["input_field"],
//         imageUrl: json["image_url"],
//         kitchen:
//             json["kitchen"] == null ? null : Kitchen.fromJson(json["kitchen"]),
//         productVariations: json["product_variations"] == null
//             ? []
//             : List<ProductVariation>.from(json["product_variations"]!
//                 .map((x) => ProductVariation.fromJson(x))),
//         productTax: json["product_tax"] == null
//             ? null
//             : ProductTax.fromJson(json["product_tax"]),
//         brand: json["brand"] == null ? null : Brand.fromJson(json["brand"]),
//         modifier: json["modifier"] == null
//             ? []
//             : List<Modifier>.from(
//                 json["modifier"]!.map((x) => Modifier.fromJson(x))),
//         modifierSets: json["modifier_sets"] == null
//             ? []
//             : List<Product>.from(
//                 json["modifier_sets"]!.map((x) => Product.fromJson(x))),
//         productLocations: json["product_locations"] == null
//             ? []
//             : List<ProductLocation>.from(json["product_locations"]!
//                 .map((x) => ProductLocation.fromJson(x))),
//         variations: json["variations"] == null
//             ? []
//             : List<Variation>.from(
//                 json["variations"]!.map((x) => Variation.fromJson(x))),
//         pivot:
//             json["pivot"] == null ? null : ProductPivot.fromJson(json["pivot"]),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//         "business_id": businessId,
//         "type": typeValues.reverse[type],
//         "unit_id": unitId,
//         "secondary_unit_id": secondaryUnitId,
//         "sub_unit_ids": subUnitIds,
//         "brand_id": brandId,
//         "category_id": categoryId,
//         "sub_category_id": subCategoryId,
//         "tax": tax,
//         "tax_type": taxTypeValues.reverse[taxType],
//         "enable_stock": enableStock,
//         "alert_quantity": alertQuantity,
//         "sku": sku,
//         "barcode_type": barcodeTypeValues.reverse[barcodeType],
//         "expiry_period": expiryPeriod,
//         "expiry_period_type": expiryPeriodType,
//         "enable_sr_no": enableSrNo,
//         "weight": weight,
//         "product_custom_field1":
//             productCustomField1Values.reverse[productCustomField1],
//         "product_custom_field2":
//             productCustomFieldValues.reverse[productCustomField2],
//         "product_custom_field3":
//             productCustomFieldValues.reverse[productCustomField3],
//         "product_custom_field4":
//             productCustomField4Values.reverse[productCustomField4],
//         "image": image,
//         "woocommerce_media_id": woocommerceMediaId,
//         "product_description": productDescription,
//         "created_by": createdBy,
//         "preparation_time_in_minutes": preparationTimeInMinutes,
//         "woocommerce_product_id": woocommerceProductId,
//         "woocommerce_disable_sync": woocommerceDisableSync,
//         "warranty_id": warrantyId,
//         "is_inactive": isInactive,
//         "repair_model_id": repairModelId,
//         "not_for_selling": notForSelling,
//         "created_at": createdAt?.toIso8601String(),
//         "updated_at": updatedAt?.toIso8601String(),
//         "kitchen_id": kitchenId,
//         "type_of_product": typeOfProduct?.toJson(),
//         "modifier_status": modifierStatus,
//         "input_field": inputField,
//         "image_url": imageUrl,
//         "kitchen": kitchen?.toJson(),
//         "product_variations": productVariations == null
//             ? []
//             : List<dynamic>.from(productVariations!.map((x) => x.toJson())),
//         "product_tax": productTax?.toJson(),
//         "brand": brand?.toJson(),
//         "modifier": modifier == null
//             ? []
//             : List<dynamic>.from(modifier!.map((x) => x.toJson())),
//         "modifier_sets": modifierSets == null
//             ? []
//             : List<dynamic>.from(modifierSets!.map((x) => x.toJson())),
//         "product_locations": productLocations == null
//             ? []
//             : List<dynamic>.from(productLocations!.map((x) => x.toJson())),
//         "variations": variations == null
//             ? []
//             : List<dynamic>.from(variations!.map((x) => x.toJson())),
//         "pivot": pivot?.toJson(),
//       };
// }
//
// enum BarcodeType { C128, C39, EAN13, EMPTY }
//
// final barcodeTypeValues = EnumValues({
//   "C128": BarcodeType.C128,
//   "C39": BarcodeType.C39,
//   "EAN13": BarcodeType.EAN13,
//   "": BarcodeType.EMPTY
// });
//
// class Brand {
//   int? id;
//   int? businessId;
//   DescriptionEnum? name;
//   dynamic description;
//   int? createdBy;
//   int? useForRepair;
//   dynamic deletedAt;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//
//   Brand({
//     this.id,
//     this.businessId,
//     this.name,
//     this.description,
//     this.createdBy,
//     this.useForRepair,
//     this.deletedAt,
//     this.createdAt,
//     this.updatedAt,
//   });
//
//   factory Brand.fromJson(Map<String, dynamic> json) => Brand(
//         id: json["id"],
//         businessId: json["business_id"],
//         name: descriptionEnumValues.map[json["name"]]!,
//         description: json["description"],
//         createdBy: json["created_by"],
//         useForRepair: json["use_for_repair"],
//         deletedAt: json["deleted_at"],
//         createdAt: json["created_at"] == null
//             ? null
//             : DateTime.parse(json["created_at"]),
//         updatedAt: json["updated_at"] == null
//             ? null
//             : DateTime.parse(json["updated_at"]),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "business_id": businessId,
//         "name": descriptionEnumValues.reverse[name],
//         "description": description,
//         "created_by": createdBy,
//         "use_for_repair": useForRepair,
//         "deleted_at": deletedAt,
//         "created_at": createdAt?.toIso8601String(),
//         "updated_at": updatedAt?.toIso8601String(),
//       };
// }
//
// enum DescriptionEnum { TEST, KITCHEN_1 }
//
// final descriptionEnumValues = EnumValues(
//     {"Kitchen 1": DescriptionEnum.KITCHEN_1, "test": DescriptionEnum.TEST});
//
// class Kitchen {
//   int? id;
//   int? businessId;
//   int? locationId;
//   PurpleName? name;
//   DescriptionEnum? description;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//   KitchenPrinter? kitchenPrinter;
//   dynamic color;
//
//   Kitchen({
//     this.id,
//     this.businessId,
//     this.locationId,
//     this.name,
//     this.description,
//     this.createdAt,
//     this.updatedAt,
//     this.kitchenPrinter,
//     this.color,
//   });
//
//   factory Kitchen.fromJson(Map<String, dynamic> json) => Kitchen(
//         id: json["id"],
//         businessId: json["business_id"],
//         locationId: json["location_id"],
//         name: purpleNameValues.map[json["name"]]!,
//         description: descriptionEnumValues.map[json["description"]]!,
//         createdAt: json["created_at"] == null
//             ? null
//             : DateTime.parse(json["created_at"]),
//         updatedAt: json["updated_at"] == null
//             ? null
//             : DateTime.parse(json["updated_at"]),
//         kitchenPrinter: json["kitchen_printer"] == null
//             ? null
//             : KitchenPrinter.fromJson(json["kitchen_printer"]),
//         color: json["color"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "business_id": businessId,
//         "location_id": locationId,
//         "name": purpleNameValues.reverse[name],
//         "description": descriptionEnumValues.reverse[description],
//         "created_at": createdAt?.toIso8601String(),
//         "updated_at": updatedAt?.toIso8601String(),
//         "kitchen_printer": kitchenPrinter?.toJson(),
//         "color": color,
//       };
// }
//
// class KitchenPrinter {
//   int? id;
//   int? receiptPrinterType;
//   int? printerId;
//   int? invoiceLayoutId;
//   int? invoiceSchemeId;
//   int? printReceiptOnInvoice;
//   int? kitchenId;
//   int? locationId;
//   int? businessId;
//   dynamic createdAt;
//   dynamic updatedAt;
//   Printer? printer;
//
//   KitchenPrinter({
//     this.id,
//     this.receiptPrinterType,
//     this.printerId,
//     this.invoiceLayoutId,
//     this.invoiceSchemeId,
//     this.printReceiptOnInvoice,
//     this.kitchenId,
//     this.locationId,
//     this.businessId,
//     this.createdAt,
//     this.updatedAt,
//     this.printer,
//   });
//
//   factory KitchenPrinter.fromJson(Map<String, dynamic> json) => KitchenPrinter(
//         id: json["id"],
//         receiptPrinterType: json["receipt_printer_type"],
//         printerId: json["printer_id"],
//         invoiceLayoutId: json["invoice_layout_id"],
//         invoiceSchemeId: json["invoice_scheme_id"],
//         printReceiptOnInvoice: json["print_receipt_on_invoice"],
//         kitchenId: json["kitchen_id"],
//         locationId: json["location_id"],
//         businessId: json["business_id"],
//         createdAt: json["created_at"],
//         updatedAt: json["updated_at"],
//         printer:
//             json["printer"] == null ? null : Printer.fromJson(json["printer"]),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "receipt_printer_type": receiptPrinterType,
//         "printer_id": printerId,
//         "invoice_layout_id": invoiceLayoutId,
//         "invoice_scheme_id": invoiceSchemeId,
//         "print_receipt_on_invoice": printReceiptOnInvoice,
//         "kitchen_id": kitchenId,
//         "location_id": locationId,
//         "business_id": businessId,
//         "created_at": createdAt,
//         "updated_at": updatedAt,
//         "printer": printer?.toJson(),
//       };
// }
//
// class Printer {
//   int? id;
//   int? businessId;
//   PrinterName? name;
//   ConnectionType? connectionType;
//   CapabilityProfile? capabilityProfile;
//   String? charPerLine;
//   IpAddress? ipAddress;
//   String? port;
//   String? path;
//   int? createdBy;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//
//   Printer({
//     this.id,
//     this.businessId,
//     this.name,
//     this.connectionType,
//     this.capabilityProfile,
//     this.charPerLine,
//     this.ipAddress,
//     this.port,
//     this.path,
//     this.createdBy,
//     this.createdAt,
//     this.updatedAt,
//   });
//
//   factory Printer.fromJson(Map<String, dynamic> json) => Printer(
//         id: json["id"],
//         businessId: json["business_id"],
//         name: printerNameValues.map[json["name"]]!,
//         connectionType: connectionTypeValues.map[json["connection_type"]]!,
//         capabilityProfile:
//             capabilityProfileValues.map[json["capability_profile"]]!,
//         charPerLine: json["char_per_line"],
//         ipAddress: ipAddressValues.map[json["ip_address"]]!,
//         port: json["port"],
//         path: json["path"],
//         createdBy: json["created_by"],
//         createdAt: json["created_at"] == null
//             ? null
//             : DateTime.parse(json["created_at"]),
//         updatedAt: json["updated_at"] == null
//             ? null
//             : DateTime.parse(json["updated_at"]),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "business_id": businessId,
//         "name": printerNameValues.reverse[name],
//         "connection_type": connectionTypeValues.reverse[connectionType],
//         "capability_profile":
//             capabilityProfileValues.reverse[capabilityProfile],
//         "char_per_line": charPerLine,
//         "ip_address": ipAddressValues.reverse[ipAddress],
//         "port": port,
//         "path": path,
//         "created_by": createdBy,
//         "created_at": createdAt?.toIso8601String(),
//         "updated_at": updatedAt?.toIso8601String(),
//       };
// }
//
// enum CapabilityProfile { DEFAULT }
//
// final capabilityProfileValues =
//     EnumValues({"default": CapabilityProfile.DEFAULT});
//
// enum ConnectionType { NETWORK }
//
// final connectionTypeValues = EnumValues({"network": ConnectionType.NETWORK});
//
// enum IpAddress { THE_101010142, THE_101010141 }
//
// final ipAddressValues = EnumValues({
//   "10.10.10.141": IpAddress.THE_101010141,
//   "10.10.10.142": IpAddress.THE_101010142
// });
//
// enum PrinterName { MAIN_KITCHEN, KOT_2 }
//
// final printerNameValues = EnumValues(
//     {"KOT 2": PrinterName.KOT_2, "Main Kitchen": PrinterName.MAIN_KITCHEN});
//
// enum PurpleName { KITCHEN_1, KITCHEN_12, KITCHEN_2, TEST_PRODUCT, VEG, VEG_1 }
//
// final purpleNameValues = EnumValues({
//   "Kitchen 1": PurpleName.KITCHEN_1,
//   "kitchen 12": PurpleName.KITCHEN_12,
//   "Kitchen 2": PurpleName.KITCHEN_2,
//   "Test product": PurpleName.TEST_PRODUCT,
//   "Veg": PurpleName.VEG,
//   "Veg 1": PurpleName.VEG_1
// });
//
// class ProductPivot {
//   int? productId;
//   int? modifierSetId;
//
//   ProductPivot({
//     this.productId,
//     this.modifierSetId,
//   });
//
//   factory ProductPivot.fromJson(Map<String, dynamic> json) => ProductPivot(
//         productId: json["product_id"],
//         modifierSetId: json["modifier_set_id"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "product_id": productId,
//         "modifier_set_id": modifierSetId,
//       };
// }
//
// enum ProductCustomField1 { EMPTY, FF, BH }
//
// final productCustomField1Values = EnumValues({
//   "Bh": ProductCustomField1.BH,
//   "": ProductCustomField1.EMPTY,
//   "Ff": ProductCustomField1.FF
// });
//
// enum ProductCustomField { EMPTY, FF, GG }
//
// final productCustomFieldValues = EnumValues({
//   "": ProductCustomField.EMPTY,
//   "Ff": ProductCustomField.FF,
//   "Gg": ProductCustomField.GG
// });
//
// enum ProductCustomField4 { EMPTY, FF, HY }
//
// final productCustomField4Values = EnumValues({
//   "": ProductCustomField4.EMPTY,
//   "Ff": ProductCustomField4.FF,
//   "Hy": ProductCustomField4.HY
// });
//
// class ProductLocation {
//   int? id;
//   int? businessId;
//   LocationId? locationId;
//   ProductLocationName? name;
//   Landmark? landmark;
//   Country? country;
//   City? state;
//   City? city;
//   String? zipCode;
//   int? invoiceSchemeId;
//   int? invoiceLayoutId;
//   int? saleInvoiceLayoutId;
//   int? sellingPriceGroupId;
//   int? printReceiptOnInvoice;
//   ReceiptPrinterType? receiptPrinterType;
//   int? printerId;
//   String? mobile;
//   dynamic alternateNumber;
//   Email? email;
//   String? website;
//   List<String>? featuredProducts;
//   int? isActive;
//   String? defaultPaymentAccounts;
//   dynamic customField1;
//   dynamic customField2;
//   dynamic customField3;
//   dynamic customField4;
//   dynamic deletedAt;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//   ProductLocationPivot? pivot;
//
//   ProductLocation({
//     this.id,
//     this.businessId,
//     this.locationId,
//     this.name,
//     this.landmark,
//     this.country,
//     this.state,
//     this.city,
//     this.zipCode,
//     this.invoiceSchemeId,
//     this.invoiceLayoutId,
//     this.saleInvoiceLayoutId,
//     this.sellingPriceGroupId,
//     this.printReceiptOnInvoice,
//     this.receiptPrinterType,
//     this.printerId,
//     this.mobile,
//     this.alternateNumber,
//     this.email,
//     this.website,
//     this.featuredProducts,
//     this.isActive,
//     this.defaultPaymentAccounts,
//     this.customField1,
//     this.customField2,
//     this.customField3,
//     this.customField4,
//     this.deletedAt,
//     this.createdAt,
//     this.updatedAt,
//     this.pivot,
//   });
//
//   factory ProductLocation.fromJson(Map<String, dynamic> json) =>
//       ProductLocation(
//         id: json["id"],
//         businessId: json["business_id"],
//         locationId: locationIdValues.map[json["location_id"]]!,
//         name: productLocationNameValues.map[json["name"]]!,
//         landmark: landmarkValues.map[json["landmark"]]!,
//         country: countryValues.map[json["country"]]!,
//         state: cityValues.map[json["state"]]!,
//         city: cityValues.map[json["city"]]!,
//         zipCode: json["zip_code"],
//         invoiceSchemeId: json["invoice_scheme_id"],
//         invoiceLayoutId: json["invoice_layout_id"],
//         saleInvoiceLayoutId: json["sale_invoice_layout_id"],
//         sellingPriceGroupId: json["selling_price_group_id"],
//         printReceiptOnInvoice: json["print_receipt_on_invoice"],
//         receiptPrinterType:
//             receiptPrinterTypeValues.map[json["receipt_printer_type"]]!,
//         printerId: json["printer_id"],
//         mobile: json["mobile"],
//         alternateNumber: json["alternate_number"],
//         email: emailValues.map[json["email"]]!,
//         website: json["website"],
//         featuredProducts: json["featured_products"] == null
//             ? []
//             : List<String>.from(json["featured_products"]!.map((x) => x)),
//         isActive: json["is_active"],
//         defaultPaymentAccounts: json["default_payment_accounts"],
//         customField1: json["custom_field1"],
//         customField2: json["custom_field2"],
//         customField3: json["custom_field3"],
//         customField4: json["custom_field4"],
//         deletedAt: json["deleted_at"],
//         createdAt: json["created_at"] == null
//             ? null
//             : DateTime.parse(json["created_at"]),
//         updatedAt: json["updated_at"] == null
//             ? null
//             : DateTime.parse(json["updated_at"]),
//         pivot: json["pivot"] == null
//             ? null
//             : ProductLocationPivot.fromJson(json["pivot"]),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "business_id": businessId,
//         "location_id": locationIdValues.reverse[locationId],
//         "name": productLocationNameValues.reverse[name],
//         "landmark": landmarkValues.reverse[landmark],
//         "country": countryValues.reverse[country],
//         "state": cityValues.reverse[state],
//         "city": cityValues.reverse[city],
//         "zip_code": zipCode,
//         "invoice_scheme_id": invoiceSchemeId,
//         "invoice_layout_id": invoiceLayoutId,
//         "sale_invoice_layout_id": saleInvoiceLayoutId,
//         "selling_price_group_id": sellingPriceGroupId,
//         "print_receipt_on_invoice": printReceiptOnInvoice,
//         "receipt_printer_type":
//             receiptPrinterTypeValues.reverse[receiptPrinterType],
//         "printer_id": printerId,
//         "mobile": mobile,
//         "alternate_number": alternateNumber,
//         "email": emailValues.reverse[email],
//         "website": website,
//         "featured_products": featuredProducts == null
//             ? []
//             : List<dynamic>.from(featuredProducts!.map((x) => x)),
//         "is_active": isActive,
//         "default_payment_accounts": defaultPaymentAccounts,
//         "custom_field1": customField1,
//         "custom_field2": customField2,
//         "custom_field3": customField3,
//         "custom_field4": customField4,
//         "deleted_at": deletedAt,
//         "created_at": createdAt?.toIso8601String(),
//         "updated_at": updatedAt?.toIso8601String(),
//         "pivot": pivot?.toJson(),
//       };
// }
//
// enum City { ABU_DHABI }
//
// final cityValues = EnumValues({"Abu Dhabi": City.ABU_DHABI});
//
// enum Country { UNITED_ARAB_EMIRATES }
//
// final countryValues =
//     EnumValues({"United Arab Emirates": Country.UNITED_ARAB_EMIRATES});
//
// enum Email { RESTRO_BIZMODO_AE }
//
// final emailValues = EnumValues({"restro@bizmodo.ae": Email.RESTRO_BIZMODO_AE});
//
// enum Landmark { AL_FALAH }
//
// final landmarkValues = EnumValues({"Al Falah": Landmark.AL_FALAH});
//
// enum LocationId { BL0001 }
//
// final locationIdValues = EnumValues({"BL0001": LocationId.BL0001});
//
// enum ProductLocationName { RESTAURANT }
//
// final productLocationNameValues =
//     EnumValues({"Restaurant": ProductLocationName.RESTAURANT});
//
// class ProductLocationPivot {
//   int? productId;
//   int? locationId;
//
//   ProductLocationPivot({
//     this.productId,
//     this.locationId,
//   });
//
//   factory ProductLocationPivot.fromJson(Map<String, dynamic> json) =>
//       ProductLocationPivot(
//         productId: json["product_id"],
//         locationId: json["location_id"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "product_id": productId,
//         "location_id": locationId,
//       };
// }
//
// enum ReceiptPrinterType { BROWSER }
//
// final receiptPrinterTypeValues =
//     EnumValues({"browser": ReceiptPrinterType.BROWSER});
//
// class ProductTax {
//   int? id;
//   int? businessId;
//   ProductTaxName? name;
//   int? amount;
//   int? isTaxGroup;
//   int? forTaxGroup;
//   int? createdBy;
//   dynamic woocommerceTaxRateId;
//   dynamic deletedAt;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//
//   ProductTax({
//     this.id,
//     this.businessId,
//     this.name,
//     this.amount,
//     this.isTaxGroup,
//     this.forTaxGroup,
//     this.createdBy,
//     this.woocommerceTaxRateId,
//     this.deletedAt,
//     this.createdAt,
//     this.updatedAt,
//   });
//
//   factory ProductTax.fromJson(Map<String, dynamic> json) => ProductTax(
//         id: json["id"],
//         businessId: json["business_id"],
//         name: productTaxNameValues.map[json["name"]]!,
//         amount: json["amount"],
//         isTaxGroup: json["is_tax_group"],
//         forTaxGroup: json["for_tax_group"],
//         createdBy: json["created_by"],
//         woocommerceTaxRateId: json["woocommerce_tax_rate_id"],
//         deletedAt: json["deleted_at"],
//         createdAt: json["created_at"] == null
//             ? null
//             : DateTime.parse(json["created_at"]),
//         updatedAt: json["updated_at"] == null
//             ? null
//             : DateTime.parse(json["updated_at"]),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "business_id": businessId,
//         "name": productTaxNameValues.reverse[name],
//         "amount": amount,
//         "is_tax_group": isTaxGroup,
//         "for_tax_group": forTaxGroup,
//         "created_by": createdBy,
//         "woocommerce_tax_rate_id": woocommerceTaxRateId,
//         "deleted_at": deletedAt,
//         "created_at": createdAt?.toIso8601String(),
//         "updated_at": updatedAt?.toIso8601String(),
//       };
// }
//
// enum ProductTaxName { VAT }
//
// final productTaxNameValues = EnumValues({"VAT": ProductTaxName.VAT});
//
// class ProductVariation {
//   int? id;
//   dynamic variationTemplateId;
//   ProductVariationName? name;
//   int? productId;
//   int? isDummy;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//   List<Variation>? variations;
//
//   ProductVariation({
//     this.id,
//     this.variationTemplateId,
//     this.name,
//     this.productId,
//     this.isDummy,
//     this.createdAt,
//     this.updatedAt,
//     this.variations,
//   });
//
//   factory ProductVariation.fromJson(Map<String, dynamic> json) =>
//       ProductVariation(
//         id: json["id"],
//         variationTemplateId: json["variation_template_id"],
//         name: productVariationNameValues.map[json["name"]]!,
//         productId: json["product_id"],
//         isDummy: json["is_dummy"],
//         createdAt: json["created_at"] == null
//             ? null
//             : DateTime.parse(json["created_at"]),
//         updatedAt: json["updated_at"] == null
//             ? null
//             : DateTime.parse(json["updated_at"]),
//         variations: json["variations"] == null
//             ? []
//             : List<Variation>.from(
//                 json["variations"]!.map((x) => Variation.fromJson(x))),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "variation_template_id": variationTemplateId,
//         "name": productVariationNameValues.reverse[name],
//         "product_id": productId,
//         "is_dummy": isDummy,
//         "created_at": createdAt?.toIso8601String(),
//         "updated_at": updatedAt?.toIso8601String(),
//         "variations": variations == null
//             ? []
//             : List<dynamic>.from(variations!.map((x) => x.toJson())),
//       };
// }
//
// enum ProductVariationName {
//   DUMMY,
//   SMALL,
//   LARGE,
//   PEANUT_BUTTER,
//   EXTRA_PEANUT,
//   TEST
// }
//
// final productVariationNameValues = EnumValues({
//   "DUMMY": ProductVariationName.DUMMY,
//   "Extra Peanut": ProductVariationName.EXTRA_PEANUT,
//   "Large": ProductVariationName.LARGE,
//   "Peanut Butter": ProductVariationName.PEANUT_BUTTER,
//   "Small": ProductVariationName.SMALL,
//   "test": ProductVariationName.TEST
// });
//
// class Variation {
//   int? id;
//   ProductVariationName? name;
//   int? productId;
//   String? subSku;
//   int? productVariationId;
//   dynamic woocommerceVariationId;
//   dynamic variationValueId;
//   String? defaultPurchasePrice;
//   String? dppIncTax;
//   String? profitPercent;
//   String? defaultSellPrice;
//   String? sellPriceIncTax;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//   dynamic deletedAt;
//   List<dynamic>? comboVariations;
//   List<VariationLocationDetail>? variationLocationDetails;
//
//   Variation({
//     this.id,
//     this.name,
//     this.productId,
//     this.subSku,
//     this.productVariationId,
//     this.woocommerceVariationId,
//     this.variationValueId,
//     this.defaultPurchasePrice,
//     this.dppIncTax,
//     this.profitPercent,
//     this.defaultSellPrice,
//     this.sellPriceIncTax,
//     this.createdAt,
//     this.updatedAt,
//     this.deletedAt,
//     this.comboVariations,
//     this.variationLocationDetails,
//   });
//
//   factory Variation.fromJson(Map<String, dynamic> json) => Variation(
//         id: json["id"],
//         name: productVariationNameValues.map[json["name"]]!,
//         productId: json["product_id"],
//         subSku: json["sub_sku"],
//         productVariationId: json["product_variation_id"],
//         woocommerceVariationId: json["woocommerce_variation_id"],
//         variationValueId: json["variation_value_id"],
//         defaultPurchasePrice: json["default_purchase_price"],
//         dppIncTax: json["dpp_inc_tax"],
//         profitPercent: json["profit_percent"],
//         defaultSellPrice: json["default_sell_price"],
//         sellPriceIncTax: json["sell_price_inc_tax"],
//         createdAt: json["created_at"] == null
//             ? null
//             : DateTime.parse(json["created_at"]),
//         updatedAt: json["updated_at"] == null
//             ? null
//             : DateTime.parse(json["updated_at"]),
//         deletedAt: json["deleted_at"],
//         comboVariations: json["combo_variations"] == null
//             ? []
//             : List<dynamic>.from(json["combo_variations"]!.map((x) => x)),
//         variationLocationDetails: json["variation_location_details"] == null
//             ? []
//             : List<VariationLocationDetail>.from(
//                 json["variation_location_details"]!
//                     .map((x) => VariationLocationDetail.fromJson(x))),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": productVariationNameValues.reverse[name],
//         "product_id": productId,
//         "sub_sku": subSku,
//         "product_variation_id": productVariationId,
//         "woocommerce_variation_id": woocommerceVariationId,
//         "variation_value_id": variationValueId,
//         "default_purchase_price": defaultPurchasePrice,
//         "dpp_inc_tax": dppIncTax,
//         "profit_percent": profitPercent,
//         "default_sell_price": defaultSellPrice,
//         "sell_price_inc_tax": sellPriceIncTax,
//         "created_at": createdAt?.toIso8601String(),
//         "updated_at": updatedAt?.toIso8601String(),
//         "deleted_at": deletedAt,
//         "combo_variations": comboVariations == null
//             ? []
//             : List<dynamic>.from(comboVariations!.map((x) => x)),
//         "variation_location_details": variationLocationDetails == null
//             ? []
//             : List<dynamic>.from(
//                 variationLocationDetails!.map((x) => x.toJson())),
//       };
// }
//
// class VariationLocationDetail {
//   int? id;
//   int? productId;
//   int? productVariationId;
//   int? variationId;
//   int? locationId;
//   String? qtyAvailable;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//
//   VariationLocationDetail({
//     this.id,
//     this.productId,
//     this.productVariationId,
//     this.variationId,
//     this.locationId,
//     this.qtyAvailable,
//     this.createdAt,
//     this.updatedAt,
//   });
//
//   factory VariationLocationDetail.fromJson(Map<String, dynamic> json) =>
//       VariationLocationDetail(
//         id: json["id"],
//         productId: json["product_id"],
//         productVariationId: json["product_variation_id"],
//         variationId: json["variation_id"],
//         locationId: json["location_id"],
//         qtyAvailable: json["qty_available"],
//         createdAt: json["created_at"] == null
//             ? null
//             : DateTime.parse(json["created_at"]),
//         updatedAt: json["updated_at"] == null
//             ? null
//             : DateTime.parse(json["updated_at"]),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "product_id": productId,
//         "product_variation_id": productVariationId,
//         "variation_id": variationId,
//         "location_id": locationId,
//         "qty_available": qtyAvailable,
//         "created_at": createdAt?.toIso8601String(),
//         "updated_at": updatedAt?.toIso8601String(),
//       };
// }
//
// enum TaxType { INCLUSIVE, EXCLUSIVE }
//
// final taxTypeValues = EnumValues(
//     {"exclusive": TaxType.EXCLUSIVE, "inclusive": TaxType.INCLUSIVE});
//
// enum Type { SINGLE, VARIABLE, EMPTY, MODIFIER }
//
// final typeValues = EnumValues({
//   "": Type.EMPTY,
//   "modifier": Type.MODIFIER,
//   "single": Type.SINGLE,
//   "variable": Type.VARIABLE
// });
//
// class Link {
//   String? url;
//   String? label;
//   bool? active;
//
//   Link({
//     this.url,
//     this.label,
//     this.active,
//   });
//
//   factory Link.fromJson(Map<String, dynamic> json) => Link(
//         url: json["url"],
//         label: json["label"],
//         active: json["active"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "url": url,
//         "label": label,
//         "active": active,
//       };
// }
//
// class EnumValues<T> {
//   Map<String, T> map;
//   late Map<T, String> reverseMap;
//
//   EnumValues(this.map);
//
//   Map<T, String> get reverse {
//     reverseMap = map.map((k, v) => MapEntry(v, k));
//     return reverseMap;
//   }
// }
