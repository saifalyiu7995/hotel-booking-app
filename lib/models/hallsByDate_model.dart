// To parse this JSON data, do
//
//     final hallsByDate = hallsByDateFromJson(jsonString);

import 'dart:convert';

HallsByDate hallsByDateFromJson(String str) =>
    HallsByDate.fromJson(json.decode(str));

String hallsByDateToJson(HallsByDate data) => json.encode(data.toJson());

class HallsByDate {
  HallsByDate({
    this.status,
    this.timeTo,
    this.timeFrom,
    this.data,
  });

  String status;
  String timeTo;
  String timeFrom;
  DataHalls data;

  factory HallsByDate.fromJson(Map<String, dynamic> json) => HallsByDate(
        status: json["status"],
        timeTo: json["time_to"],
        timeFrom: json["time_from"],
        data: DataHalls.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "time_to": timeTo,
        "time_from": timeFrom,
        "data": data.toJson(),
      };
}

class DataHalls {
  DataHalls({
    this.hallTypes,
  });

  List<Map<String, String>> hallTypes;

  factory DataHalls.fromJson(Map<String, dynamic> json) => DataHalls(
        hallTypes: List<Map<String, String>>.from(json["hall_types"].map((x) =>
            Map.from(x).map(
                (k, v) => MapEntry<String, String>(k, v == null ? null : v)))),
      );

  Map<String, dynamic> toJson() => {
        "hall_types": List<dynamic>.from(hallTypes.map((x) => Map.from(x).map(
            (k, v) => MapEntry<String, dynamic>(k, v == null ? null : v)))),
      };
}
