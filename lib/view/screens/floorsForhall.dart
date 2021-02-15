import 'package:flutter/material.dart';
import 'package:hotel_booking_app/models/speedyCheckInByDate_model.dart';
import 'package:hotel_booking_app/models/speedyCheckInHall.dart';
import 'package:hotel_booking_app/view/widgets/singleHotel.dart';

class FloorScreenHall extends StatefulWidget {
  String status, from, to, adults, kids, timetTo, timeFrom;
  bool speedy, hall;
  List<Datumm> roomTypes;

  FloorScreenHall(
      {this.roomTypes,
      this.status,
      this.from,
      this.to,
      this.adults,
      this.timetTo,
      this.timeFrom,
      this.speedy,
      this.kids});

  @override
  _FloorScreenHallState createState() => _FloorScreenHallState();
}

class _FloorScreenHallState extends State<FloorScreenHall> {
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
                              id: widget.roomTypes[index].hallTypeId,
                              image: widget.roomTypes[index].image ??
                                  "http://sub72.protegeglobal.com/hms/assets/admin/uploads/gallery/small/1539955295673.jpg",
                              name: widget.roomTypes[index].floor,
                              price: widget.roomTypes[index].hallNo,
                              adult: widget.adults,
                              kid: widget.kids,
                              from: widget.from,
                              to: widget.to,
                              timefrom: widget.timeFrom,
                              timeto: widget.timetTo,
                              tag: "",
                              hall: true,
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
