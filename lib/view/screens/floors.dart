import 'package:flutter/material.dart';
import 'package:hotel_booking_app/models/speedyCheckInByDate_model.dart';
import 'package:hotel_booking_app/models/speedyCheckInHall.dart';
import 'package:hotel_booking_app/view/widgets/singleHotel.dart';

class FloorScreen extends StatefulWidget {
  String status, from, to, adults, kids;
  bool speedy, hall;
  List<Datum> roomTypes;

  FloorScreen(
      {this.roomTypes,
      this.status,
      this.from,
      this.to,
      this.adults,
      this.speedy,
      this.kids});

  @override
  _FloorScreenState createState() => _FloorScreenState();
}

class _FloorScreenState extends State<FloorScreen> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Floors",
                  style: TextStyle(fontFamily: "SFproBold", fontSize: 22),
                ),
              ),
              widget.status == "success"
                  ? Container(
                      height: screenSize.height * 0.9,
                      child: GridView.builder(
                          gridDelegate:
                              new SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2, childAspectRatio: 0.76),
                          itemCount: widget.roomTypes.length,
                          itemBuilder: (BuildContext context, int index) {
                            return SingleHotel(
                              id: widget.roomTypes[index].roomTypeId,
                              image: widget.roomTypes[index].image ??
                                  "http://sub72.protegeglobal.com/hms/assets/admin/uploads/gallery/small/1539955295673.jpg",
                              name: widget.roomTypes[index].floor,
                              price: widget.roomTypes[index].roomNo,
                              adult: widget.adults,
                              kid: widget.kids,
                              from: widget.from,
                              to: widget.to,
                              tag: "",
                              hall: false,
                              home: false,
                              speedyBook: true,
                              speedy: false,
                              floor: true,
                            );
                          }),
                    )
                  : Center(
                      child: Text("No Rooms Found."),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
