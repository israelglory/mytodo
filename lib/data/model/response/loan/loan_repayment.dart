class LoanRepaymentResponse {
  final int? amountPaid;
  final String? status;
  final int? amount;
  final DateTime? paymentDate;
  final String? source;
  final String? user;
  final String? loanId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? id;
  final bool? isActive;

  LoanRepaymentResponse({
    this.amountPaid,
    this.status,
    this.amount,
    this.paymentDate,
    this.source,
    this.user,
    this.loanId,
    this.createdAt,
    this.updatedAt,
    this.id,
    this.isActive,
  });

  factory LoanRepaymentResponse.fromJson(Map<String, dynamic> json) =>
      LoanRepaymentResponse(
        amountPaid: json["amountPaid"],
        status: json["status"],
        amount: json["amount"],
        paymentDate: DateTime.parse(json["paymentDate"]),
        source: json["source"],
        user: json["user"],
        loanId: json["loanId"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        id: json["id"],
        isActive: json["isActive"],
      );

  Map<String, dynamic> toJson() => {
        "amountPaid": amountPaid,
        "status": status,
        "amount": amount,
        "paymentDate": paymentDate?.toIso8601String(),
        "source": source,
        "user": user,
        "loanId": loanId,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "id": id,
        "isActive": isActive,
      };
}
