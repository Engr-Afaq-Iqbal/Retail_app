import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/Config/enums.dart';
import '/Models/ProductsModel/ProductModel.dart';
import '/Models/ProductsModel/ProductVariationAndModifierModel.dart';

class SellLine {
  SellLine({
    this.id,
    this.transactionId,
    this.productId,
    this.variationId,
    this.quantity = 1,
    this.secondaryUnitQuantity,
    this.mfgWastePercent,
    this.mfgIngredientGroupId,
    this.quantityReturned,
    this.unitPriceBeforeDiscount,
    this.unitPrice,
    this.lineDiscountType,
    this.lineDiscountAmount,
    this.unitPriceIncTax,
    this.itemTax,
    this.taxId,
    this.discountId,
    this.lotNoLineId,
    this.sellLineNote,
    this.woocommerceLineItemsId,
    this.soLineId,
    this.soQuantityInvoiced,
    this.resServiceStaffId,
    this.resLineOrderStatus,
    this.resLineOrderStatusColorValue,
    this.parentSellLineId,
    this.childrenType,
    this.subUnitId,
    this.createdAt,
    this.updatedAt,
    this.product,
    this.variations,
    this.isSelected = false,
  });

  int? id;
  int? transactionId;
  int? productId;
  int? variationId;
  int quantity = 1;
  String? secondaryUnitQuantity;
  String? mfgWastePercent;
  dynamic mfgIngredientGroupId;
  String? quantityReturned;
  String? unitPriceBeforeDiscount;
  String? unitPrice;
  Type? lineDiscountType;
  String? lineDiscountAmount;
  String? unitPriceIncTax;
  String? itemTax;
  int? taxId;
  dynamic discountId;
  dynamic lotNoLineId;
  String? sellLineNote;
  dynamic woocommerceLineItemsId;
  dynamic soLineId;
  String? soQuantityInvoiced;
  dynamic resServiceStaffId;
  LineOrderStatus? resLineOrderStatus;
  int? resLineOrderStatusColorValue;
  dynamic parentSellLineId;
  String? childrenType;
  dynamic subUnitId;
  DateTime? createdAt;
  DateTime? updatedAt;
  ProductModel? product;
  ProductVariation? variations;
  late bool isSelected;

  SellLine copyWith({
    int? id,
    int? transactionId,
    int? productId,
    int? variationId,
    int? quantity,
    String? secondaryUnitQuantity,
    String? mfgWastePercent,
    dynamic mfgIngredientGroupId,
    String? quantityReturned,
    String? unitPriceBeforeDiscount,
    String? unitPrice,
    Type? lineDiscountType,
    String? lineDiscountAmount,
    String? unitPriceIncTax,
    String? itemTax,
    int? taxId,
    dynamic discountId,
    dynamic lotNoLineId,
    String? sellLineNote,
    dynamic woocommerceLineItemsId,
    dynamic soLineId,
    String? soQuantityInvoiced,
    dynamic resServiceStaffId,
    LineOrderStatus? resLineOrderStatus,
    int? resLineOrderStatusColorValue,
    dynamic parentSellLineId,
    String? childrenType,
    dynamic subUnitId,
    DateTime? createdAt,
    DateTime? updatedAt,
    ProductModel? product,
    ProductVariation? variations,
    bool? isSelected,
  }) =>
      SellLine(
        id: id ?? this.id,
        transactionId: transactionId ?? this.transactionId,
        productId: productId ?? this.productId,
        variationId: variationId ?? this.variationId,
        quantity: quantity ?? this.quantity,
        secondaryUnitQuantity:
            secondaryUnitQuantity ?? this.secondaryUnitQuantity,
        mfgWastePercent: mfgWastePercent ?? this.mfgWastePercent,
        mfgIngredientGroupId: mfgIngredientGroupId ?? this.mfgIngredientGroupId,
        quantityReturned: quantityReturned ?? this.quantityReturned,
        unitPriceBeforeDiscount:
            unitPriceBeforeDiscount ?? this.unitPriceBeforeDiscount,
        unitPrice: unitPrice ?? this.unitPrice,
        lineDiscountType: lineDiscountType ?? this.lineDiscountType,
        lineDiscountAmount: lineDiscountAmount ?? this.lineDiscountAmount,
        unitPriceIncTax: unitPriceIncTax ?? this.unitPriceIncTax,
        itemTax: itemTax ?? this.itemTax,
        taxId: taxId ?? this.taxId,
        discountId: discountId ?? this.discountId,
        lotNoLineId: lotNoLineId ?? this.lotNoLineId,
        sellLineNote: sellLineNote ?? this.sellLineNote,
        woocommerceLineItemsId:
            woocommerceLineItemsId ?? this.woocommerceLineItemsId,
        soLineId: soLineId ?? this.soLineId,
        soQuantityInvoiced: soQuantityInvoiced ?? this.soQuantityInvoiced,
        resServiceStaffId: resServiceStaffId ?? this.resServiceStaffId,
        resLineOrderStatus: resLineOrderStatus ?? this.resLineOrderStatus,
        resLineOrderStatusColorValue:
            ((resLineOrderStatus == LineOrderStatus.COOKED)
                    ? 0xFFf5365c
                    : (resLineOrderStatus == LineOrderStatus.SERVED)
                        ? 0xFF98D973
                        : 0xFFffc107) ??
                this.resLineOrderStatusColorValue,
        parentSellLineId: parentSellLineId ?? this.parentSellLineId,
        childrenType: childrenType ?? this.childrenType,
        subUnitId: subUnitId ?? this.subUnitId,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        product: product ?? this.product,
        variations: variations ?? this.variations,
      );

  SellLine.fromJson(Map<String, dynamic> json) {
    id = json["id"] == null ? null : json["id"];
    transactionId =
        json["transaction_id"] == null ? null : json["transaction_id"];
    productId = json["product_id"] == null ? null : json["product_id"];
    variationId = json["variation_id"] == null ? null : json["variation_id"];
    quantity = json["quantity"] == null ? 1 : json["quantity"];
    secondaryUnitQuantity = json["secondary_unit_quantity"] == null
        ? null
        : json["secondary_unit_quantity"];
    mfgWastePercent =
        json["mfg_waste_percent"] == null ? null : json["mfg_waste_percent"];
    mfgIngredientGroupId = json["mfg_ingredient_group_id"];
    quantityReturned =
        json["quantity_returned"] == null ? null : json["quantity_returned"];
    unitPriceBeforeDiscount = json["unit_price_before_discount"] == null
        ? null
        : json["unit_price_before_discount"];
    unitPrice = json["unit_price"] == null ? null : json["unit_price"];
    lineDiscountType = json["line_discount_type"] == null
        ? null
        : typeValues.map[json["line_discount_type"]];
    lineDiscountAmount = json["line_discount_amount"] == null
        ? null
        : json["line_discount_amount"];
    unitPriceIncTax =
        json["unit_price_inc_tax"] == null ? null : json["unit_price_inc_tax"];
    itemTax = json["item_tax"] == null ? null : json["item_tax"];
    taxId = json["tax_id"] == null ? null : json["tax_id"];
    discountId = json["discount_id"];
    lotNoLineId = json["lot_no_line_id"];
    sellLineNote =
        json["sell_line_note"] == null ? null : json["sell_line_note"];
    woocommerceLineItemsId = json["woocommerce_line_items_id"];
    soLineId = json["so_line_id"];
    soQuantityInvoiced = json["so_quantity_invoiced"] == null
        ? null
        : json["so_quantity_invoiced"];
    resServiceStaffId = json["res_service_staff_id"];
    try {
      resLineOrderStatus = json["res_line_order_status"] == null
          ? LineOrderStatus.PENDING
          : lineOrderStatusValues
              .map[json["res_line_order_status"].toString().capitalize];
    } catch (e) {
      debugPrint('res_line_order_status -> SellLineModel -> Error => $e');
    }

    /// Line Order Status BG Color
    if (resLineOrderStatus == LineOrderStatus.COOKED) {
      resLineOrderStatusColorValue = 0xFFf5365c;
    } else if (resLineOrderStatus == LineOrderStatus.SERVED) {
      resLineOrderStatusColorValue = 0xFF98D973;
    } else {
      resLineOrderStatusColorValue = 0xFFffc107;
    }

    parentSellLineId = json["parent_sell_line_id"];
    childrenType = json["children_type"] == null ? null : json["children_type"];
    subUnitId = json["sub_unit_id"];
    createdAt = json["created_at"] == null
        ? null
        : DateTime.tryParse('${json["created_at"]}');
    updatedAt = json["updated_at"] == null
        ? null
        : DateTime.tryParse('${json["updated_at"]}');
    try {
      product = json["product"] == null
          ? null
          : productModelFromJson(json["product"]);
    } catch (e) {
      debugPrint('product -> SellLineModel -> Error => $e');
    }
    try {
      variations = json["variations"] == null
          ? null
          : ProductVariation.fromJson(json["variations"]);
    } catch (_e) {
      debugPrint('variations -> SellLineModel -> Error => $_e');
    }
    isSelected = false;
  }

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "transaction_id": transactionId == null ? null : transactionId,
        "product_id": productId == null ? null : productId,
        "variation_id": variationId == null ? null : variationId,
        "quantity": quantity == null ? null : quantity,
        "secondary_unit_quantity":
            secondaryUnitQuantity == null ? null : secondaryUnitQuantity,
        "mfg_waste_percent": mfgWastePercent == null ? null : mfgWastePercent,
        "mfg_ingredient_group_id": mfgIngredientGroupId,
        "quantity_returned": quantityReturned == null ? null : quantityReturned,
        "unit_price_before_discount":
            unitPriceBeforeDiscount == null ? null : unitPriceBeforeDiscount,
        "unit_price": unitPrice == null ? null : unitPrice,
        "line_discount_type": lineDiscountType == null
            ? null
            : typeValues.reverse?[lineDiscountType],
        "line_discount_amount":
            lineDiscountAmount == null ? null : lineDiscountAmount,
        "unit_price_inc_tax": unitPriceIncTax == null ? null : unitPriceIncTax,
        "item_tax": itemTax == null ? null : itemTax,
        "tax_id": taxId == null ? null : taxId,
        "discount_id": discountId,
        "lot_no_line_id": lotNoLineId,
        "sell_line_note": sellLineNote == null ? null : sellLineNote,
        "woocommerce_line_items_id": woocommerceLineItemsId,
        "so_line_id": soLineId,
        "so_quantity_invoiced":
            soQuantityInvoiced == null ? null : soQuantityInvoiced,
        "res_service_staff_id": resServiceStaffId,
        "res_line_order_status": resLineOrderStatus == null
            ? null
            : lineOrderStatusValues
                .reverse?[resLineOrderStatus ?? LineOrderStatus.PENDING],
        "parent_sell_line_id": parentSellLineId,
        "children_type": childrenType == null ? null : childrenType,
        "sub_unit_id": subUnitId,
        "created_at": createdAt == null ? null : createdAt?.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt?.toIso8601String(),
        "product": product != null ? productModelToJson(product!) : null,
        "variations": variations,
      };
}
