// To parse this JSON data, do
//
//     final checkRoomAvailability = checkRoomAvailabilityFromJson(jsonString);

import 'dart:convert';

CheckRoomAvailability checkRoomAvailabilityFromJson(String str) =>
    CheckRoomAvailability.fromJson(json.decode(str));

String checkRoomAvailabilityToJson(CheckRoomAvailability data) =>
    json.encode(data.toJson());

class CheckRoomAvailability {
  CheckRoomAvailability({
    this.status,
    this.message,
    this.dateFrom,
    this.dateTo,
    this.nights,
    this.priceDetails,
    this.taxes,
    this.total,
    this.services,
    this.room,
  });

  String status;
  String message;
  DateTime dateFrom;
  DateTime dateTo;
  String nights;
  List<PriceDetail> priceDetails;
  Taxes taxes;
  String total;
  List<Service> services;
  List<Room> room;

  factory CheckRoomAvailability.fromJson(Map<String, dynamic> json) =>
      CheckRoomAvailability(
        status: json["status"],
        message: json["message"],
        dateFrom: DateTime.parse(json["date_from"]),
        dateTo: DateTime.parse(json["date_to"]),
        nights: json["nights"],
        priceDetails: List<PriceDetail>.from(
            json["price_details"].map((x) => PriceDetail.fromJson(x))),
        taxes: Taxes.fromJson(json["taxes"]),
        total: json["total"],
        services: List<Service>.from(
            json["services"].map((x) => Service.fromJson(x))),
        room: List<Room>.from(json["room"].map((x) => Room.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "date_from":
            "${dateFrom.year.toString().padLeft(4, '0')}-${dateFrom.month.toString().padLeft(2, '0')}-${dateFrom.day.toString().padLeft(2, '0')}",
        "date_to":
            "${dateTo.year.toString().padLeft(4, '0')}-${dateTo.month.toString().padLeft(2, '0')}-${dateTo.day.toString().padLeft(2, '0')}",
        "nights": nights,
        "price_details":
            List<dynamic>.from(priceDetails.map((x) => x.toJson())),
        "taxes": taxes.toJson(),
        "total": total,
        "services": List<dynamic>.from(services.map((x) => x.toJson())),
        "room": List<dynamic>.from(room.map((x) => x.toJson())),
      };
}

class PriceDetail {
  PriceDetail({
    this.date,
    this.price,
    this.type,
    this.addPerson,
    this.addPersonPrice,
  });

  DateTime date;
  String price;
  String type;
  String addPerson;
  String addPersonPrice;

  factory PriceDetail.fromJson(Map<String, dynamic> json) => PriceDetail(
        date: DateTime.parse(json["date"]),
        price: json["price"],
        type: json["type"],
        addPerson: json["add_person"],
        addPersonPrice: json["add_person_price"],
      );

  Map<String, dynamic> toJson() => {
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "price": price,
        "type": type,
        "add_person": addPerson,
        "add_person_price": addPersonPrice,
      };
}

class Room {
  Room({
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
  dynamic extraBed;
  String extraBeds;
  String kidsOccupancy;
  String basePrice;
  String additionalPerson;
  String extraBedPrice;

  factory Room.fromJson(Map<String, dynamic> json) => Room(
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

class Service {
  Service({
    this.id,
    this.title,
    this.description,
    this.shortDescription,
    this.priceType,
    this.price,
    this.status,
    this.serviceId,
    this.roomTypeId,
  });

  String id;
  String title;
  String description;
  String shortDescription;
  String priceType;
  String price;
  String status;
  String serviceId;
  String roomTypeId;

  factory Service.fromJson(Map<String, dynamic> json) => Service(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        shortDescription: json["short_description"],
        priceType: json["price_type"],
        price: json["price"],
        status: json["status"],
        serviceId: json["service_id"],
        roomTypeId: json["room_type_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "short_description": shortDescription,
        "price_type": priceType,
        "price": price,
        "status": status,
        "service_id": serviceId,
        "room_type_id": roomTypeId,
      };
}

class Taxes {
  Taxes({
    this.name,
    this.type,
    this.rate,
    this.taxAmount,
  });

  String name;
  String type;
  String rate;
  String taxAmount;

  factory Taxes.fromJson(Map<String, dynamic> json) => Taxes(
        name: json["name"],
        type: json["type"],
        rate: json["rate"],
        taxAmount: json["tax_amount"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "type": type,
        "rate": rate,
        "tax_amount": taxAmount,
      };
}
