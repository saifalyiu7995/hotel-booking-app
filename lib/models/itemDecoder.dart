// To parse this JSON data, do
//
//     final itemDecode = itemDecodeFromJson(jsonString);

import 'dart:convert';

List<ItemDecode> itemDecodeFromJson(String str) =>
    List<ItemDecode>.from(json.decode(str).map((x) => ItemDecode.fromJson(x)));

String itemDecodeToJson(List<ItemDecode> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ItemDecode {
  ItemDecode({
    this.name,
    this.price,
    this.qty,
    this.id,
  });

  String name;
  String price;
  String qty;
  String id;

  factory ItemDecode.fromJson(Map<String, dynamic> json) => ItemDecode(
        name: json["name"],
        price: json["price"],
        qty: json["qty"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "price": price,
        "qty": qty,
        "id": id,
      };
}
