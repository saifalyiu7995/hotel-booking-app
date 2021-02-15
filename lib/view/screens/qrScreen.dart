import 'package:flutter/material.dart';

class QrScreen extends StatefulWidget {
  @override
  _QrScreenState createState() => _QrScreenState();
}

class _QrScreenState extends State<QrScreen> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Color(0xff7E57C2),
          //change your color here
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Your Key",
          style: TextStyle(
              color: Colors.black, fontFamily: "SFproBold", fontSize: 22),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Icon(
              Icons.download_rounded,
              color: Color(0xff000000),
            ),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              height: screenSize.height * 0.35,
              width: screenSize.width * 0.75,
              decoration: BoxDecoration(
                  color: Color(0xffFFFFFF),
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xff7E57C2).withOpacity(0.5),
                      offset: Offset(0.0, 2.0),
                      blurRadius: 6.0,
                    ),
                  ]),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Image(
                  image: AssetImage("assets/images/qr-code.png"),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Text(
            "Adnan Sharaf",
            style: TextStyle(
                color: Color(0xff000000),
                fontFamily: "SFproBold",
                fontSize: 34),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            "Scan to Unlock Your Room.",
            style: TextStyle(
                color: Colors.grey, fontFamily: "SFpro", fontSize: 16),
          ),
        ],
      ),
    );
  }
}
