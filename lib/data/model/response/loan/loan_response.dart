class LoanResponse {
  final String? id;
  final RepaymentData? repaymentData;
  final String? monthlyIncome;
  final String? employmentStatus;
  final String? status;
  final LoanCategory? loanCategory;
  final int? amount;
  final String? loanPlan;
  final Metadata? metadata;
  final String? user;
  final String? createdBy;
  final int? rate;
  final int? duration;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  LoanResponse({
    this.id,
    this.repaymentData,
    this.monthlyIncome,
    this.employmentStatus,
    this.status,
    this.loanCategory,
    this.amount,
    this.loanPlan,
    this.metadata,
    this.user,
    this.createdBy,
    this.rate,
    this.duration,
    this.createdAt,
    this.updatedAt,
  });

  factory LoanResponse.fromJson(Map<String, dynamic> json) => LoanResponse(
        id: json["id"],
        repaymentData: RepaymentData.fromJson(json["repaymentData"]),
        monthlyIncome: json["monthlyIncome"],
        employmentStatus: json["employmentStatus"],
        status: json["status"],
        loanCategory: LoanCategory.fromJson(json["loanCategory"]),
        amount: json["amount"],
        loanPlan: json["loanPlan"],
        metadata: Metadata.fromJson(json["metadata"]),
        user: json["user"],
        createdBy: json["createdBy"],
        rate: json["rate"],
        duration: json["duration"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "repaymentData": repaymentData?.toJson(),
        "monthlyIncome": monthlyIncome,
        "employmentStatus": employmentStatus,
        "status": status,
        "loanCategory": loanCategory?.toJson(),
        "amount": amount,
        "loanPlan": loanPlan,
        "metadata": metadata?.toJson(),
        "user": user,
        "createdBy": createdBy,
        "rate": rate,
        "duration": duration,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}

class LoanCategory {
  final String? id;
  final int? minimumAmount;
  final String? status;
  final String? name;
  final String? loanType;
  final String? description;
  final int? maximumAmount;
  final List<Charge>? charges;
  final List<Plan>? plans;
  final String? createdBy;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  LoanCategory({
    this.id,
    this.minimumAmount,
    this.status,
    this.name,
    this.description,
    this.loanType,
    this.maximumAmount,
    this.charges,
    this.plans,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
  });

  factory LoanCategory.fromJson(Map<String, dynamic> json) => LoanCategory(
        id: json["id"],
        minimumAmount: json["minimumAmount"],
        status: json["status"],
        name: json["name"],
        description: json["description"],
        maximumAmount: json["maximumAmount"],
        loanType: json["loanType"],
        charges:
            List<Charge>.from(json["charges"].map((x) => Charge.fromJson(x))),
        plans: List<Plan>.from(json["plans"].map((x) => Plan.fromJson(x))),
        createdBy: json["createdBy"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "minimumAmount": minimumAmount,
        "status": status,
        "name": name,
        "loanType": loanType,
        "description": description,
        "maximumAmount": maximumAmount,
        "charges": List<dynamic>.from(charges!.map((x) => x.toJson())),
        "plans": List<dynamic>.from(plans!.map((x) => x.toJson())),
        "createdBy": createdBy,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
      };
}

class Charge {
  final String? id;
  final String? chargeFeeType;
  final String? chargeType;
  final double? chargeAmount;
  final int? maxChargeAmount;

  Charge({
    this.id,
    this.chargeFeeType,
    this.chargeType,
    this.chargeAmount,
    this.maxChargeAmount,
  });

  factory Charge.fromJson(Map<String, dynamic> json) => Charge(
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

class Metadata {
  final NextOfKinDetails? nextOfKinDetails;
  final GarantorDetails? garantorDetails;

  Metadata({
    this.nextOfKinDetails,
    this.garantorDetails,
  });

  factory Metadata.fromJson(Map<String, dynamic> json) => Metadata(
        nextOfKinDetails: NextOfKinDetails.fromJson(json["nextOfKinDetails"]),
        garantorDetails: json["guarantorDetails"] != null
            ? GarantorDetails.fromJson(json["guarantorDetails"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "nextOfKinDetails": nextOfKinDetails?.toJson(),
        "guarantorDetails": garantorDetails?.toJson(),
      };
}

class GarantorDetails {
  final String? fullName;
  final String? phoneNumber;
  final String? emailAddress;
  final String? address;

  GarantorDetails({
    this.fullName,
    this.phoneNumber,
    this.emailAddress,
    this.address,
  });

  factory GarantorDetails.fromJson(Map<String, dynamic> json) =>
      GarantorDetails(
        fullName: json["fullName"],
        phoneNumber: json["phoneNumber"],
        emailAddress: json["emailAddress"],
        address: json["address"],
      );

  Map<String, dynamic> toJson() => {
        "fullName": fullName,
        "phoneNumber": phoneNumber,
        "emailAddress": emailAddress,
        "address": address,
      };
}

class NextOfKinDetails {
  final String? fullName;
  final String? phoneNumber;
  final String? relationship;
  final String? address;

  NextOfKinDetails({
    this.fullName,
    this.phoneNumber,
    this.relationship,
    this.address,
  });

  factory NextOfKinDetails.fromJson(Map<String, dynamic> json) =>
      NextOfKinDetails(
        fullName: json["fullName"],
        phoneNumber: json["phoneNumber"],
        relationship: json["relationship"],
        address: json["address"],
      );

  Map<String, dynamic> toJson() => {
        "fullName": fullName,
        "phoneNumber": phoneNumber,
        "relationship": relationship,
        "address": address,
      };
}

class RepaymentData {
  final int? expectedReturn;
  final int? totalReturned;
  final int? balance;
  final int? interestAmount;

  RepaymentData({
    this.expectedReturn,
    this.totalReturned,
    this.balance,
    this.interestAmount,
  });

  factory RepaymentData.fromJson(Map<String, dynamic> json) => RepaymentData(
        expectedReturn: json["expectedReturn"],
        totalReturned: json["totalReturned"],
        balance: json["balance"],
        interestAmount: json["interestAmount"],
      );

  Map<String, dynamic> toJson() => {
        "expectedReturn": expectedReturn,
        "totalReturned": totalReturned,
        "balance": balance,
        "interestAmount": interestAmount,
      };
}
