class ApiResponse<T> {
  int? insertedId;
  bool success = true;
  String? message = '';
  int? totalCount;
  int? pageSize;
  int? statusCode;
  int? currentPage;
  int? totalPages;
  bool? hasNext;
  bool? hasPrevious;
  Summary? summary;
  T? data;

  ApiResponse(
      {this.insertedId,
      this.success = true,
      this.message = '',
      this.totalCount,
      this.pageSize,
      this.statusCode,
      this.currentPage,
      this.totalPages,
      this.hasNext,
      this.hasPrevious,
      this.summary,
      this.data});

  ApiResponse.fromJson(Map<String, dynamic> json) {
    insertedId = json['insertedId'];
    success = json['isSuccess'] ?? true;
    message = json['message'].toString();
    totalCount = json['total_count'];
    pageSize = json['page_size'];
    currentPage = json['current_page'];
    totalPages = json['totalPages'];
    hasNext = json['has_next'];
    hasPrevious = json['has_previous'];
    if (json['summary'] != null) {
      summary = Summary.fromJson(json['summary']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['insertedId'] = insertedId;
    data['isSuccess'] = success;
    data['message'] = message;
    data['total_count'] = totalCount;
    data['page_size'] = pageSize;
    data['current_page'] = currentPage;
    data['totalPages'] = totalPages;
    data['has_next'] = hasNext;
    data['has_previous'] = hasPrevious;
    if (summary != null) {
      data['summary'] = summary!.toJson();
    }
    return data;
  }
}

class Summary {
  final num? credit;
  final num? debit;

  Summary({
    this.credit,
    this.debit,
  });

  factory Summary.fromJson(Map<String, dynamic> json) => Summary(
        credit: json["credit"],
        debit: json["debit"],
      );

  Map<String, dynamic> toJson() => {
        "credit": credit,
        "debit": debit,
      };
}
