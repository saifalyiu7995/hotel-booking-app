// To parse this JSON data, do
//
//     final stripePayModel = stripePayModelFromJson(jsonString);

import 'dart:convert';

StripePayModel stripePayModelFromJson(String str) =>
    StripePayModel.fromJson(json.decode(str));

String stripePayModelToJson(StripePayModel data) => json.encode(data.toJson());

class StripePayModel {
  StripePayModel({
    this.stripeStatus,
    this.stripeMessage,
    this.status,
    this.message,
  });

  String stripeStatus;
  String stripeMessage;
  String status;
  String message;

  factory StripePayModel.fromJson(Map<String, dynamic> json) => StripePayModel(
        stripeStatus: json["stripe_status"],
        stripeMessage: json["stripe_message"],
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "stripe_status": stripeStatus,
        "stripe_message": stripeMessage,
        "status": status,
        "message": message,
      };
}
