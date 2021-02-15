import 'package:flutter/material.dart';
import 'package:hotel_booking_app/view/widgets/singleHotel.dart';

class RoomsByDateScreen extends StatefulWidget {
  String status, from, to, adults, kids;
  bool speedy;
  List<Map<String, String>> roomTypes;

  RoomsByDateScreen(
      {this.roomTypes,
      this.status,
      this.from,
      this.to,
      this.speedy,
      this.adults,
      this.kids});

  @override
  _RoomsByDateScreenState createState() => _RoomsByDateScreenState();
}

class _RoomsByDateScreenState extends State<RoomsByDateScreen> {
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
                  "Rooms",
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
                              id: widget.roomTypes[index]["id"],
                              image: widget.roomTypes[index]["image"] ??
                                  "http://sub72.protegeglobal.com/hms/assets/admin/uploads/gallery/small/1539955295673.jpg",
                              name: widget.roomTypes[index]["title"],
                              price: widget.roomTypes[index]["base_price"],
                              adult: widget.adults,
                              kid: widget.kids,
                              from: widget.from,
                              to: widget.to,
                              tag: "",
                              hall: false,
                              speedy: widget.speedy,
                              speedyBook: false,
                              home: false,
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
