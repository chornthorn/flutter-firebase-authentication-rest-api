class EmailConfirmCodeReqModel {
  EmailConfirmCodeReqModel({
      this.requestType,
    required this.idToken,
  });

  final String? requestType;
  final String idToken;

  factory EmailConfirmCodeReqModel.fromJson(Map<String, dynamic> json) =>
      EmailConfirmCodeReqModel(
        requestType: json["requestType"],
        idToken: json["idToken"],
      );

  Map<String, dynamic> toJson() => {
        "requestType": requestType,
        "idToken": idToken,
      };
}
