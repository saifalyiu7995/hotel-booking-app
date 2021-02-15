import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  String order_id,
      guest_id,
      guest_name,
      room_type,
      kids,
      adults,
      nights,
      checkin,
      checkout;
  DetailScreen(
      {this.adults,
      this.checkin,
      this.checkout,
      this.guest_id,
      this.guest_name,
      this.kids,
      this.nights,
      this.order_id,
      this.room_type});
  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total Amount:",
                    style: TextStyle(
                        color: Color(0xff7E57C2),
                        fontSize: 22,
                        fontFamily: "SFproBold"),
                  ),
                  Text(
                    "\$14230.00",
                    style: TextStyle(
                        color: Color(0xff262F56),
                        fontSize: 22,
                        fontFamily: "SFproBold"),
                  ),
                ],
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                            color: Color(0xffBECDE2),
                            offset: Offset(6, 6),
                            blurRadius: 16),
                        BoxShadow(
                            color: Color(0xffF4F4F4).withOpacity(.2),
                            offset: Offset(-6, -6),
                            blurRadius: 16),
                      ]),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Order ID:",
                              style: TextStyle(
                                  color: Colors.deepPurple,
                                  fontFamily: "SFproBold",
                                  fontSize: 18),
                            ),
                            Text(
                              widget.order_id ?? "",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: "SFproBold",
                                  fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: screenSize.width * 0.9,
                        height: 1,
                        child: Container(
                          color: Colors.black,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Guest ID:",
                              style: TextStyle(
                                  color: Colors.deepPurple,
                                  fontFamily: "SFproBold",
                                  fontSize: 18),
                            ),
                            Text(
                              widget.guest_id ?? "",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: "SFproBold",
                                  fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: screenSize.width * 0.9,
                        height: 1,
                        child: Container(
                          color: Colors.black,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Guest Name:",
                              style: TextStyle(
                                  color: Colors.deepPurple,
                                  fontFamily: "SFproBold",
                                  fontSize: 18),
                            ),
                            Text(
                              widget.guest_name ?? "",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: "SFproBold",
                                  fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: screenSize.width * 0.9,
                        height: 1,
                        child: Container(
                          color: Colors.black,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Type:",
                              style: TextStyle(
                                  color: Colors.deepPurple,
                                  fontFamily: "SFproBold",
                                  fontSize: 18),
                            ),
                            Text(
                              widget.room_type ?? "",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: "SFproBold",
                                  fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: screenSize.width * 0.9,
                        height: 1,
                        child: Container(
                          color: Colors.black,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Kids:",
                              style: TextStyle(
                                  color: Colors.deepPurple,
                                  fontFamily: "SFproBold",
                                  fontSize: 18),
                            ),
                            Text(
                              widget.kids ?? "",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: "SFproBold",
                                  fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: screenSize.width * 0.9,
                        height: 1,
                        child: Container(
                          color: Colors.black,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Adults:",
                              style: TextStyle(
                                  color: Colors.deepPurple,
                                  fontFamily: "SFproBold",
                                  fontSize: 18),
                            ),
                            Text(
                              widget.adults ?? "",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: "SFproBold",
                                  fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: screenSize.width * 0.9,
                        height: 1,
                        child: Container(
                          color: Colors.black,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Nights:",
                              style: TextStyle(
                                  color: Colors.deepPurple,
                                  fontFamily: "SFproBold",
                                  fontSize: 18),
                            ),
                            Text(
                              widget.nights ?? "",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: "SFproBold",
                                  fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: screenSize.width * 0.9,
                        height: 1,
                        child: Container(
                          color: Colors.black,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Check-in:",
                              style: TextStyle(
                                  color: Colors.deepPurple,
                                  fontFamily: "SFproBold",
                                  fontSize: 18),
                            ),
                            Text(
                              widget.checkin ?? "",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: "SFproBold",
                                  fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: screenSize.width * 0.9,
                        height: 1,
                        child: Container(
                          color: Colors.black,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Check-out:",
                              style: TextStyle(
                                  color: Colors.deepPurple,
                                  fontFamily: "SFproBold",
                                  fontSize: 18),
                            ),
                            Text(
                              widget.checkout ?? "",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: "SFproBold",
                                  fontSize: 18),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
