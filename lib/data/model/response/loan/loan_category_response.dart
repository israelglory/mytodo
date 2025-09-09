class LoanCategoryResponse {
  final String id;
  final int? minimumAmount;
  final String? status;
  final String? name;
  final String? description;
  final String? avatar;
  final int? maximumAmount;
  final List<LoanCharge>? charges;
  final List<LoanPlan>? plans;
  final String? createdBy;
  final String? loanType;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  LoanCategoryResponse({
    required this.id,
    this.minimumAmount,
    this.status,
    this.loanType,
    this.name,
    this.description,
    this.avatar,
    this.maximumAmount,
    this.charges,
    this.plans,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
  });

  factory LoanCategoryResponse.fromJson(Map<String, dynamic> json) =>
      LoanCategoryResponse(
        id: json["id"],
        loanType: json["loanType"],
        minimumAmount: json["minimumAmount"],
        status: json["status"],
        name: json["name"],
        description: json["description"],
        avatar: json["avatar"] ?? "",
        maximumAmount: json["maximumAmount"],
        charges: json["charges"] != null
            ? List<LoanCharge>.from(
                json["charges"].map((x) => LoanCharge.fromJson(x)))
            : null,
        plans: json["plans"] != null
            ? List<LoanPlan>.from(
                json["plans"].map((x) => LoanPlan.fromJson(x)))
            : null,
        createdBy: json["createdBy"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "loanType": loanType,
        "minimumAmount": minimumAmount,
        "status": status,
        "name": name,
        "description": description,
        "avatar": avatar,
        "maximumAmount": maximumAmount,
        "charges": List<dynamic>.from(charges!.map((x) => x.toJson())),
        "plans": List<dynamic>.from(plans!.map((x) => x.toJson())),
        "createdBy": createdBy,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}

class LoanCharge {
  final String? id;
  final String? chargeFeeType;
  final String? chargeType;
  final double? chargeAmount;
  final int? maxChargeAmount;

  LoanCharge({
    this.id,
    this.chargeFeeType,
    this.chargeType,
    this.chargeAmount,
    this.maxChargeAmount,
  });

  factory LoanCharge.fromJson(Map<String, dynamic> json) => LoanCharge(
        id: json["id"],
        chargeFeeType: json["chargeFeeType"],
        chargeType: json["chargeType"],
        chargeAmount: json["chargeAmount"]?.toDouble(),
        maxChargeAmount: json["maxChargeAmount"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "chargeFeeType": chargeFeeType,
        "chargeType": chargeType,
        "chargeAmount": chargeAmount,
        "maxChargeAmount": maxChargeAmount,
      };
}

class LoanPlan {
  final String? id;
  final double? tenure;
  final double? rate;

  LoanPlan({
    this.id,
    this.tenure,
    this.rate,
  });

  factory LoanPlan.fromJson(Map<String, dynamic> json) => LoanPlan(
        id: json["id"],
        tenure: json["tenure"]?.toDouble(),
        rate: json["rate"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tenure": tenure,
        "rate": rate,
      };
}
