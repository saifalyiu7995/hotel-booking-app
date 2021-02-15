// To parse this JSON data, do
//
//     final getRestaurant = getRestaurantFromJson(jsonString);

import 'dart:convert';

GetRestaurant getRestaurantFromJson(String str) =>
    GetRestaurant.fromJson(json.decode(str));

String getRestaurantToJson(GetRestaurant data) => json.encode(data.toJson());

class GetRestaurant {
  GetRestaurant({
    this.status,
    this.stores,
  });

  String status;
  List<Store> stores;

  factory GetRestaurant.fromJson(Map<String, dynamic> json) => GetRestaurant(
        status: json["status"],
        stores: List<Store>.from(json["stores"].map((x) => Store.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "stores": List<dynamic>.from(stores.map((x) => x.toJson())),
      };
}

class Store {
  Store({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.adresse,
    this.footerText,
    this.city,
    this.country,
    this.createdAt,
    this.status,
  });

  String id;
  String name;
  String email;
  String phone;
  String adresse;
  String footerText;
  String city;
  String country;
  DateTime createdAt;
  String status;

  factory Store.fromJson(Map<String, dynamic> json) => Store(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        adresse: json["adresse"],
        footerText: json["footer_text"],
        city: json["city"],
        country: json["country"],
        createdAt: DateTime.parse(json["created_at"]),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "phone": phone,
        "adresse": adresse,
        "footer_text": footerText,
        "city": city,
        "country": country,
        "created_at": createdAt.toIso8601String(),
        "status": status,
      };
}
