class ListAccountsModel {
  List<Data>? data;

  ListAccountsModel({this.data});

  ListAccountsModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  int? businessId;
  String? name;
  String? accountNumber;
  // List<AccountDetails>? accountDetails;
  int? accountTypeId;
  Null? note;
  int? createdBy;
  int? isClosed;
  Null? deletedAt;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
        this.businessId,
        this.name,
        this.accountNumber,
        // this.accountDetails,
        this.accountTypeId,
        this.note,
        this.createdBy,
        this.isClosed,
        this.deletedAt,
        this.createdAt,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    businessId = json['business_id'];
    name = json['name'];
    accountNumber = json['account_number'];
    // if (json['account_details'] != null) {
    //   accountDetails = <AccountDetails>[];
    //   json['account_details'].forEach((v) {
    //     accountDetails!.add(new AccountDetails.fromJson(v));
    //   });
    // }
    accountTypeId = json['account_type_id'];
    note = json['note'];
    createdBy = json['created_by'];
    isClosed = json['is_closed'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['business_id'] = this.businessId;
    data['name'] = this.name;
    data['account_number'] = this.accountNumber;
    // if (this.accountDetails != null) {
    //   data['account_details'] =
    //       this.accountDetails!.map((v) => v.toJson()).toList();
    // }
    data['account_type_id'] = this.accountTypeId;
    data['note'] = this.note;
    data['created_by'] = this.createdBy;
    data['is_closed'] = this.isClosed;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class AccountDetails {
  Null? label;
  Null? value;

  AccountDetails({this.label, this.value});

  AccountDetails.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['label'] = this.label;
    data['value'] = this.value;
    return data;
  }
}