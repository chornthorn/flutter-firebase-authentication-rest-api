class RefreshCredentialResModel {
  RefreshCredentialResModel({
    required this.accessToken,
    required this.expiresIn,
    required this.tokenType,
    required this.refreshToken,
    required this.idToken,
    required this.userId,
    required this.projectId,
  });

  final String accessToken;
  final String expiresIn;
  final String tokenType;
  final String refreshToken;
  final String idToken;
  final String userId;
  final String projectId;

  factory RefreshCredentialResModel.fromJson(Map<String, dynamic> json) =>
      RefreshCredentialResModel(
        accessToken: json["access_token"],
        expiresIn: json["expires_in"],
        tokenType: json["token_type"],
        refreshToken: json["refresh_token"],
        idToken: json["id_token"],
        userId: json["user_id"],
        projectId: json["project_id"],
      );

  Map<String, dynamic> toJson() => {
        "access_token": accessToken,
        "expires_in": expiresIn,
        "token_type": tokenType,
        "refresh_token": refreshToken,
        "id_token": idToken,
        "user_id": userId,
        "project_id": projectId,
      };
}
