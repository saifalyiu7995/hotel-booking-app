// To parse this JSON data, do
//
//     final myBookings = myBookingsFromJson(jsonString);

import 'dart:convert';

MyBookings myBookingsFromJson(String str) =>
    MyBookings.fromJson(json.decode(str));

String myBookingsToJson(MyBookings data) => json.encode(data.toJson());

class MyBookings {
  MyBookings({
    this.status,
    this.bookings,
  });

  String status;
  List<Booking> bookings;

  factory MyBookings.fromJson(Map<String, dynamic> json) => MyBookings(
        status: json["status"],
        bookings: List<Booking>.from(
            json["bookings"].map((x) => Booking.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "bookings": List<dynamic>.from(bookings.map((x) => x.toJson())),
      };
}

class Booking {
  Booking({
    this.id,
    this.orderNo,
    this.txnId,
    this.guestId,
    this.checkIn,
    this.checkOut,
    this.timeFrom,
    this.timeTo,
    this.adults,
    this.kids,
    this.roomTypeId,
    this.hallTypeId,
    this.roomId,
    this.hallId,
    this.orderedOn,
    this.status,
    this.paymentStatus,
    this.paymentGatewayStatus,
    this.paymentGatewayName,
    this.basePrice,
    this.additionalPerson,
    this.additionalPersonAmount,
    this.amount,
    this.taxamount,
    this.paidServiceAmount,
    this.totalamount,
    this.advanceAmount,
    this.nights,
    this.currency,
    this.currencyUnit,
    this.coupon,
    this.couponDiscount,
    this.afterCouponTotalamount,
    this.freePaidServices,
    this.freePaidServicesTitle,
    this.freePaidServicesAmount,
    this.isNew,
    this.checkedout,
    this.isCancelByGuest,
    this.isCancelView,
    this.speedyCheck,
    this.stripeIntent,
    this.firstname,
    this.lastname,
    this.mobile,
    this.roomType,
    this.hallType,
  });

  String id;
  String orderNo;
  dynamic txnId;
  String guestId;
  DateTime checkIn;
  DateTime checkOut;
  dynamic timeFrom;
  dynamic timeTo;
  String adults;
  String kids;
  String roomTypeId;
  String hallTypeId;
  String roomId;
  String hallId;
  DateTime orderedOn;
  String status;
  String paymentStatus;
  dynamic paymentGatewayStatus;
  String paymentGatewayName;
  String basePrice;
  String additionalPerson;
  String additionalPersonAmount;
  String amount;
  String taxamount;
  dynamic paidServiceAmount;
  String totalamount;
  String advanceAmount;
  String nights;
  String currency;
  String currencyUnit;
  dynamic coupon;
  dynamic couponDiscount;
  dynamic afterCouponTotalamount;
  String freePaidServices;
  String freePaidServicesTitle;
  dynamic freePaidServicesAmount;
  String isNew;
  String checkedout;
  String isCancelByGuest;
  String isCancelView;
  String speedyCheck;
  dynamic stripeIntent;
  String firstname;
  String lastname;
  String mobile;
  String roomType;
  dynamic hallType;

  factory Booking.fromJson(Map<String, dynamic> json) => Booking(
        id: json["id"],
        orderNo: json["order_no"],
        txnId: json["txn_id"],
        guestId: json["guest_id"],
        checkIn: DateTime.parse(json["check_in"]),
        checkOut: DateTime.parse(json["check_out"]),
        timeFrom: json["time_from"],
        timeTo: json["time_to"],
        adults: json["adults"],
        kids: json["kids"],
        roomTypeId: json["room_type_id"],
        hallTypeId: json["hall_type_id"],
        roomId: json["room_id"],
        hallId: json["hall_id"],
        orderedOn: DateTime.parse(json["ordered_on"]),
        status: json["status"],
        paymentStatus: json["payment_status"],
        paymentGatewayStatus: json["payment_gateway_status"],
        paymentGatewayName: json["payment_gateway_name"],
        basePrice: json["base_price"],
        additionalPerson: json["additional_person"],
        additionalPersonAmount: json["additional_person_amount"],
        amount: json["amount"],
        taxamount: json["taxamount"],
        paidServiceAmount: json["paid_service_amount"],
        totalamount: json["totalamount"],
        advanceAmount: json["advance_amount"],
        nights: json["nights"],
        currency: json["currency"],
        currencyUnit: json["currency_unit"],
        coupon: json["coupon"],
        couponDiscount: json["coupon_discount"],
        afterCouponTotalamount: json["after_coupon_totalamount"],
        freePaidServices: json["free_paid_services"],
        freePaidServicesTitle: json["free_paid_services_title"],
        freePaidServicesAmount: json["free_paid_services_amount"],
        isNew: json["is_new"],
        checkedout: json["checkedout"],
        isCancelByGuest: json["is_cancel_by_guest"],
        isCancelView: json["is_cancel_view"],
        speedyCheck: json["speedy_check"],
        stripeIntent: json["stripe_intent"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        mobile: json["mobile"],
        roomType: json["room_type"],
        hallType: json["hall_type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "order_no": orderNo,
        "txn_id": txnId,
        "guest_id": guestId,
        "check_in":
            "${checkIn.year.toString().padLeft(4, '0')}-${checkIn.month.toString().padLeft(2, '0')}-${checkIn.day.toString().padLeft(2, '0')}",
        "check_out":
            "${checkOut.year.toString().padLeft(4, '0')}-${checkOut.month.toString().padLeft(2, '0')}-${checkOut.day.toString().padLeft(2, '0')}",
        "time_from": timeFrom,
        "time_to": timeTo,
        "adults": adults,
        "kids": kids,
        "room_type_id": roomTypeId,
        "hall_type_id": hallTypeId,
        "room_id": roomId,
        "hall_id": hallId,
        "ordered_on": orderedOn.toIso8601String(),
        "status": status,
        "payment_status": paymentStatus,
        "payment_gateway_status": paymentGatewayStatus,
        "payment_gateway_name": paymentGatewayName,
        "base_price": basePrice,
        "additional_person": additionalPerson,
        "additional_person_amount": additionalPersonAmount,
        "amount": amount,
        "taxamount": taxamount,
        "paid_service_amount": paidServiceAmount,
        "totalamount": totalamount,
        "advance_amount": advanceAmount,
        "nights": nights,
        "currency": currency,
        "currency_unit": currencyUnit,
        "coupon": coupon,
        "coupon_discount": couponDiscount,
        "after_coupon_totalamount": afterCouponTotalamount,
        "free_paid_services": freePaidServices,
        "free_paid_services_title": freePaidServicesTitle,
        "free_paid_services_amount": freePaidServicesAmount,
        "is_new": isNew,
        "checkedout": checkedout,
        "is_cancel_by_guest": isCancelByGuest,
        "is_cancel_view": isCancelView,
        "speedy_check": speedyCheck,
        "stripe_intent": stripeIntent,
        "firstname": firstname,
        "lastname": lastname,
        "mobile": mobile,
        "room_type": roomType,
        "hall_type": hallType,
      };
}
