import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;
import 'package:hotel_booking_app/common.dart';
import 'package:hotel_booking_app/models/myBokking_model.dart';
import 'package:hotel_booking_app/services/web_service.dart';
import 'package:hotel_booking_app/view/screens/food/restaurant.dart';
import 'package:hotel_booking_app/view/screens/hallsByDate.dart';
import 'package:hotel_booking_app/view/screens/myBooking.dart';
import 'package:hotel_booking_app/view/screens/myPayments.dart';
import 'package:hotel_booking_app/view/screens/profileScreen.dart';
import 'package:hotel_booking_app/view/screens/roomsByDate.dart';
import 'package:hotel_booking_app/view/screens/welcomScreen.dart';
import 'package:hotel_booking_app/view/widgets/dropMenu.dart';
import 'package:hotel_booking_app/view/widgets/singleHotel.dart';
import 'package:hotel_booking_app/view/widgets/singleHotelA.dart';
import 'package:hotel_booking_app/view_models/homeViewModel.dart';

import 'package:flutter_session/flutter_session.dart';
import 'package:provider/provider.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:intl/intl.dart' as intl;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now().add(Duration(days: 7));
  final f = new intl.DateFormat('yyyy-MM-dd');
  String roomType = "Room";
  TimeOfDay _timeFrom, _timeTo;
  String selectedDate = DateTime.now().toString().substring(0, 10);
  TextEditingController adultController = new TextEditingController();
  TextEditingController kidController = new TextEditingController();
  bool speedyCheck = false;
  var session = FlutterSession();

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

  Future displayDateRangePicker(BuildContext context) async {
    final List<DateTime> picked = await DateRagePicker.showDatePicker(
        context: context,
        initialFirstDate: _startDate,
        initialLastDate: _endDate,
        firstDate: new DateTime(DateTime.now().year - 50),
        lastDate: new DateTime(DateTime.now().year + 50));
    if (picked != null && picked.length == 2) {
      setState(() {
        _startDate = picked[0];
        _endDate = picked[1];
      });
    }
  }

  Future<void> _handleClickMe() async {
    return showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) {
        return CupertinoActionSheet(
          title: Text(
            'Room Type',
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          message: Text(
            'Please select the room type.',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          actions: <Widget>[
            CupertinoActionSheetAction(
              child: Text('Room'),
              onPressed: () {
                setState(() {
                  roomType = "Room";
                  Navigator.pop(context);
                });
              },
            ),
            CupertinoActionSheetAction(
              child: Text('Hall'),
              onPressed: () {
                setState(() {
                  roomType = "Hall";
                  Navigator.pop(context);
                });
              },
            ),
          ],
          cancelButton: CupertinoActionSheetAction(
            isDefaultAction: true,
            child: Text('Cancel'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        );
      },
    );
  }

  datePickerSingle() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    ).then((value) {
      print(f.format(value));
      print(value.year.toString() +
          "-" +
          value.month.toString() +
          "-" +
          value.day.toString());

      setState(() {
        selectedDate = f.format(value);
      });
    });
  }

  Future<void> _timePicker(bool to) async {
    TimeOfDay time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget child) {
        return Directionality(
          textDirection: TextDirection.ltr,
          child: child,
        );
      },
    );
    if (time != null) {
      setState(() {
        to == true ? _timeTo = time : _timeFrom = time;
        print(_timeFrom);
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<HomeViewModel>(context, listen: false).fetchHome();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    // final roomsbydate =
    //     Provider.of<RoomByDateViewModel>(context, listen: false);

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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Column(
                  children: [
                    Image(
                      width: double.infinity,
                      height: screenSize.height * 0.55,
                      fit: BoxFit.fill,
                      image: AssetImage("assets/images/hotelbg.jpg"),
                    ),
                    Container(
                      width: double.infinity,
                      height: screenSize.height * 0.095,
                      decoration: BoxDecoration(boxShadow: [
                        BoxShadow(
                            blurRadius: 20,
                            color: Colors.white,
                            spreadRadius: 30,
                            offset: Offset(0, -10)),
                      ]),
                    )
                  ],
                ),
                Positioned(
                  top: 20,
                  left: 10,
                  right: 10,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 20.0, right: 20, top: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProfileScreen(),
                                ));
                          },
                          child: Image(
                              height: 25,
                              image: AssetImage("assets/images/userr.png")),
                        ),
                        DropMenu(
                          icons: [
                            Icon(Icons.book_online_rounded),
                            Icon(Icons.payment_rounded),
                            Icon(Icons.restaurant),
                            Icon(Icons.exit_to_app_rounded),
                          ],
                          name: [
                            "My Bookings",
                            "My Payments",
                            "Restaurant",
                            "Logout"
                          ],
                          iconColor: Colors.white,
                          onChange: (index) {
                            print(index);
                            if (index == 0) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MyBookingsScreen(),
                                  ));
                            } else if (index == 1) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MyPaymentsScreen(),
                                  ));
                            } else if (index == 2) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => RestaurantScreen(),
                                  ));
                            } else if (index == 3) {
                              session.set("id", "");
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) => WelcomeScreen()),
                                  (Route<dynamic> route) => false);
                            }
                          },
                        )
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 290,
                  right: 10,
                  left: 10,
                  child: Center(
                    child: Container(
                      width: screenSize.width * 0.9,
                      height: screenSize.height * 0.1,
                      decoration: BoxDecoration(
                          color: Color(0xff000000).withOpacity(0.5),
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 10,
                                color: Color(0xff7E57C2).withOpacity(0.2),
                                spreadRadius: 3,
                                offset: Offset(0, 0)),
                          ]),
                      child: Center(
                        child: Text(
                          "Make Your Reservation.",
                          style: TextStyle(
                              fontFamily: "SFproBold",
                              fontSize: 28,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 10,
                  left: 10,
                  child: Center(
                    child: Container(
                      width: screenSize.width * 0.9,
                      decoration: BoxDecoration(
                          color: Color(0xff000000).withOpacity(0.5),
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 10,
                                color: Color(0xff7E57C2).withOpacity(0.2),
                                spreadRadius: 3,
                                offset: Offset(0, 0)),
                          ]),
                      child: Column(
                        children: [
                          roomType == "Room"
                              ? InkWell(
                                  onTap: () async {
                                    await displayDateRangePicker(context);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(30),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Color(0xffffffff)
                                                .withOpacity(0.9),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.black,
                                                  offset: Offset(0, -30),
                                                  blurRadius: 20),
                                              BoxShadow(
                                                  color: Colors.black,
                                                  offset: Offset(0, 30),
                                                  blurRadius: 20)
                                            ]),
                                        height: screenSize.height * 0.06,
                                        width: screenSize.width * 0.8,
                                        child: Center(
                                          child: Text(
                                            "${intl.DateFormat('dd-MM-yyyy').format(_startDate).toString()}   |   ${intl.DateFormat('dd-MM-yyyy').format(_endDate).toString()}",
                                            style: TextStyle(
                                                color: Color(0xff7E57C2),
                                                fontFamily: "SFpro",
                                                fontSize: 18),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : Column(
                                  children: [
                                    InkWell(
                                      onTap: datePickerSingle,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: Color(0xffffffff)
                                                    .withOpacity(0.9),
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Colors.black,
                                                      offset: Offset(0, -30),
                                                      blurRadius: 20),
                                                  BoxShadow(
                                                      color: Colors.black,
                                                      offset: Offset(0, 30),
                                                      blurRadius: 20)
                                                ]),
                                            height: screenSize.height * 0.06,
                                            width: screenSize.width * 0.8,
                                            child: Center(
                                              child: Text(
                                                selectedDate ?? "Select Date",
                                                style: TextStyle(
                                                    color: Color(0xff7E57C2),
                                                    fontFamily: "SFpro",
                                                    fontSize: 18),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              _timePicker(false);
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color: Color(0xffffffff)
                                                          .withOpacity(0.9),
                                                      boxShadow: [
                                                        BoxShadow(
                                                            color: Colors.black,
                                                            offset:
                                                                Offset(0, -30),
                                                            blurRadius: 20),
                                                        BoxShadow(
                                                            color: Colors.black,
                                                            offset:
                                                                Offset(0, 30),
                                                            blurRadius: 20)
                                                      ]),
                                                  height:
                                                      screenSize.height * 0.06,
                                                  width:
                                                      screenSize.width * 0.37,
                                                  child: Center(
                                                    child: Text(
                                                      _timeFrom == null
                                                          ? "From"
                                                          : _timeFrom
                                                                  .hourOfPeriod
                                                                  .toString() +
                                                              ":" +
                                                              _timeFrom.minute
                                                                  .toString(),
                                                      style: TextStyle(
                                                          color:
                                                              Color(0xff7E57C2),
                                                          fontFamily: "SFpro",
                                                          fontSize: 18),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              _timePicker(true);
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color: Color(0xffffffff)
                                                          .withOpacity(0.9),
                                                      boxShadow: [
                                                        BoxShadow(
                                                            color: Colors.black,
                                                            offset:
                                                                Offset(0, -30),
                                                            blurRadius: 20),
                                                        BoxShadow(
                                                            color: Colors.black,
                                                            offset:
                                                                Offset(0, 30),
                                                            blurRadius: 20)
                                                      ]),
                                                  height:
                                                      screenSize.height * 0.06,
                                                  width:
                                                      screenSize.width * 0.37,
                                                  child: Center(
                                                    child: Text(
                                                      _timeTo == null
                                                          ? "To"
                                                          : _timeTo.hourOfPeriod
                                                                  .toString() +
                                                              ":" +
                                                              _timeTo.minute
                                                                  .toString(),
                                                      style: TextStyle(
                                                          color:
                                                              Color(0xff7E57C2),
                                                          fontFamily: "SFpro",
                                                          fontSize: 18),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                          InkWell(
                            onTap: _handleClickMe,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Color(0xffFFFFFF).withOpacity(0.9),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.black,
                                            offset: Offset(0, -30),
                                            blurRadius: 20),
                                        BoxShadow(
                                            color: Colors.black,
                                            offset: Offset(0, 30),
                                            blurRadius: 20)
                                      ]),
                                  height: screenSize.height * 0.06,
                                  width: screenSize.width * 0.8,
                                  child: Center(
                                    child: Text(
                                      roomType == null ? "Room" : roomType,
                                      style: TextStyle(
                                          color: Color(0xff7E57C2),
                                          fontFamily: "SFpro",
                                          fontSize: 18),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          roomType == "Room"
                              ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8.0,
                                          top: 8,
                                          bottom: 8,
                                          right: 0),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(30),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Color(0xffFFFFFF)
                                                  .withOpacity(0.9),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.black,
                                                    offset: Offset(0, -30),
                                                    blurRadius: 20),
                                                BoxShadow(
                                                    color: Colors.black,
                                                    offset: Offset(0, 30),
                                                    blurRadius: 20)
                                              ]),
                                          height: screenSize.height * 0.06,
                                          width: screenSize.width * 0.38,
                                          child: Center(
                                            child: Container(
                                              margin: EdgeInsets.only(
                                                  left: 10, top: 5),
                                              child: TextField(
                                                maxLines: 1,
                                                maxLengthEnforced: true,
                                                keyboardType:
                                                    TextInputType.number,
                                                controller: kidController,
                                                decoration: InputDecoration(
                                                  disabledBorder:
                                                      InputBorder.none,
                                                  hintText: "Kids",
                                                  hintStyle: TextStyle(
                                                      color: Color(0xff7E57C2),
                                                      fontFamily: "SFpro",
                                                      fontSize: 20),
                                                ),
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontFamily: "SFpro",
                                                    fontSize: 20),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 0.0,
                                          top: 8,
                                          bottom: 8,
                                          right: 8),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(30),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Color(0xffFFFFFF),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.black,
                                                    offset: Offset(0, -30),
                                                    blurRadius: 20),
                                                BoxShadow(
                                                    color: Colors.black,
                                                    offset: Offset(0, 30),
                                                    blurRadius: 20)
                                              ]),
                                          height: screenSize.height * 0.06,
                                          width: screenSize.width * 0.38,
                                          child: Center(
                                            child: Container(
                                              margin: EdgeInsets.only(
                                                  left: 10, top: 5),
                                              child: TextField(
                                                maxLines: 1,
                                                maxLengthEnforced: true,
                                                keyboardType:
                                                    TextInputType.number,
                                                controller: adultController,
                                                decoration: InputDecoration(
                                                  disabledBorder:
                                                      InputBorder.none,
                                                  hintText: "Adults",
                                                  hintStyle: TextStyle(
                                                      color: Color(0xff7E57C2),
                                                      fontFamily: "SFpro",
                                                      fontSize: 20),
                                                ),
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontFamily: "SFpro",
                                                    fontSize: 20),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : SizedBox(),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 12.0, bottom: 8),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  speedyCheck = !speedyCheck;
                                });
                              },
                              child: Align(
                                alignment: Alignment.bottomLeft,
                                child: Row(
                                  children: [
                                    speedyCheck == false
                                        ? Image(
                                            height: 35,
                                            image: AssetImage(
                                                'assets/images/radio_off.png'),
                                          )
                                        : Image(
                                            height: 35,
                                            image: AssetImage(
                                                'assets/images/radio_off2.png'),
                                          ),
                                    Text(
                                      "Speedy Check-in",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: "SFproBold"),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              // print(_timeFrom.hour);
                              // print(_timeTo.hour);
                              // print(_timeFrom.hourOfPeriod ?? "null");
                              // print(_timeTo.hourOfPeriod ?? "null");
                              // print(selectedDate ?? "null");
                              // roomsbydate.fetchRoomsByDate(
                              //     from: "2020", to: "2020");
                              print(roomType);
                              if (adultController.text.toString() == "" &&
                                  roomType == "Room") {
                                CommonUsed.showFloatingFlushbar(
                                    context, "Adult must be 1.", [
                                  Colors.red.shade900,
                                  Colors.redAccent.shade400
                                ]);
                              } else {
                                print(roomType);
                                pr.show();
                                roomType == "Room"
                                    ? getRoomsByDate(
                                            from: intl.DateFormat('yyyy-MM-dd')
                                                    .format(_startDate)
                                                    .toString() ??
                                                "2020-01-01",
                                            to: intl.DateFormat('yyyy-MM-dd')
                                                    .format(_endDate)
                                                    .toString() ??
                                                "2020-01-01")
                                        .then((value) {
                                        pr.hide();
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  RoomsByDateScreen(
                                                status: value.status ?? "error",
                                                roomTypes: value.data.roomTypes,
                                                from: intl.DateFormat(
                                                        'yyyy-MM-dd')
                                                    .format(_startDate)
                                                    .toString(),
                                                to: intl.DateFormat(
                                                        'yyyy-MM-dd')
                                                    .format(_endDate)
                                                    .toString(),
                                                adults: adultController.text
                                                            .toString() ==
                                                        ""
                                                    ? "1"
                                                    : adultController.text
                                                        .toString(),
                                                kids: kidController.text
                                                            .toString() ==
                                                        ""
                                                    ? "0"
                                                    : kidController.text
                                                        .toString(),
                                                speedy: speedyCheck,
                                              ),
                                            ));
                                      })
                                    : getHallsByDate(
                                        from: selectedDate,
                                        timeFrom: _timeFrom.hour.toString(),
                                        timeto: _timeTo.hour.toString(),
                                      ).then((value) {
                                        pr.hide();
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  HallsByDateScreen(
                                                status: value.status ?? "error",
                                                date: selectedDate,
                                                from: _timeFrom.hour.toString(),
                                                to: _timeTo.hour.toString(),
                                                hallTypes: value.data.hallTypes,
                                                speedy: speedyCheck,
                                              ),
                                            ));
                                      });
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 8.0, right: 8, bottom: 8),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Color(0xff7E57C2).withOpacity(0.6),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.black,
                                            offset: Offset(0, -30),
                                            blurRadius: 20),
                                        BoxShadow(
                                            color: Colors.black,
                                            offset: Offset(0, 30),
                                            blurRadius: 20)
                                      ]),
                                  height: screenSize.height * 0.06,
                                  width: screenSize.width * 0.8,
                                  child: Center(
                                    child: Text(
                                      "Search",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: "SFproBold",
                                          fontSize: 22),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0, left: 20.0),
              child: Text(
                "Rooms",
                style: TextStyle(
                    color: Colors.black, fontFamily: "SFproBold", fontSize: 26),
              ),
            ),
            Consumer<HomeViewModel>(
              builder: (context, hvm, _) => Container(
                height: screenSize.height * 0.34,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: hvm.rooms.length ?? 3,
                  itemBuilder: (context, index) {
                    return SingleHotel(
                      id: hvm.rooms[index].roomvm["id"] ?? "2",
                      image: hvm.rooms[index].roomvm["image"] ??
                          "http://sub72.protegeglobal.com/hms/assets/admin/uploads/gallery/small/1539955295673.jpg",
                      name: hvm.rooms[index].roomvm["title"] ?? "abc",
                      price: hvm.rooms[index].roomvm["base_price"] ?? "75.00",
                      tag: "",
                      hall: false,
                      home: true,
                      adult: "1",
                      kid: "",
                      from: "1",
                      to: "5",
                      speedy: false,
                      speedyBook: false,
                    );
                  },
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 0.0, left: 20.0),
              child: Text(
                "Halls",
                style: TextStyle(
                    color: Colors.black, fontFamily: "SFproBold", fontSize: 26),
              ),
            ),
            Consumer<HomeViewModel>(
              builder: (context, hvm, _) => Container(
                height: screenSize.height * 0.34,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: hvm.halls.length ?? 3,
                  itemBuilder: (context, index) {
                    return SingleHotel(
                      id: hvm.halls[index].hallm.id,
                      image: hvm.halls[index].hallm.image ??
                          "http://sub72.protegeglobal.com/hms/assets/admin/uploads/gallery/small/1539955295673.jpg",
                      name: hvm.halls[index].hallm.title ?? "abc",
                      price: hvm.halls[index].hallm.basePrice ?? "75.00",
                      tag: "",
                      hall: false,
                      home: true,
                      adult: "1",
                      kid: "",
                      from: "1",
                      to: "5",
                      speedy: false,
                      speedyBook: false,
                    );
                  },
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0, left: 20.0),
              child: Text(
                "Best For You",
                style: TextStyle(
                    color: Colors.black, fontFamily: "SFproBold", fontSize: 26),
              ),
            ),
            Container(
              height: screenSize.height * 0.4,
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
          ],
        ),
      ),
    );
  }
}
