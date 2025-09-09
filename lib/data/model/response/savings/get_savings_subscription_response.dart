class GetSavingsSubscriptionResponse {
  final String? id;
  final AutomationData? automationData;
  final String? interestRateType;
  final num? interestEarned;
  final String? status;
  final String? savingsPlan;
  final String? savingsCategory;
  final num? amount;
  final Metadata? metadata;
  final String? user;
  final num? duration;
  final num? rate;
  final DateTime? startDate;
  final DateTime? endDate;
  final DateTime? lastPaymentDate;
  final String? createdBy;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final bool? interestAdvanceWithdrawn;

  GetSavingsSubscriptionResponse({
    this.id,
    this.automationData,
    this.interestRateType,
    this.interestEarned,
    this.status,
    this.savingsPlan,
    this.savingsCategory,
    this.amount,
    this.metadata,
    this.user,
    this.duration,
    this.rate,
    this.startDate,
    this.endDate,
    this.lastPaymentDate,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
    this.interestAdvanceWithdrawn,
  });

  factory GetSavingsSubscriptionResponse.fromJson(Map<String, dynamic> json) =>
      GetSavingsSubscriptionResponse(
        id: json["id"],
        automationData: json["automationData"] != null
            ? AutomationData.fromJson(json["automationData"])
            : null,
        interestRateType: json["interestRateType"],
        interestEarned: json["interestEarned"] ?? 0,
        status: json["status"],
        savingsPlan: json["savingsPlan"],
        savingsCategory: json["savingsCategory"],
        amount: json["amount"],
        metadata: json["metadata"] != null
            ? Metadata.fromJson(json["metadata"])
            : null,
        user: json["user"],
        duration: json["duration"],
        rate: json["rate"],
        startDate:
            DateTime.parse(json["startDate"] ?? DateTime.now().toString()),
        endDate: DateTime.parse(json["endDate"] ?? DateTime.now().toString()),
        lastPaymentDate: DateTime.parse(
            json["lastPaymentDate"] ?? DateTime.now().toString()),
        createdBy: json["createdBy"],
        createdAt:
            DateTime.parse(json["createdAt"] ?? DateTime.now().toString()),
        updatedAt:
            DateTime.parse(json["updatedAt"] ?? DateTime.now().toString()),
        interestAdvanceWithdrawn: json["interestAdvanceWithdrawn"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "automationData": automationData?.toJson(),
        "interestRateType": interestRateType,
        "interestEarned": interestEarned,
        "status": status,
        "savingsPlan": savingsPlan,
        "savingsCategory": savingsCategory,
        "amount": amount,
        "metadata": metadata?.toJson(),
        "user": user,
        "duration": duration,
        "rate": rate,
        "startDate": startDate?.toIso8601String(),
        "endDate": endDate?.toIso8601String(),
        "lastPaymentDate": lastPaymentDate?.toIso8601String(),
        "createdBy": createdBy,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "interestAdvanceWithdrawn": interestAdvanceWithdrawn,
      };
}

class AutomationData {
  final String? frequency;
  final int? dayOfWeek;
  final int? dayOfMonth;

  AutomationData({
    this.frequency,
    this.dayOfWeek,
    this.dayOfMonth,
  });

  factory AutomationData.fromJson(Map<String, dynamic> json) => AutomationData(
        frequency: json["frequency"],
        dayOfWeek: json["dayOfWeek"],
        dayOfMonth: json["dayOfMonth"],
      );

  Map<String, dynamic> toJson() => {
        "frequency": frequency,
        "dayOfWeek": dayOfWeek,
        "dayOfMonth": dayOfMonth,
      };
}

class Metadata {
  final String? title;
  final String? savingsFrequency;
  final String? savingsDayOfTheWeek;
  final String? savingsDuration;
  final String? savingstime;

  Metadata({
    this.title,
    this.savingsFrequency,
    this.savingsDayOfTheWeek,
    this.savingsDuration,
    this.savingstime,
  });

  factory Metadata.fromJson(Map<String, dynamic> json) => Metadata(
        title: json["title"],
        savingsFrequency: json["savingsFrequency"],
        savingsDayOfTheWeek: json["savingsDayOfTheWeek"],
        savingsDuration: json["savingsDuration"],
        savingstime: json["savingstime"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "savingsFrequency": savingsFrequency,
        "savingsDayOfTheWeek": savingsDayOfTheWeek,
        "savingsDuration": savingsDuration,
        "savingstime": savingstime,
      };
}
