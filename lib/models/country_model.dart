// To parse this JSON data, do
//
//     final country = countryFromJson(jsonString);

import 'dart:convert';

Country countryFromJson(String str) => Country.fromJson(json.decode(str));

String countryToJson(Country data) => json.encode(data.toJson());

class Country {
  Country({
    this.status,
    this.countries,
  });

  String status;
  List<CountryElement> countries;

  factory Country.fromJson(Map<String, dynamic> json) => Country(
        status: json["status"],
        countries: List<CountryElement>.from(
            json["countries"].map((x) => CountryElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "countries": List<dynamic>.from(countries.map((x) => x.toJson())),
      };
}

class CountryElement {
  CountryElement({
    this.id,
    this.sortname,
    this.name,
    this.sequence,
  });

  String id;
  String sortname;
  String name;
  String sequence;

  factory CountryElement.fromJson(Map<String, dynamic> json) => CountryElement(
        id: json["id"],
        sortname: json["sortname"],
        name: json["name"],
        sequence: json["sequence"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "sortname": sortname,
        "name": name,
        "sequence": sequence,
      };
}
