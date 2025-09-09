class GetSupportTicketsRes {
  final String? id;
  final String? status;
  final String? message;
  final DateTime? createdAt;
  final String? user;
  final String? createdBy;
  final DateTime? updatedAt;

  GetSupportTicketsRes({
    this.id,
    this.status,
    this.message,
    this.createdAt,
    this.user,
    this.createdBy,
    this.updatedAt,
  });

  factory GetSupportTicketsRes.fromJson(Map<String, dynamic> json) =>
      GetSupportTicketsRes(
        id: json["id"],
        status: json["status"],
        message: json["message"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        user: json["user"],
        createdBy: json["createdBy"],
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
        "message": message,
        "createdAt": createdAt?.toIso8601String(),
        "user": user,
        "createdBy": createdBy,
        "updatedAt": updatedAt?.toIso8601String(),
      };
}
