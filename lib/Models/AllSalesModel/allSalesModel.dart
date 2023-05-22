// To parse this JSON data, do
//
//     final allSalesModel = allSalesModelFromJson(jsonString);

import 'dart:convert';

AllSalesModel allSalesModelFromJson(String str) =>
    AllSalesModel.fromJson(json.decode(str));

String allSalesModelToJson(AllSalesModel data) => json.encode(data.toJson());

class AllSalesModel {
  List<Datum>? data;
  Links? links;
  Meta? meta;

  AllSalesModel({
    this.data,
    this.links,
    this.meta,
  });

  factory AllSalesModel.fromJson(Map<String, dynamic> json) => AllSalesModel(
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        links: json["links"] == null ? null : Links.fromJson(json["links"]),
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "links": links?.toJson(),
        "meta": meta?.toJson(),
      };
}

class Datum {
  int? id;
  int? isSuspend;
  int? businessId;
  int? locationId;
  int? resTableId;
  int? resWaiterId;
  DateTime? transactionDate;
  DatumType? type;
  int? contactId;
  int? isDirectSale;
  String? invoiceNo;
  String? invoiceNoText;
  FirstNameEnum? name;
  String? mobile;
  dynamic supplierBusinessName;
  DatumStatus? status;
  PaymentStatus? paymentStatus;
  String? finalTotal;
  String? taxAmount;
  String? discountAmount;
  String? discountType;
  String? totalBeforeTax;
  int? rpRedeemed;
  String? rpRedeemedAmount;
  int? rpEarned;
  int? typesOfServiceId;
  String? shippingStatus;
  dynamic payTermNumber;
  dynamic payTermType;
  String? additionalNotes;
  dynamic staffNote;
  String? shippingDetails;
  dynamic document;
  DateTime? createdAt;
  dynamic shippingCustomField1;
  dynamic shippingCustomField2;
  dynamic shippingCustomField3;
  dynamic shippingCustomField4;
  dynamic shippingCustomField5;
  dynamic customField1;
  dynamic customField2;
  dynamic customField3;
  dynamic customField4;
  int? createdBy;
  String? roundOffAmount;
  String? shippingCharges;
  String? saleDate;
  AddedBy? addedBy;
  String? totalPaid;
  BusinessLocation? businessLocation;
  int? returnExists;
  dynamic returnPaid;
  String? amountReturn;
  int? returnTransactionId;
  String? typesOfServiceName;
  dynamic serviceCustomField1;
  int? totalItems;
  AddedBy? waiter;
  String? tableName;
  String? soQtyRemaining;
  int? isExport;
  double? sellDue;
  String? resOrderStatus;
  double? sellReturnDue;
  double? totalItemTax;
  PaymentMethod? paymentMethod;
  List<SellLin>? sellLines;
  SalesPerson? serviceStaff;
  SalesPerson? salesPerson;
  Table? table;
  Location? location;
  List<PaymentLine>? paymentLines;
  Contact? contact;
  List<SellLin>? sellLins;
  TypesOfService? typesOfService;
  String? invoiceUrl;
  String? paymentLink;

  Datum({
    this.id,
    this.isSuspend,
    this.businessId,
    this.locationId,
    this.resTableId,
    this.resWaiterId,
    this.transactionDate,
    this.type,
    this.contactId,
    this.isDirectSale,
    this.invoiceNo,
    this.invoiceNoText,
    this.name,
    this.mobile,
    this.supplierBusinessName,
    this.status,
    this.paymentStatus,
    this.finalTotal,
    this.taxAmount,
    this.discountAmount,
    this.discountType,
    this.totalBeforeTax,
    this.rpRedeemed,
    this.rpRedeemedAmount,
    this.rpEarned,
    this.typesOfServiceId,
    this.shippingStatus,
    this.payTermNumber,
    this.payTermType,
    this.additionalNotes,
    this.staffNote,
    this.shippingDetails,
    this.document,
    this.createdAt,
    this.shippingCustomField1,
    this.shippingCustomField2,
    this.shippingCustomField3,
    this.shippingCustomField4,
    this.shippingCustomField5,
    this.customField1,
    this.customField2,
    this.customField3,
    this.customField4,
    this.createdBy,
    this.roundOffAmount,
    this.shippingCharges,
    this.saleDate,
    this.addedBy,
    this.totalPaid,
    this.businessLocation,
    this.returnExists,
    this.returnPaid,
    this.amountReturn,
    this.returnTransactionId,
    this.typesOfServiceName,
    this.serviceCustomField1,
    this.totalItems,
    this.waiter,
    this.tableName,
    this.soQtyRemaining,
    this.isExport,
    this.sellDue,
    this.resOrderStatus,
    this.sellReturnDue,
    this.totalItemTax,
    this.paymentMethod,
    this.sellLines,
    this.serviceStaff,
    this.salesPerson,
    this.table,
    this.location,
    this.paymentLines,
    this.contact,
    this.sellLins,
    this.typesOfService,
    this.invoiceUrl,
    this.paymentLink,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        isSuspend: json["is_suspend"],
        businessId: json["business_id"],
        locationId: json["location_id"],
        resTableId: json["res_table_id"],
        resWaiterId: json["res_waiter_id"],
        transactionDate: json["transaction_date"] == null
            ? null
            : DateTime.parse(json["transaction_date"]),
        type: datumTypeValues.map[json["type"]]!,
        contactId: json["contact_id"],
        isDirectSale: json["is_direct_sale"],
        invoiceNo: json["invoice_no"],
        invoiceNoText: json["invoice_no_text"],
        name: firstNameEnumValues.map[json["name"]]!,
        mobile: json["mobile"],
        supplierBusinessName: json["supplier_business_name"],
        status: datumStatusValues.map[json["status"]]!,
        paymentStatus: paymentStatusValues.map[json["payment_status"]]!,
        finalTotal: json["final_total"],
        taxAmount: json["tax_amount"],
        discountAmount: json["discount_amount"],
        discountType: json["discount_type"],
        totalBeforeTax: json["total_before_tax"],
        rpRedeemed: json["rp_redeemed"],
        rpRedeemedAmount: json["rp_redeemed_amount"],
        rpEarned: json["rp_earned"],
        typesOfServiceId: json["types_of_service_id"],
        shippingStatus: json["shipping_status"],
        payTermNumber: json["pay_term_number"],
        payTermType: json["pay_term_type"],
        additionalNotes: json["additional_notes"],
        staffNote: json["staff_note"],
        shippingDetails: json["shipping_details"],
        document: json["document"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        shippingCustomField1: json["shipping_custom_field_1"],
        shippingCustomField2: json["shipping_custom_field_2"],
        shippingCustomField3: json["shipping_custom_field_3"],
        shippingCustomField4: json["shipping_custom_field_4"],
        shippingCustomField5: json["shipping_custom_field_5"],
        customField1: json["custom_field_1"],
        customField2: json["custom_field_2"],
        customField3: json["custom_field_3"],
        customField4: json["custom_field_4"],
        createdBy: json["created_by"],
        roundOffAmount: json["round_off_amount"],
        shippingCharges: json["shipping_charges"],
        saleDate: json["sale_date"],
        addedBy: addedByValues.map[json["added_by"]]!,
        totalPaid: json["total_paid"],
        businessLocation:
            businessLocationValues.map[json["business_location"]]!,
        returnExists: json["return_exists"],
        returnPaid: json["return_paid"],
        amountReturn: json["amount_return"],
        returnTransactionId: json["return_transaction_id"],
        typesOfServiceName: json["types_of_service_name"],
        serviceCustomField1: json["service_custom_field_1"],
        totalItems: json["total_items"],
        waiter: addedByValues.map[json["waiter"]]!,
        tableName: json["table_name"],
        soQtyRemaining: json["so_qty_remaining"],
        isExport: json["is_export"],
        sellDue: json["sell_due"]?.toDouble(),
        resOrderStatus: json["res_order_status"],
        sellReturnDue: json["sell_return_due"]?.toDouble(),
        totalItemTax: json["total_item_tax"]?.toDouble(),
        paymentMethod: paymentMethodValues.map[json["payment_method"]]!,
        sellLines: json["sell_lines"] == null
            ? []
            : List<SellLin>.from(
                json["sell_lines"]!.map((x) => SellLin.fromJson(x))),
        serviceStaff: json["service_staff"] == null
            ? null
            : SalesPerson.fromJson(json["service_staff"]),
        salesPerson: json["sales_person"] == null
            ? null
            : SalesPerson.fromJson(json["sales_person"]),
        table: json["table"] == null ? null : Table.fromJson(json["table"]),
        location: json["location"] == null
            ? null
            : Location.fromJson(json["location"]),
        paymentLines: json["payment_lines"] == null
            ? []
            : List<PaymentLine>.from(
                json["payment_lines"]!.map((x) => PaymentLine.fromJson(x))),
        contact:
            json["contact"] == null ? null : Contact.fromJson(json["contact"]),
        sellLins: json["sell_lins"] == null
            ? []
            : List<SellLin>.from(
                json["sell_lins"]!.map((x) => SellLin.fromJson(x))),
        typesOfService: json["types_of_service"] == null
            ? null
            : TypesOfService.fromJson(json["types_of_service"]),
        invoiceUrl: json["invoice_url"],
        paymentLink: json["payment_link"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "is_suspend": isSuspend,
        "business_id": businessId,
        "location_id": locationId,
        "res_table_id": resTableId,
        "res_waiter_id": resWaiterId,
        "transaction_date": transactionDate?.toIso8601String(),
        "type": datumTypeValues.reverse[type],
        "contact_id": contactId,
        "is_direct_sale": isDirectSale,
        "invoice_no": invoiceNo,
        "invoice_no_text": invoiceNoText,
        "name": firstNameEnumValues.reverse[name],
        "mobile": mobile,
        "supplier_business_name": supplierBusinessName,
        "status": datumStatusValues.reverse[status],
        "payment_status": paymentStatusValues.reverse[paymentStatus],
        "final_total": finalTotal,
        "tax_amount": taxAmount,
        "discount_amount": discountAmount,
        "discount_type": discountType,
        "total_before_tax": totalBeforeTax,
        "rp_redeemed": rpRedeemed,
        "rp_redeemed_amount": rpRedeemedAmount,
        "rp_earned": rpEarned,
        "types_of_service_id": typesOfServiceId,
        "shipping_status": shippingStatus,
        "pay_term_number": payTermNumber,
        "pay_term_type": payTermType,
        "additional_notes": additionalNotes,
        "staff_note": staffNote,
        "shipping_details": shippingDetails,
        "document": document,
        "created_at": createdAt?.toIso8601String(),
        "shipping_custom_field_1": shippingCustomField1,
        "shipping_custom_field_2": shippingCustomField2,
        "shipping_custom_field_3": shippingCustomField3,
        "shipping_custom_field_4": shippingCustomField4,
        "shipping_custom_field_5": shippingCustomField5,
        "custom_field_1": customField1,
        "custom_field_2": customField2,
        "custom_field_3": customField3,
        "custom_field_4": customField4,
        "created_by": createdBy,
        "round_off_amount": roundOffAmount,
        "shipping_charges": shippingCharges,
        "sale_date": saleDate,
        "added_by": addedByValues.reverse[addedBy],
        "total_paid": totalPaid,
        "business_location": businessLocationValues.reverse[businessLocation],
        "return_exists": returnExists,
        "return_paid": returnPaid,
        "amount_return": amountReturn,
        "return_transaction_id": returnTransactionId,
        "types_of_service_name": typesOfServiceName,
        "service_custom_field_1": serviceCustomField1,
        "total_items": totalItems,
        "waiter": addedByValues.reverse[waiter],
        "table_name": tableName,
        "so_qty_remaining": soQtyRemaining,
        "is_export": isExport,
        "sell_due": sellDue,
        "res_order_status": resOrderStatus,
        "sell_return_due": sellReturnDue,
        "total_item_tax": totalItemTax,
        "payment_method": paymentMethodValues.reverse[paymentMethod],
        "sell_lines": sellLines == null
            ? []
            : List<dynamic>.from(sellLines!.map((x) => x.toJson())),
        "service_staff": serviceStaff?.toJson(),
        "sales_person": salesPerson?.toJson(),
        "table": table?.toJson(),
        "location": location?.toJson(),
        "payment_lines": paymentLines == null
            ? []
            : List<dynamic>.from(paymentLines!.map((x) => x.toJson())),
        "contact": contact?.toJson(),
        "sell_lins": sellLins == null
            ? []
            : List<dynamic>.from(sellLins!.map((x) => x.toJson())),
        "types_of_service": typesOfService?.toJson(),
        "invoice_url": invoiceUrl,
        "payment_link": paymentLink,
      };
}

enum AddedBy { HASEEB_BIN_OMER_SYED, EMPTY, NAFEES }

final addedByValues = EnumValues({
  "  ": AddedBy.EMPTY,
  " Haseeb Bin Omer Syed": AddedBy.HASEEB_BIN_OMER_SYED,
  " Nafees ": AddedBy.NAFEES
});

enum BusinessLocation { RESTAURANT }

final businessLocationValues =
    EnumValues({"Restaurant": BusinessLocation.RESTAURANT});

class Contact {
  int? id;
  int? businessId;
  ContactType? type;
  dynamic supplierBusinessName;
  FirstNameEnum? name;
  dynamic prefix;
  FirstNameEnum? firstName;
  dynamic middleName;
  dynamic lastName;
  dynamic email;
  ContactId? contactId;
  ContactStatusEnum? contactStatus;
  dynamic taxNumber;
  dynamic city;
  dynamic state;
  dynamic country;
  dynamic addressLine1;
  dynamic addressLine2;
  dynamic zipCode;
  dynamic dob;
  String? mobile;
  dynamic landline;
  dynamic alternateNumber;
  dynamic payTermNumber;
  dynamic payTermType;
  String? creditLimit;
  int? createdBy;
  dynamic convertedBy;
  dynamic convertedOn;
  String? balance;
  int? totalRp;
  int? totalRpUsed;
  int? totalRpExpired;
  int? isDefault;
  dynamic shippingAddress;
  dynamic shippingCustomFieldDetails;
  int? isExport;
  dynamic exportCustomField1;
  dynamic exportCustomField2;
  dynamic exportCustomField3;
  dynamic exportCustomField4;
  dynamic exportCustomField5;
  dynamic exportCustomField6;
  dynamic position;
  dynamic customerGroupId;
  dynamic crmSource;
  dynamic crmLifeStage;
  dynamic customField1;
  dynamic customField2;
  dynamic customField3;
  dynamic customField4;
  dynamic customField5;
  dynamic customField6;
  dynamic customField7;
  dynamic customField8;
  dynamic customField9;
  dynamic customField10;
  dynamic deletedAt;
  DateTime? createdAt;
  DateTime? updatedAt;

  Contact({
    this.id,
    this.businessId,
    this.type,
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

  factory Contact.fromJson(Map<String, dynamic> json) => Contact(
        id: json["id"],
        businessId: json["business_id"],
        type: contactTypeValues.map[json["type"]]!,
        supplierBusinessName: json["supplier_business_name"],
        name: firstNameEnumValues.map[json["name"]]!,
        prefix: json["prefix"],
        firstName: firstNameEnumValues.map[json["first_name"]],
        middleName: json["middle_name"],
        lastName: json["last_name"],
        email: json["email"],
        contactId: contactIdValues.map[json["contact_id"]],
        contactStatus: contactStatusEnumValues.map[json["contact_status"]],
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
        "type": contactTypeValues.reverse[type],
        "supplier_business_name": supplierBusinessName,
        "name": firstNameEnumValues.reverse[name],
        "prefix": prefix,
        "first_name": firstNameEnumValues.reverse[firstName],
        "middle_name": middleName,
        "last_name": lastName,
        "email": email,
        "contact_id": contactIdValues.reverse[contactId],
        "contact_status": contactStatusEnumValues.reverse[contactStatus],
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
        "deleted_at": deletedAt,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

enum ContactId { CO0001 }

final contactIdValues = EnumValues({"CO0001": ContactId.CO0001});

enum ContactStatusEnum { ACTIVE }

final contactStatusEnumValues =
    EnumValues({"active": ContactStatusEnum.ACTIVE});

enum FirstNameEnum { WALK_IN_CUSTOMER, WALK_IN }

final firstNameEnumValues = EnumValues({
  "Walk-In": FirstNameEnum.WALK_IN,
  "Walk-In Customer": FirstNameEnum.WALK_IN_CUSTOMER
});

enum ContactType { CUSTOMER }

final contactTypeValues = EnumValues({"customer": ContactType.CUSTOMER});

class Location {
  int? id;
  int? businessId;
  LocationId? locationId;
  BusinessLocation? name;
  Landmark? landmark;
  Country? country;
  City? state;
  City? city;
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
  dynamic email;
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

  Location({
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
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        id: json["id"],
        businessId: json["business_id"],
        locationId: locationIdValues.map[json["location_id"]]!,
        name: businessLocationValues.map[json["name"]]!,
        landmark: landmarkValues.map[json["landmark"]]!,
        country: countryValues.map[json["country"]]!,
        state: cityValues.map[json["state"]]!,
        city: cityValues.map[json["city"]]!,
        zipCode: json["zip_code"],
        invoiceSchemeId: json["invoice_scheme_id"],
        invoiceLayoutId: json["invoice_layout_id"],
        saleInvoiceLayoutId: json["sale_invoice_layout_id"],
        sellingPriceGroupId: json["selling_price_group_id"],
        printReceiptOnInvoice: json["print_receipt_on_invoice"],
        receiptPrinterType:
            receiptPrinterTypeValues.map[json["receipt_printer_type"]]!,
        printerId: json["printer_id"],
        mobile: json["mobile"],
        alternateNumber: json["alternate_number"],
        email: json["email"],
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
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "business_id": businessId,
        "location_id": locationIdValues.reverse[locationId],
        "name": businessLocationValues.reverse[name],
        "landmark": landmarkValues.reverse[landmark],
        "country": countryValues.reverse[country],
        "state": cityValues.reverse[state],
        "city": cityValues.reverse[city],
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
        "email": email,
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
      };
}

enum City { ABU_DHABI }

final cityValues = EnumValues({"Abu Dhabi": City.ABU_DHABI});

enum Country { UNITED_ARAB_EMIRATES }

final countryValues =
    EnumValues({"United Arab Emirates": Country.UNITED_ARAB_EMIRATES});

enum Landmark { AL_FALAH }

final landmarkValues = EnumValues({"Al Falah": Landmark.AL_FALAH});

enum LocationId { BL0001 }

final locationIdValues = EnumValues({"BL0001": LocationId.BL0001});

enum ReceiptPrinterType { PRINTER }

final receiptPrinterTypeValues =
    EnumValues({"printer": ReceiptPrinterType.PRINTER});

class PaymentLine {
  int? id;
  int? transactionId;
  int? businessId;
  int? isReturn;
  String? amount;
  String? method;
  dynamic paymentType;
  dynamic transactionNo;
  dynamic cardTransactionNumber;
  String? cardNumber;
  String? cardType;
  dynamic cardHolderName;
  String? cardMonth;
  String? cardYear;
  String? cardSecurity;
  String? chequeNumber;
  String? bankAccountNumber;
  DateTime? paidOn;
  int? createdBy;
  int? paidThroughLink;
  dynamic gateway;
  int? isAdvance;
  int? paymentFor;
  dynamic parentId;
  dynamic note;
  dynamic document;
  String? paymentRefNo;
  int? accountId;
  DateTime? createdAt;
  DateTime? updatedAt;

  PaymentLine({
    this.id,
    this.transactionId,
    this.businessId,
    this.isReturn,
    this.amount,
    this.method,
    this.paymentType,
    this.transactionNo,
    this.cardTransactionNumber,
    this.cardNumber,
    this.cardType,
    this.cardHolderName,
    this.cardMonth,
    this.cardYear,
    this.cardSecurity,
    this.chequeNumber,
    this.bankAccountNumber,
    this.paidOn,
    this.createdBy,
    this.paidThroughLink,
    this.gateway,
    this.isAdvance,
    this.paymentFor,
    this.parentId,
    this.note,
    this.document,
    this.paymentRefNo,
    this.accountId,
    this.createdAt,
    this.updatedAt,
  });

  factory PaymentLine.fromJson(Map<String, dynamic> json) => PaymentLine(
        id: json["id"],
        transactionId: json["transaction_id"],
        businessId: json["business_id"],
        isReturn: json["is_return"],
        amount: json["amount"],
        method: json["method"],
        paymentType: json["payment_type"],
        transactionNo: json["transaction_no"],
        cardTransactionNumber: json["card_transaction_number"],
        cardNumber: json["card_number"],
        cardType: json["card_type"],
        cardHolderName: json["card_holder_name"],
        cardMonth: json["card_month"],
        cardYear: json["card_year"],
        cardSecurity: json["card_security"],
        chequeNumber: json["cheque_number"],
        bankAccountNumber: json["bank_account_number"],
        paidOn:
            json["paid_on"] == null ? null : DateTime.parse(json["paid_on"]),
        createdBy: json["created_by"],
        paidThroughLink: json["paid_through_link"],
        gateway: json["gateway"],
        isAdvance: json["is_advance"],
        paymentFor: json["payment_for"],
        parentId: json["parent_id"],
        note: json["note"],
        document: json["document"],
        paymentRefNo: json["payment_ref_no"],
        accountId: json["account_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "transaction_id": transactionId,
        "business_id": businessId,
        "is_return": isReturn,
        "amount": amount,
        "method": method,
        "payment_type": paymentType,
        "transaction_no": transactionNo,
        "card_transaction_number": cardTransactionNumber,
        "card_number": cardNumber,
        "card_type": cardType,
        "card_holder_name": cardHolderName,
        "card_month": cardMonth,
        "card_year": cardYear,
        "card_security": cardSecurity,
        "cheque_number": chequeNumber,
        "bank_account_number": bankAccountNumber,
        "paid_on": paidOn?.toIso8601String(),
        "created_by": createdBy,
        "paid_through_link": paidThroughLink,
        "gateway": gateway,
        "is_advance": isAdvance,
        "payment_for": paymentFor,
        "parent_id": parentId,
        "note": note,
        "document": document,
        "payment_ref_no": paymentRefNo,
        "account_id": accountId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

enum PaymentMethod { EMPTY, CASH }

final paymentMethodValues =
    EnumValues({"Cash": PaymentMethod.CASH, "": PaymentMethod.EMPTY});

enum PaymentStatus { DUE }

final paymentStatusValues = EnumValues({"due": PaymentStatus.DUE});

class SalesPerson {
  int? id;
  UserType? userType;
  dynamic surname;
  FirstName? firstName;
  LastName? lastName;
  Username? username;
  Email? email;
  Language? language;
  dynamic contactNo;
  dynamic address;
  int? businessId;
  dynamic availableAt;
  dynamic pausedAt;
  dynamic essentialsDepartmentId;
  dynamic essentialsDesignationId;
  dynamic essentialsSalary;
  EssentialsPayPeriod? essentialsPayPeriod;
  dynamic essentialsPayCycle;
  dynamic maxSalesDiscountPercent;
  int? allowLogin;
  ContactStatusEnum? status;
  dynamic crmContactId;
  int? isCmmsnAgnt;
  String? cmmsnPercent;
  int? selectedContacts;
  dynamic dob;
  Gender? gender;
  MaritalStatus? maritalStatus;
  BloodGroup? bloodGroup;
  String? contactNumber;
  String? altNumber;
  String? familyNumber;
  String? fbLink;
  String? twitterLink;
  String? socialMedia1;
  String? socialMedia2;
  EntAddress? permanentAddress;
  EntAddress? currentAddress;
  GuardianName? guardianName;
  String? customField1;
  String? customField2;
  String? customField3;
  String? customField4;
  String? bankDetails;
  IdProofName? idProofName;
  String? idProofNumber;
  dynamic crmDepartment;
  dynamic crmDesignation;
  dynamic locationId;
  dynamic deletedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? deviceToken;

  SalesPerson({
    this.id,
    this.userType,
    this.surname,
    this.firstName,
    this.lastName,
    this.username,
    this.email,
    this.language,
    this.contactNo,
    this.address,
    this.businessId,
    this.availableAt,
    this.pausedAt,
    this.essentialsDepartmentId,
    this.essentialsDesignationId,
    this.essentialsSalary,
    this.essentialsPayPeriod,
    this.essentialsPayCycle,
    this.maxSalesDiscountPercent,
    this.allowLogin,
    this.status,
    this.crmContactId,
    this.isCmmsnAgnt,
    this.cmmsnPercent,
    this.selectedContacts,
    this.dob,
    this.gender,
    this.maritalStatus,
    this.bloodGroup,
    this.contactNumber,
    this.altNumber,
    this.familyNumber,
    this.fbLink,
    this.twitterLink,
    this.socialMedia1,
    this.socialMedia2,
    this.permanentAddress,
    this.currentAddress,
    this.guardianName,
    this.customField1,
    this.customField2,
    this.customField3,
    this.customField4,
    this.bankDetails,
    this.idProofName,
    this.idProofNumber,
    this.crmDepartment,
    this.crmDesignation,
    this.locationId,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.deviceToken,
  });

  factory SalesPerson.fromJson(Map<String, dynamic> json) => SalesPerson(
        id: json["id"],
        userType: userTypeValues.map[json["user_type"]],
        surname: json["surname"],
        firstName: firstNameValues.map[json["first_name"]],
        lastName: lastNameValues.map[json["last_name"]],
        username: usernameValues.map[json["username"]],
        email: emailValues.map[json["email"]],
        language: languageValues.map[json["language"]],
        contactNo: json["contact_no"],
        address: json["address"],
        businessId: json["business_id"],
        availableAt: json["available_at"],
        pausedAt: json["paused_at"],
        essentialsDepartmentId: json["essentials_department_id"],
        essentialsDesignationId: json["essentials_designation_id"],
        essentialsSalary: json["essentials_salary"],
        essentialsPayPeriod:
            essentialsPayPeriodValues.map[json["essentials_pay_period"]],
        essentialsPayCycle: json["essentials_pay_cycle"],
        maxSalesDiscountPercent: json["max_sales_discount_percent"],
        allowLogin: json["allow_login"],
        status: contactStatusEnumValues.map[json["status"]],
        crmContactId: json["crm_contact_id"],
        isCmmsnAgnt: json["is_cmmsn_agnt"],
        cmmsnPercent: json["cmmsn_percent"],
        selectedContacts: json["selected_contacts"],
        dob: json["dob"],
        gender: genderValues.map[json["gender"]],
        maritalStatus: maritalStatusValues.map[json["marital_status"]],
        bloodGroup: bloodGroupValues.map[json["blood_group"]],
        contactNumber: json["contact_number"],
        altNumber: json["alt_number"],
        familyNumber: json["family_number"],
        fbLink: json["fb_link"],
        twitterLink: json["twitter_link"],
        socialMedia1: json["social_media_1"],
        socialMedia2: json["social_media_2"],
        permanentAddress: entAddressValues.map[json["permanent_address"]],
        currentAddress: entAddressValues.map[json["current_address"]],
        guardianName: guardianNameValues.map[json["guardian_name"]],
        customField1: json["custom_field_1"],
        customField2: json["custom_field_2"],
        customField3: json["custom_field_3"],
        customField4: json["custom_field_4"],
        bankDetails: json["bank_details"],
        idProofName: idProofNameValues.map[json["id_proof_name"]],
        idProofNumber: json["id_proof_number"],
        crmDepartment: json["crm_department"],
        crmDesignation: json["crm_designation"],
        locationId: json["location_id"],
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        deviceToken: json["device_token"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_type": userTypeValues.reverse[userType],
        "surname": surname,
        "first_name": firstNameValues.reverse[firstName],
        "last_name": lastNameValues.reverse[lastName],
        "username": usernameValues.reverse[username],
        "email": emailValues.reverse[email],
        "language": languageValues.reverse[language],
        "contact_no": contactNo,
        "address": address,
        "business_id": businessId,
        "available_at": availableAt,
        "paused_at": pausedAt,
        "essentials_department_id": essentialsDepartmentId,
        "essentials_designation_id": essentialsDesignationId,
        "essentials_salary": essentialsSalary,
        "essentials_pay_period":
            essentialsPayPeriodValues.reverse[essentialsPayPeriod],
        "essentials_pay_cycle": essentialsPayCycle,
        "max_sales_discount_percent": maxSalesDiscountPercent,
        "allow_login": allowLogin,
        "status": contactStatusEnumValues.reverse[status],
        "crm_contact_id": crmContactId,
        "is_cmmsn_agnt": isCmmsnAgnt,
        "cmmsn_percent": cmmsnPercent,
        "selected_contacts": selectedContacts,
        "dob": dob,
        "gender": genderValues.reverse[gender],
        "marital_status": maritalStatusValues.reverse[maritalStatus],
        "blood_group": bloodGroupValues.reverse[bloodGroup],
        "contact_number": contactNumber,
        "alt_number": altNumber,
        "family_number": familyNumber,
        "fb_link": fbLink,
        "twitter_link": twitterLink,
        "social_media_1": socialMedia1,
        "social_media_2": socialMedia2,
        "permanent_address": entAddressValues.reverse[permanentAddress],
        "current_address": entAddressValues.reverse[currentAddress],
        "guardian_name": guardianNameValues.reverse[guardianName],
        "custom_field_1": customField1,
        "custom_field_2": customField2,
        "custom_field_3": customField3,
        "custom_field_4": customField4,
        "bank_details": bankDetails,
        "id_proof_name": idProofNameValues.reverse[idProofName],
        "id_proof_number": idProofNumber,
        "crm_department": crmDepartment,
        "crm_designation": crmDesignation,
        "location_id": locationId,
        "deleted_at": deletedAt,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "device_token": deviceToken,
      };
}

enum BloodGroup { A }

final bloodGroupValues = EnumValues({"A+": BloodGroup.A});

enum EntAddress { VILLA_32_ZONE_21_AL_SHAMKHA_ABU_DHABI }

final entAddressValues = EnumValues({
  "Villa 32, Zone 21, Al Shamkha, Abu Dhabi":
      EntAddress.VILLA_32_ZONE_21_AL_SHAMKHA_ABU_DHABI
});

enum Email { RESTRO_DYNAMICTECH_AE, INFO_ESNAADGROUP_AE }

final emailValues = EnumValues({
  "info@esnaadgroup.ae": Email.INFO_ESNAADGROUP_AE,
  "restro@dynamictech.ae": Email.RESTRO_DYNAMICTECH_AE
});

enum EssentialsPayPeriod { MONTH }

final essentialsPayPeriodValues =
    EnumValues({"month": EssentialsPayPeriod.MONTH});

enum FirstName { HASEEB_BIN_OMER, NAFEES }

final firstNameValues = EnumValues(
    {"Haseeb Bin Omer": FirstName.HASEEB_BIN_OMER, "Nafees": FirstName.NAFEES});

enum Gender { MALE }

final genderValues = EnumValues({"male": Gender.MALE});

enum GuardianName { DYNAMIC_TECH }

final guardianNameValues =
    EnumValues({"DynamicTech": GuardianName.DYNAMIC_TECH});

enum IdProofName { EMIRATES_ID }

final idProofNameValues = EnumValues({"Emirates ID": IdProofName.EMIRATES_ID});

enum Language { EN }

final languageValues = EnumValues({"en": Language.EN});

enum LastName { SYED }

final lastNameValues = EnumValues({"Syed": LastName.SYED});

enum MaritalStatus { MARRIED }

final maritalStatusValues = EnumValues({"married": MaritalStatus.MARRIED});

enum UserType { USER }

final userTypeValues = EnumValues({"user": UserType.USER});

enum Username { RESTAURANT, INFO_ESNAADGROUP_AE }

final usernameValues = EnumValues({
  "info@esnaadgroup.ae": Username.INFO_ESNAADGROUP_AE,
  "restaurant": Username.RESTAURANT
});

class SellLin {
  int? id;
  int? transactionId;
  int? productId;
  int? variationId;
  int? quantity;
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
  ResLineOrderStatus? resLineOrderStatus;
  dynamic parentSellLineId;
  String? childrenType;
  dynamic subUnitId;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? modifierInput;
  dynamic kitchenId;
  String? remarks;
  Product? product;
  Variations? variations;
  List<dynamic>? modifiersfilter;

  SellLin({
    this.id,
    this.transactionId,
    this.productId,
    this.variationId,
    this.quantity,
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
    this.parentSellLineId,
    this.childrenType,
    this.subUnitId,
    this.createdAt,
    this.updatedAt,
    this.modifierInput,
    this.kitchenId,
    this.remarks,
    this.product,
    this.variations,
    this.modifiersfilter,
  });

  factory SellLin.fromJson(Map<String, dynamic> json) => SellLin(
        id: json["id"],
        transactionId: json["transaction_id"],
        productId: json["product_id"],
        variationId: json["variation_id"],
        quantity: json["quantity"],
        secondaryUnitQuantity: json["secondary_unit_quantity"],
        mfgWastePercent: json["mfg_waste_percent"],
        mfgIngredientGroupId: json["mfg_ingredient_group_id"],
        quantityReturned: json["quantity_returned"],
        unitPriceBeforeDiscount: json["unit_price_before_discount"],
        unitPrice: json["unit_price"],
        lineDiscountType: typeValues.map[json["line_discount_type"]]!,
        lineDiscountAmount: json["line_discount_amount"],
        unitPriceIncTax: json["unit_price_inc_tax"],
        itemTax: json["item_tax"],
        taxId: json["tax_id"],
        discountId: json["discount_id"],
        lotNoLineId: json["lot_no_line_id"],
        sellLineNote: json["sell_line_note"],
        woocommerceLineItemsId: json["woocommerce_line_items_id"],
        soLineId: json["so_line_id"],
        soQuantityInvoiced: json["so_quantity_invoiced"],
        resServiceStaffId: json["res_service_staff_id"],
        resLineOrderStatus:
            resLineOrderStatusValues.map[json["res_line_order_status"]],
        parentSellLineId: json["parent_sell_line_id"],
        childrenType: json["children_type"],
        subUnitId: json["sub_unit_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        modifierInput: json["modifier_input"],
        kitchenId: json["kitchen_id"],
        remarks: json["remarks"],
        product:
            json["product"] == null ? null : Product.fromJson(json["product"]),
        variations: json["variations"] == null
            ? null
            : Variations.fromJson(json["variations"]),
        modifiersfilter: json["modifiersfilter"] == null
            ? []
            : List<dynamic>.from(json["modifiersfilter"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "transaction_id": transactionId,
        "product_id": productId,
        "variation_id": variationId,
        "quantity": quantity,
        "secondary_unit_quantity": secondaryUnitQuantity,
        "mfg_waste_percent": mfgWastePercent,
        "mfg_ingredient_group_id": mfgIngredientGroupId,
        "quantity_returned": quantityReturned,
        "unit_price_before_discount": unitPriceBeforeDiscount,
        "unit_price": unitPrice,
        "line_discount_type": typeValues.reverse[lineDiscountType],
        "line_discount_amount": lineDiscountAmount,
        "unit_price_inc_tax": unitPriceIncTax,
        "item_tax": itemTax,
        "tax_id": taxId,
        "discount_id": discountId,
        "lot_no_line_id": lotNoLineId,
        "sell_line_note": sellLineNote,
        "woocommerce_line_items_id": woocommerceLineItemsId,
        "so_line_id": soLineId,
        "so_quantity_invoiced": soQuantityInvoiced,
        "res_service_staff_id": resServiceStaffId,
        "res_line_order_status":
            resLineOrderStatusValues.reverse[resLineOrderStatus],
        "parent_sell_line_id": parentSellLineId,
        "children_type": childrenType,
        "sub_unit_id": subUnitId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "modifier_input": modifierInput,
        "kitchen_id": kitchenId,
        "remarks": remarks,
        "product": product?.toJson(),
        "variations": variations?.toJson(),
        "modifiersfilter": modifiersfilter == null
            ? []
            : List<dynamic>.from(modifiersfilter!.map((x) => x)),
      };
}

enum Type { FIXED }

final typeValues = EnumValues({"fixed": Type.FIXED});

class Product {
  int? id;
  String? name;
  int? businessId;
  ProductType? type;
  int? unitId;
  dynamic secondaryUnitId;
  dynamic subUnitIds;
  dynamic brandId;
  int? categoryId;
  dynamic subCategoryId;
  int? tax;
  TaxType? taxType;
  int? enableStock;
  String? alertQuantity;
  String? sku;
  BarcodeType? barcodeType;
  dynamic expiryPeriod;
  dynamic expiryPeriodType;
  int? enableSrNo;
  String? weight;
  String? productCustomField1;
  String? productCustomField2;
  String? productCustomField3;
  String? productCustomField4;
  String? image;
  dynamic woocommerceMediaId;
  dynamic productDescription;
  int? createdBy;
  dynamic preparationTimeInMinutes;
  dynamic woocommerceProductId;
  int? woocommerceDisableSync;
  dynamic warrantyId;
  int? isInactive;
  dynamic repairModelId;
  int? notForSelling;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? kitchenId;
  int? typeOfProduct;
  int? modifierStatus;
  int? inputField;
  String? imageUrl;

  Product({
    this.id,
    this.name,
    this.businessId,
    this.type,
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
    this.woocommerceMediaId,
    this.productDescription,
    this.createdBy,
    this.preparationTimeInMinutes,
    this.woocommerceProductId,
    this.woocommerceDisableSync,
    this.warrantyId,
    this.isInactive,
    this.repairModelId,
    this.notForSelling,
    this.createdAt,
    this.updatedAt,
    this.kitchenId,
    this.typeOfProduct,
    this.modifierStatus,
    this.inputField,
    this.imageUrl,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        businessId: json["business_id"],
        type: productTypeValues.map[json["type"]]!,
        unitId: json["unit_id"],
        secondaryUnitId: json["secondary_unit_id"],
        subUnitIds: json["sub_unit_ids"],
        brandId: json["brand_id"],
        categoryId: json["category_id"],
        subCategoryId: json["sub_category_id"],
        tax: json["tax"],
        taxType: taxTypeValues.map[json["tax_type"]]!,
        enableStock: json["enable_stock"],
        alertQuantity: json["alert_quantity"],
        sku: json["sku"],
        barcodeType: barcodeTypeValues.map[json["barcode_type"]]!,
        expiryPeriod: json["expiry_period"],
        expiryPeriodType: json["expiry_period_type"],
        enableSrNo: json["enable_sr_no"],
        weight: json["weight"],
        productCustomField1: json["product_custom_field1"],
        productCustomField2: json["product_custom_field2"],
        productCustomField3: json["product_custom_field3"],
        productCustomField4: json["product_custom_field4"],
        image: json["image"],
        woocommerceMediaId: json["woocommerce_media_id"],
        productDescription: json["product_description"],
        createdBy: json["created_by"],
        preparationTimeInMinutes: json["preparation_time_in_minutes"],
        woocommerceProductId: json["woocommerce_product_id"],
        woocommerceDisableSync: json["woocommerce_disable_sync"],
        warrantyId: json["warranty_id"],
        isInactive: json["is_inactive"],
        repairModelId: json["repair_model_id"],
        notForSelling: json["not_for_selling"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        kitchenId: json["kitchen_id"],
        typeOfProduct: json["type_of_product"],
        modifierStatus: json["modifier_status"],
        inputField: json["input_field"],
        imageUrl: json["image_url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "business_id": businessId,
        "type": productTypeValues.reverse[type],
        "unit_id": unitId,
        "secondary_unit_id": secondaryUnitId,
        "sub_unit_ids": subUnitIds,
        "brand_id": brandId,
        "category_id": categoryId,
        "sub_category_id": subCategoryId,
        "tax": tax,
        "tax_type": taxTypeValues.reverse[taxType],
        "enable_stock": enableStock,
        "alert_quantity": alertQuantity,
        "sku": sku,
        "barcode_type": barcodeTypeValues.reverse[barcodeType],
        "expiry_period": expiryPeriod,
        "expiry_period_type": expiryPeriodType,
        "enable_sr_no": enableSrNo,
        "weight": weight,
        "product_custom_field1": productCustomField1,
        "product_custom_field2": productCustomField2,
        "product_custom_field3": productCustomField3,
        "product_custom_field4": productCustomField4,
        "image": image,
        "woocommerce_media_id": woocommerceMediaId,
        "product_description": productDescription,
        "created_by": createdBy,
        "preparation_time_in_minutes": preparationTimeInMinutes,
        "woocommerce_product_id": woocommerceProductId,
        "woocommerce_disable_sync": woocommerceDisableSync,
        "warranty_id": warrantyId,
        "is_inactive": isInactive,
        "repair_model_id": repairModelId,
        "not_for_selling": notForSelling,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "kitchen_id": kitchenId,
        "type_of_product": typeOfProduct,
        "modifier_status": modifierStatus,
        "input_field": inputField,
        "image_url": imageUrl,
      };
}

enum BarcodeType { C128 }

final barcodeTypeValues = EnumValues({"C128": BarcodeType.C128});

enum TaxType { INCLUSIVE, EXCLUSIVE }

final taxTypeValues = EnumValues(
    {"exclusive": TaxType.EXCLUSIVE, "inclusive": TaxType.INCLUSIVE});

enum ProductType { SINGLE }

final productTypeValues = EnumValues({"single": ProductType.SINGLE});

enum ResLineOrderStatus { COOKED, SERVED }

final resLineOrderStatusValues = EnumValues(
    {"cooked": ResLineOrderStatus.COOKED, "served": ResLineOrderStatus.SERVED});

class Variations {
  int? id;
  VariationsName? name;
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

  Variations({
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
  });

  factory Variations.fromJson(Map<String, dynamic> json) => Variations(
        id: json["id"],
        name: variationsNameValues.map[json["name"]]!,
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
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": variationsNameValues.reverse[name],
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
      };
}

enum VariationsName { DUMMY }

final variationsNameValues = EnumValues({"DUMMY": VariationsName.DUMMY});

enum DatumStatus { FINAL }

final datumStatusValues = EnumValues({"final": DatumStatus.FINAL});

class Table {
  int? id;
  int? businessId;
  int? locationId;
  String? name;
  String? description;
  int? createdBy;
  dynamic deletedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? numberOfPerson;
  String? status;

  Table({
    this.id,
    this.businessId,
    this.locationId,
    this.name,
    this.description,
    this.createdBy,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.numberOfPerson,
    this.status,
  });

  factory Table.fromJson(Map<String, dynamic> json) => Table(
        id: json["id"],
        businessId: json["business_id"],
        locationId: json["location_id"],
        name: json["name"],
        description: json["description"],
        createdBy: json["created_by"],
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        numberOfPerson: json["number_of_person"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "business_id": businessId,
        "location_id": locationId,
        "name": name,
        "description": description,
        "created_by": createdBy,
        "deleted_at": deletedAt,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "number_of_person": numberOfPerson,
        "status": status,
      };
}

enum DatumType { SELL }

final datumTypeValues = EnumValues({"sell": DatumType.SELL});

class TypesOfService {
  int? id;
  String? name;
  dynamic description;
  int? businessId;
  List<String>? locationPriceGroup;
  String? packingCharge;
  Type? packingChargeType;
  int? enableCustomFields;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? color;

  TypesOfService({
    this.id,
    this.name,
    this.description,
    this.businessId,
    this.locationPriceGroup,
    this.packingCharge,
    this.packingChargeType,
    this.enableCustomFields,
    this.createdAt,
    this.updatedAt,
    this.color,
  });

  factory TypesOfService.fromJson(Map<String, dynamic> json) => TypesOfService(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        businessId: json["business_id"],
        locationPriceGroup: json["location_price_group"] == null
            ? []
            : List<String>.from(json["location_price_group"]!.map((x) => x)),
        packingCharge: json["packing_charge"],
        packingChargeType: typeValues.map[json["packing_charge_type"]]!,
        enableCustomFields: json["enable_custom_fields"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        color: json["color"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "business_id": businessId,
        "location_price_group": locationPriceGroup == null
            ? []
            : List<dynamic>.from(locationPriceGroup!.map((x) => x)),
        "packing_charge": packingCharge,
        "packing_charge_type": typeValues.reverse[packingChargeType],
        "enable_custom_fields": enableCustomFields,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "color": color,
      };
}

class Links {
  String? first;
  String? last;
  dynamic prev;
  String? next;

  Links({
    this.first,
    this.last,
    this.prev,
    this.next,
  });

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
  int? currentPage;
  int? from;
  int? lastPage;
  List<Link>? links;
  String? path;
  int? perPage;
  int? to;
  int? total;

  Meta({
    this.currentPage,
    this.from,
    this.lastPage,
    this.links,
    this.path,
    this.perPage,
    this.to,
    this.total,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        currentPage: json["current_page"],
        from: json["from"],
        lastPage: json["last_page"],
        links: json["links"] == null
            ? []
            : List<Link>.from(json["links"]!.map((x) => Link.fromJson(x))),
        path: json["path"],
        perPage: json["per_page"],
        to: json["to"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "from": from,
        "last_page": lastPage,
        "links": links == null
            ? []
            : List<dynamic>.from(links!.map((x) => x.toJson())),
        "path": path,
        "per_page": perPage,
        "to": to,
        "total": total,
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
