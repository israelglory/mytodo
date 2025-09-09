class NotificationRes {
  final DateTime? createdAt;
  final String? message;

  NotificationRes({
    this.createdAt,
    this.message,
  });

  factory NotificationRes.fromJson(Map<String, dynamic> json) =>
      NotificationRes(
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "createdAt": createdAt?.toIso8601String(),
        "message": message,
      };
}
