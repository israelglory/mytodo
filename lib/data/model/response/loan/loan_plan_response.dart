class LoanPlanResponse {
  final String name;
  final int rate;
  final int minDuration;
  final int maxDuration;
  final String description;
  final int minimumAmount;
  final int maximumAmount;
  final String status;
  final String loanCategory;
  final List<dynamic> fee;
  final String user;
  final String createdBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String id;

  LoanPlanResponse({
    required this.name,
    required this.rate,
    required this.minDuration,
    required this.maxDuration,
    required this.description,
    required this.minimumAmount,
    required this.maximumAmount,
    required this.status,
    required this.loanCategory,
    required this.fee,
    required this.user,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
    required this.id,
  });

  factory LoanPlanResponse.fromJson(Map<String, dynamic> json) =>
      LoanPlanResponse(
        name: json["name"],
        rate: json["rate"],
        minDuration: json["minDuration"],
        maxDuration: json["maxDuration"],
        description: json["description"],
        minimumAmount: json["minimumAmount"],
        maximumAmount: json["maximumAmount"],
        status: json["status"],
        loanCategory: json["loanCategory"],
        fee: List<dynamic>.from(json["fee"].map((x) => x)),
        user: json["user"],
        createdBy: json["createdBy"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "rate": rate,
        "minDuration": minDuration,
        "maxDuration": maxDuration,
        "description": description,
        "minimumAmount": minimumAmount,
        "maximumAmount": maximumAmount,
        "status": status,
        "loanCategory": loanCategory,
        "fee": List<dynamic>.from(fee.map((x) => x)),
        "user": user,
        "createdBy": createdBy,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "id": id,
      };
}
