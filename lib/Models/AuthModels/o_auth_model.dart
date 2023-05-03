import 'dart:convert';

OauthModel oauthModelFromJson(String str) =>
    OauthModel.fromJson(json.decode(str));

class OauthModel {
  OauthModel({
    this.tokenType = "",
    this.expiresIn = 0,
    this.accessToken = "",
    this.refreshToken = "",
  });

  String tokenType;
  int expiresIn;
  String accessToken;
  String refreshToken;

  factory OauthModel.fromJson(Map<String, dynamic> json) => OauthModel(
        tokenType: json["token_type"],
        expiresIn: json["expires_in"],
        accessToken: json["access_token"],
        refreshToken: json["refresh_token"],
      );

  Map<String, dynamic> toJson() => {
        "token_type": tokenType,
        "expires_in": expiresIn,
        "access_token": accessToken,
        "refresh_token": refreshToken,
      };
}
