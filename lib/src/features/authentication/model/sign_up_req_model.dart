class SignUpReqModel {
  SignUpReqModel({
    required this.email,
    required this.password,
    this.returnSecureToken = true,
  });

  final String email;
  final String password;
  final bool returnSecureToken;

  factory SignUpReqModel.fromJson(Map<String, dynamic> json) => SignUpReqModel(
        email: json["email"],
        password: json["password"],
        returnSecureToken: json["returnSecureToken"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
        "returnSecureToken": returnSecureToken,
      };
}
