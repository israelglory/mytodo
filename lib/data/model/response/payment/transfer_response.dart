class TransferResponse {
  final bool? pending;
  final bool? locked;
  final String? user;
  final String? source;
  final String? type;
  final int? amount;
  final String? purpose;
  final String? createdBy;
  final String? transactionDump;
  final Meta? meta;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? id;

  TransferResponse({
    this.pending,
    this.locked,
    this.user,
    this.source,
    this.type,
    this.amount,
    this.purpose,
    this.createdBy,
    this.transactionDump,
    this.meta,
    this.createdAt,
    this.updatedAt,
    this.id,
  });

  factory TransferResponse.fromJson(Map<String, dynamic> json) =>
      TransferResponse(
        pending: json["pending"],
        locked: json["locked"],
        user: json["user"],
        source: json["source"],
        type: json["type"],
        amount: json["amount"],
        purpose: json["purpose"],
        createdBy: json["createdBy"],
        transactionDump: json["transactionDump"],
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "pending": pending,
        "locked": locked,
        "user": user,
        "source": source,
        "type": type,
        "amount": amount,
        "purpose": purpose,
        "createdBy": createdBy,
        "transactionDump": transactionDump,
        "meta": meta?.toJson(),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "id": id,
      };
}

class Meta {
  final String? accountNumber;
  final String? accountName;
  final String? currency;
  final double? fee;
  final String? message;

  Meta({
    this.accountNumber,
    this.accountName,
    this.currency,
    this.fee,
    this.message,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        accountNumber: json["accountNumber"],
        accountName: json["accountName"],
        currency: json["currency"],
        fee: json["fee"]?.toDouble(),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "accountNumber": accountNumber,
        "accountName": accountName,
        "currency": currency,
        "fee": fee,
        "message": message,
      };
}
