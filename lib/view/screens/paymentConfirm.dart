import 'package:flutter/material.dart';
import 'package:hotel_booking_app/common.dart';
import 'package:hotel_booking_app/services/web_service.dart';
import 'package:hotel_booking_app/view/screens/done.dart';
import 'package:hotel_booking_app/view/widgets/background.dart';
import 'package:hotel_booking_app/view/widgets/roundedButton.dart';
import 'package:hotel_booking_app/view/widgets/roundedTextfield.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:stripe_payment/stripe_payment.dart';
import 'package:flutter_session/flutter_session.dart';

class PaymentConfirmScreen extends StatefulWidget {
  String total,
      discription,
      kids,
      adults,
      dateTo,
      dateFrom,
      roomType,
      timeTo,
      timeFrom;
  List<String> paidServices;
  bool hall, speedy;

  PaymentConfirmScreen(
      {this.total,
      this.discription,
      this.adults,
      this.kids,
      this.dateFrom,
      this.dateTo,
      this.roomType,
      this.timeTo,
      this.timeFrom,
      this.hall,
      this.speedy,
      this.paidServices});
  @override
  _PaymentConfirmScreenState createState() => _PaymentConfirmScreenState();
}

class _PaymentConfirmScreenState extends State<PaymentConfirmScreen> {
  bool fullpay, partpay, paypal, stripe, payonarrive = false;
  String paymentGateway, paymentCheck;
  String userid;

  @override
  void initState() {
    super.initState();

    getUserId();
    getPaymentKey().then((value) {
      print(value.stripeApiKey);
      StripePayment.setOptions(StripeOptions(
          publishableKey: "pk_test_AT0x9neMvnVTOZkCz6x3dOBk",
          merchantId: "Test",
          androidPayMode: 'test'));
    });
  }

  getUserId() {
    FlutterSession().get("id").then((value) {
      setState(() {
        userid = value.toString();
        print(userid);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
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

    return Scaffold(
      body: SafeArea(
        child: Background(
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: <
              Widget>[
            SizedBox(
              height: 15,
            ),
            Text(
              "Payment",
              style: TextStyle(
                  fontFamily: "SFproBold",
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: size.height * 0.06,
            ),
            // Image.asset(
            //   "assets/images/payment.png",
            //   height: size.height * 0.25,
            // ),
            Padding(
              padding: const EdgeInsets.only(left: 19.0, right: 19, top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total",
                    style: TextStyle(
                        fontFamily: "SFproBold",
                        color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "\$" + widget.total ?? "\$112",
                    style: TextStyle(
                        fontFamily: "SFproBold",
                        color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(15),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xff7E57C2).withOpacity(0.2),
                      blurRadius: 10,
                      offset: Offset(0, 0),
                    ),
                  ]),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      "Details",
                      style: TextStyle(
                          fontFamily: "SFproBold",
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Text(
                      widget.discription ??
                          "Quad 1 Nights Booking From 20/01/2021 to 21/01/2021",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: "SFproBold",
                          fontStyle: FontStyle.italic,
                          color: Colors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),

            Container(
              margin: EdgeInsets.all(15),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xff7E57C2).withOpacity(0.2),
                      blurRadius: 10,
                      offset: Offset(0, 0),
                    ),
                  ]),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      "Payment Type",
                      style: TextStyle(
                          fontFamily: "SFproBold",
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Full Payment",
                              style: TextStyle(fontSize: 16),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  fullpay = true;
                                  partpay = false;
                                  paymentCheck = "full";
                                });
                              },
                              child: fullpay == true
                                  ? Image(
                                      height: size.height * 0.03,
                                      image: AssetImage(
                                          "assets/images/Checkbox.png"),
                                    )
                                  : Image(
                                      height: size.height * 0.03,
                                      image: AssetImage("assets/images/un.png"),
                                    ),
                            ),
                          ],
                        ),
                        widget.speedy == true
                            ? SizedBox()
                            : Row(
                                children: [
                                  Text(
                                    "Partial Payment",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        fullpay = false;
                                        partpay = true;
                                        paymentCheck = "part";
                                      });
                                    },
                                    child: partpay == true
                                        ? Image(
                                            height: size.height * 0.03,
                                            image: AssetImage(
                                                "assets/images/Checkbox.png"),
                                          )
                                        : Image(
                                            height: size.height * 0.03,
                                            image: AssetImage(
                                                "assets/images/un.png"),
                                          ),
                                  ),
                                ],
                              ),
                      ],
                    )
                  ],
                ),
              ),
            ),

            Container(
              margin: EdgeInsets.all(15),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xff7E57C2).withOpacity(0.2),
                      blurRadius: 10,
                      offset: Offset(0, 0),
                    ),
                  ]),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      "Payment Method",
                      style: TextStyle(
                          fontFamily: "SFproBold",
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        // widget.speedy == true
                        //     ? SizedBox()
                        //     : Row(
                        //         children: [
                        //           Text(
                        //             "PayPal",
                        //             style: TextStyle(fontSize: 16),
                        //           ),
                        //           InkWell(
                        //             onTap: () {
                        //               setState(() {
                        //                 stripe = false;
                        //                 payonarrive = false;
                        //                 paypal = true;
                        //                 paymentGateway = "1";
                        //               });
                        //             },
                        //             child: paypal == true
                        //                 ? Image(
                        //                     height: size.height * 0.03,
                        //                     image: AssetImage(
                        //                         "assets/images/Checkbox.png"),
                        //                   )
                        //                 : Image(
                        //                     height: size.height * 0.03,
                        //                     image: AssetImage(
                        //                         "assets/images/un.png"),
                        //                   ),
                        //           ),
                        //         ],
                        //       ),
                        Row(
                          children: [
                            Text(
                              "Stripe",
                              style: TextStyle(fontSize: 16),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  stripe = true;
                                  payonarrive = false;
                                  paypal = false;
                                  paymentGateway = "2";
                                  print(stripe);
                                });
                              },
                              child: stripe == true
                                  ? Image(
                                      height: size.height * 0.03,
                                      image: AssetImage(
                                          "assets/images/Checkbox.png"),
                                    )
                                  : Image(
                                      height: size.height * 0.03,
                                      image: AssetImage("assets/images/un.png"),
                                    ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "Pay On Arrive",
                              style: TextStyle(fontSize: 16),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  stripe = false;
                                  payonarrive = true;
                                  paypal = false;
                                  paymentGateway = "3";
                                });
                              },
                              child: payonarrive == true
                                  ? Image(
                                      height: size.height * 0.03,
                                      image: AssetImage(
                                          "assets/images/Checkbox.png"),
                                    )
                                  : Image(
                                      height: size.height * 0.03,
                                      image: AssetImage("assets/images/un.png"),
                                    ),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            // RoundedTextField(
            //   hintText: "Coupon",
            //   iconData: Icons.receipt,
            //   hintcolor: Colors.black87,
            //   iconcolor: Color(0xff7E57C2),
            //   password: false,
            //   tType: TextInputType.datetime,
            // ),
            SizedBox(
              height: size.height * 0.06,
            ),
            RoundedButton(
              text: "Continue",
              press: () {
                pr.show();
                print(paymentGateway);
                print(widget.dateFrom.toString() + " " + widget.roomType);
                print(userid);
                stripe == true
                    ? StripePayment.paymentRequestWithCardForm(
                            CardFormPaymentRequest())
                        .then((paymentData) {
                        pr.hide();
                        // print(paymentData.id);
                        // print(paymentData.customerId);
                        // print(paymentData.type);
                        // print(paymentData.billingDetails.email);

                        // print(widget.adults + "adulllllllttttttttttttt");
                        // print(widget.kids + "kiiiiiiddddddddssssssssss");
                        // print(widget.dateFrom + "dateeeeeee frrrrrooooommm");
                        // print(widget.dateTo + "daattttteeeee toooooooooooo");
                        // print(widget.roomType + "roooooommmm tyyyyppppeeeee");
                        // print(userid + " iiiiiidddddddddddd");
                        widget.hall == true
                            ? stripepayhall(
                                    pm: paymentData.id,
                                    adults: "1",
                                    kids: "1",
                                    paidServices: [],
                                    datefrom: widget.dateTo,
                                    dateto: widget.dateTo,
                                    adv: "0",
                                    coupon: "",
                                    roomTytpe: widget.roomType,
                                    paymentype: paymentCheck,
                                    paymentGateway: paymentGateway,
                                    timefrom: widget.timeFrom,
                                    timeto: widget.timeTo,
                                    guestId: userid,
                                    keyless: "1",
                                    selectedRoom: CommonUsed.floorNo)
                                .then((value) {
                                print(value.status);
                                if (value.stripeStatus == "success") {
                                  print(value.status);
                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                          builder: (context) => DoneScreen()),
                                      (Route<dynamic> route) => false);
                                } else {
                                  CommonUsed.showFloatingFlushbar(
                                      context,
                                      value.message ?? "Something went wrong!",
                                      [
                                        Colors.red.shade900,
                                        Colors.redAccent.shade400
                                      ]);
                                }
                              })
                            : stripepay(
                                pm: paymentData.id,
                                adults: widget.adults,
                                kids: widget.kids,
                                adv: "0",
                                coupon: "",
                                datefrom: widget.dateFrom,
                                dateto: widget.dateTo,
                                paidServices: CommonUsed.paidServices,
                                paymentGateway: paymentGateway,
                                paymentype: paymentCheck ?? "2",
                                roomTytpe: widget.roomType,
                                guestId: userid,
                                keyless: "1",
                                selectedRoom: "1",
                              ).then((value) {
                                print(value.status);
                                if (value.stripeStatus == "success") {
                                  print(value.status);
                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                          builder: (context) => DoneScreen()),
                                      (Route<dynamic> route) => false);
                                } else {
                                  CommonUsed.showFloatingFlushbar(
                                      context,
                                      value.message ?? "Something went wrong!",
                                      [
                                        Colors.red.shade900,
                                        Colors.redAccent.shade400
                                      ]);
                                }
                              });
                      })
                    : payonarrive == true
                        ? widget.hall == true
                            ? payOnArrivalHall(
                                    adults: widget.adults,
                                    kids: widget.kids,
                                    date: widget.dateTo,
                                    adv: "0",
                                    coupon: "",
                                    roomTytpe: widget.roomType,
                                    paymentype: paymentCheck,
                                    paymentGateway: paymentGateway,
                                    timefrom: widget.timeFrom,
                                    timeto: widget.timeTo,
                                    guestId: userid)
                                .then((value) {
                                pr.hide();
                                print(value.orderNo);
                                print(value.status);
                                if (value.status == "success") {
                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                          builder: (context) => DoneScreen()),
                                      (Route<dynamic> route) => false);
                                }
                              })
                            : payOnArrival(
                                    adults: widget.adults,
                                    kids: widget.kids,
                                    datefrom: widget.dateFrom,
                                    dateto: widget.dateTo,
                                    adv: "0",
                                    coupon: "",
                                    roomTytpe: widget.roomType,
                                    paymentype: paymentCheck,
                                    paymentGateway: paymentGateway,
                                    paidServices: widget.paidServices,
                                    guestId: userid)
                                .then((value) {
                                pr.hide();
                                print(value.orderNo);
                                print(value.status);
                                if (value.status == "success") {
                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                          builder: (context) => DoneScreen()),
                                      (Route<dynamic> route) => false);
                                }
                              })
                        : Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => DoneScreen()),
                            (Route<dynamic> route) => false);
              },
              textColor: Colors.white,
              color: Color(0xff7E57C2),
            ),
          ]),
        ),
      ),
    );
  }
}
