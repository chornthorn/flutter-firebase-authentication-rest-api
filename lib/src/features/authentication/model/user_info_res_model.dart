import 'provider_user_info_model.dart';

class UserInfoResModel {
  UserInfoResModel({
    required this.kind,
    required this.users,
  });

  final String kind;
  final List<UserModel> users;

  factory UserInfoResModel.fromJson(Map<String, dynamic> json) =>
      UserInfoResModel(
        kind: json["kind"],
        users: List<UserModel>.from(
            json["users"].map((x) => UserModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "kind": kind,
        "users": List<dynamic>.from(users.map((x) => x.toJson())),
      };
}

class UserModel {
  UserModel({
    required this.localId,
    required this.email,
    required this.displayName,
    required this.photoUrl,
    required this.passwordHash,
    required this.emailVerified,
    required this.passwordUpdatedAt,
    required this.providerUserInfo,
    required this.validSince,
    required this.lastLoginAt,
    required this.createdAt,
    required this.lastRefreshAt,
  });

  final String localId;
  final String email;
  final String? displayName;
  final String? photoUrl;
  final String passwordHash;
  final bool emailVerified;
  final int passwordUpdatedAt;
  final List<ProviderUserInfo> providerUserInfo;
  final String validSince;
  final String lastLoginAt;
  final String createdAt;
  final DateTime lastRefreshAt;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        localId: json["localId"],
        email: json["email"],
        displayName: json["displayName"],
        photoUrl: json["photoUrl"],
        passwordHash: json["passwordHash"],
        emailVerified: json["emailVerified"],
        passwordUpdatedAt: json["passwordUpdatedAt"],
        providerUserInfo: List<ProviderUserInfo>.from(
            json["providerUserInfo"].map((x) => ProviderUserInfo.fromJson(x))),
        validSince: json["validSince"],
        lastLoginAt: json["lastLoginAt"],
        createdAt: json["createdAt"],
        lastRefreshAt: DateTime.parse(json["lastRefreshAt"]),
      );

  Map<String, dynamic> toJson() => {
        "localId": localId,
        "email": email,
        "displayName": displayName,
        "photoUrl": photoUrl,
        "passwordHash": passwordHash,
        "emailVerified": emailVerified,
        "passwordUpdatedAt": passwordUpdatedAt,
        "providerUserInfo":
            List<dynamic>.from(providerUserInfo.map((x) => x.toJson())),
        "validSince": validSince,
        "lastLoginAt": lastLoginAt,
        "createdAt": createdAt,
        "lastRefreshAt": lastRefreshAt.toIso8601String(),
      };
}
