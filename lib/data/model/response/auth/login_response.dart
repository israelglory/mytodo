import '../../model.dart';

class LogInResponse {
  final Data data;
  final String message;

  LogInResponse({
    required this.data,
    required this.message,
  });

  factory LogInResponse.fromJson(Map<String, dynamic> json) => LogInResponse(
        data: Data.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "message": message,
      };
}

class Data {
  final User user;
  final Tokens tokens;

  Data({
    required this.user,
    required this.tokens,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        user: User.fromJson(json["user"]),
        tokens: Tokens.fromJson(json["tokens"]),
      );

  Map<String, dynamic> toJson() => {
        "user": user.toJson(),
        "tokens": tokens.toJson(),
      };
}

class Tokens {
  final Access access;
  final Access refresh;

  Tokens({
    required this.access,
    required this.refresh,
  });

  factory Tokens.fromJson(Map<String, dynamic> json) => Tokens(
        access: Access.fromJson(json["access"]),
        refresh: Access.fromJson(json["refresh"]),
      );

  Map<String, dynamic> toJson() => {
        "access": access.toJson(),
        "refresh": refresh.toJson(),
      };
}

class Access {
  final String token;
  final DateTime expires;

  Access({
    required this.token,
    required this.expires,
  });

  factory Access.fromJson(Map<String, dynamic> json) => Access(
        token: json["token"],
        expires: DateTime.parse(json["expires"]),
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "expires": expires.toIso8601String(),
      };
}
