// To parse this JSON data, do
//
//     final forgetPassModel = forgetPassModelFromJson(jsonString);

import 'dart:convert';

ForgetPassModel forgetPassModelFromJson(String str) =>
    ForgetPassModel.fromJson(json.decode(str));

String forgetPassModelToJson(ForgetPassModel data) =>
    json.encode(data.toJson());

class ForgetPassModel {
  ForgetPassModel({
    this.status,
    this.userId,
    this.message,
  });

  String status;
  String userId;
  String message;

  factory ForgetPassModel.fromJson(Map<String, dynamic> json) =>
      ForgetPassModel(
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
