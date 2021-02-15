import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hotel_booking_app/common.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:hotel_booking_app/view/screens/homeScreen.dart';
import 'package:hotel_booking_app/view/screens/loginScreen.dart';
import 'package:hotel_booking_app/view/screens/qrScreen.dart';
import 'package:hotel_booking_app/view/screens/registerScreen.dart';
import 'package:hotel_booking_app/view/widgets/slide.dart';
import 'package:hotel_booking_app/view_models/homeViewModel.dart';
import 'package:provider/provider.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  FirebaseMessaging _fcm = FirebaseMessaging();

  String notificationText = "";
  bool colorChange = false;
  int _current = 0;

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i));
    }
    return result;
  }

  var images = [
    {
      "images": "assets/images/trip.png",
      "desc":
          "Make these holidays memorable, Plan your trip for your holidays.",
      "title": "Plan your trip."
    },
    {
      "images": "assets/images/book.gif",
      "desc": "Find best deals for any seasnon, choose wahts suits.",
      "title": "Find best deals."
    },
    {
      "images": "assets/images/relax.png",
      "desc": "Relax and enjoy the luxury of our hotels, that reflect nature.",
      "title": "Relax and enjoy."
    },
  ];

  Future<bool> _onBackPressed() {
    var screenSize = MediaQuery.of(context).size;
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: Center(
                child: Text(
              'Are you sure?',
              style: TextStyle(
                  color: Color(0xffFA4A0C),
                  fontFamily: "SFpro",
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
            )),
            content: Container(
              height: screenSize.height * 0.1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Do you want to exit an App',
                    style: TextStyle(
                        fontFamily: "SFpro",
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: screenSize.height * 0.02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Center(
                        child: Container(
                          width: screenSize.width * 0.3,
                          height: screenSize.height * 0.04,
                          decoration: BoxDecoration(
                              color: Color(0xffFA4A0C),
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: [
                                BoxShadow(
                                    color: Color(0xffFA4A0C).withOpacity(0.25),
                                    blurRadius: 8,
                                    offset: Offset(0, 4))
                              ]),
                          child: InkWell(
                              onTap: () {
                                Navigator.of(context).pop(false);
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: Center(
                                  child: Text(
                                    "NO",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontFamily: "SFpro",
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white),
                                  ),
                                ),
                              )),
                        ),
                      ),
                      Center(
                        child: Container(
                          width: screenSize.width * 0.3,
                          height: screenSize.height * 0.04,
                          decoration: BoxDecoration(
                              color: Color(0xffFFFFFF),
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: [
                                BoxShadow(
                                    color: Color(0xffFA4A0C).withOpacity(0.25),
                                    blurRadius: 8,
                                    offset: Offset(0, 4))
                              ]),
                          child: InkWell(
                              onTap: () {
                                Navigator.of(context).pop(true);
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: Center(
                                  child: Text(
                                    "YES",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontFamily: "SFpro",
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xffFA4A0C)),
                                  ),
                                ),
                              )),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ) ??
        false;
  }

  Future<bool> _onGetKey() {
    var screenSize = MediaQuery.of(context).size;
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: Center(
                child: Text(
              'Enter Your Booking ID',
              style: TextStyle(
                  color: Color(0xff7E57C2),
                  fontFamily: "SFpro",
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
            )),
            content: Container(
              height: screenSize.height * 0.13,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: screenSize.width * 0.63,
                    height: screenSize.height * 0.05,
                    decoration: BoxDecoration(
                        color: Color(0xffFFFFFF),
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                              color: Color(0xff7E57C2).withOpacity(0.25),
                              blurRadius: 8,
                              offset: Offset(0, 4))
                        ]),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Center(
                          child: Padding(
                        padding: const EdgeInsets.only(top: 3, bottom: 3),
                        child: TextFormField(
                          decoration: new InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              contentPadding: EdgeInsets.only(
                                  left: 15, bottom: 11, top: 11, right: 15),
                              hintText: "#Booking ID"),
                        ),
                      )),
                    ),
                  ),
                  SizedBox(
                    height: screenSize.height * 0.02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Center(
                        child: Container(
                          width: screenSize.width * 0.3,
                          height: screenSize.height * 0.04,
                          decoration: BoxDecoration(
                              color: Color(0xff7E57C2),
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: [
                                BoxShadow(
                                    color: Color(0xff7E57C2).withOpacity(0.25),
                                    blurRadius: 8,
                                    offset: Offset(0, 4))
                              ]),
                          child: InkWell(
                              onTap: () {
                                Navigator.of(context).pop(false);
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: Center(
                                  child: Text(
                                    "CANCEL",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontFamily: "SFpro",
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white),
                                  ),
                                ),
                              )),
                        ),
                      ),
                      Center(
                        child: Container(
                          width: screenSize.width * 0.3,
                          height: screenSize.height * 0.04,
                          decoration: BoxDecoration(
                              color: Color(0xffFFFFFF),
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: [
                                BoxShadow(
                                    color: Color(0xff7E57C2).withOpacity(0.25),
                                    blurRadius: 8,
                                    offset: Offset(0, 4))
                              ]),
                          child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => QrScreen(),
                                    ));
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: Center(
                                  child: Text(
                                    "SUBMIT",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontFamily: "SFpro",
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xff7E57C2)),
                                  ),
                                ),
                              )),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ) ??
        false;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fcm.configure(onMessage: (message) async {
      notificationText = message["notification"]["title"];
      print(notificationText);
      CommonUsed.showFloatingFlushbar(
          context, notificationText, [Colors.blueAccent, Colors.orangeAccent]);
    }, onResume: (message) async {
      notificationText = message["data"]["title"];
      print(notificationText);
      CommonUsed.showFloatingFlushbar(
          context, notificationText, [Colors.blueAccent, Colors.orangeAccent]);
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        backgroundColor: Color(0xffffffff),
        body: Container(
            height: screenSize.height,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CarouselSlider(
                      items: images
                          .map(
                            (e) => Container(
                              margin: EdgeInsets.only(left: 30, right: 30),
                              child: SlideWidget(
                                title: e["title"],
                                description: e["desc"],
                                imgurl: e["images"],
                              ),
                            ),
                          )
                          .toList(),
                      options: CarouselOptions(
                        height: screenSize.height * 0.66,
                        initialPage: 0,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _current = index;
                          });
                        },
                        autoPlay: true,
                        autoPlayInterval: Duration(seconds: 3),
                        autoPlayAnimationDuration: Duration(milliseconds: 800),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enlargeCenterPage: true,
                        scrollDirection: Axis.horizontal,
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: map<Widget>(images, (index) {
                      return Container(
                        width: _current == index ? 15 : 10,
                        height: _current == index ? 12 : 10,
                        margin: EdgeInsets.symmetric(
                            vertical: 0.0, horizontal: 2.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _current == index
                              ? Color(0xff7E57C2)
                              : Colors.grey,
                        ),
                      );
                    }),
                  ),
                  SizedBox(
                    height: screenSize.height * 0.12,
                  ),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) =>
                        //         ChangeNotifierProvider<HomeViewModel>(
                        //             create: (context) => HomeViewModel(),
                        //             child: HomeScreen()),
                        //   ),
                        // );
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegisterScreen()));
                      },
                      child: Container(
                        width: screenSize.width * 0.85,
                        height: screenSize.height * 0.08,
                        decoration: BoxDecoration(
                            color: Color(0xff7E57C2),
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                  color: Color(0xff7E57C2).withOpacity(0.45),
                                  blurRadius: 18,
                                  offset: Offset(0, 0))
                            ]),
                        child: Center(
                          child: Text(
                            "SIGN UP",
                            style: TextStyle(
                                fontSize: 17,
                                fontFamily: "SFproBold",
                                fontWeight: FontWeight.w600,
                                color: Color(0xffFFFFFF)),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: screenSize.height * 0.02,
                  ),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        // Navigator.push(
                        //     context, SlideRightRoute(page: LoginScreen()));
                        // Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()));
                      },
                      child: Container(
                        width: screenSize.width * 0.85,
                        height: screenSize.height * 0.08,
                        decoration: BoxDecoration(
                            color: Color(0xffFFFFFF),
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                  color: Color(0xff7E57C2).withOpacity(0.45),
                                  blurRadius: 8,
                                  offset: Offset(0, 0))
                            ]),
                        child: Center(
                          child: Text(
                            "LOGIN",
                            style: TextStyle(
                                fontSize: 17,
                                fontFamily: "SFproBold",
                                fontWeight: FontWeight.w600,
                                color: Color(0xff7E57C2)),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
