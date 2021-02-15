import 'package:flutter/material.dart';
import 'package:hotel_booking_app/common.dart';
import 'package:hotel_booking_app/services/web_service.dart';
import 'package:hotel_booking_app/view/screens/food/foodMain.dart';

class BookingListByRestaurantScreen extends StatefulWidget {
  List<String> bookingIds;
  String rest_id;
  BookingListByRestaurantScreen({this.bookingIds, this.rest_id});
  @override
  _BookingListByRestaurantScreenState createState() =>
      _BookingListByRestaurantScreenState();
}

class _BookingListByRestaurantScreenState
    extends State<BookingListByRestaurantScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.bookingIds);
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Padding(
          padding: const EdgeInsets.only(right: 18.0),
          child: Center(
            child: Text(
              "Booking ID",
              style: TextStyle(
                  color: Colors.deepPurple,
                  fontFamily: "SFproBold",
                  fontSize: 22),
            ),
          ),
        ),
        actions: [
          Icon(
            Icons.account_balance_wallet_rounded,
            color: Colors.white,
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          height: screenSize.height * 0.88,
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: widget.bookingIds.length,
            itemBuilder: (context, index) {
              if (widget.bookingIds.length == 0 ||
                  widget.bookingIds.length == null) {
                return Center(
                  child: Text(
                    "Nothing Yet!",
                    style: TextStyle(color: Colors.black, fontSize: 22),
                  ),
                );
              } else {
                return InkWell(
                  onTap: () {
                    checkBookingId(widget.bookingIds[index]).then((v) {
                      if (v.status == "success") {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FoodMainScreen(
                                  rest_id: widget.rest_id,
                                  order_no: widget.bookingIds[index],
                                  room_no: v.rooms[0] ?? "111"),
                            ));
                      } else {
                        CommonUsed.showFloatingFlushbar(
                            context,
                            "Session Not Found Against " +
                                widget.bookingIds[index] +
                                " !",
                            [Colors.red.shade900, Colors.redAccent.shade400]);
                      }
                    });
                  },
                  child: Container(
                      width: double.infinity,
                      height: screenSize.height * 0.1,
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.deepPurple.withOpacity(0.3),
                                blurRadius: 5,
                                offset: Offset(0, 0))
                          ]),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            widget.bookingIds[index],
                            style: TextStyle(fontSize: 22),
                          ),
                        ),
                      )),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
