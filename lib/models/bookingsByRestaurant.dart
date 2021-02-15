// To parse this JSON data, do
//
//     final bookingsByRestaurant = bookingsByRestaurantFromJson(jsonString);

import 'dart:convert';

BookingsByRestaurant bookingsByRestaurantFromJson(String str) =>
    BookingsByRestaurant.fromJson(json.decode(str));

String bookingsByRestaurantToJson(BookingsByRestaurant data) =>
    json.encode(data.toJson());

class BookingsByRestaurant {
  BookingsByRestaurant({
    this.status,
    this.orders,
  });

  String status;
  List<String> orders;

  factory BookingsByRestaurant.fromJson(Map<String, dynamic> json) =>
      BookingsByRestaurant(
        status: json["status"],
        orders: List<String>.from(json["orders"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "orders": List<dynamic>.from(orders.map((x) => x)),
      };
}
