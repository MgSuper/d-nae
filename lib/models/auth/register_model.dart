import 'dart:convert';

Register RegisterFromJson(String str) => Register.fromJson(json.decode(str));

String RegisterToJson(Register data) => json.encode(data.toJson());

class Register {
  Register({
    required this.username,
    required this.email,
    required this.password,
  });

  final String username;
  final String email;
  final String password;

  factory Register.fromJson(Map<String, dynamic> json) => Register(
        username: json["username"],
        email: json["email"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "email": email,
        "password": password,
      };
}
