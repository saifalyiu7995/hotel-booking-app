// To parse this JSON data, do
//
//     final myPayments = myPaymentsFromJson(jsonString);

import 'dart:convert';

MyPayments myPaymentsFromJson(String str) =>
    MyPayments.fromJson(json.decode(str));

String myPaymentsToJson(MyPayments data) => json.encode(data.toJson());

class MyPayments {
  MyPayments({
    this.status,
    this.payments,
  });

  String status;
  List<Payment> payments;

  factory MyPayments.fromJson(Map<String, dynamic> json) => MyPayments(
        status: json["status"],
        payments: List<Payment>.from(
            json["payments"].map((x) => Payment.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "payments": List<dynamic>.from(payments.map((x) => x.toJson())),
      };
}

class Payment {
  Payment({
    this.id,
    this.orderId,
    this.dateTime,
    this.amount,
    this.invoice,
    this.isMainAmount,
    this.paymentMethod,
    this.addedDate,
    this.firstname,
    this.lastname,
    this.guestAddress,
    this.guestPhone,
    this.guestEmail,
    this.guestCountry,
    this.guestState,
    this.guestCity,
    this.cs,
  });

  String id;
  String orderId;
  DateTime dateTime;
  String amount;
  String invoice;
  String isMainAmount;
  String paymentMethod;
  DateTime addedDate;
  String firstname;
  String lastname;
  String guestAddress;
  String guestPhone;
  String guestEmail;
  dynamic guestCountry;
  dynamic guestState;
  dynamic guestCity;
  String cs;

  factory Payment.fromJson(Map<String, dynamic> json) => Payment(
        id: json["id"],
        orderId: json["order_id"],
        dateTime: DateTime.parse(json["date_time"]),
        amount: json["amount"],
        invoice: json["invoice"],
        isMainAmount: json["is_main_amount"],
        paymentMethod: json["payment_method"],
        addedDate: DateTime.parse(json["added_date"]),
        firstname: json["firstname"],
        lastname: json["lastname"],
        guestAddress: json["guest_address"],
        guestPhone: json["guest_phone"],
        guestEmail: json["guest_email"],
        guestCountry: json["guest_country"],
        guestState: json["guest_state"],
        guestCity: json["guest_city"],
        cs: json["cs"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "order_id": orderId,
        "date_time": dateTime.toIso8601String(),
        "amount": amount,
        "invoice": invoice,
        "is_main_amount": isMainAmount,
        "payment_method": paymentMethod,
        "added_date":
            "${addedDate.year.toString().padLeft(4, '0')}-${addedDate.month.toString().padLeft(2, '0')}-${addedDate.day.toString().padLeft(2, '0')}",
        "firstname": firstname,
        "lastname": lastname,
        "guest_address": guestAddress,
        "guest_phone": guestPhone,
        "guest_email": guestEmail,
        "guest_country": guestCountry,
        "guest_state": guestState,
        "guest_city": guestCity,
        "cs": cs,
      };
}
