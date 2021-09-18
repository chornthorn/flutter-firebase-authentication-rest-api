class UserInfoReqModel {
  UserInfoReqModel({
    required this.idToken,
  });

  final String idToken;

  factory UserInfoReqModel.fromJson(Map<String, dynamic> json) =>
      UserInfoReqModel(
        idToken: json["idToken"],
      );

  Map<String, dynamic> toJson() => {
        "idToken": idToken,
      };
}
