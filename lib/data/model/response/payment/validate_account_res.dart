class ValidateAccountResponse {
  final String? accountNumber;
  final String? accountName;
  final double? fee;
  final double? vat;

  ValidateAccountResponse({
    this.accountNumber,
    this.accountName,
    this.fee,
    this.vat,
  });

  factory ValidateAccountResponse.fromJson(Map<String, dynamic> json) =>
      ValidateAccountResponse(
        accountNumber: json["accountNumber"],
        accountName: json["accountName"],
        fee: json["fee"]?.toDouble(),
        vat: json["vat"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "accountNumber": accountNumber,
        "accountName": accountName,
        "fee": fee,
        "vat": vat,
      };
}
