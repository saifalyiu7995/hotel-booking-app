import 'package:flutter/material.dart';
import 'package:hotel_booking_app/models/hallDetail_model.dart';
import 'package:hotel_booking_app/view/widgets/singleHotel.dart';

class HallsByDateScreen extends StatefulWidget {
  final String status, from, to, date;

  final List<Map<String, String>> hallTypes;

  bool speedy;

  HallsByDateScreen(
      {this.hallTypes,
      this.status,
      this.from,
      this.to,
      this.date,
      this.speedy});

  @override
  _HallsByDateScreenState createState() => _HallsByDateScreenState();
}

class _HallsByDateScreenState extends State<HallsByDateScreen> {
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
                  "Halls",
                  style: TextStyle(fontFamily: "SFproBold", fontSize: 22),
                ),
              ),
              widget.status == "success"
                  ? Container(
                      height: screenSize.height * 0.9,
                      child: GridView.builder(
                          gridDelegate:
                              new SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2, childAspectRatio: 0.7),
                          itemCount: widget.hallTypes.length,
                          itemBuilder: (BuildContext context, int index) {
                            return SingleHotel(
                              id: widget.hallTypes[index]["id"],
                              image: widget.hallTypes[index]["image"] ??
                                  "http://sub72.protegeglobal.com/hms/assets/admin/uploads/gallery/small/1539955295673.jpg",
                              name: widget.hallTypes[index]["title"],
                              price: widget.hallTypes[index]["base_price"],
                              timefrom: widget.from,
                              timeto: widget.to,
                              date: widget.date,
                              tag: "",
                              hall: true,
                              home: false,
                              speedy: widget.speedy,
                              speedyBook: false,
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
