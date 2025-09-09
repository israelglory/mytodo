class GetAccountInfoResponse {
  final int? balance;
  final int? debt;
  final int? stash;
  final String? user;
  final AccountInfo? accountInfo;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? id;

  GetAccountInfoResponse({
    this.balance,
    this.debt,
    this.stash,
    this.user,
    this.accountInfo,
    this.createdAt,
    this.updatedAt,
    this.id,
  });

  factory GetAccountInfoResponse.fromJson(Map<String, dynamic> json) =>
      GetAccountInfoResponse(
        balance: json["balance"],
        debt: json["debt"],
        stash: json["stash"],
        user: json["user"],
        accountInfo: AccountInfo.fromJson(json["accountInfo"]),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "balance": balance,
        "debt": debt,
        "stash": stash,
        "user": user,
        "accountInfo": accountInfo?.toJson(),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "id": id,
      };
}

class AccountInfo {
  final String? accountNumber;
  final String? accountReference;
  final String? accountName;
  final String? bankName;

  AccountInfo({
    this.accountNumber,
    this.accountReference,
    this.accountName,
    this.bankName,
  });

  factory AccountInfo.fromJson(Map<String, dynamic> json) => AccountInfo(
        accountNumber: json["accountNumber"],
        accountReference: json["accountReference"],
        accountName: json["accountName"],
        bankName: json["bankName"],
      );

  Map<String, dynamic> toJson() => {
        "accountNumber": accountNumber,
        "accountReference": accountReference,
        "accountName": accountName,
        "bankName": bankName,
      };
}
