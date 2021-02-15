// To parse this JSON data, do
//
//     final roomsByDate = roomsByDateFromJson(jsonString);

import 'dart:convert';

RoomsByDate roomsByDateFromJson(String str) =>
    RoomsByDate.fromJson(json.decode(str));

String roomsByDateToJson(RoomsByDate data) => json.encode(data.toJson());

class RoomsByDate {
  RoomsByDate({
    this.status,
    this.dateFrom,
    this.dateTo,
    this.data,
  });

  String status;
  DateTime dateFrom;
  DateTime dateTo;
  Data data;

  factory RoomsByDate.fromJson(Map<String, dynamic> json) => RoomsByDate(
        status: json["status"],
        dateFrom: DateTime.parse(json["date_from"]),
        dateTo: DateTime.parse(json["date_to"]),
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "date_from":
            "${dateFrom.year.toString().padLeft(4, '0')}-${dateFrom.month.toString().padLeft(2, '0')}-${dateFrom.day.toString().padLeft(2, '0')}",
        "date_to":
            "${dateTo.year.toString().padLeft(4, '0')}-${dateTo.month.toString().padLeft(2, '0')}-${dateTo.day.toString().padLeft(2, '0')}",
        "data": data.toJson(),
      };
}

class Data {
  Data({
    this.roomTypes,
  });

  List<Map<String, String>> roomTypes;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        roomTypes: List<Map<String, String>>.from(json["room_types"].map((x) =>
            Map.from(x).map(
                (k, v) => MapEntry<String, String>(k, v == null ? null : v)))),
      );

  Map<String, dynamic> toJson() => {
        "room_types": List<dynamic>.from(roomTypes.map((x) => Map.from(x).map(
            (k, v) => MapEntry<String, dynamic>(k, v == null ? null : v)))),
      };
}
