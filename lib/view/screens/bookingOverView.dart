import 'package:hotel_booking_app/services/web_service.dart';
import 'package:hotel_booking_app/view/screens/paymentConfirm.dart';
import 'package:hotel_booking_app/view/screens/personalInfo.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:flutter/material.dart';
import 'package:hotel_booking_app/common.dart';
import 'package:hotel_booking_app/models/checkAvailability_model.dart';
import 'package:hotel_booking_app/view/widgets/roundedButton.dart';

class BookingOverViewScreen extends StatefulWidget {
  final CheckRoomAvailability checkRoomAvailability;
  final String kids, adults, roomType;
  bool speedyBook;
  BookingOverViewScreen(
      {this.checkRoomAvailability,
      this.adults,
      this.kids,
      this.roomType,
      this.speedyBook});

  @override
  _BookingOverViewScreenState createState() => _BookingOverViewScreenState();
}

class _BookingOverViewScreenState extends State<BookingOverViewScreen> {
  bool check = false;
  int i;

  List<bool> checkPosition;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    checkPosition = List<bool>(widget.checkRoomAvailability.services.length);
    for (var i = 0; i < checkPosition.length; i++) {
      checkPosition[i] = false;
    }
    print(widget.checkRoomAvailability.services.length);
  }

  @override
  Widget build(BuildContext context) {
    ProgressDialog pr = ProgressDialog(context);
    pr = ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: true, showLogs: true);
    pr.style(
        message: 'Processing...',
        borderRadius: 10.0,
        backgroundColor: Colors.white,
        progressWidget: Center(child: CircularProgressIndicator()),
        elevation: 10.0,
        insetAnimCurve: Curves.easeInOut,
        progress: 0.0,
        maxProgress: 100.0,
        progressTextStyle: TextStyle(
            color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
        messageTextStyle: TextStyle(
            color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600));

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
                padding: const EdgeInsets.only(left: 19.0, right: 19),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total:",
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: "SFproBold",
                          fontSize: 22),
                    ),
                    Text(
                      (int.parse(widget.checkRoomAvailability.total) +
                                  CommonUsed.paidprice)
                              .toString() ??
                          "",
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: "SFproBold",
                          fontSize: 22),
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
                            "Adults",
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: "SFproBold",
                                fontSize: 16),
                          ),
                          Text(
                            widget.adults ?? "0",
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
                            "Kids",
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: "SFproBold",
                                fontSize: 16),
                          ),
                          Text(
                            widget.kids ?? "0",
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
                            "Nights",
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: "SFproBold",
                                fontSize: 16),
                          ),
                          Text(
                            widget.checkRoomAvailability.nights.toString() ??
                                "2",
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
                            (widget.checkRoomAvailability.taxes.rate ?? "0") +
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
                            widget.checkRoomAvailability.taxes.taxAmount
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
                "Price Per Night",
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
                  children: widget.checkRoomAvailability.priceDetails
                      .map((e) => Column(
                            children: [
                              widget.checkRoomAvailability.priceDetails
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
              widget.checkRoomAvailability.services.length > 0
                  ? Text(
                      "Paid Services",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          fontFamily: "SFproBold"),
                    )
                  : SizedBox(
                      height: screenSize.height * 0.01,
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
                  children: widget.checkRoomAvailability.services
                      .map((e) => Column(
                            children: [
                              widget.checkRoomAvailability.services.indexOf(e) >
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
                                    Container(
                                      width: screenSize.width * 0.3,
                                      child: Text(
                                        e.title ?? "",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: "SFproBold",
                                            fontSize: 16),
                                      ),
                                    ),
                                    Container(
                                      width: screenSize.width * 0.2,
                                      child: Text(
                                        "\$" + e.price,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: "SFproBold",
                                            fontSize: 16),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          checkPosition[
                                              widget.checkRoomAvailability
                                                  .services
                                                  .indexOf(e)] = !checkPosition[
                                              widget.checkRoomAvailability
                                                  .services
                                                  .indexOf(e)];

                                          if (checkPosition[widget
                                                  .checkRoomAvailability
                                                  .services
                                                  .indexOf(e)] ==
                                              true) {
                                            CommonUsed.paidServices.add(widget
                                                .checkRoomAvailability
                                                .services[widget
                                                    .checkRoomAvailability
                                                    .services
                                                    .indexOf(e)]
                                                .id);
                                            // CommonUsed.paidprice += int.parse(
                                            //     widget
                                            //         .checkRoomAvailability
                                            //         .services[widget
                                            //             .checkRoomAvailability
                                            //             .services
                                            //             .indexOf(e)]
                                            //         .price);
                                          } else {
                                            CommonUsed.paidServices.remove(
                                                widget
                                                    .checkRoomAvailability
                                                    .services[widget
                                                        .checkRoomAvailability
                                                        .services
                                                        .indexOf(e)]
                                                    .id);
                                          }

                                          print(CommonUsed.paidServices);
                                        });
                                      },
                                      child: checkPosition[widget
                                              .checkRoomAvailability.services
                                              .indexOf(e)]
                                          ? Image(
                                              height: screenSize.height * 0.03,
                                              image: AssetImage(
                                                  "assets/images/Checkbox.png"),
                                            )
                                          : Image(
                                              height: screenSize.height * 0.03,
                                              image: AssetImage(
                                                  "assets/images/un.png"),
                                            ),
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
                  pr.show();
                  widget.speedyBook == false
                      ? bookingRoomA(
                              adults: widget.adults,
                              kids: widget.kids,
                              datefrom: widget.checkRoomAvailability.dateFrom
                                  .toString()
                                  .substring(0, 10),
                              dateto: widget.checkRoomAvailability.dateTo
                                  .toString()
                                  .substring(0, 10),
                              roomTytpe: widget.roomType,
                              paidServices: CommonUsed.paidServices)
                          .then((value) {
                          pr.hide();
                          print(value.totalamount);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PaymentConfirmScreen(
                                    discription: value.details,
                                    total: value.totalamount,
                                    adults: widget.adults,
                                    kids: widget.kids,
                                    dateFrom: widget
                                        .checkRoomAvailability.dateFrom
                                        .toString()
                                        .substring(0, 10),
                                    dateTo: widget.checkRoomAvailability.dateTo
                                        .toString()
                                        .substring(0, 10),
                                    roomType: widget.roomType,
                                    paidServices: CommonUsed.paidServices),
                              ));
                        })
                      : bookingRoomA(
                              adults: widget.adults,
                              kids: widget.kids,
                              datefrom: widget.checkRoomAvailability.dateFrom
                                  .toString()
                                  .substring(0, 10),
                              dateto: widget.checkRoomAvailability.dateTo
                                  .toString()
                                  .substring(0, 10),
                              roomTytpe: widget.roomType,
                              paidServices: CommonUsed.paidServices)
                          .then((value) {
                          pr.hide();
                          print(value.totalamount);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PersonalInfo(
                                    discription: value.details,
                                    total: value.totalamount,
                                    adults: widget.adults,
                                    kids: widget.kids,
                                    dateFrom: widget
                                        .checkRoomAvailability.dateFrom
                                        .toString()
                                        .substring(0, 10),
                                    dateTo: widget.checkRoomAvailability.dateTo
                                        .toString()
                                        .substring(0, 10),
                                    roomType: widget.roomType,
                                    paidServices: CommonUsed.paidServices),
                              ));
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
