// To parse this JSON data, do
//
//     final stripPaymentKey = stripPaymentKeyFromJson(jsonString);

import 'dart:convert';

StripPaymentKey stripPaymentKeyFromJson(String str) =>
    StripPaymentKey.fromJson(json.decode(str));

String stripPaymentKeyToJson(StripPaymentKey data) =>
    json.encode(data.toJson());

class StripPaymentKey {
  StripPaymentKey({
    this.stripeApiKey,
  });

  String stripeApiKey;

  factory StripPaymentKey.fromJson(Map<String, dynamic> json) =>
      StripPaymentKey(
        stripeApiKey: json["stripe_api_key"],
      );

  Map<String, dynamic> toJson() => {
        "stripe_api_key": stripeApiKey,
      };
}
