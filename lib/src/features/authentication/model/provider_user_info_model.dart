class ProviderUserInfo {
  ProviderUserInfo({
    required this.providerId,
    required this.displayName,
    required this.photoUrl,
    required this.federatedId,
    required this.email,
    required this.rawId,
  });

  final String providerId;
  final String? displayName;
  final String? photoUrl;
  final String federatedId;
  final String email;
  final String rawId;

  factory ProviderUserInfo.fromJson(Map<String, dynamic> json) =>
      ProviderUserInfo(
        providerId: json["providerId"],
        displayName: json["displayName"],
        photoUrl: json["photoUrl"],
        federatedId: json["federatedId"],
        email: json["email"],
        rawId: json["rawId"],
      );

  Map<String, dynamic> toJson() => {
    "providerId": providerId,
    "displayName": displayName,
    "photoUrl": photoUrl,
    "federatedId": federatedId,
    "email": email,
    "rawId": rawId,
  };
}