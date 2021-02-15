import 'package:flutter/material.dart';
import 'package:hotel_booking_app/common.dart';

import 'package:hotel_booking_app/view/screens/homeScreen.dart';

import 'package:hotel_booking_app/view/widgets/background.dart';
import 'package:hotel_booking_app/view/widgets/roundedButton.dart';
import 'package:hotel_booking_app/view/widgets/roundedTextfield.dart';

class PaymentScreen extends StatefulWidget {
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String email;
  String password;
  var _formKey = GlobalKey<FormState>();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; //Total height and width of screen

    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Background(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Payment",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 19,
                      fontWeight: FontWeight.bold),
                ),
                Image.asset(
                  "assets/images/payment.png",
                  height: size.height * 0.35,
                ),
                RoundedTextField(
                  hintText: "Card Number",
                  iconData: Icons.credit_card,
                  hintcolor: Colors.black87,
                  iconcolor: Color(0xff7E57C2),
                  password: false,
                  tcontroller: emailController,
                  tType: TextInputType.number,
                ),
                RoundedTextField(
                  hintText: "EXP",
                  iconData: Icons.date_range_rounded,
                  hintcolor: Colors.black87,
                  iconcolor: Color(0xff7E57C2),
                  password: false,
                  tcontroller: passwordController,
                  tType: TextInputType.datetime,
                ),
                RoundedTextField(
                  hintText: "CVV",
                  iconData: Icons.fiber_pin,
                  hintcolor: Colors.black87,
                  iconcolor: Color(0xff7E57C2),
                  password: true,
                  tcontroller: emailController,
                  tType: TextInputType.number,
                ),
                // RoundedTextField(
                //   hintText: "DOB",
                //   iconData: Icons.date_range_rounded,
                //   hintcolor: Colors.black87,
                //   iconcolor: Color(0xff7E57C2),
                //   password: false,
                //
                //   tcontroller: passwordController,
                //   tType: TextInputType.datetime,
                // ),
                RoundedButton(
                  text: "SUBMIT",
                  press: () {
                    if (_formKey.currentState.validate()) {
                      if (CommonUsed.isValidname == true &&
                          CommonUsed.isValidnum == true) {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return HomeScreen();
                        }));
                      }
                    }
                  },
                  textColor: Colors.white,
                  color: Color(0xff7E57C2),
                ),
                SizedBox(
                  height: size.height * 0.00,
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: <Widget>[
                //     Text(
                //       "Don't have an account?",
                //       style: TextStyle(
                //         color: Color(0xff7E57C2),
                //         fontSize: 14,
                //       ),
                //     ),
                //     GestureDetector(
                //       onTap: () {
                //         Navigator.pop(context);
                //         Navigator.push(
                //           context,
                //           MaterialPageRoute(
                //             builder: (context) {
                //               return RegisterScreen();
                //             },
                //           ),
                //         );
                //       },
                //       child: Text(
                //         "Sign up",
                //         style: TextStyle(
                //             color: Color(0xff7E57C2),
                //             fontSize: 16,
                //             fontWeight: FontWeight.bold),
                //       ),
                //     ),
                //   ],
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
