class SavingsPlanResponse {
  final String savingsCategory;
  final String savingsConfig;
  final String name;
  final String description;
  final int rate;
  final int duration;
  final int amount;
  final int targetAmount;
  final bool isActive;
  final Metadata metadata;
  final String user;
  final String createdBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String id;

  SavingsPlanResponse({
    required this.savingsCategory,
    required this.savingsConfig,
    required this.name,
    required this.description,
    required this.rate,
    required this.duration,
    required this.amount,
    required this.targetAmount,
    required this.isActive,
    required this.metadata,
    required this.user,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
    required this.id,
  });

  factory SavingsPlanResponse.fromJson(Map<String, dynamic> json) =>
      SavingsPlanResponse(
        savingsCategory: json["savingsCategory"],
        savingsConfig: json["savingsConfig"],
        name: json["name"],
        description: json["description"],
        rate: json["rate"],
        duration: json["duration"],
        amount: json["amount"],
        targetAmount: json["targetAmount"],
        isActive: json["isActive"],
        metadata: Metadata.fromJson(json["metadata"]),
        user: json["user"],
        createdBy: json["createdBy"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "savingsCategory": savingsCategory,
        "savingsConfig": savingsConfig,
        "name": name,
        "description": description,
        "rate": rate,
        "duration": duration,
        "amount": amount,
        "targetAmount": targetAmount,
        "isActive": isActive,
        "metadata": metadata.toJson(),
        "user": user,
        "createdBy": createdBy,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "id": id,
      };
}

class Metadata {
  Metadata();

  factory Metadata.fromJson(Map<String, dynamic> json) => Metadata();

  Map<String, dynamic> toJson() => {};
}
