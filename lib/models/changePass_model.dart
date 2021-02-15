// To parse this JSON data, do
//
//     final changePassModel = changePassModelFromJson(jsonString);

import 'dart:convert';

ChangePassModel changePassModelFromJson(String str) =>
    ChangePassModel.fromJson(json.decode(str));

String changePassModelToJson(ChangePassModel data) =>
    json.encode(data.toJson());

class ChangePassModel {
  ChangePassModel({
    this.status,
    this.userId,
    this.message,
  });

  String status;
  String userId;
  String message;

  factory ChangePassModel.fromJson(Map<String, dynamic> json) =>
      ChangePassModel(
        status: json["status"],
        userId: json["user_id"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "user_id": userId,
        "message": message,
      };
}
