class VerificationStatusResponse {
  final bool? completed;
  final Email? email;
  final Bvn? bvn;
  final Bvn? identity;
  final Bvn? id;

  VerificationStatusResponse({
    this.completed,
    this.email,
    this.bvn,
    this.identity,
    this.id,
  });

  factory VerificationStatusResponse.fromJson(Map<String, dynamic> json) =>
      VerificationStatusResponse(
        completed: json["completed"],
        email: json["email"] == null ? null : Email.fromJson(json["email"]),
        bvn: json["bvn"] == null ? null : Bvn.fromJson(json["bvn"]),
        identity:
            json["identity"] == null ? null : Bvn.fromJson(json["identity"]),
        id: json["id"] == null ? null : Bvn.fromJson(json["id"]),
      );

  Map<String, dynamic> toJson() => {
        "completed": completed,
        "email": email?.toJson(),
        "bvn": bvn?.toJson(),
        "identity": identity?.toJson(),
        "id": id?.toJson(),
      };
}

class Bvn {
  final bool? status;

  Bvn({
    this.status,
  });

  factory Bvn.fromJson(Map<String, dynamic> json) => Bvn(
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
      };
}

class Email {
  final String? status;

  Email({
    this.status,
  });

  factory Email.fromJson(Map<String, dynamic> json) => Email(
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
      };
}
