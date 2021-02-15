import 'package:flutter/material.dart';
import 'package:hotel_booking_app/models/myBokking_model.dart';
import 'package:hotel_booking_app/services/web_service.dart';
import 'package:hotel_booking_app/view/screens/detailPayment.dart';
import 'package:hotel_booking_app/view/widgets/listItem.dart';
import 'package:flutter_session/flutter_session.dart';

class MyBookingsScreen extends StatefulWidget {
  @override
  _MyBookingsScreenState createState() => _MyBookingsScreenState();
}

class _MyBookingsScreenState extends State<MyBookingsScreen> {
  String userid;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserId();
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
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xffFFFFFF),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "My Bookings",
              style: TextStyle(
                  color: Color(0xff7E57C2),
                  fontFamily: "SFproBold",
                  fontSize: 22),
            ),
            SizedBox(
              height: screenSize.height * 0.01,
            ),
            SingleChildScrollView(
              child: Container(
                height: screenSize.height * 0.88,
                width: screenSize.width,
                child: FutureBuilder<MyBookings>(
                  future: getMyBookings(id: userid.toString() ?? "1"),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data.status == "success") {
                        return ListView.builder(
                          itemCount: snapshot.data.bookings.length,
                          itemBuilder: (context, index) => InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailScreen(
                                      adults:
                                          snapshot.data.bookings[index].adults,
                                      checkin: snapshot
                                          .data.bookings[index].checkIn
                                          .toString()
                                          .substring(0, 11),
                                      checkout: snapshot
                                          .data.bookings[index].checkOut
                                          .toString()
                                          .substring(0, 11),
                                      guest_id:
                                          snapshot.data.bookings[index].guestId,
                                      guest_name: snapshot
                                          .data.bookings[index].firstname,
                                      kids: snapshot.data.bookings[index].kids,
                                      nights:
                                          snapshot.data.bookings[index].nights,
                                      order_id:
                                          snapshot.data.bookings[index].orderNo,
                                      room_type: snapshot
                                              .data.bookings[index].roomType ??
                                          snapshot
                                              .data.bookings[index].hallType,
                                    ),
                                  ));
                            },
                            child: Container(
                              margin: EdgeInsets.only(
                                  top: 10, left: 15, bottom: 10, right: 15),
                              child: ListItemWidget(
                                screenSize: screenSize,
                                orderNo: snapshot.data.bookings[index].orderNo,
                                bookingOn: snapshot
                                    .data.bookings[index].orderedOn
                                    .toString(),
                                roomType:
                                    snapshot.data.bookings[index].roomType ??
                                        snapshot.data.bookings[index].hallType,
                              ),
                            ),
                          ),
                        );
                      } else {
                        return Center(
                            child: Text(
                          "Nothing Found!🧐",
                          style: TextStyle(
                              // fontFamily: "SFproBold",
                              fontSize: 18,
                              color: Colors.grey[400]),
                        ));
                      }
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
