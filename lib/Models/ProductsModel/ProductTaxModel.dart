import '/Config/enums.dart';

ProductTaxModel productTaxModelFromJson(Map<String, dynamic> jsonKeyData) =>
    ProductTaxModel.fromJson(jsonKeyData);

class ProductTaxModel {
  ProductTaxModel({
    this.id,
    this.businessId,
    this.name,
    this.amount,
    this.isTaxGroup,
    this.forTaxGroup,
    this.createdBy,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  final int? id;
  final int? businessId;
  final ProductTaxName? name;
  final int? amount;
  final int? isTaxGroup;
  final int? forTaxGroup;
  final int? createdBy;
  final DateTime? deletedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  // ProductTax copyWith({
  //   int id,
  //   int businessId,
  //   ProductTaxName name,
  //   int amount,
  //   int isTaxGroup,
  //   int forTaxGroup,
  //   int createdBy,
  //   dynamic deletedAt,
  //   DateTime createdAt,
  //   DateTime updatedAt,
  // }) =>
  //     ProductTax(
  //       id: id ?? this.id,
  //       businessId: businessId ?? this.businessId,
  //       name: name ?? this.name,
  //       amount: amount ?? this.amount,
  //       isTaxGroup: isTaxGroup ?? this.isTaxGroup,
  //       forTaxGroup: forTaxGroup ?? this.forTaxGroup,
  //       createdBy: createdBy ?? this.createdBy,
  //       deletedAt: deletedAt ?? this.deletedAt,
  //       createdAt: createdAt ?? this.createdAt,
  //       updatedAt: updatedAt ?? this.updatedAt,
  //     );

  factory ProductTaxModel.fromJson(Map<String, dynamic> json) => ProductTaxModel(
        id: json["id"],
        businessId: json["business_id"],
        name: json["name"] != null ? productTaxNameValues.map[json["name"]] : null,
        amount: json["amount"],
        isTaxGroup: json["is_tax_group"],
        forTaxGroup: json["for_tax_group"],
        createdBy: json["created_by"],
        deletedAt: json["deleted_at"] != null ? DateTime.tryParse('${json["deleted_at"]}') : null,
        createdAt: json["created_at"] != null ? DateTime.tryParse('${json["created_at"]}') : null,
        updatedAt: json["updated_at"] != null ? DateTime.tryParse('${json["updated_at"]}') : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "business_id": businessId,
        "name": productTaxNameValues.reverse?[name],
        "amount": amount,
        "is_tax_group": isTaxGroup,
        "for_tax_group": forTaxGroup,
        "created_by": createdBy,
        "deleted_at": deletedAt != null ? deletedAt?.toIso8601String() : null,
        "created_at": createdAt != null ? createdAt?.toIso8601String() : null,
        "updated_at": updatedAt != null ? updatedAt?.toIso8601String() : null,
      };
}
