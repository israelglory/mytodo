class GetBankResponse {
  final String? name;
  final String? uuid;
  final String? interInstitutionCode;
  final String? sortCode;

  GetBankResponse({
    this.name,
    this.uuid,
    this.interInstitutionCode,
    this.sortCode,
  });

  factory GetBankResponse.fromJson(Map<String, dynamic> json) =>
      GetBankResponse(
        name: json["name"],
        uuid: json["uuid"],
        interInstitutionCode: json["interInstitutionCode"],
        sortCode: json["sortCode"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "uuid": uuid,
        "interInstitutionCode": interInstitutionCode,
        "sortCode": sortCode,
      };
}
