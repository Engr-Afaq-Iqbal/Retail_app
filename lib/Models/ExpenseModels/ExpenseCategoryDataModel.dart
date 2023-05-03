ExpenseCategoryDataModel? expenseCategoryDataModelFromJson(
        Map<String, dynamic> str) =>
    ExpenseCategoryDataModel.fromJson(str);

Map<String, dynamic> expenseCategoryDataModelToJson(
        ExpenseCategoryDataModel data) =>
    data.toJson();

class ExpenseCategoryDataModel {
  ExpenseCategoryDataModel({
    this.id,
    this.name,
    this.businessId,
    this.code,
    this.parentId,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? name;
  int? businessId;
  dynamic code;
  dynamic parentId;
  dynamic deletedAt;
  DateTime? createdAt;
  DateTime? updatedAt;

  ExpenseCategoryDataModel copyWith({
    int? id,
    String? name,
    int? businessId,
    dynamic code,
    dynamic parentId,
    dynamic deletedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      ExpenseCategoryDataModel(
        id: id ?? this.id,
        name: name ?? this.name,
        businessId: businessId ?? this.businessId,
        code: code ?? this.code,
        parentId: parentId ?? this.parentId,
        deletedAt: deletedAt ?? this.deletedAt,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory ExpenseCategoryDataModel.fromJson(Map<String, dynamic> json) =>
      ExpenseCategoryDataModel(
        id: json["id"],
        name: json["name"],
        businessId: json["business_id"],
        code: json["code"],
        parentId: json["parent_id"],
        deletedAt: json["deleted_at"],
        createdAt: DateTime.tryParse('${json["created_at"]}'),
        updatedAt: DateTime.tryParse('${json["updated_at"]}'),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "business_id": businessId,
        "code": code,
        "parent_id": parentId,
        "deleted_at": deletedAt,
        "created_at": createdAt == null ? null : createdAt?.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt?.toIso8601String(),
      };
}
