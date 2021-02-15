// To parse this JSON data, do
//
//     final cities = citiesFromJson(jsonString);

import 'dart:convert';

Cities citiesFromJson(String str) => Cities.fromJson(json.decode(str));

String citiesToJson(Cities data) => json.encode(data.toJson());

class Cities {
  Cities({
    this.status,
    this.cities,
  });

  String status;
  List<City> cities;

  factory Cities.fromJson(Map<String, dynamic> json) => Cities(
        status: json["status"],
        cities: List<City>.from(json["cities"].map((x) => City.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "cities": List<dynamic>.from(cities.map((x) => x.toJson())),
      };
}

class City {
  City({
    this.id,
    this.name,
    this.stateId,
  });

  String id;
  String name;
  String stateId;

  factory City.fromJson(Map<String, dynamic> json) => City(
        id: json["id"],
        name: json["name"],
        stateId: json["state_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "state_id": stateId,
      };
}
