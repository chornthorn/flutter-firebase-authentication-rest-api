class RefreshCredentialReqModel {
  RefreshCredentialReqModel({
    required this.grantType,
    required this.refreshToken,
  });

  final String grantType;
  final String refreshToken;

  factory RefreshCredentialReqModel.fromJson(Map<String, dynamic> json) =>
      RefreshCredentialReqModel(
        grantType: json["grant_type"],
        refreshToken: json["refresh_token"],
      );

  Map<String, dynamic> toJson() => {
        "grant_type": grantType,
        "refresh_token": refreshToken,
      };
}
