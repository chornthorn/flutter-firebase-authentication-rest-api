class DeleteAccountReqModel {
  DeleteAccountReqModel({
    required this.idToken,
  });

  final String idToken;

  factory DeleteAccountReqModel.fromJson(Map<String, dynamic> json) =>
      DeleteAccountReqModel(
        idToken: json["idToken"],
      );

  Map<String, dynamic> toJson() => {
        "idToken": idToken,
      };
}
