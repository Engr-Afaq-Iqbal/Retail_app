PaymentMethodAccountModel? paymentMethodAccountModelFromJson(
        Map<String, dynamic> str) =>
    PaymentMethodAccountModel.fromJson(str);

Map<String, dynamic> paymentMethodAccountModelToJson(
        PaymentMethodAccountModel data) =>
    data.toJson();

class PaymentMethodAccountModel {
  PaymentMethodAccountModel({
    this.paymentMethod,
    this.account,
  });

  String? paymentMethod;
  AccountModel? account;

  PaymentMethodAccountModel copyWith({
    String? paymentMethod,
    AccountModel? account,
  }) =>
      PaymentMethodAccountModel(
        paymentMethod: paymentMethod ?? this.paymentMethod,
        account: account ?? this.account,
      );

  factory PaymentMethodAccountModel.fromJson(Map<String, dynamic> json) =>
      PaymentMethodAccountModel(
        paymentMethod: json["payment_method"],
        account: json["account"] == null
            ? null
            : accountModelFromJson(json["account"]),
      );

  Map<String, dynamic> toJson() => {
        "payment_method": paymentMethod,
        "account": account == null ? null : accountModelToJson(account!),
      };
}

AccountModel? accountModelFromJson(Map<String, dynamic> str) =>
    AccountModel.fromJson(str);

Map<String, dynamic> accountModelToJson(AccountModel data) => data.toJson();

class AccountModel {
  AccountModel({
    this.id,
    this.name,
    this.balance,
  });

  int? id;
  String? name;
  String? balance;

  AccountModel copyWith({
    int? id,
    String? name,
    String? balance,
  }) =>
      AccountModel(
        id: id ?? this.id,
        name: name ?? this.name,
        balance: balance ?? this.balance,
      );

  factory AccountModel.fromJson(Map<String, dynamic> json) => AccountModel(
        id: json["id"],
        name: json["name"],
        balance: json["balance"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "balance": balance,
      };
}
