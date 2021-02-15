import 'package:flutter/material.dart';
import 'package:hotel_booking_app/view/screens/homeScreen.dart';
import 'package:hotel_booking_app/view/widgets/roundButton.dart';
import 'package:hotel_booking_app/view_models/homeViewModel.dart';
import 'package:provider/provider.dart';

class DoneScreen extends StatefulWidget {
  @override
  _DoneScreenState createState() => _DoneScreenState();
}

class _DoneScreenState extends State<DoneScreen> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: screenSize.height * 0.15,
            ),
            Center(
              child: Image(
                  height: screenSize.height * 0.4,
                  image: AssetImage("assets/images/Completed.png")),
            ),
            SizedBox(
              height: screenSize.height * 0.05,
            ),
            Text(
              "You Are Done!",
              style: TextStyle(
                  color: Colors.black, fontFamily: "SFproBold", fontSize: 34),
            ),
            SizedBox(
              height: screenSize.height * 0.2,
            ),
            RoundButton(
                screenSize: screenSize,
                name: "Explore More",
                ontap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return ChangeNotifierProvider<HomeViewModel>(
                          create: (context) => HomeViewModel(),
                          child: HomeScreen());
                    }),
                  );
                })
          ],
        ),
      ),
    );
  }
}
