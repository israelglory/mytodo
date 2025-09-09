class User {
  final bool emailVerified;
  final String status;
  final String role;
  final String countryCode;
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String referralCode;
  final String id;

  User({
    required this.emailVerified,
    required this.status,
    required this.role,
    required this.countryCode,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.referralCode,
    required this.id,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        emailVerified: json["emailVerified"],
        status: json["status"],
        role: json["role"],
        countryCode: json["countryCode"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        phoneNumber: json["phoneNumber"],
        referralCode: json["referralCode"],
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
        "id": id,
      };
}
