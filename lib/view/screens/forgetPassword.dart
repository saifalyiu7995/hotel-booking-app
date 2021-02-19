import 'package:flutter/material.dart';
import 'package:hotel_booking_app/common.dart';

import 'package:hotel_booking_app/services/web_service.dart';
import 'package:hotel_booking_app/view/screens/loginScreen.dart';
import 'package:hotel_booking_app/view/screens/newPassword.dart';
import 'package:hotel_booking_app/view/screens/registerScreen.dart';
import 'package:hotel_booking_app/view/widgets/background.dart';
import 'package:hotel_booking_app/view/widgets/roundedButton.dart';
import 'package:hotel_booking_app/view/widgets/roundedTextfield.dart';

import 'package:progress_dialog/progress_dialog.dart';

class ForgetPassScreen extends StatefulWidget {
  String userid;
  ForgetPassScreen({this.userid});
  @override
  _ForgetPassScreenState createState() => _ForgetPassScreenState();
}

class _ForgetPassScreenState extends State<ForgetPassScreen> {
  String email;

  var _formKey = GlobalKey<FormState>();
  TextEditingController passConfirmController = new TextEditingController();
  TextEditingController passController = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; //Total height and width of screen

    ProgressDialog pr = ProgressDialog(context);
    pr = ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: true, showLogs: true);
    pr.style(
        message: 'Processing...',
        borderRadius: 10.0,
        backgroundColor: Colors.white,
        progressWidget: Center(child: CircularProgressIndicator()),
        elevation: 10.0,
        insetAnimCurve: Curves.easeInOut,
        progress: 0.0,
        maxProgress: 100.0,
        progressTextStyle: TextStyle(
            color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
        messageTextStyle: TextStyle(
            color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600));

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
                  "Forget Password",
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: "SFproBold",
                      fontSize: 19,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                Image.asset(
                  "assets/images/forget.png",
                  height: size.height * 0.32,
                ),
                SizedBox(
                  height: size.height * 0.05,
                ),
                RoundedTextField(
                  hintText: "Password",
                  iconData: Icons.lock,
                  hintcolor: Colors.black87,
                  iconcolor: Color(0xff7E57C2),
                  password: true,
                  tcontroller: passConfirmController,
                  input: "password",
                  tType: TextInputType.emailAddress,
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                RoundedTextField(
                  hintText: "Confirm Password",
                  iconData: Icons.lock,
                  hintcolor: Colors.black87,
                  iconcolor: Color(0xff7E57C2),
                  password: true,
                  tcontroller: passController,
                  input: "passowrd",
                  tType: TextInputType.emailAddress,
                ),
                RoundedButton(
                  text: "ENTER ➔",
                  press: () {
                    if (_formKey.currentState.validate()) {
                      if (passController.text.toString() ==
                              passConfirmController.text.toString() &&
                          (passController.text.toString() != "" &&
                              passConfirmController.text.toString() != "")) {
                        print(passConfirmController.text.toString());
                        pr.show();

                        updatePassword(id: widget.userid).then((value) {
                          print(value.status);
                          pr.hide();
                          if (value.status == "success") {
                            Navigator.pop(context);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginScreen(),
                                ));
                          } else {
                            CommonUsed.showFloatingFlushbar(context,
                                value.message ?? "Something went wrong!", [
                              Colors.red.shade900,
                              Colors.redAccent.shade400
                            ]);
                          }
                        });
                        // getUserEmail(email: emailController.text.toString())
                        //     .then((value) {
                        //   pr.hide();
                        //   if (value.status == "success") {
                        //     Navigator.push(
                        //         context,
                        //         MaterialPageRoute(
                        //           builder: (context) => ChangePassScreen(
                        //             userId: value.userId ?? "0",
                        //           ),
                        //         ));
                        //   } else {
                        //     CommonUsed.showFloatingFlushbar(context,
                        //         value.message, [Colors.red[900], Colors.red]);
                        //   }
                        // });
                      } else {
                        CommonUsed.showFloatingFlushbar(
                            context,
                            "Invalid Input!",
                            [Colors.red.shade900, Colors.redAccent.shade400]);
                      }
                    }
                  },
                  textColor: Colors.white,
                  color: Color(0xff7E57C2),
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Don't have an account?",
                      style: TextStyle(
                        color: Color(0xff7E57C2),
                        fontSize: 14,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return RegisterScreen();
                            },
                          ),
                        );
                      },
                      child: Text(
                        "Sign up",
                        style: TextStyle(
                            color: Color(0xff7E57C2),
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                Text(
                  "OR ",
                  style: TextStyle(
                    color: Color(0xff7E57C2),
                    fontSize: 14,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return LoginScreen();
                        },
                      ),
                    );
                  },
                  child: Text(
                    "Login?",
                    style: TextStyle(
                        color: Color(0xff7E57C2),
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
