import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hotel_booking_app/common.dart';

import 'package:hotel_booking_app/services/web_service.dart';
import 'package:hotel_booking_app/view/screens/loginScreen.dart';

import 'package:progress_dialog/progress_dialog.dart';

import 'package:hotel_booking_app/view/widgets/background.dart';
import 'package:hotel_booking_app/view/widgets/roundedButton.dart';
import 'package:hotel_booking_app/view/widgets/roundedTextfield.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
    with SingleTickerProviderStateMixin {
  String email;
  String password;
  int numofapp;
  bool isselected = false;
  var _formKey = GlobalKey<FormState>();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController numController = new TextEditingController();
  TextEditingController confirmpassController = new TextEditingController();
  TextEditingController fnameController = new TextEditingController();
  TextEditingController lnameController = new TextEditingController();

  // Future<int> _addIntToSF(int numm) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setInt('intValue', numm);
  // }

  Widget get login_text => AnimatedDefaultTextStyle(
      style: isselected
          ? TextStyle(
              color: Colors.red.shade900,
              fontSize: 22,
              fontWeight: FontWeight.bold)
          : TextStyle(
              color: Color(0xff7E57C2),
              fontSize: 16,
              fontWeight: FontWeight.bold),
      duration: const Duration(milliseconds: 300),
      child: Text(
        "Login",
      ));

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
        child: Background(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: size.height * 0.05,
                ),
                Text(
                  "REGISTER",
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: "SFproBold",
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: size.height * 0.05,
                ),
                // Image.asset(
                //   "assets/images/welcome.png",
                //   height: size.height * 0.1,
                // ),

                RoundedTextField(
                  hintText: "First Name",
                  iconData: Icons.person,
                  hintcolor: Colors.black87,
                  iconcolor: Color(0xff7E57C2),
                  password: false,
                  input: "fname",
                  tcontroller: fnameController,
                  tType: TextInputType.name,
                ),
                RoundedTextField(
                  hintText: "Last Name",
                  iconData: Icons.person,
                  hintcolor: Colors.black87,
                  iconcolor: Color(0xff7E57C2),
                  password: false,
                  tcontroller: lnameController,
                  tType: TextInputType.name,
                  input: "name",
                ),
                RoundedTextField(
                  hintText: "Email",
                  iconData: Icons.email,
                  hintcolor: Colors.black87,
                  iconcolor: Color(0xff7E57C2),
                  password: false,
                  tcontroller: emailController,
                  tType: TextInputType.emailAddress,
                  input: "email",
                ),
                RoundedTextField(
                  hintText: "Contact",
                  iconData: Icons.phone_android_rounded,
                  hintcolor: Colors.black87,
                  iconcolor: Color(0xff7E57C2),
                  password: false,
                  input: "number",
                  tcontroller: numController,
                  tType: TextInputType.number,
                ),
                RoundedTextField(
                  hintText: "Password",
                  iconData: Icons.lock,
                  hintcolor: Colors.black87,
                  iconcolor: Color(0xff7E57C2),
                  password: true,
                  input: "password",
                  tcontroller: passwordController,
                ),
                RoundedTextField(
                  hintText: "Confirm Password",
                  iconData: Icons.lock,
                  hintcolor: Colors.black87,
                  iconcolor: Color(0xff7E57C2),
                  password: true,
                  input: "password",
                  tcontroller: confirmpassController,
                ),
                RoundedButton(
                  text: "SIGN UP",
                  press: () async {
                    FocusScope.of(context).unfocus();
                    if (_formKey.currentState.validate()) {
                      if (CommonUsed.validlogin == true &&
                          CommonUsed.isValidemail == true &&
                          CommonUsed.isValidname == true &&
                          CommonUsed.isValidnum == true &&
                          CommonUsed.isValidfname == true) {
                        pr.show();
                        registerUser(
                          fname: fnameController.text.toString(),
                          lname: lnameController.text.toString(),
                          email: emailController.text.toString(),
                          contact: numController.text.toString(),
                          password: passwordController.text.toString(),
                          confirm: confirmpassController.text.toString(),
                        ).then((value) {
                          pr.hide();
                          CommonUsed.showFloatingFlushbar(
                              context,
                              value.message,
                              [Colors.deepPurple, Color(0xff7E57C2)]);
                          if (value.status == "success") {
                            Timer(Duration(seconds: 3), () {
                              print(
                                  "Yeah, this line is printed after 3 seconds");
                              Navigator.pop(context);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LoginScreen(),
                                  ));
                            });
                          }
                        });
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
                      "Already have an account?",
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
                      child: login_text,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
