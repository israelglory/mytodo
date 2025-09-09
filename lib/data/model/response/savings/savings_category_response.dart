class SavingsCategoryResponse {
  final String? id;
  final String? interestRateType;
  final bool? enableManualTopUp;
  final String? savingsType;
  final String? status;
  final String? name;
  final String? description;
  final String? avatar;
  final List<Plan>? plans;
  final String? createdBy;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final bool? interestAdvanceWithdrawn;

  SavingsCategoryResponse({
    this.id,
    this.interestRateType,
    this.enableManualTopUp,
    this.savingsType,
    this.status,
    this.name,
    this.description,
    this.avatar,
    this.plans,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
    this.interestAdvanceWithdrawn,
  });

  factory SavingsCategoryResponse.fromJson(Map<String, dynamic> json) =>
      SavingsCategoryResponse(
        id: json["id"],
        interestRateType: json["interestRateType"],
        enableManualTopUp: json["enableManualTopUp"],
        savingsType: json["savingsType"],
        status: json["status"],
        name: json["name"],
        description: json["description"],
        avatar: json["avatar"],
        plans: json["plans"] == null
            ? []
            : List<Plan>.from(json["plans"]!.map((x) => Plan.fromJson(x))),
        createdBy: json["createdBy"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        interestAdvanceWithdrawn: json["interestAdvanceWithdrawn"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "interestRateType": interestRateType,
        "enableManualTopUp": enableManualTopUp,
        "savingsType": savingsType,
        "status": status,
        "name": name,
        "description": description,
        "avatar": avatar,
        "plans": plans == null
            ? []
            : List<dynamic>.from(plans!.map((x) => x.toJson())),
        "createdBy": createdBy,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "interestAdvanceWithdrawn": interestAdvanceWithdrawn,
      };
}

class Plan {
  final String? id;
  final int? tenure;
  final int? rate;

  Plan({
    this.id,
    this.tenure,
    this.rate,
  });

  factory Plan.fromJson(Map<String, dynamic> json) => Plan(
        id: json["id"],
        tenure: json["tenure"],
        rate: json["rate"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tenure": tenure,
        "rate": rate,
      };
}
