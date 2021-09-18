import 'provider_user_info_model.dart';

class UpdateProfileResModel {
  UpdateProfileResModel({
    required this.kind,
    required this.localId,
    required this.email,
    required this.displayName,
    required this.providerUserInfo,
    required this.photoUrl,
    required this.passwordHash,
    required this.emailVerified,
  });

  final String kind;
  final String localId;
  final String email;
  final String? displayName;
  final List<ProviderUserInfo> providerUserInfo;
  final String? photoUrl;
  final String passwordHash;
  final bool emailVerified;

  factory UpdateProfileResModel.fromJson(Map<String, dynamic> json) =>
      UpdateProfileResModel(
        kind: json["kind"],
        localId: json["localId"],
        email: json["email"],
        displayName: json["displayName"],
        providerUserInfo: List<ProviderUserInfo>.from(
            json["providerUserInfo"].map((x) => ProviderUserInfo.fromJson(x))),
        photoUrl: json["photoUrl"],
        passwordHash: json["passwordHash"],
        emailVerified: json["emailVerified"],
      );

  Map<String, dynamic> toJson() => {
        "kind": kind,
        "localId": localId,
        "email": email,
        "displayName": displayName,
        "providerUserInfo":
            List<dynamic>.from(providerUserInfo.map((x) => x.toJson())),
        "photoUrl": photoUrl,
        "passwordHash": passwordHash,
        "emailVerified": emailVerified,
      };
}
