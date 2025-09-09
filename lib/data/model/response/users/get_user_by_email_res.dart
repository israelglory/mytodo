class GetUserByEmailResponse {
  final bool? emailVerified;
  final String? status;
  final String? role;
  final String? countryCode;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phoneNumber;
  final String? referralCode;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? id;

  GetUserByEmailResponse({
    this.emailVerified,
    this.status,
    this.role,
    this.countryCode,
    this.firstName,
    this.lastName,
    this.email,
    this.phoneNumber,
    this.referralCode,
    this.createdAt,
    this.updatedAt,
    this.id,
  });

  factory GetUserByEmailResponse.fromJson(Map<String, dynamic> json) =>
      GetUserByEmailResponse(
        emailVerified: json["emailVerified"],
        status: json["status"],
        role: json["role"],
        countryCode: json["countryCode"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        phoneNumber: json["phoneNumber"],
        referralCode: json["referralCode"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "emailVerified": emailVerified,
        "status": status,
        "role": role,
        "countryCode": countryCode,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "phoneNumber": phoneNumber,
        "referralCode": referralCode,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "id": id,
      };
}
