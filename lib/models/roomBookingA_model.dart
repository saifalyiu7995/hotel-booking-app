// To parse this JSON data, do
//
//     final roomBookingA = roomBookingAFromJson(jsonString);

import 'dart:convert';

RoomBookingA roomBookingAFromJson(String str) =>
    RoomBookingA.fromJson(json.decode(str));

String roomBookingAToJson(RoomBookingA data) => json.encode(data.toJson());

class RoomBookingA {
  RoomBookingA({
    this.paidServiceAmount,
    this.totalamount,
    this.details,
    this.status,
  });

  String paidServiceAmount;
  String totalamount;
  String details;
  String status;

  factory RoomBookingA.fromJson(Map<String, dynamic> json) => RoomBookingA(
        paidServiceAmount: json["paid_service_amount"],
        totalamount: json["totalamount"],
        details: json["details"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "paid_service_amount": paidServiceAmount,
        "totalamount": totalamount,
        "details": details,
        "status": status,
      };
}
