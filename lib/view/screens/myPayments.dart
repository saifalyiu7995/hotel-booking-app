import 'package:flutter/material.dart';
import 'package:hotel_booking_app/models/myPayments_model.dart';
import 'package:hotel_booking_app/services/web_service.dart';
import 'package:hotel_booking_app/view/screens/detailPayment.dart';
import 'package:hotel_booking_app/view/widgets/listItem.dart';
import 'package:flutter_session/flutter_session.dart';

class MyPaymentsScreen extends StatefulWidget {
  @override
  _MyPaymentsScreenState createState() => _MyPaymentsScreenState();
}

class _MyPaymentsScreenState extends State<MyPaymentsScreen> {
  String userid;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserId();
  }

  getUserId() {
    FlutterSession().get("id").then((value) {
      setState(() {
        userid = value.toString();
        print(userid);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xffFFFFFF),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "My Payments",
              style: TextStyle(
                  color: Color(0xff7E57C2),
                  fontFamily: "SFproBold",
                  fontSize: 22),
            ),
            SizedBox(
              height: screenSize.height * 0.01,
            ),
            SingleChildScrollView(
              child: Container(
                height: screenSize.height * 0.88,
                width: screenSize.width,
                child: FutureBuilder<MyPayments>(
                  future: getMyPayments(id: userid ?? "1"),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data.status == "success") {
                        return ListView.builder(
                          itemCount: snapshot.data.payments.length,
                          itemBuilder: (context, index) => InkWell(
                            //   onTap: () {
                            //   Navigator.push(context, MaterialPageRoute(builder:
                            //   (context) => DetailScreen(
                            //     adults: snapshot.data.payments[index].,
                            //   ) ,) );
                            // },
                            child: Container(
                              margin: EdgeInsets.only(
                                  top: 10, left: 15, bottom: 10, right: 15),
                              child: ListItemWidget(
                                screenSize: screenSize,
                                orderNo: snapshot.data.payments[index].orderId,
                                bookingOn: snapshot
                                    .data.payments[index].addedDate
                                    .toString()
                                    .substring(0, 11),
                                roomType: snapshot.data.payments[index].invoice,
                                pyamnet: true,
                              ),
                            ),
                          ),
                        );
                      } else {
                        return Center(
                            child: Text(
                          "Nothing Found!🧐",
                          style: TextStyle(
                              // fontFamily: "SFproBold",
                              fontSize: 18,
                              color: Colors.grey[400]),
                        ));
                      }
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
