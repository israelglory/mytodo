class TerminateSavingsResponse {
  final Subscription? subscription;
  final num? refund;
  final num? fee;

  TerminateSavingsResponse({
    this.subscription,
    this.refund,
    this.fee,
  });

  factory TerminateSavingsResponse.fromJson(Map<String, dynamic> json) =>
      TerminateSavingsResponse(
        subscription: json["subscription"] == null
            ? null
            : Subscription.fromJson(json["subscription"]),
        refund: json["refund"],
        fee: json["fee"],
      );

  Map<String, dynamic> toJson() => {
        "subscription": subscription?.toJson(),
        "refund": refund,
        "fee": fee,
      };
}

class Subscription {
  final String? savingsPlan;
  final DateTime? startDate;
  final DateTime? endDate;
  final num? amount;
  final num? interestEarned;
  final String? interestRateType;
  final AutomationData? automationData;
  final DateTime? lastPaymentDate;
  final num? duration;
  final num? rate;
  final String? savingsCategory;
  final String? status;
  final Metadata? metadata;
  final String? user;
  final String? createdBy;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? id;

  Subscription({
    this.savingsPlan,
    this.startDate,
    this.endDate,
    this.amount,
    this.interestEarned,
    this.interestRateType,
    this.automationData,
    this.lastPaymentDate,
    this.duration,
    this.rate,
    this.savingsCategory,
    this.status,
    this.metadata,
    this.user,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
    this.id,
  });

  factory Subscription.fromJson(Map<String, dynamic> json) => Subscription(
        savingsPlan: json["savingsPlan"],
        startDate: json["startDate"] == null
            ? null
            : DateTime.parse(json["startDate"]),
        endDate:
            json["endDate"] == null ? null : DateTime.parse(json["endDate"]),
        amount: json["amount"],
        interestEarned: json["interestEarned"],
        interestRateType: json["interestRateType"],
        automationData: json["automationData"] == null
            ? null
            : AutomationData.fromJson(json["automationData"]),
        lastPaymentDate: json["lastPaymentDate"] == null
            ? null
            : DateTime.parse(json["lastPaymentDate"]),
        duration: json["duration"],
        rate: json["rate"],
        savingsCategory: json["savingsCategory"],
        status: json["status"],
        metadata: json["metadata"] == null
            ? null
            : Metadata.fromJson(json["metadata"]),
        user: json["user"],
        createdBy: json["createdBy"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "savingsPlan": savingsPlan,
        "startDate": startDate?.toIso8601String(),
        "endDate": endDate?.toIso8601String(),
        "amount": amount,
        "interestEarned": interestEarned,
        "interestRateType": interestRateType,
        "automationData": automationData?.toJson(),
        "lastPaymentDate": lastPaymentDate?.toIso8601String(),
        "duration": duration,
        "rate": rate,
        "savingsCategory": savingsCategory,
        "status": status,
        "metadata": metadata?.toJson(),
        "user": user,
        "createdBy": createdBy,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "id": id,
      };
}

class AutomationData {
  final String? frequency;
  final num? dayOfWeek;
  final num? dayOfMonth;

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
  Metadata();

  factory Metadata.fromJson(Map<String, dynamic> json) => Metadata();

  Map<String, dynamic> toJson() => {};
}
