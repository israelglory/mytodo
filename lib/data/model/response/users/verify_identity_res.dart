class VerifyIdentityRes {
  final String? status;
  final String? phoneNumber;
  final String? error;

  VerifyIdentityRes({
    this.status,
    this.phoneNumber,
    this.error,
  });

  factory VerifyIdentityRes.fromJson(Map<String, dynamic> json) =>
      VerifyIdentityRes(
        status: json["status"],
        phoneNumber: json["phoneNumber"],
        error: json["error"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "phoneNumber": phoneNumber,
        "error": error,
      };
}
