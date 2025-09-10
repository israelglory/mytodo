class User {
  final String username;
  final String email;
  final String id;
  final String password;

  User({
    required this.email,
    required this.username,
    required this.id,
    required this.password,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    username: json["username"] ?? "",
    email: json["email"] ?? "",

    id: json["id"] ?? "",
    password: json["password"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "username": username,
    "email": email,

    "id": id,
    "password": password,
  };
}
