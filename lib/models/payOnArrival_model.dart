// To parse this JSON data, do
//
//     final payOnArrival = payOnArrivalFromJson(jsonString);

import 'dart:convert';

PayOnArrival payOnArrivalFromJson(String str) =>
    PayOnArrival.fromJson(json.decode(str));

String payOnArrivalToJson(PayOnArrival data) => json.encode(data.toJson());

class PayOnArrival {
  PayOnArrival({
    this.status,
    this.message,
    this.orderNo,
  });

  String status;
  String message;
  String orderNo;

  factory PayOnArrival.fromJson(Map<String, dynamic> json) => PayOnArrival(
        status: json["status"],
        message: json["message"],
        orderNo: json["order_no"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "order_no": orderNo,
      };
}
