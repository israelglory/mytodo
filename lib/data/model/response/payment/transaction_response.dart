class TransactionResponse {
  final String? id;
  final bool? pending;
  final bool? locked;
  final String? user;
  final String? source;
  final String? type;
  final num? amount;
  final String? purpose;
  final String? createdBy;
  final String? transactionDump;
  final String? reference;
  final num? ledgerBalance;
  final Meta? meta;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  TransactionResponse({
    this.id,
    this.pending,
    this.locked,
    this.user,
    this.source,
    this.type,
    this.amount,
    this.purpose,
    this.createdBy,
    this.transactionDump,
    this.reference,
    this.ledgerBalance,
    this.meta,
    this.createdAt,
    this.updatedAt,
  });

  factory TransactionResponse.fromJson(Map<String, dynamic> json) =>
      TransactionResponse(
        id: json["id"],
        pending: json["pending"],
        locked: json["locked"],
        user: json["user"],
        source: json["source"],
        type: json["type"],
        amount: json["amount"],
        purpose: json["purpose"],
        createdBy: json["createdBy"],
        transactionDump: json["transactionDump"],
        reference: json["reference"],
        ledgerBalance: json["ledgerBalance"],
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "pending": pending,
        "locked": locked,
        "user": user,
        "source": source,
        "type": type,
        "amount": amount,
        "purpose": purpose,
        "createdBy": createdBy,
        "transactionDump": transactionDump,
        "reference": reference,
        "ledgerBalance": ledgerBalance,
        "meta": meta?.toJson(),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}

class Meta {
  final String? accountNumber;
  final String? payerName;
  final String? senderBankName;
  final String? accountName;
  final String? bankName;
  final String? destination;
  final String? currency;
  final num? fee;
  final String? message;
  final String? reference;

  Meta({
    this.accountNumber,
    this.payerName,
    this.senderBankName,
    this.accountName,
    this.bankName,
    this.destination,
    this.currency,
    this.fee,
    this.message,
    this.reference,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        accountNumber: json["accountNumber"],
        payerName: json["payerName"],
        accountName: json["accountName"],
        bankName: json["bankName"],
        senderBankName: json["senderBankName"],
        destination: json["destination"],
        currency: json["currency"],
        fee: json["fee"],
        message: json["message"],
        reference: json["reference"],
      );

  Map<String, dynamic> toJson() => {
        "accountNumber": accountNumber,
        "payerName": payerName,
        "accountName": accountName,
        "bankName": bankName,
        "destination": destination,
        "currency": currency,
        "fee": fee,
        "message": message,
        "reference": reference,
      };
}
