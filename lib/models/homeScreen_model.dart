// To parse this JSON data, do
//
//     final homeModel = homeModelFromJson(jsonString);

import 'dart:convert';

HomeModel homeModelFromJson(String str) => HomeModel.fromJson(json.decode(str));

String homeModelToJson(HomeModel data) => json.encode(data.toJson());

class HomeModel {
  HomeModel({
    this.rooms,
    this.halls,
    this.testimonials,
  });

  List<Map<String, String>> rooms;
  List<Hall> halls;
  List<Testimonial> testimonials;

  factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(
        rooms: List<Map<String, String>>.from(json["rooms"].map((x) =>
            Map.from(x).map(
                (k, v) => MapEntry<String, String>(k, v == null ? null : v)))),
        halls: List<Hall>.from(json["halls"].map((x) => Hall.fromJson(x))),
        testimonials: List<Testimonial>.from(
            json["testimonials"].map((x) => Testimonial.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "rooms": List<dynamic>.from(rooms.map((x) => Map.from(x).map(
            (k, v) => MapEntry<String, dynamic>(k, v == null ? null : v)))),
        "halls": List<dynamic>.from(halls.map((x) => x.toJson())),
        "testimonials": List<dynamic>.from(testimonials.map((x) => x.toJson())),
      };
}

class Hall {
  Hall({
    this.id,
    this.title,
    this.slug,
    this.shortcode,
    this.description,
    this.baseOccupancy,
    this.higherOccupancy,
    this.basePrice,
    this.bookingType,
    this.image,
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
  String image;

  factory Hall.fromJson(Map<String, dynamic> json) => Hall(
        id: json["id"],
        title: json["title"],
        slug: json["slug"],
        shortcode: json["shortcode"],
        description: json["description"],
        baseOccupancy: json["base_occupancy"],
        higherOccupancy: json["higher_occupancy"],
        basePrice: json["base_price"],
        bookingType: json["booking_type"],
        image: json["image"],
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
        "image": image,
      };
}

class Testimonial {
  Testimonial({
    this.id,
    this.autherName,
    this.title,
    this.testimonial,
    this.autherImage,
    this.rating,
    this.country,
    this.image,
  });

  String id;
  String autherName;
  String title;
  String testimonial;
  String autherImage;
  String rating;
  String country;
  String image;

  factory Testimonial.fromJson(Map<String, dynamic> json) => Testimonial(
        id: json["id"],
        autherName: json["auther_name"],
        title: json["title"],
        testimonial: json["testimonial"],
        autherImage: json["auther_image"],
        rating: json["rating"],
        country: json["country"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "auther_name": autherName,
        "title": title,
        "testimonial": testimonial,
        "auther_image": autherImage,
        "rating": rating,
        "country": country,
        "image": image,
      };
}
