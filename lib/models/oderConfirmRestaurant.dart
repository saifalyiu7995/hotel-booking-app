// To parse this JSON data, do
//
//     final orderConfirmRestaurant = orderConfirmRestaurantFromJson(jsonString);

import 'dart:convert';

OrderConfirmRestaurant orderConfirmRestaurantFromJson(String str) =>
    OrderConfirmRestaurant.fromJson(json.decode(str));

String orderConfirmRestaurantToJson(OrderConfirmRestaurant data) =>
    json.encode(data.toJson());

class OrderConfirmRestaurant {
  OrderConfirmRestaurant({
    this.status,
    this.message,
  });

  String status;
  String message;

  factory OrderConfirmRestaurant.fromJson(Map<String, dynamic> json) =>
      OrderConfirmRestaurant(
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
      };
}
