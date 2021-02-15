import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:hotel_booking_app/models/cartItem_model.dart';

class CommonUsed {
  static bool validlogin = false;
  static bool isValidemail = false;
  static bool isValidname = false;
  static bool isValidnum = false;
  static bool isValidfname = false;
  static int paidprice = 0;
  static bool speedy;
  static String floorNo = "";

  static List<String> paidServices = List<String>();

  static List<String> itemsInCart = List<String>();

  static List<Item> lstfood = List<Item>();

  static showFloatingFlushbar(
      BuildContext context, String stext, List<Color> colors) {
    Flushbar(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(10),
      borderRadius: 8,
      duration: Duration(seconds: 4),
      backgroundGradient: LinearGradient(
        colors: colors, //[Colors.red.shade900, Colors.redAccent.shade400]
        stops: [0.6, 1],
      ),
      boxShadows: [
        BoxShadow(
          color: Colors.black45,
          offset: Offset(3, 3),
          blurRadius: 3,
        ),
      ],
      // All of the previous Flushbars could be dismissed by swiping down
      // now we want to swipe to the sides
      dismissDirection: FlushbarDismissDirection.HORIZONTAL,
      // The default curve is Curves.easeOut
      forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
      title: 'Alert',
      message: stext,
    )..show(context);
  }
}
