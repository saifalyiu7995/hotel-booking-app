import 'package:flutter/material.dart';
import 'package:hotel_booking_app/common.dart';
import 'package:hotel_booking_app/models/getRestaurant.dart';
import 'package:hotel_booking_app/services/web_service.dart';
import 'package:hotel_booking_app/view/screens/food/bookingListByRestaurant.dart';
import 'package:hotel_booking_app/view/screens/food/foodMain.dart';
import 'package:flutter_session/flutter_session.dart';

class RestaurantScreen extends StatefulWidget {
  @override
  _RestaurantScreenState createState() => _RestaurantScreenState();
}

class _RestaurantScreenState extends State<RestaurantScreen> {
  Future<GetRestaurant> futureRestaurant;

  @override
  void initState() {
    super.initState();
    futureRestaurant = getRestaurant();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 5,
              ),
              Text(
                "RESTAURANT",
                style: TextStyle(
                    color: Colors.black, fontFamily: "SFproBold", fontSize: 22),
              ),
              SizedBox(
                height: 5,
              ),
              FutureBuilder<GetRestaurant>(
                  future: futureRestaurant,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data.status == "success") {
                        return Container(
                          width: double.infinity,
                          height: screenSize.height,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                height: screenSize.height * 0.8,
                                child: ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  itemCount: snapshot.data.stores.length ?? 1,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        FlutterSession()
                                            .get('id')
                                            .then((value) {
                                          print(value.toString());
                                          getBookingsOnRestaurant(
                                                  value.toString())
                                              .then((val) {
                                            if (val.status == "success") {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        BookingListByRestaurantScreen(
                                                      bookingIds: val.orders,
                                                      rest_id: snapshot.data
                                                          .stores[index].id,
                                                    ),
                                                  ));
                                              print(val.orders);
                                            } else {
                                              CommonUsed.showFloatingFlushbar(
                                                  context,
                                                  "No order found against your id",
                                                  [
                                                    Colors.red.shade900,
                                                    Colors.redAccent.shade400
                                                  ]);
                                            }
                                          });
                                        });
                                      },
                                      child: Container(
                                        width: double.infinity,
                                        height: 80,
                                        margin: EdgeInsets.all(14),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.deepPurple
                                                      .withOpacity(0.3),
                                                  blurRadius: 10,
                                                  offset: Offset(0, 0))
                                            ]),
                                        child: Center(
                                          child: Text(
                                            snapshot.data.stores[index].name,
                                            style: TextStyle(
                                              fontSize: 22,
                                              color: Color(0xff7E57C2),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        );
                      } else {
                        return Center(
                          child: Text(
                            "Sorry, We do not have any restaurant at this moment.",
                            style: TextStyle(
                                fontFamily: "SFproBold", fontSize: 22),
                          ),
                        );
                      }
                    } else {
                      return Container(
                        height: screenSize.height * 0.8,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
