import 'package:flutter/material.dart';

class ListItemWidget extends StatelessWidget {
  String orderNo;
  String image;
  String qty;
  String roomType;
  String bookingOn;
  bool pyamnet;
  final Size screenSize;
  ListItemWidget(
      {Key key,
      @required this.screenSize,
      this.image,
      this.orderNo,
      this.qty,
      this.roomType,
      this.pyamnet,
      this.bookingOn})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenSize.height * 0.12,
      width: screenSize.width * 0.9,
      decoration: BoxDecoration(
          color: Color(0xffF2F3F7),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
                color: Color(0xffBECDE2), offset: Offset(6, 6), blurRadius: 8),
            BoxShadow(
                color: Color(0xffffffff),
                offset: Offset(-6, -6),
                blurRadius: 16),
          ]),
      child: Stack(
        children: [
          Positioned(
            bottom: -18,
            left: 220,
            child: Image(
              height: 40,
              width: 40,
              image: AssetImage(image ?? "assets/images/box.png"),
            ),
          ),
          Positioned(
            bottom: -15,
            left: 260,
            child: Image(
              height: 50,
              width: 50,
              image: AssetImage(image ?? "assets/images/box.png"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Order no:",
                      style: TextStyle(
                        color: Color(0xff262F56),
                        fontFamily: "SFproBold",
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      orderNo ?? "Alex Jordan",
                      style: TextStyle(
                        color: Color(0xff262F56),
                        fontFamily: "SFproBold",
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Order Date:",
                      style: TextStyle(
                        color: Color(0xff262F56),
                        fontFamily: "SFproBold",
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      bookingOn,
                      style: TextStyle(
                        color: Color(0xff262F56),
                        fontFamily: "SFproBold",
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    pyamnet == true
                        ? Text(
                            "Total Amount",
                            style: TextStyle(
                              color: Color(0xff7E57C2),
                              fontFamily: "SFproBold",
                              fontSize: 18,
                            ),
                          )
                        : Text(
                            "Type:",
                            style: TextStyle(
                              color: Color(0xff7E57C2),
                              fontFamily: "SFproBold",
                              fontSize: 13,
                            ),
                          ),
                    Text(
                      pyamnet == true ? "\$" + roomType : roomType,
                      style: TextStyle(
                        color: Color(0xff7E57C2),
                        fontFamily: "SFproBold",
                        fontSize: pyamnet == true ? 18 : 13,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
