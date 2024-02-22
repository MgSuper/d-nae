import 'dart:convert';

Profile ProfileFromJson(String str) => Profile.fromJson(json.decode(str));

String ProfileToJson(Profile data) => json.encode(data.toJson());

class Profile {
  Profile({
    required this.id,
    required this.username,
    required this.email,
    required this.location,
  });

  final String id;
  final String username;
  final String email;
  final String location;

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        id: json["_id"],
        username: json["username"],
        email: json["email"],
        location: json["location"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "username": username,
        "email": email,
        "location": location,
      };
}
