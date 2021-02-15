// To parse this JSON data, do
//
//     final foodMainModel = foodMainModelFromJson(jsonString);

import 'dart:convert';

FoodMainModel foodMainModelFromJson(String str) =>
    FoodMainModel.fromJson(json.decode(str));

String foodMainModelToJson(FoodMainModel data) => json.encode(data.toJson());

class FoodMainModel {
  FoodMainModel({
    this.status,
    this.categories,
  });

  String status;
  List<Category> categories;

  factory FoodMainModel.fromJson(Map<String, dynamic> json) => FoodMainModel(
        status: json["status"],
        categories: List<Category>.from(
            json["categories"].map((x) => Category.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
      };
}

class Category {
  Category({
    this.name,
    this.data,
  });

  String name;
  List<CatData> data;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        name: json["name"],
        data: List<CatData>.from(json["data"].map((x) => CatData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class CatData {
  CatData({
    this.ctname,
    this.id,
    this.name,
    this.code,
    this.tax,
    this.price,
    this.description,
    this.photothumb,
    this.options,
  });

  String ctname;
  String id;
  String name;
  String code;
  String tax;
  String price;
  String description;
  String photothumb;
  List<String> options;

  factory CatData.fromJson(Map<String, dynamic> json) => CatData(
        ctname: json["ctname"],
        id: json["id"],
        name: json["name"],
        code: json["code"],
        tax: json["tax"],
        price: json["price"],
        description: json["description"],
        photothumb: json["photothumb"],
        options: List<String>.from(json["options"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "ctname": ctname,
        "id": id,
        "name": name,
        "code": code,
        "tax": tax,
        "price": price,
        "description": description,
        "photothumb": photothumb,
        "options": List<dynamic>.from(options.map((x) => x)),
      };
}
