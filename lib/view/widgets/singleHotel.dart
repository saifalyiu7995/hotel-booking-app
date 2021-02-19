import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hotel_booking_app/common.dart';
import 'package:hotel_booking_app/services/web_service.dart';
import 'package:hotel_booking_app/view/screens/floors.dart';
import 'package:hotel_booking_app/view/screens/floorsForhall.dart';
import 'package:hotel_booking_app/view/screens/hallDetail.dart';
import 'package:hotel_booking_app/view/screens/hotelDetail.dart';
import 'package:hotel_booking_app/view_models/hallDetailViewModel.dart';
import 'package:hotel_booking_app/view_models/homeViewModel.dart';
import 'package:hotel_booking_app/view_models/roomDetailViewModel.dart';
import 'package:provider/provider.dart';

class SingleHotel extends StatefulWidget {
  String id;
  String price;
  String name;
  String image;
  String screenName;
  double rating;
  String tag;
  bool hall, home;
  String kid, adult, to, from, timeto, timefrom, date;
  bool speedy, speedyBook, floor;

  SingleHotel(
      {this.id,
      this.price,
      this.name,
      this.image,
      this.screenName,
      this.rating,
      this.adult,
      this.kid,
      this.from,
      this.to,
      this.tag,
      this.timeto,
      this.timefrom,
      this.date,
      this.speedy,
      this.home,
      this.speedyBook,
      this.floor,
      this.hall});

  @override
  _SingleHotelState createState() => _SingleHotelState();
}

class _SingleHotelState extends State<SingleHotel> {
  String check;
  bool checkNetwork;
  Future checlNetwork() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      setState(() {
        check = "true";
      });
      print("true");
    } else if (connectivityResult == ConnectivityResult.none) {
      setState(() {
        check = "false";
      });
      print("false");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    checlNetwork();
    if (check == "true") {
      checkNetwork = false;
    } else {
      checkNetwork = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        print(widget.timefrom);
        setState(() {
          widget.floor == true
              ? CommonUsed.floorNo = widget.price.toString()
              : "";
          print("Floor No: " + CommonUsed.floorNo);
        });

        widget.speedy == false
            ? widget.hall == false
                ? Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          ChangeNotifierProvider<RoomDetailViewModel>(
                              create: (context) => RoomDetailViewModel(),
                              child: HotelDetail(
                                id: widget.id,
                                imageUrl: widget.image,
                                adult: widget.adult,
                                kid: widget.kid,
                                from: widget.from,
                                to: widget.to,
                                hall: widget.hall,
                                home: widget.home,
                                speedyBook: widget.speedyBook,
                              )),
                    ))
                : Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          ChangeNotifierProvider<HallDetailViewModel>(
                              create: (context) => HallDetailViewModel(),
                              child: HallDetail(
                                id: widget.id,
                                imageUrl: widget.image,
                                from: widget.timefrom,
                                to: widget.timeto,
                                date: widget.date ?? widget.to,
                                home: widget.home,
                                speedyBook: widget.speedyBook,
                              )),
                    ))
            : widget.hall == false
                ? speedycheckin(
                        adult: widget.adult,
                        kids: widget.kid,
                        dateFrom: widget.from,
                        dateTo: widget.to,
                        roomTytpe: widget.id)
                    .then((value) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FloorScreen(
                              adults: widget.adult,
                              from: widget.from,
                              kids: widget.kid,
                              to: widget.to,
                              roomTypes: value.data,
                              status: value.status,
                              speedy: widget.speedy),
                        ));
                  })
                // : print(widget.date.toString() + "  " + widget.id.toString());
                : speedycheckinHall(
                        adult: "1",
                        kids: "1",
                        dateFrom: widget.date,
                        dateTo: widget.date,
                        roomTytpe: widget.id)
                    .then((value) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FloorScreenHall(
                              adults: widget.adult,
                              from: widget.date,
                              timetTo: widget.timeto,
                              timeFrom: widget.timefrom,
                              kids: widget.kid,
                              to: widget.date,
                              roomTypes: value.data,
                              status: value.status,
                              speedy: widget.speedy),
                        ));
                  });
      },
      child: Container(
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Color(0xffFFFFFF),
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Color(0xff7E57C2).withOpacity(0.5),
                  offset: Offset(0.0, 2.0),
                  blurRadius: 6.0,
                ),
              ]),
          child: Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    decoration:
                        BoxDecoration(color: Colors.transparent, boxShadow: [
                      BoxShadow(
                          color: Color(0xff393939).withOpacity(0.10),
                          blurRadius: 30,
                          offset: Offset(0, 30))
                    ]),
                    height: widget.screenName == "main"
                        ? screenSize.height * 0.2
                        : screenSize.height * 0.23,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: checkNetwork
                          ? Image.network(
                              // product_list[index]["image"],

                              widget.image,
                              height: screenSize.height * 0.13,
                              width: screenSize.width * 0.5,
                              fit: BoxFit.fill,
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes
                                        : null,
                                  ),
                                );
                              },
                            )
                          : Image(
                              image: AssetImage(
                                  "assets/images/shopping-cart.png")),
                    ),
                  ),
                  SizedBox(
                    height: screenSize.height * 0.01,
                  ),
                  SizedBox(
                    width: screenSize.width * 0.4,
                    child: Center(
                      child: Text(
                        // product_list[index]["name"],
                        widget.name,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Color(0xff7E57C2),
                            fontFamily: "SFproBold",
                            fontSize: 16),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: screenSize.height * 0.01,
                  ),
                  Center(
                    child: Text(
                      widget.floor == true
                          ? widget.price.toString()
                          : ("\$" + widget.price.toString()),
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: "SFproBold",
                          fontSize: 18),
                    ),
                  ),
                ],
              ),
              Positioned(
                left: 10.0,
                bottom: 80.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: screenSize.width * 0.4,
                      child: Text(
                        widget.name,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                    widget.screenName == "main"
                        ? SizedBox(
                            height: 9,
                          )
                        : SizedBox(
                            height: 10,
                          )
                    // Row(
                    //   children: <Widget>[
                    //     Icon(
                    //       FontAwesomeIcons.locationArrow,
                    //       size: 14.0,
                    //       color: Colors.white,
                    //     ),
                    //     SizedBox(width: 5.0),
                    //     Text(
                    //       "Italy",
                    //       style: TextStyle(
                    //         fontSize: 19,
                    //         color: Colors.white,
                    //       ),
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
