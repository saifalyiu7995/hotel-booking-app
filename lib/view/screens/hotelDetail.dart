import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hotel_booking_app/common.dart';
import 'package:hotel_booking_app/provider/stateProvier.dart';
import 'package:hotel_booking_app/services/web_service.dart';
import 'package:hotel_booking_app/view/screens/bookingOverView.dart';
import 'package:hotel_booking_app/view/screens/paymentScreen.dart';
import 'package:hotel_booking_app/view/screens/personalInfo.dart';
import 'package:hotel_booking_app/view/widgets/roundedButton.dart';
import 'package:hotel_booking_app/view/widgets/singleHotelA.dart';
import 'package:hotel_booking_app/view_models/roomDetailViewModel.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';
import 'package:html/parser.dart';

class HotelDetail extends StatefulWidget {
  String imageUrl;
  String id;
  String kid, adult, to, from;
  bool hall, home, speedy, speedyBook;

  HotelDetail(
      {this.id,
      this.imageUrl,
      this.adult,
      this.kid,
      this.to,
      this.home,
      this.from,
      this.speedy,
      this.speedyBook,
      this.hall});

  @override
  _HotelDetailState createState() => _HotelDetailState();
}

class _HotelDetailState extends State<HotelDetail> {
  var product_list = [
    {
      "name": "Sun Motel",
      "tag": "img1",
      "price": 120.00,
      "image":
          "https://i.pinimg.com/originals/b4/25/e7/b425e71cb2d7a608ea595b5b45733182.jpg",
      "rating": 4.2,
      "images": [
        "http://sc01.alicdn.com/kf/H9723d2feee024e87a740b2a85dedffa4o.jpg",
        "http://sc01.alicdn.com/kf/H9723d2feee024e87a740b2a85dedffa4o.jpg",
        "http://sc01.alicdn.com/kf/H9723d2feee024e87a740b2a85dedffa4o.jpg",
        "http://sc01.alicdn.com/kf/H9723d2feee024e87a740b2a85dedffa4o.jpg"
      ]
    },
    {
      "name": "Oliver Hills",
      "tag": "img2",
      "price": 450.00,
      "image":
          "https://cf.bstatic.com/images/hotel/max1024x768/328/32806018.jpg",
      "rating": 4.2,
      "images": [
        "http://sc02.alicdn.com/kf/H515812599ce843bca7c7218ddf45a291M.jpg",
        "http://sc02.alicdn.com/kf/H515812599ce843bca7c7218ddf45a291M.jpg",
        "http://sc02.alicdn.com/kf/H515812599ce843bca7c7218ddf45a291M.jpg",
        "http://sc02.alicdn.com/kf/H515812599ce843bca7c7218ddf45a291M.jpg"
      ]
    },
    {
      "name": "Sapphire",
      "tag": "img3",
      "price": 60.00,
      "image":
          "https://www.hospitalitynet.org/picture/xxl_153109612.jpg?t=20191217104416",
      "rating": 4.2,
      "images": [
        "http://sc02.alicdn.com/kf/Uf8a68099eef64e04ace5023ec073e90fc.jpg",
        "http://sc02.alicdn.com/kf/Uf8a68099eef64e04ace5023ec073e90fc.jpg",
        "http://sc02.alicdn.com/kf/Uf8a68099eef64e04ace5023ec073e90fc.jpg",
        "http://sc02.alicdn.com/kf/Uf8a68099eef64e04ace5023ec073e90fc.jpg"
      ]
    },
    {
      "name": "Continental",
      "tag": "img4",
      "price": 1200.00,
      "image":
          "https://cf.bstatic.com/images/hotel/max1024x768/182/182788183.jpg",
      "rating": 4.2,
      "images": [
        "http://sc02.alicdn.com/kf/HTB1kRRvCf9TBuNjy0Fcq6zeiFXaS.jpg",
        "http://sc02.alicdn.com/kf/HTB1kRRvCf9TBuNjy0Fcq6zeiFXaS.jpg",
        "http://sc02.alicdn.com/kf/HTB1kRRvCf9TBuNjy0Fcq6zeiFXaS.jpg",
        "http://sc02.alicdn.com/kf/HTB1kRRvCf9TBuNjy0Fcq6zeiFXaS.jpg"
      ]
    },
  ];

  var icon_list = [
    {"iconName": "Beach View", "icon": Icons.beach_access_rounded},
    {"iconName": "Wifi", "icon": Icons.wifi_rounded},
    {"iconName": "King Bed", "icon": Icons.king_bed_rounded},
    {"iconName": "Parking", "icon": Icons.local_parking_rounded},
    {"iconName": "Perosnal Bar", "icon": Icons.wine_bar_rounded},
    {"iconName": "Play Area", "icon": Icons.sports_basketball_rounded}
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Provider.of<RoomDetailViewModel>(context, listen: false)
        .fetchRoomDetail(id: widget.id);
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Consumer<RoomDetailViewModel>(
      builder: (context, roomdetails, child) => Scaffold(
        body: roomdetails.roomType.length == 0
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          Stack(
                            children: <Widget>[
                              Container(
                                height: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black26,
                                      offset: Offset(0.0, 2.0),
                                      blurRadius: 6.0,
                                    ),
                                  ],
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(30.0),
                                  child: CarouselSlider(
                                      options: CarouselOptions(
                                          height:
                                              MediaQuery.of(context).size.width,
                                          autoPlay: true,
                                          viewportFraction: 1.0),
                                      items: roomdetails.image
                                          .map(
                                            (e) => Image(
                                              image: NetworkImage(
                                                  "http://sub72.protegeglobal.com/hms/assets/admin/uploads/gallery/small/" +
                                                      e.imagevm.image),
                                              fit: BoxFit.cover,
                                            ),
                                          )
                                          .toList()),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 40.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    IconButton(
                                      icon: Icon(Icons.arrow_back),
                                      iconSize: 30.0,
                                      color: Colors.white,
                                      onPressed: () => Navigator.pop(context),
                                    ),
                                    // Row(
                                    //   children: <Widget>[
                                    //     IconButton(
                                    //       icon: Icon(Icons.search),
                                    //       iconSize: 30.0,
                                    //       color: Colors.white,
                                    //       onPressed: () =>
                                    //           Navigator.pop(context),
                                    //     ),
                                    //     IconButton(
                                    //       icon: Icon(
                                    //           FontAwesomeIcons.sortAmountDown),
                                    //       iconSize: 25.0,
                                    //       color: Colors.white,
                                    //       onPressed: () =>
                                    //           Navigator.pop(context),
                                    //     ),
                                    //   ],
                                    // ),
                                  ],
                                ),
                              ),
                              Positioned(
                                left: 20.0,
                                bottom: 20.0,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      roomdetails.roomType[0].roomtypevm.title,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 35.0,
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 1.2,
                                      ),
                                    ),
                                    // Row(
                                    //   children: <Widget>[
                                    //     Icon(
                                    //       FontAwesomeIcons.locationArrow,
                                    //       size: 15.0,
                                    //       color: Colors.white70,
                                    //     ),
                                    //     SizedBox(width: 5.0),
                                    //     Text(
                                    //       "Spain",
                                    //       style: TextStyle(
                                    //         color: Colors.white70,
                                    //         fontSize: 20.0,
                                    //       ),
                                    //     ),
                                    //   ],
                                    // ),
                                  ],
                                ),
                              ),
                              // Positioned(
                              //   right: 20.0,
                              //   bottom: 20.0,
                              //   child: Icon(
                              //     Icons.location_on,
                              //     color: Colors.white70,
                              //     size: 25.0,
                              //   ),
                              // ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Center(
                        child: Container(
                          height: screenSize.height * 0.42,
                          width: screenSize.width * 0.9,
                          decoration: BoxDecoration(
                              color: Color(0xffFFFFFF),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xff7E57C2).withOpacity(0.5),
                                  offset: Offset(0.0, 2.0),
                                  blurRadius: 6.0,
                                ),
                              ]),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      height: screenSize.height * 0.035,
                                      width: screenSize.width * 0.22,
                                      decoration: BoxDecoration(
                                          color: Color(0xff7E57C2),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Color(0xff7E57C2)
                                                  .withOpacity(0.5),
                                              offset: Offset(0.0, 2.0),
                                              blurRadius: 6.0,
                                            ),
                                          ]),
                                      child: Center(
                                        child: Text(
                                          "For Rent",
                                          style: TextStyle(
                                              color: Color(0xffFFFFFF),
                                              fontSize: 16),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "\$ " +
                                          roomdetails
                                              .roomType[0].roomtypevm.basePrice
                                              .toString(),
                                      style: TextStyle(
                                        color: Color(0xff000000),
                                        fontSize: 28,
                                        fontFamily: "SFproBold",
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 0),
                                child: Text(
                                  roomdetails.roomType[0].roomtypevm.title,
                                  style: TextStyle(
                                    color: Color(0xff000000),
                                    fontSize: 28,
                                    fontFamily: "SFpro",
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(
                                      FontAwesomeIcons.bed,
                                      color: Colors.grey,
                                      size: 16,
                                    ),
                                    SizedBox(
                                      width: 14,
                                    ),
                                    Icon(
                                      FontAwesomeIcons.hotTub,
                                      color: Colors.grey,
                                      size: 16,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Icon(
                                      FontAwesomeIcons.wifi,
                                      color: Colors.grey,
                                      size: 14,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 0),
                                child: Text(
                                  roomdetails.roomType[0].roomtypevm
                                              .description ==
                                          ""
                                      ? "The elegant Hotel Continental is centrally located in Oslo, only 492 feet from Oslo's main street, Karl Johan."
                                      : parse(parse(roomdetails.roomType[0]
                                                  .roomtypevm.description)
                                              .body
                                              .text)
                                          .documentElement
                                          .text,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 14),
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Center(
                                child: SizedBox(
                                  width: screenSize.width * 0.8,
                                  height: 0.4,
                                  child: Container(
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 0),
                                child: Text(
                                  "Amenities",
                                  style: TextStyle(
                                    color: Color(0xff000000),
                                    fontSize: 18,
                                    fontFamily: "SFpro",
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: screenSize.height * 0.14,
                                width: double.infinity,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: icon_list.length,
                                  itemBuilder: (context, index) {
                                    return Column(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.all(10),
                                          width: screenSize.width * 0.137,
                                          height: 50,
                                          decoration: BoxDecoration(
                                              color: Color(0xff7E57C2),
                                              borderRadius:
                                                  BorderRadius.circular(35),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Color(0xff7E57C2)
                                                      .withOpacity(0.5),
                                                  offset: Offset(0.0, 2.0),
                                                  blurRadius: 6.0,
                                                ),
                                              ]),
                                          child: Icon(
                                            icon_list[index]["icon"],
                                            color: Colors.white,
                                            size: 32,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 2,
                                        ),
                                        Text(
                                          icon_list[index]["iconName"],
                                          style: TextStyle(fontSize: 12),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      widget.home == false
                          ? Center(
                              child: RoundedButton(
                                text: "BOOK NOW",
                                press: () {
                                  print(widget.adult);
                                  getRoomsAvailability(
                                          typeId: widget.id,
                                          adult: widget.adult,
                                          kid: widget.kid,
                                          from: widget.from,
                                          to: widget.to)
                                      .then((value) {
                                    print(value.message);
                                    if (value.status == "success") {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                BookingOverViewScreen(
                                                    checkRoomAvailability:
                                                        value,
                                                    adults: widget.adult,
                                                    kids: widget.kid,
                                                    roomType: widget.id,
                                                    speedyBook:
                                                        widget.speedyBook),
                                          ));
                                    } else {
                                      CommonUsed.showFloatingFlushbar(
                                          context,
                                          value.message ??
                                              "Something went wrong",
                                          [Colors.red[500], Colors.redAccent]);
                                    }
                                  });

                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //       builder: (context) => PaymentScreen(),
                                  //     ));
                                },
                                textColor: Colors.white,
                                color: Color(0xff7E57C2),
                              ),
                            )
                          : SizedBox(),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0, left: 20.0),
                        child: Text(
                          "Best For You",
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: "SFproBold",
                              fontSize: 26),
                        ),
                      ),
                      Container(
                        height: screenSize.height * 0.6,
                        width: screenSize.width,
                        child: ListView.builder(
                          itemCount: product_list.length,
                          itemBuilder: (context, index) {
                            return SingleHotelA(
                              imageUrl: product_list[index]["image"],
                              name: product_list[index]["name"],
                              price: product_list[index]["price"],
                            );
                          },
                        ),
                      )
                    ]),
              ),
      ),
    );
  }
}
