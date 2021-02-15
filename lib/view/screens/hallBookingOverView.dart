import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hotel_booking_app/models/checkAvailability_model.dart';
import 'package:hotel_booking_app/models/checkHallAvailability_model.dart';
import 'package:hotel_booking_app/services/web_service.dart';
import 'package:hotel_booking_app/view/screens/paymentConfirm.dart';
import 'package:hotel_booking_app/view/screens/personalInfo.dart';
import 'package:hotel_booking_app/view/widgets/roundedButton.dart';

class HallBookingOverViewScreen extends StatefulWidget {
  final CheckHallAvailability checkHallAvailability;
  final String roomType, date, fromTime, toTime;
  bool speedyBook;
  HallBookingOverViewScreen(
      {this.checkHallAvailability,
      this.roomType,
      this.date,
      this.fromTime,
      this.toTime,
      this.speedyBook});

  @override
  _HallBookingOverViewScreenState createState() =>
      _HallBookingOverViewScreenState();
}

class _HallBookingOverViewScreenState extends State<HallBookingOverViewScreen> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: screenSize.height * 0.01,
              ),
              Text(
                "Booking Overview",
                style: TextStyle(
                  fontFamily: "SFproBold",
                  color: Colors.black,
                  fontSize: 23,
                ),
              ),
              SizedBox(
                height: screenSize.height * 0.02,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 22.0, right: 22, bottom: 8, top: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total:",
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: "SFproBold",
                          fontSize: 26),
                    ),
                    Text(
                      "\$" + widget.checkHallAvailability.total.toString() ??
                          "2",
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: "SFproBold",
                          fontSize: 26),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.all(15),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xff7E57C2).withOpacity(0.5),
                        blurRadius: 20,
                        offset: Offset(0, 0),
                      ),
                    ]),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 12.0, right: 12, bottom: 8, top: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Hours",
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: "SFproBold",
                                fontSize: 16),
                          ),
                          Text(
                            widget.checkHallAvailability.totalHours
                                        .toString() ==
                                    ""
                                ? "n/a"
                                : widget.checkHallAvailability.totalHours
                                    .toString(),
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: "SFproBold",
                                fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 1,
                      width: screenSize.width * 0.9,
                      child: Container(
                        color: Colors.grey.shade400,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 12.0, right: 12, bottom: 8, top: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Tax",
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: "SFproBold",
                                fontSize: 16),
                          ),
                          Text(
                            (widget.checkHallAvailability.taxes.rate ?? "0") +
                                "%",
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: "SFproBold",
                                fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 1,
                      width: screenSize.width * 0.9,
                      child: Container(
                        color: Colors.grey.shade400,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 12.0, right: 12, bottom: 8, top: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Tax Amount",
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: "SFproBold",
                                fontSize: 16),
                          ),
                          Text(
                            widget.checkHallAvailability.taxes.taxAmount
                                .toString(),
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: "SFproBold",
                                fontSize: 16),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Text(
                "Price Per Hour",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    fontFamily: "SFproBold"),
              ),
              Container(
                margin: EdgeInsets.all(15),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xff7E57C2).withOpacity(0.5),
                        blurRadius: 20,
                        offset: Offset(0, 0),
                      ),
                    ]),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: widget.checkHallAvailability.priceDetails
                      .map((e) => Column(
                            children: [
                              widget.checkHallAvailability.priceDetails
                                          .indexOf(e) >
                                      0
                                  ? SizedBox(
                                      height: 1,
                                      width: screenSize.width * 0.9,
                                      child: Container(
                                        color: Colors.grey.shade400,
                                      ),
                                    )
                                  : SizedBox(),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 12.0, right: 12, bottom: 8, top: 4),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      e.date.toString().substring(0, 10),
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: "SFproBold",
                                          fontSize: 16),
                                    ),
                                    Text(
                                      e.price ?? "",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: "SFproBold",
                                          fontSize: 16),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ))
                      .toList(),
                ),
              ),
              RoundedButton(
                text: "Continue",
                press: () {
                  print(widget.date);
                  widget.speedyBook == false
                      ? bookingHallA(
                              adults: "",
                              kids: "",
                              date: widget.date,
                              hallTytpe: widget.roomType,
                              timeFrom: widget.fromTime,
                              timeTo: widget.toTime)
                          .then((value) {
                          print(value.status);
                          if (value.status == "success") {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PaymentConfirmScreen(
                                      discription: value.details,
                                      total: value.totalamount,
                                      adults: "",
                                      kids: "",
                                      dateFrom: widget.date,
                                      dateTo: widget.date,
                                      timeTo: widget.toTime,
                                      hall: true,
                                      timeFrom: widget.fromTime,
                                      roomType: widget.roomType,
                                      paidServices: [""]),
                                ));
                          }
                        })
                      : bookingHallA(
                              adults: "",
                              kids: "",
                              date: widget.date,
                              hallTytpe: widget.roomType,
                              timeFrom: widget.fromTime,
                              timeTo: widget.toTime)
                          .then((value) {
                          print(value.status);
                          if (value.status == "success") {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PersonalInfo(
                                      discription: value.details,
                                      total: value.totalamount,
                                      adults: "",
                                      kids: "",
                                      dateFrom: widget.date,
                                      dateTo: widget.date,
                                      timeTo: widget.toTime,
                                      hall: true,
                                      timeFrom: widget.fromTime,
                                      roomType: widget.roomType,
                                      paidServices: [""]),
                                ));
                          }
                        });
                },
                textColor: Colors.white,
                color: Color(0xff7E57C2),
              )
            ],
          ),
        ),
      ),
    );
  }
}
