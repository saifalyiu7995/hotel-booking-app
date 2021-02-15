// To parse this JSON data, do
//
//     final hallDetaillModel = hallDetaillModelFromJson(jsonString);

import 'dart:convert';

HallDetaillModel hallDetaillModelFromJson(String str) =>
    HallDetaillModel.fromJson(json.decode(str));

String hallDetaillModelToJson(HallDetaillModel data) =>
    json.encode(data.toJson());

class HallDetaillModel {
  HallDetaillModel({
    this.status,
    this.hallType,
    this.amenities,
    this.images,
  });

  String status;
  List<HallType> hallType;
  List<AmenityHall> amenities;
  List<ImageHall> images;

  factory HallDetaillModel.fromJson(Map<String, dynamic> json) =>
      HallDetaillModel(
        status: json["status"],
        hallType: List<HallType>.from(
            json["hall_type"].map((x) => HallType.fromJson(x))),
        amenities: List<AmenityHall>.from(
            json["amenities"].map((x) => AmenityHall.fromJson(x))),
        images: List<ImageHall>.from(
            json["images"].map((x) => ImageHall.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "hall_type": List<dynamic>.from(hallType.map((x) => x.toJson())),
        "amenities": List<dynamic>.from(amenities.map((x) => x.toJson())),
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
      };
}

class AmenityHall {
  AmenityHall({
    this.id,
    this.title,
    this.active,
    this.description,
  });

  String id;
  String title;
  String active;
  String description;

  factory AmenityHall.fromJson(Map<String, dynamic> json) => AmenityHall(
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

class HallType {
  HallType({
    this.id,
    this.title,
    this.slug,
    this.shortcode,
    this.description,
    this.baseOccupancy,
    this.higherOccupancy,
    this.basePrice,
    this.bookingType,
  });

  String id;
  String title;
  String slug;
  String shortcode;
  String description;
  String baseOccupancy;
  String higherOccupancy;
  String basePrice;
  String bookingType;

  factory HallType.fromJson(Map<String, dynamic> json) => HallType(
        id: json["id"],
        title: json["title"],
        slug: json["slug"],
        shortcode: json["shortcode"],
        description: json["description"],
        baseOccupancy: json["base_occupancy"],
        higherOccupancy: json["higher_occupancy"],
        basePrice: json["base_price"],
        bookingType: json["booking_type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "slug": slug,
        "shortcode": shortcode,
        "description": description,
        "base_occupancy": baseOccupancy,
        "higher_occupancy": higherOccupancy,
        "base_price": basePrice,
        "booking_type": bookingType,
      };
}

class ImageHall {
  ImageHall({
    this.id,
    this.image,
    this.isFeatured,
    this.hallTypeId,
  });

  String id;
  String image;
  String isFeatured;
  String hallTypeId;

  factory ImageHall.fromJson(Map<String, dynamic> json) => ImageHall(
        id: json["id"],
        image: json["image"],
        isFeatured: json["is_featured"],
        hallTypeId: json["hall_type_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "is_featured": isFeatured,
        "hall_type_id": hallTypeId,
      };
}
