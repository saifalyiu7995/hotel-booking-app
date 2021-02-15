// To parse this JSON data, do
//
//     final speedyInfo = speedyInfoFromJson(jsonString);

import 'dart:convert';

SpeedyInfo speedyInfoFromJson(String str) =>
    SpeedyInfo.fromJson(json.decode(str));

String speedyInfoToJson(SpeedyInfo data) => json.encode(data.toJson());

class SpeedyInfo {
  SpeedyInfo({
    this.status,
    this.message,
  });

  String status;
  String message;

  factory SpeedyInfo.fromJson(Map<String, dynamic> json) => SpeedyInfo(
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
      };
}
