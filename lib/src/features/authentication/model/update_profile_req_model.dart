class UpdateProfileReqModel {
  UpdateProfileReqModel({
    required this.idToken,
    required this.displayName,
    required this.photoUrl,
    required this.returnSecureToken,
  });

  final String idToken;
  final String displayName;
  final String photoUrl;
  final bool returnSecureToken;

  factory UpdateProfileReqModel.fromJson(Map<String, dynamic> json) =>
      UpdateProfileReqModel(
        idToken: json["idToken"],
        displayName: json["displayName"],
        photoUrl: json["photoUrl"],
        returnSecureToken: json["returnSecureToken"],
      );

  Map<String, dynamic> toJson() => {
        "idToken": idToken,
        "displayName": displayName,
        "photoUrl": photoUrl,
        "returnSecureToken": returnSecureToken,
      };
}
