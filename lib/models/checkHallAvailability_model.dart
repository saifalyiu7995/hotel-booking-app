// To parse this JSON data, do
//
//     final checkHallAvailability = checkHallAvailabilityFromJson(jsonString);

import 'dart:convert';

CheckHallAvailability checkHallAvailabilityFromJson(String str) =>
    CheckHallAvailability.fromJson(json.decode(str));

String checkHallAvailabilityToJson(CheckHallAvailability data) =>
    json.encode(data.toJson());

class CheckHallAvailability {
  CheckHallAvailability({
    this.status,
    this.message,
    this.dateFrom,
    this.dateTo,
    this.hallType,
    this.totalHours,
    this.priceDetails,
    this.taxes,
    this.total,
    this.hall,
  });

  String status;
  String message;
  DateTime dateFrom;
  DateTime dateTo;
  String hallType;
  String totalHours;
  List<PriceDetail> priceDetails;
  Taxes taxes;
  String total;
  String hall;

  factory CheckHallAvailability.fromJson(Map<String, dynamic> json) =>
      CheckHallAvailability(
        status: json["status"],
        message: json["message"],
        dateFrom: DateTime.parse(json["date_from"]),
        dateTo: DateTime.parse(json["date_to"]),
        hallType: json["hall_type"],
        totalHours: json["total_hours"],
        priceDetails: List<PriceDetail>.from(
            json["price_details"].map((x) => PriceDetail.fromJson(x))),
        taxes: Taxes.fromJson(json["taxes"]),
        total: json["total"],
        hall: json["hall"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "date_from":
            "${dateFrom.year.toString().padLeft(4, '0')}-${dateFrom.month.toString().padLeft(2, '0')}-${dateFrom.day.toString().padLeft(2, '0')}",
        "date_to":
            "${dateTo.year.toString().padLeft(4, '0')}-${dateTo.month.toString().padLeft(2, '0')}-${dateTo.day.toString().padLeft(2, '0')}",
        "hall_type": hallType,
        "total_hours": totalHours,
        "price_details":
            List<dynamic>.from(priceDetails.map((x) => x.toJson())),
        "taxes": taxes.toJson(),
        "total": total,
        "hall": hall,
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
