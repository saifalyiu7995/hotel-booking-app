// To parse this JSON data, do
//
//     final state = stateFromJson(jsonString);

import 'dart:convert';

StateModel stateFromJson(String str) => StateModel.fromJson(json.decode(str));

String stateToJson(StateModel data) => json.encode(data.toJson());

class StateModel {
  StateModel({
    this.status,
    this.states,
  });

  String status;
  List<StateElement> states;

  factory StateModel.fromJson(Map<String, dynamic> json) => StateModel(
        status: json["status"],
        states: List<StateElement>.from(
            json["states"].map((x) => StateElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "states": List<dynamic>.from(states.map((x) => x.toJson())),
      };
}

class StateElement {
  StateElement({
    this.id,
    this.name,
    this.countryId,
  });

  String id;
  String name;
  String countryId;

  factory StateElement.fromJson(Map<String, dynamic> json) => StateElement(
        id: json["id"],
        name: json["name"],
        countryId: json["country_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "country_id": countryId,
      };
}
