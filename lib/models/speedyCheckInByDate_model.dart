// To parse this JSON data, do
//
//     final speedyCheckInByDate = speedyCheckInByDateFromJson(jsonString);

import 'dart:convert';

SpeedyCheckInByDate speedyCheckInByDateFromJson(String str) =>
    SpeedyCheckInByDate.fromJson(json.decode(str));

String speedyCheckInByDateToJson(SpeedyCheckInByDate data) =>
    json.encode(data.toJson());

class SpeedyCheckInByDate {
  SpeedyCheckInByDate({
    this.status,
    this.message,
    this.data,
  });

  String status;
  String message;
  List<Datum> data;

  factory SpeedyCheckInByDate.fromJson(Map<String, dynamic> json) =>
      SpeedyCheckInByDate(
        status: json["status"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.id,
    this.floorId,
    this.roomNo,
    this.roomTypeId,
    this.floor,
    this.image,
  });

  String id;
  String floorId;
  String roomNo;
  String roomTypeId;
  String floor;
  String image;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        floorId: json["floor_id"],
        roomNo: json["room_no"],
        roomTypeId: json["room_type_id"],
        floor: json["floor"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "floor_id": floorId,
        "room_no": roomNo,
        "room_type_id": roomTypeId,
        "floor": floor,
        "image": image,
      };
}
