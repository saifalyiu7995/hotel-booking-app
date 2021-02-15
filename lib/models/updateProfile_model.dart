// To parse this JSON data, do
//
//     final updateProfile = updateProfileFromJson(jsonString);

import 'dart:convert';

UpdateProfile updateProfileFromJson(String str) =>
    UpdateProfile.fromJson(json.decode(str));

String updateProfileToJson(UpdateProfile data) => json.encode(data.toJson());

class UpdateProfile {
  UpdateProfile({
    this.status,
    this.message,
  });

  String status;
  String message;

  factory UpdateProfile.fromJson(Map<String, dynamic> json) => UpdateProfile(
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
      };
}
