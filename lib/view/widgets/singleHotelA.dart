import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SingleHotelA extends StatelessWidget {
  String imageUrl;
  String name;
  double price;

  SingleHotelA({this.imageUrl, this.name, this.price});

  Text _buildRatingStars(int rating) {
    String stars = '';
    for (int i = 0; i < rating; i++) {
      stars += '⭐ ';
    }
    stars.trim();

    return Text(
      stars,
      style: TextStyle(fontSize: 7),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          margin: EdgeInsets.fromLTRB(40.0, 5.0, 20.0, 5.0),
          height: 140.0,
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.0),
              boxShadow: [
                BoxShadow(
                  color: Color(0xff7E57C2).withOpacity(0.5),
                  offset: Offset(0.0, 2.0),
                  blurRadius: 6.0,
                ),
              ]),
          child: Padding(
            padding: EdgeInsets.fromLTRB(100.0, 20.0, 20.0, 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: 100.0,
                      child: Text(
                        name,
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                    Column(
                      children: <Widget>[
                        Text(
                          '\$${price.toString()}',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          'per pax',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Text(
                  "Sightseeing tour",
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
                _buildRatingStars(4),
                SizedBox(height: 10.0),
                Row(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(5.0),
                      width: 70.0,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xff7E57C2).withOpacity(0.5),
                              offset: Offset(0.0, 2.0),
                              blurRadius: 6.0,
                            ),
                          ]),
                      alignment: Alignment.center,
                      child: Text(
                        "6:00",
                        style: TextStyle(
                          color: Color(0xff7E57C2),
                        ),
                      ),
                    ),
                    SizedBox(width: 10.0),
                    Container(
                      padding: EdgeInsets.all(5.0),
                      width: 70.0,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xff7E57C2).withOpacity(0.5),
                              offset: Offset(0.0, 2.0),
                              blurRadius: 6.0,
                            ),
                          ]),
                      alignment: Alignment.center,
                      child: Text(
                        "4:00",
                        style: TextStyle(
                          color: Color(0xff7E57C2),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        Positioned(
          left: 20.0,
          top: 15.0,
          bottom: 15.0,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Image(
              width: 110.0,
              image: NetworkImage(
                imageUrl,
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }
}
