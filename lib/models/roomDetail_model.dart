// To parse this JSON data, do
//
//     final roomDeatlModel = roomDeatlModelFromJson(jsonString);

import 'dart:convert';

RoomDeatlModel roomDeatlModelFromJson(String str) =>
    RoomDeatlModel.fromJson(json.decode(str));

String roomDeatlModelToJson(RoomDeatlModel data) => json.encode(data.toJson());

class RoomDeatlModel {
  RoomDeatlModel({
    this.status,
    this.roomType,
    this.amenities,
    this.image,
  });

  String status;
  List<RoomType> roomType;
  List<Amenity> amenities;
  List<Imagee> image;

  factory RoomDeatlModel.fromJson(Map<String, dynamic> json) => RoomDeatlModel(
        status: json["status"],
        roomType: List<RoomType>.from(
            json["room_type"].map((x) => RoomType.fromJson(x))),
        amenities: List<Amenity>.from(
            json["amenities"].map((x) => Amenity.fromJson(x))),
        image: List<Imagee>.from(json["image"].map((x) => Imagee.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "room_type": List<dynamic>.from(roomType.map((x) => x.toJson())),
        "amenities": List<dynamic>.from(amenities.map((x) => x.toJson())),
        "image": List<dynamic>.from(image.map((x) => x.toJson())),
      };
}

class Amenity {
  Amenity({
    this.id,
    this.title,
    this.active,
    this.description,
  });

  String id;
  String title;
  String active;
  String description;

  factory Amenity.fromJson(Map<String, dynamic> json) => Amenity(
        id: json["id"],
        title: json["title"],
        active: json["active"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "active": active,
        "description": description,
      };
}

class Imagee {
  Imagee({
    this.id,
    this.image,
    this.isFeatured,
    this.roomTypeId,
  });

  String id;
  String image;
  String isFeatured;
  String roomTypeId;

  factory Imagee.fromJson(Map<String, dynamic> json) => Imagee(
        id: json["id"],
        image: json["image"],
        isFeatured: json["is_featured"],
        roomTypeId: json["room_type_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "is_featured": isFeatured,
        "room_type_id": roomTypeId,
      };
}

class RoomType {
  RoomType({
    this.id,
    this.title,
    this.slug,
    this.shortcode,
    this.description,
    this.baseOccupancy,
    this.higherOccupancy,
    this.extraBed,
    this.extraBeds,
    this.kidsOccupancy,
    this.basePrice,
    this.additionalPerson,
    this.extraBedPrice,
  });

  String id;
  String title;
  String slug;
  String shortcode;
  String description;
  String baseOccupancy;
  String higherOccupancy;
  String extraBed;
  String extraBeds;
  String kidsOccupancy;
  String basePrice;
  String additionalPerson;
  String extraBedPrice;

  factory RoomType.fromJson(Map<String, dynamic> json) => RoomType(
        id: json["id"],
        title: json["title"],
        slug: json["slug"],
        shortcode: json["shortcode"],
        description: json["description"],
        baseOccupancy: json["base_occupancy"],
        higherOccupancy: json["higher_occupancy"],
        extraBed: json["extra_bed"],
        extraBeds: json["extra_beds"],
        kidsOccupancy: json["kids_occupancy"],
        basePrice: json["base_price"],
        additionalPerson: json["additional_person"],
        extraBedPrice: json["extra_bed_price"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "slug": slug,
        "shortcode": shortcode,
        "description": description,
        "base_occupancy": baseOccupancy,
        "higher_occupancy": higherOccupancy,
        "extra_bed": extraBed,
        "extra_beds": extraBeds,
        "kids_occupancy": kidsOccupancy,
        "base_price": basePrice,
        "additional_person": additionalPerson,
        "extra_bed_price": extraBedPrice,
      };
}
