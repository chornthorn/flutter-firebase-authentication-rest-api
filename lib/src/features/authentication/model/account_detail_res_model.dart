import 'provider_user_info_model.dart';

class AccountDetailResModel {
  AccountDetailResModel({
    required this.kind,
    required this.localId,
    required this.email,
    required this.displayName,
    required this.idToken,
    required this.providerUserInfo,
    required this.photoUrl,
    required this.refreshToken,
    required this.expiresIn,
    required this.passwordHash,
    required this.emailVerified,
  });

  final String kind;
  final String localId;
  final String email;
  final String? displayName;
  final String idToken;
  final List<ProviderUserInfo> providerUserInfo;
  final String? photoUrl;
  final String refreshToken;
  final String expiresIn;
  final String passwordHash;
  final bool emailVerified;

  factory AccountDetailResModel.fromJson(Map<String, dynamic> json) =>
      AccountDetailResModel(
        kind: json["kind"],
        localId: json["localId"],
        email: json["email"],
        displayName: json["displayName"],
        idToken: json["idToken"],
        providerUserInfo: List<ProviderUserInfo>.from(
            json["providerUserInfo"].map((x) => ProviderUserInfo.fromJson(x))),
        photoUrl: json["photoUrl"],
        refreshToken: json["refreshToken"],
        expiresIn: json["expiresIn"],
        passwordHash: json["passwordHash"],
        emailVerified: json["emailVerified"],
      );

  Map<String, dynamic> toJson() => {
        "kind": kind,
        "localId": localId,
        "email": email,
        "displayName": displayName,
        "idToken": idToken,
        "providerUserInfo":
            List<dynamic>.from(providerUserInfo.map((x) => x.toJson())),
        "photoUrl": photoUrl,
        "refreshToken": refreshToken,
        "expiresIn": expiresIn,
        "passwordHash": passwordHash,
        "emailVerified": emailVerified,
      };
}
