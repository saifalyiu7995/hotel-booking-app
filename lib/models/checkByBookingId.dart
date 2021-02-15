// To parse this JSON data, do
//
//     final checkByBookingId = checkByBookingIdFromJson(jsonString);

import 'dart:convert';

CheckByBookingId checkByBookingIdFromJson(String str) =>
    CheckByBookingId.fromJson(json.decode(str));

String checkByBookingIdToJson(CheckByBookingId data) =>
    json.encode(data.toJson());

class CheckByBookingId {
  CheckByBookingId({
    this.status,
    this.message,
    this.orderNo,
    this.rooms,
    this.checked,
  });

  String status;
  String message;
  String orderNo;
  List<String> rooms;
  String checked;

  factory CheckByBookingId.fromJson(Map<String, dynamic> json) =>
      CheckByBookingId(
        status: json["status"],
        message: json["message"],
        orderNo: json["order_no"],
        rooms: List<String>.from(json["rooms"].map((x) => x)),
        checked: json["checked"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "order_no": orderNo,
        "rooms": List<dynamic>.from(rooms.map((x) => x)),
        "checked": checked,
      };
}
