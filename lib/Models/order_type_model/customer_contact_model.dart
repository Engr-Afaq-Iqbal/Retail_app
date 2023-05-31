// To parse this JSON data, do
//
//     final customerContactModel = customerContactModelFromJson(jsonString);

import 'dart:convert';

ContactModel contactModelFromJson(String str) =>
    ContactModel.fromJson(json.decode(str));

String contactModelToJson(ContactModel data) => json.encode(data.toJson());

class ContactModel {
  ContactModel({
    this.contactDataList = const [],
    this.links,
    this.meta,
  });

  final List<ContactDataModel> contactDataList;
  final Links? links;
  final Meta? meta;

  ContactModel copyWith({
    List<ContactDataModel>? customers,
    Links? links,
    Meta? meta,
  }) =>
      ContactModel(
        contactDataList: customers ?? this.contactDataList,
        links: links ?? this.links,
        meta: meta ?? this.meta,
      );

  factory ContactModel.fromJson(Map<String, dynamic> json) => ContactModel(
        contactDataList: List<ContactDataModel>.from(
            json["data"].map((x) => contactDataModelFromJson(x))),
        links: (json["links"] != null) ? Links.fromJson(json["links"]) : null,
        meta: (json["meta"] != null) ? Meta.fromJson(json["meta"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(
            contactDataList.map((x) => contactDataModelToJson(x))),
        "links": links?.toJson(),
        "meta": meta?.toJson(),
      };
}

ContactDataModel contactDataModelFromJson(Map<String, dynamic> x) =>
    ContactDataModel.fromJson(x);

Map<String, dynamic> contactDataModelToJson(ContactDataModel data) =>
    data.toJson();

class ContactDataModel {
  ContactDataModel({
    required this.id,
    required this.businessId,
    required this.type,
    this.supplierBusinessName,
    this.name,
    this.prefix,
    this.firstName,
    this.middleName,
    this.lastName,
    this.email,
    this.contactId,
    this.contactStatus,
    this.taxNumber,
    this.city,
    this.state,
    this.country,
    this.addressLine1,
    this.addressLine2,
    this.zipCode,
    this.dob,
    this.mobile,
    this.landline,
    this.alternateNumber,
    this.payTermNumber,
    this.payTermType,
    this.creditLimit,
    this.createdBy,
    this.convertedBy,
    this.convertedOn,
    this.balance,
    this.totalRp,
    this.totalRpUsed,
    this.totalRpExpired,
    this.isDefault,
    this.shippingAddress,
    this.shippingCustomFieldDetails,
    this.isExport,
    this.exportCustomField1,
    this.exportCustomField2,
    this.exportCustomField3,
    this.exportCustomField4,
    this.exportCustomField5,
    this.exportCustomField6,
    this.position,
    this.customerGroupId,
    this.crmSource,
    this.crmLifeStage,
    this.customField1,
    this.customField2,
    this.customField3,
    this.customField4,
    this.customField5,
    this.customField6,
    this.customField7,
    this.customField8,
    this.customField9,
    this.customField10,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  final int id;
  final int businessId;
  final String type;
  final String? supplierBusinessName;
  final String? name;
  final dynamic prefix;
  final String? firstName;
  final String? middleName;
  final String? lastName;
  final String? email;
  final String? contactId;
  final String? contactStatus;
  final String? taxNumber;
  final String? city;
  final String? state;
  final String? country;
  final String? addressLine1;
  final String? addressLine2;
  final String? zipCode;
  final String? dob;
  final String? mobile;
  final String? landline;
  final String? alternateNumber;
  final int? payTermNumber;
  final String? payTermType;
  final dynamic creditLimit;
  final int? createdBy;
  final dynamic convertedBy;
  final dynamic convertedOn;
  final String? balance;
  final int? totalRp;
  final int? totalRpUsed;
  final int? totalRpExpired;
  final int? isDefault;
  final String? shippingAddress;
  final dynamic shippingCustomFieldDetails;
  final int? isExport;
  final dynamic exportCustomField1;
  final dynamic exportCustomField2;
  final dynamic exportCustomField3;
  final dynamic exportCustomField4;
  final dynamic exportCustomField5;
  final dynamic exportCustomField6;
  final dynamic position;
  final dynamic customerGroupId;
  final dynamic crmSource;
  final dynamic crmLifeStage;
  final dynamic customField1;
  final dynamic customField2;
  final dynamic customField3;
  final dynamic customField4;
  final dynamic customField5;
  final dynamic customField6;
  final dynamic customField7;
  final dynamic customField8;
  final dynamic customField9;
  final dynamic customField10;
  final DateTime? deletedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  ContactDataModel copyWith({
    int? id,
    int? businessId,
    String? type,
    String? supplierBusinessName,
    String? name,
    dynamic prefix,
    String? firstName,
    String? middleName,
    String? lastName,
    String? email,
    String? contactId,
    String? contactStatus,
    String? taxNumber,
    String? city,
    String? state,
    String? country,
    String? addressLine1,
    String? addressLine2,
    String? zipCode,
    String? dob,
    String? mobile,
    String? landline,
    String? alternateNumber,
    int? payTermNumber,
    String? payTermType,
    dynamic creditLimit,
    int? createdBy,
    dynamic convertedBy,
    dynamic convertedOn,
    String? balance,
    int? totalRp,
    int? totalRpUsed,
    int? totalRpExpired,
    int? isDefault,
    String? shippingAddress,
    dynamic shippingCustomFieldDetails,
    int? isExport,
    dynamic exportCustomField1,
    dynamic exportCustomField2,
    dynamic exportCustomField3,
    dynamic exportCustomField4,
    dynamic exportCustomField5,
    dynamic exportCustomField6,
    dynamic position,
    dynamic customerGroupId,
    dynamic crmSource,
    dynamic crmLifeStage,
    dynamic customField1,
    dynamic customField2,
    dynamic customField3,
    dynamic customField4,
    dynamic customField5,
    dynamic customField6,
    dynamic customField7,
    dynamic customField8,
    dynamic customField9,
    dynamic customField10,
    DateTime? deletedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      ContactDataModel(
        id: id ?? this.id,
        businessId: businessId ?? this.businessId,
        type: type ?? this.type,
        supplierBusinessName: supplierBusinessName ?? this.supplierBusinessName,
        name: name ?? this.name,
        prefix: prefix ?? this.prefix,
        firstName: firstName ?? this.firstName,
        middleName: middleName ?? this.middleName,
        lastName: lastName ?? this.lastName,
        email: email ?? this.email,
        contactId: contactId ?? this.contactId,
        contactStatus: contactStatus ?? this.contactStatus,
        taxNumber: taxNumber ?? this.taxNumber,
        city: city ?? this.city,
        state: state ?? this.state,
        country: country ?? this.country,
        addressLine1: addressLine1 ?? this.addressLine1,
        addressLine2: addressLine2 ?? this.addressLine2,
        zipCode: zipCode ?? this.zipCode,
        dob: dob ?? this.dob,
        mobile: mobile ?? this.mobile,
        landline: landline ?? this.landline,
        alternateNumber: alternateNumber ?? this.alternateNumber,
        payTermNumber: payTermNumber ?? this.payTermNumber,
        payTermType: payTermType ?? this.payTermType,
        creditLimit: creditLimit ?? this.creditLimit,
        createdBy: createdBy ?? this.createdBy,
        convertedBy: convertedBy ?? this.convertedBy,
        convertedOn: convertedOn ?? this.convertedOn,
        balance: balance ?? this.balance,
        totalRp: totalRp ?? this.totalRp,
        totalRpUsed: totalRpUsed ?? this.totalRpUsed,
        totalRpExpired: totalRpExpired ?? this.totalRpExpired,
        isDefault: isDefault ?? this.isDefault,
        shippingAddress: shippingAddress ?? this.shippingAddress,
        shippingCustomFieldDetails:
            shippingCustomFieldDetails ?? this.shippingCustomFieldDetails,
        isExport: isExport ?? this.isExport,
        exportCustomField1: exportCustomField1 ?? this.exportCustomField1,
        exportCustomField2: exportCustomField2 ?? this.exportCustomField2,
        exportCustomField3: exportCustomField3 ?? this.exportCustomField3,
        exportCustomField4: exportCustomField4 ?? this.exportCustomField4,
        exportCustomField5: exportCustomField5 ?? this.exportCustomField5,
        exportCustomField6: exportCustomField6 ?? this.exportCustomField6,
        position: position ?? this.position,
        customerGroupId: customerGroupId ?? this.customerGroupId,
        crmSource: crmSource ?? this.crmSource,
        crmLifeStage: crmLifeStage ?? this.crmLifeStage,
        customField1: customField1 ?? this.customField1,
        customField2: customField2 ?? this.customField2,
        customField3: customField3 ?? this.customField3,
        customField4: customField4 ?? this.customField4,
        customField5: customField5 ?? this.customField5,
        customField6: customField6 ?? this.customField6,
        customField7: customField7 ?? this.customField7,
        customField8: customField8 ?? this.customField8,
        customField9: customField9 ?? this.customField9,
        customField10: customField10 ?? this.customField10,
        deletedAt: deletedAt ?? this.deletedAt,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory ContactDataModel.fromJson(Map<String, dynamic> json) =>
      ContactDataModel(
        id: json["id"],
        businessId: json["business_id"] == null ? 0 : json["business_id"],
        type: json["type"],
        supplierBusinessName: json["supplier_business_name"],
        name: json["name"],
        prefix: json["prefix"],
        firstName: json["first_name"],
        middleName: json["middle_name"],
        lastName: json["last_name"],
        email: json["email"],
        contactId: json["contact_id"],
        contactStatus: json["contact_status"],
        taxNumber: json["tax_number"],
        city: json["city"],
        state: json["state"],
        country: json["country"],
        addressLine1: json["address_line_1"],
        addressLine2: json["address_line_2"],
        zipCode: json["zip_code"],
        dob: json["dob"],
        mobile: json["mobile"],
        landline: json["landline"],
        alternateNumber: json["alternate_number"],
        payTermNumber: json["pay_term_number"],
        payTermType: json["pay_term_type"],
        creditLimit: json["credit_limit"],
        createdBy: json["created_by"],
        convertedBy: json["converted_by"],
        convertedOn: json["converted_on"],
        balance: json["balance"],
        totalRp: json["total_rp"],
        totalRpUsed: json["total_rp_used"],
        totalRpExpired: json["total_rp_expired"],
        isDefault: json["is_default"],
        shippingAddress: json["shipping_address"],
        shippingCustomFieldDetails: json["shipping_custom_field_details"],
        isExport: json["is_export"],
        exportCustomField1: json["export_custom_field_1"],
        exportCustomField2: json["export_custom_field_2"],
        exportCustomField3: json["export_custom_field_3"],
        exportCustomField4: json["export_custom_field_4"],
        exportCustomField5: json["export_custom_field_5"],
        exportCustomField6: json["export_custom_field_6"],
        position: json["position"],
        customerGroupId: json["customer_group_id"],
        crmSource: json["crm_source"],
        crmLifeStage: json["crm_life_stage"],
        customField1: json["custom_field1"],
        customField2: json["custom_field2"],
        customField3: json["custom_field3"],
        customField4: json["custom_field4"],
        customField5: json["custom_field5"],
        customField6: json["custom_field6"],
        customField7: json["custom_field7"],
        customField8: json["custom_field8"],
        customField9: json["custom_field9"],
        customField10: json["custom_field10"],
        deletedAt: DateTime.tryParse('${json["deleted_at"]}'),
        createdAt: DateTime.tryParse('${json["created_at"]}'),
        updatedAt: DateTime.tryParse('${json["updated_at"]}'),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "business_id": businessId,
        "type": type,
        "supplier_business_name": supplierBusinessName,
        "name": name,
        "prefix": prefix,
        "first_name": firstName,
        "middle_name": middleName,
        "last_name": lastName,
        "email": email,
        "contact_id": contactId,
        "contact_status": contactStatus,
        "tax_number": taxNumber,
        "city": city,
        "state": state,
        "country": country,
        "address_line_1": addressLine1,
        "address_line_2": addressLine2,
        "zip_code": zipCode,
        "dob": dob,
        "mobile": mobile,
        "landline": landline,
        "alternate_number": alternateNumber,
        "pay_term_number": payTermNumber,
        "pay_term_type": payTermType,
        "credit_limit": creditLimit,
        "created_by": createdBy,
        "converted_by": convertedBy,
        "converted_on": convertedOn,
        "balance": balance,
        "total_rp": totalRp,
        "total_rp_used": totalRpUsed,
        "total_rp_expired": totalRpExpired,
        "is_default": isDefault,
        "shipping_address": shippingAddress,
        "shipping_custom_field_details": shippingCustomFieldDetails,
        "is_export": isExport,
        "export_custom_field_1": exportCustomField1,
        "export_custom_field_2": exportCustomField2,
        "export_custom_field_3": exportCustomField3,
        "export_custom_field_4": exportCustomField4,
        "export_custom_field_5": exportCustomField5,
        "export_custom_field_6": exportCustomField6,
        "position": position,
        "customer_group_id": customerGroupId,
        "crm_source": crmSource,
        "crm_life_stage": crmLifeStage,
        "custom_field1": customField1,
        "custom_field2": customField2,
        "custom_field3": customField3,
        "custom_field4": customField4,
        "custom_field5": customField5,
        "custom_field6": customField6,
        "custom_field7": customField7,
        "custom_field8": customField8,
        "custom_field9": customField9,
        "custom_field10": customField10,
        "deleted_at": deletedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class Links {
  Links({
    this.first,
    this.last,
    this.prev,
    this.next,
  });

  final String? first;
  final String? last;
  final String? prev;
  final String? next;

  Links copyWith({
    String? first,
    String? last,
    String? prev,
    String? next,
  }) =>
      Links(
        first: first ?? this.first,
        last: last ?? this.last,
        prev: prev ?? this.prev,
        next: next ?? this.next,
      );

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        first: json["first"],
        last: json["last"],
        prev: json["prev"],
        next: json["next"],
      );

  Map<String, dynamic> toJson() => {
        "first": first,
        "last": last,
        "prev": prev,
        "next": next,
      };
}

class Meta {
  Meta({
    this.currentPage,
    this.from,
    this.lastPage,
    this.path,
    this.perPage,
    this.to,
    this.total,
  });

  final int? currentPage;
  final int? from;
  final int? lastPage;
  final String? path;
  final int? perPage;
  final int? to;
  final int? total;

  Meta copyWith({
    int? currentPage,
    int? from,
    int? lastPage,
    String? path,
    int? perPage,
    int? to,
    int? total,
  }) =>
      Meta(
        currentPage: currentPage ?? this.currentPage,
        from: from ?? this.from,
        lastPage: lastPage ?? this.lastPage,
        path: path ?? this.path,
        perPage: perPage ?? this.perPage,
        to: to ?? this.to,
        total: total ?? this.total,
      );

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        currentPage: json["current_page"],
        from: json["from"],
        lastPage: json["last_page"],
        path: json["path"],
        perPage: json["per_page"],
        to: json["to"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "from": from,
        "last_page": lastPage,
        "path": path,
        "per_page": perPage,
        "to": to,
        "total": total,
      };
}
