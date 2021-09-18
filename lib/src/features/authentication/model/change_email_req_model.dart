class ChangeEmailReqModel {
  ChangeEmailReqModel({
    required this.idToken,
    required this.email,
    required this.returnSecureToken,
  });

  final String idToken;
  final String email;
  final bool returnSecureToken;

  factory ChangeEmailReqModel.fromJson(Map<String, dynamic> json) =>
      ChangeEmailReqModel(
        idToken: json["idToken"],
        email: json["email"],
        returnSecureToken: json["returnSecureToken"],
      );

  Map<String, dynamic> toJson() => {
        "idToken": idToken,
        "email": email,
        "returnSecureToken": returnSecureToken,
      };
}
