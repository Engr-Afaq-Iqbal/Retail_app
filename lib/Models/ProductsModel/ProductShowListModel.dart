// To parse this JSON data, do
//
//     final productShowListModel = productShowListModelFromJson(jsonString);

import 'dart:convert';

ProductShowListModel productShowListModelFromJson(String str) =>
    ProductShowListModel.fromJson(json.decode(str));

String productShowListModelToJson(ProductShowListModel data) =>
    json.encode(data.toJson());

class ProductShowListModel {
  int? currentPage;
  List<ProductShow>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Link>? links;
  String? nextPageUrl;
  String? path;
  int? perPage;
  dynamic prevPageUrl;
  int? to;
  int? total;

  ProductShowListModel({
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

  factory ProductShowListModel.fromJson(Map<String, dynamic> json) =>
      ProductShowListModel(
        currentPage: json["current_page"],
        data: json["data"] == null
            ? []
            : List<ProductShow>.from(
                json["data"]!.map((x) => ProductShow.fromJson(x))),
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

class ProductShow {
  int? id;
  String? product;
  String? type;
  Category? category;
  dynamic subCategory;
  String? unit;
  dynamic brand;
  String? tax;
  String? sku;
  String? image;
  String? weight;
  int? enableStock;
  int? isInactive;
  int? notForSelling;
  String? productCustomField1;
  String? productCustomField2;
  String? productCustomField3;
  String? productCustomField4;
  String? alertQuantity;
  String? currentStock;
  String? maxPrice;
  String? minPrice;
  String? maxPurchasePrice;
  String? minPurchasePrice;
  int? woocommerceDisableSync;
  String? imageUrl;
  List<dynamic>? media;
  List<ProductVariation>? productVariations;
  dynamic deviceModal;
  ProductVariationsDetails? productVariationsDetails;
  List<ProductLocation>? productLocations;

  ProductShow({
    this.id,
    this.product,
    this.type,
    this.category,
    this.subCategory,
    this.unit,
    this.brand,
    this.tax,
    this.sku,
    this.image,
    this.weight,
    this.enableStock,
    this.isInactive,
    this.notForSelling,
    this.productCustomField1,
    this.productCustomField2,
    this.productCustomField3,
    this.productCustomField4,
    this.alertQuantity,
    this.currentStock,
    this.maxPrice,
    this.minPrice,
    this.maxPurchasePrice,
    this.minPurchasePrice,
    this.woocommerceDisableSync,
    this.imageUrl,
    this.media,
    this.productVariations,
    this.deviceModal,
    this.productVariationsDetails,
    this.productLocations,
  });

  factory ProductShow.fromJson(Map<String, dynamic> json) => ProductShow(
        id: json["id"],
        product: json["product"],
        type: json["type"],
        category: categoryValues.map[json["category"]],
        subCategory: json["sub_category"],
        unit: json["unit"],
        brand: json["brand"],
        tax: json["tax"],
        sku: json["sku"],
        image: json["image"],
        weight: json["weight"],
        enableStock: json["enable_stock"],
        isInactive: json["is_inactive"],
        notForSelling: json["not_for_selling"],
        productCustomField1: json["product_custom_field1"],
        productCustomField2: json["product_custom_field2"],
        productCustomField3: json["product_custom_field3"],
        productCustomField4: json["product_custom_field4"],
        alertQuantity: json["alert_quantity"],
        currentStock: json["current_stock"],
        maxPrice: json["max_price"],
        minPrice: json["min_price"],
        maxPurchasePrice: json["max_purchase_price"],
        minPurchasePrice: json["min_purchase_price"],
        woocommerceDisableSync: json["woocommerce_disable_sync"],
        imageUrl: json["image_url"],
        media: json["media"] == null
            ? []
            : List<dynamic>.from(json["media"]!.map((x) => x)),
        productVariations: json["product_variations"] == null
            ? []
            : List<ProductVariation>.from(json["product_variations"]!
                .map((x) => ProductVariation.fromJson(x))),
        deviceModal: json["device_modal"],
        productVariationsDetails: json["product_variations_details"] == null
            ? null
            : ProductVariationsDetails.fromJson(
                json["product_variations_details"]),
        productLocations: json["product_locations"] == null
            ? []
            : List<ProductLocation>.from(json["product_locations"]!
                .map((x) => ProductLocation.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product": product,
        "type": type,
        "category": categoryValues.reverse[category],
        "sub_category": subCategory,
        "unit": unit,
        "brand": brand,
        "tax": tax,
        "sku": sku,
        "image": image,
        "weight": weight,
        "enable_stock": enableStock,
        "is_inactive": isInactive,
        "not_for_selling": notForSelling,
        "product_custom_field1": productCustomField1,
        "product_custom_field2": productCustomField2,
        "product_custom_field3": productCustomField3,
        "product_custom_field4": productCustomField4,
        "alert_quantity": alertQuantity,
        "current_stock": currentStock,
        "max_price": maxPrice,
        "min_price": minPrice,
        "max_purchase_price": maxPurchasePrice,
        "min_purchase_price": minPurchasePrice,
        "woocommerce_disable_sync": woocommerceDisableSync,
        "image_url": imageUrl,
        "media": media == null ? [] : List<dynamic>.from(media!.map((x) => x)),
        "product_variations": productVariations == null
            ? []
            : List<dynamic>.from(productVariations!.map((x) => x.toJson())),
        "device_modal": deviceModal,
        "product_variations_details": productVariationsDetails?.toJson(),
        "product_locations": productLocations == null
            ? []
            : List<dynamic>.from(productLocations!.map((x) => x.toJson())),
      };
}

enum Category { BREAKFAST }

final categoryValues = EnumValues({"الفطور   Breakfast": Category.BREAKFAST});

class ProductLocation {
  int? id;
  int? businessId;
  LocationId? locationId;
  ProductLocationName? name;
  Landmark? landmark;
  Country? country;
  String? state;
  String? city;
  String? zipCode;
  int? invoiceSchemeId;
  int? invoiceLayoutId;
  int? saleInvoiceLayoutId;
  int? sellingPriceGroupId;
  int? printReceiptOnInvoice;
  ReceiptPrinterType? receiptPrinterType;
  int? printerId;
  String? mobile;
  dynamic alternateNumber;
  Email? email;
  String? website;
  List<String>? featuredProducts;
  int? isActive;
  String? defaultPaymentAccounts;
  dynamic customField1;
  dynamic customField2;
  dynamic customField3;
  dynamic customField4;
  dynamic deletedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  Pivot? pivot;

  ProductLocation({
    this.id,
    this.businessId,
    this.locationId,
    this.name,
    this.landmark,
    this.country,
    this.state,
    this.city,
    this.zipCode,
    this.invoiceSchemeId,
    this.invoiceLayoutId,
    this.saleInvoiceLayoutId,
    this.sellingPriceGroupId,
    this.printReceiptOnInvoice,
    this.receiptPrinterType,
    this.printerId,
    this.mobile,
    this.alternateNumber,
    this.email,
    this.website,
    this.featuredProducts,
    this.isActive,
    this.defaultPaymentAccounts,
    this.customField1,
    this.customField2,
    this.customField3,
    this.customField4,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.pivot,
  });

  factory ProductLocation.fromJson(Map<String, dynamic> json) =>
      ProductLocation(
        id: json["id"],
        businessId: json["business_id"],
        locationId: locationIdValues.map[json["location_id"]],
        name: productLocationNameValues.map[json["name"]],
        landmark: landmarkValues.map[json["landmark"]],
        country: countryValues.map[json["country"]],
        state: json["state"],
        city: json["city"],
        zipCode: json["zip_code"],
        invoiceSchemeId: json["invoice_scheme_id"],
        invoiceLayoutId: json["invoice_layout_id"],
        saleInvoiceLayoutId: json["sale_invoice_layout_id"],
        sellingPriceGroupId: json["selling_price_group_id"],
        printReceiptOnInvoice: json["print_receipt_on_invoice"],
        receiptPrinterType:
            receiptPrinterTypeValues.map[json["receipt_printer_type"]],
        printerId: json["printer_id"],
        mobile: json["mobile"],
        alternateNumber: json["alternate_number"],
        email: emailValues.map[json["email"]],
        website: json["website"],
        featuredProducts: json["featured_products"] == null
            ? []
            : List<String>.from(json["featured_products"]!.map((x) => x)),
        isActive: json["is_active"],
        defaultPaymentAccounts: json["default_payment_accounts"],
        customField1: json["custom_field1"],
        customField2: json["custom_field2"],
        customField3: json["custom_field3"],
        customField4: json["custom_field4"],
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        pivot: json["pivot"] == null ? null : Pivot.fromJson(json["pivot"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "business_id": businessId,
        "location_id": locationIdValues.reverse[locationId],
        "name": productLocationNameValues.reverse[name],
        "landmark": landmarkValues.reverse[landmark],
        "country": countryValues.reverse[country],
        "state": state,
        "city": city,
        "zip_code": zipCode,
        "invoice_scheme_id": invoiceSchemeId,
        "invoice_layout_id": invoiceLayoutId,
        "sale_invoice_layout_id": saleInvoiceLayoutId,
        "selling_price_group_id": sellingPriceGroupId,
        "print_receipt_on_invoice": printReceiptOnInvoice,
        "receipt_printer_type":
            receiptPrinterTypeValues.reverse[receiptPrinterType],
        "printer_id": printerId,
        "mobile": mobile,
        "alternate_number": alternateNumber,
        "email": emailValues.reverse[email],
        "website": website,
        "featured_products": featuredProducts == null
            ? []
            : List<dynamic>.from(featuredProducts!.map((x) => x)),
        "is_active": isActive,
        "default_payment_accounts": defaultPaymentAccounts,
        "custom_field1": customField1,
        "custom_field2": customField2,
        "custom_field3": customField3,
        "custom_field4": customField4,
        "deleted_at": deletedAt,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "pivot": pivot?.toJson(),
      };
}

enum Country { UNITED_ARAB_EMIRATES }

final countryValues =
    EnumValues({"United Arab Emirates": Country.UNITED_ARAB_EMIRATES});

enum Email { RESTRO_BIZMODO_AE }

final emailValues = EnumValues({"restro@bizmodo.ae": Email.RESTRO_BIZMODO_AE});

enum Landmark { AL_FALAH }

final landmarkValues = EnumValues({"Al Falah": Landmark.AL_FALAH});

enum LocationId { BL0001 }

final locationIdValues = EnumValues({"BL0001": LocationId.BL0001});

enum ProductLocationName { RESTAURANT }

final productLocationNameValues =
    EnumValues({"Restaurant": ProductLocationName.RESTAURANT});

class Pivot {
  int? productId;
  int? locationId;

  Pivot({
    this.productId,
    this.locationId,
  });

  factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
        productId: json["product_id"],
        locationId: json["location_id"],
      );

  Map<String, dynamic> toJson() => {
        "product_id": productId,
        "location_id": locationId,
      };
}

enum ReceiptPrinterType { BROWSER }

final receiptPrinterTypeValues =
    EnumValues({"browser": ReceiptPrinterType.BROWSER});

class ProductVariation {
  int? id;
  dynamic variationTemplateId;
  ProductVariationName? name;
  int? productId;
  int? isDummy;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<Variation>? variations;

  ProductVariation({
    this.id,
    this.variationTemplateId,
    this.name,
    this.productId,
    this.isDummy,
    this.createdAt,
    this.updatedAt,
    this.variations,
  });

  factory ProductVariation.fromJson(Map<String, dynamic> json) =>
      ProductVariation(
        id: json["id"],
        variationTemplateId: json["variation_template_id"],
        name: productVariationNameValues.map[json["name"]]!,
        productId: json["product_id"],
        isDummy: json["is_dummy"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        variations: json["variations"] == null
            ? []
            : List<Variation>.from(
                json["variations"]!.map((x) => Variation.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "variation_template_id": variationTemplateId,
        "name": productVariationNameValues.reverse[name],
        "product_id": productId,
        "is_dummy": isDummy,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "variations": variations == null
            ? []
            : List<dynamic>.from(variations!.map((x) => x.toJson())),
      };
}

enum ProductVariationName { DUMMY }

final productVariationNameValues =
    EnumValues({"DUMMY": ProductVariationName.DUMMY});

class Variation {
  int? id;
  ProductVariationName? name;
  int? productId;
  String? subSku;
  int? productVariationId;
  dynamic woocommerceVariationId;
  dynamic variationValueId;
  String? defaultPurchasePrice;
  String? dppIncTax;
  String? profitPercent;
  String? defaultSellPrice;
  String? sellPriceIncTax;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  List<dynamic>? comboVariations;
  List<GroupPrice>? groupPrices;

  Variation({
    this.id,
    this.name,
    this.productId,
    this.subSku,
    this.productVariationId,
    this.woocommerceVariationId,
    this.variationValueId,
    this.defaultPurchasePrice,
    this.dppIncTax,
    this.profitPercent,
    this.defaultSellPrice,
    this.sellPriceIncTax,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.comboVariations,
    this.groupPrices,
  });

  factory Variation.fromJson(Map<String, dynamic> json) => Variation(
        id: json["id"],
        name: productVariationNameValues.map[json["name"]]!,
        productId: json["product_id"],
        subSku: json["sub_sku"],
        productVariationId: json["product_variation_id"],
        woocommerceVariationId: json["woocommerce_variation_id"],
        variationValueId: json["variation_value_id"],
        defaultPurchasePrice: json["default_purchase_price"],
        dppIncTax: json["dpp_inc_tax"],
        profitPercent: json["profit_percent"],
        defaultSellPrice: json["default_sell_price"],
        sellPriceIncTax: json["sell_price_inc_tax"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        comboVariations: json["combo_variations"] == null
            ? []
            : List<dynamic>.from(json["combo_variations"]!.map((x) => x)),
        groupPrices: json["group_prices"] == null
            ? []
            : List<GroupPrice>.from(
                json["group_prices"]!.map((x) => GroupPrice.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": productVariationNameValues.reverse[name],
        "product_id": productId,
        "sub_sku": subSku,
        "product_variation_id": productVariationId,
        "woocommerce_variation_id": woocommerceVariationId,
        "variation_value_id": variationValueId,
        "default_purchase_price": defaultPurchasePrice,
        "dpp_inc_tax": dppIncTax,
        "profit_percent": profitPercent,
        "default_sell_price": defaultSellPrice,
        "sell_price_inc_tax": sellPriceIncTax,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "deleted_at": deletedAt,
        "combo_variations": comboVariations == null
            ? []
            : List<dynamic>.from(comboVariations!.map((x) => x)),
        "group_prices": groupPrices == null
            ? []
            : List<dynamic>.from(groupPrices!.map((x) => x.toJson())),
      };
}

class GroupPrice {
  int? id;
  int? variationId;
  int? priceGroupId;
  String? priceIncTax;
  DateTime? createdAt;
  DateTime? updatedAt;

  GroupPrice({
    this.id,
    this.variationId,
    this.priceGroupId,
    this.priceIncTax,
    this.createdAt,
    this.updatedAt,
  });

  factory GroupPrice.fromJson(Map<String, dynamic> json) => GroupPrice(
        id: json["id"],
        variationId: json["variation_id"],
        priceGroupId: json["price_group_id"],
        priceIncTax: json["price_inc_tax"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "variation_id": variationId,
        "price_group_id": priceGroupId,
        "price_inc_tax": priceIncTax,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class ProductVariationsDetails {
  int? productId;
  String? qtyAvailable;

  ProductVariationsDetails({
    this.productId,
    this.qtyAvailable,
  });

  factory ProductVariationsDetails.fromJson(Map<String, dynamic> json) =>
      ProductVariationsDetails(
        productId: json["product_id"],
        qtyAvailable: json["qty_available"],
      );

  Map<String, dynamic> toJson() => {
        "product_id": productId,
        "qty_available": qtyAvailable,
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

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
