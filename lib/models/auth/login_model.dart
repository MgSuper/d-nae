import 'dart:convert';

Login loginModelFromJson(String str) => Login.fromJson(json.decode(str));

String loginModelToJson(Login data) => json.encode(data.toJson());

class Login {
  Login({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;

  factory Login.fromJson(Map<String, dynamic> json) => Login(
        email: json["email"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
      };
}
