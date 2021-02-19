import 'package:flutter/material.dart';
import 'package:hotel_booking_app/provider/stateProvier.dart';
import 'package:hotel_booking_app/view/screens/done.dart';
import 'package:hotel_booking_app/view/screens/food/foodMain.dart';
import 'package:hotel_booking_app/view/screens/food/restaurant.dart';

import 'package:flutter_session/flutter_session.dart';
import 'package:hotel_booking_app/view/screens/homeScreen.dart';
import 'package:hotel_booking_app/view/screens/welcomScreen.dart';
import 'package:hotel_booking_app/view_models/homeViewModel.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    dynamic token = FlutterSession().get('id');
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<HomeViewModel>(
          create: (context) => HomeViewModel(),
        ),
        ChangeNotifierProvider<MyState>(
          create: (context) => MyState(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'eCommerce',
        theme: ThemeData(
          fontFamily: "SFpro",
          backgroundColor: Colors.white,
          primarySwatch: Colors.deepPurple,
          accentColor: Color(0xff7E57C2),
          primaryColor: Color(0xff7E57C2),
          brightness: Brightness.light,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home:

            // RestaurantScreen(),

            //  DoneScreen(),

            FutureBuilder(
          future: FlutterSession().get('id'),
          builder: (context, snapshot) {
            if (snapshot.data == "" || !snapshot.hasData) {
              return WelcomeScreen();
            } else {
              return HomeScreen();
            }
          },
        ),

        // MultiProvider(
        //   providers: [
        //     ChangeNotifierProvider<HomeViewModel>(
        //         create: (context) => HomeViewModel()),
        //     ChangeNotifierProvider<RoomDetailViewModel>(
        //         create: (context) => RoomDetailViewModel()),
        //   ],
        //   child: Scaffold(
        //     body: Stack(
        //       children: [WelcomeScreen()],
        //     ),
        //   ),
        // ),
      ),
    );
  }
}
