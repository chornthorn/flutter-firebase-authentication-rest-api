class EmailConfirmCodeResModel {
  EmailConfirmCodeResModel({
    required this.kind,
    required this.email,
  });

  final String kind;
  final String email;

  factory EmailConfirmCodeResModel.fromJson(Map<String, dynamic> json) =>
      EmailConfirmCodeResModel(
        kind: json["kind"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "kind": kind,
        "email": email,
      };
}
