class GetLoanByIdResponse {
  final RepaymentData? repaymentData;
  final String? monthlyIncome;
  final String? employmentStatus;
  final String? status;
  final String? loanCategory;
  final int? amount;
  final String? loanPlan;
  final Metadata? metadata;
  final String? user;
  final String? createdBy;
  final int? rate;
  final int? duration;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? id;

  GetLoanByIdResponse({
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
    this.id,
  });

  factory GetLoanByIdResponse.fromJson(Map<String, dynamic> json) =>
      GetLoanByIdResponse(
        repaymentData: RepaymentData.fromJson(json["repaymentData"]),
        monthlyIncome: json["monthlyIncome"],
        employmentStatus: json["employmentStatus"],
        status: json["status"],
        loanCategory: json["loanCategory"],
        amount: json["amount"],
        loanPlan: json["loanPlan"],
        metadata: Metadata.fromJson(json["metadata"]),
        user: json["user"],
        createdBy: json["createdBy"],
        rate: json["rate"],
        duration: json["duration"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "repaymentData": repaymentData?.toJson(),
        "monthlyIncome": monthlyIncome,
        "employmentStatus": employmentStatus,
        "status": status,
        "loanCategory": loanCategory,
        "amount": amount,
        "loanPlan": loanPlan,
        "metadata": metadata?.toJson(),
        "user": user,
        "createdBy": createdBy,
        "rate": rate,
        "duration": duration,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "id": id,
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
        garantorDetails: GarantorDetails.fromJson(json["guarantorDetails"]),
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
