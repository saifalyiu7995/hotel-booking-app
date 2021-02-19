import 'package:flutter/material.dart';

class SlideWidget extends StatelessWidget {
  String title;
  String description;
  String imgurl;

  SlideWidget({this.imgurl, this.title, this.description});
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Container(
      width: screenSize.width * 0.54,
      child: Column(
        children: [
          SizedBox(
            height: screenSize.height * 0.08,
          ),
          Center(
            child: Image(
              image: AssetImage(
                  imgurl == null ? "assets/images/book.gif" : imgurl),
              width: 500,
            ),
          ),
          Center(
            child: Container(
              child: Text(
                title == null ? "Plan your trip." : title,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 23,
                    fontFamily: "SFproBold",
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Center(
            child: Container(
              margin: EdgeInsets.only(
                top: 14,
              ),
              child: Text(
                description == null
                    ? "Make these holidays memorable, Plan your trip for your holidays."
                    : description,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black54,
                    fontSize: 17,
                    fontFamily: "SFproBold",
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
