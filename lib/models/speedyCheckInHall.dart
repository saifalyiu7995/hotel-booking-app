// To parse this JSON data, do
//
//     final speedyCheckInByDateHall = speedyCheckInByDateHallFromJson(jsonString);

import 'dart:convert';

SpeedyCheckInByDateHall speedyCheckInByDateHallFromJson(String str) =>
    SpeedyCheckInByDateHall.fromJson(json.decode(str));

String speedyCheckInByDateHallToJson(SpeedyCheckInByDateHall data) =>
    json.encode(data.toJson());

class SpeedyCheckInByDateHall {
  SpeedyCheckInByDateHall({
    this.status,
    this.message,
    this.data,
  });

  String status;
  String message;
  List<Datumm> data;

  factory SpeedyCheckInByDateHall.fromJson(Map<String, dynamic> json) =>
      SpeedyCheckInByDateHall(
        status: json["status"],
        message: json["message"],
        data: List<Datumm>.from(json["data"].map((x) => Datumm.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datumm {
  Datumm({
    this.id,
    this.floorId,
    this.hallNo,
    this.hallTypeId,
    this.floor,
    this.image,
  });

  String id;
  String floorId;
  String hallNo;
  String hallTypeId;
  String floor;
  String image;

  factory Datumm.fromJson(Map<String, dynamic> json) => Datumm(
        id: json["id"],
        floorId: json["floor_id"],
        hallNo: json["hall_no"],
        hallTypeId: json["hall_type_id"],
        floor: json["floor"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "floor_id": floorId,
        "hall_no": hallNo,
        "hall_type_id": hallTypeId,
        "floor": floor,
        "image": image,
      };
}
