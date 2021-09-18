class ChangePasswordReqModel {
  ChangePasswordReqModel({
    required this.idToken,
    required this.password,
    required this.returnSecureToken,
  });

  final String idToken;
  final String password;
  final bool returnSecureToken;

  factory ChangePasswordReqModel.fromJson(Map<String, dynamic> json) =>
      ChangePasswordReqModel(
        idToken: json["idToken"],
        password: json["password"],
        returnSecureToken: json["returnSecureToken"],
      );

  Map<String, dynamic> toJson() => {
        "idToken": idToken,
        "password": password,
        "returnSecureToken": returnSecureToken,
      };
}
