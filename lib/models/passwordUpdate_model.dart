// To parse this JSON data, do
//
//     final passwordUpdate = passwordUpdateFromJson(jsonString);

import 'dart:convert';

PasswordUpdate passwordUpdateFromJson(String str) =>
    PasswordUpdate.fromJson(json.decode(str));

String passwordUpdateToJson(PasswordUpdate data) => json.encode(data.toJson());

class PasswordUpdate {
  PasswordUpdate({
    this.status,
    this.message,
  });

  String status;
  String message;

  factory PasswordUpdate.fromJson(Map<String, dynamic> json) => PasswordUpdate(
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
      };
}
