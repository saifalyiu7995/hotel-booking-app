import 'package:flutter/material.dart';
import 'package:hotel_booking_app/common.dart';
import 'package:hotel_booking_app/services/web_service.dart';
import 'package:hotel_booking_app/view/screens/forgetPassword.dart';
import 'package:hotel_booking_app/view/screens/homeScreen.dart';
import 'package:hotel_booking_app/view/screens/newPassword.dart';

import 'package:hotel_booking_app/view/screens/registerScreen.dart';
import 'package:hotel_booking_app/view/widgets/background.dart';
import 'package:hotel_booking_app/view/widgets/roundedButton.dart';
import 'package:hotel_booking_app/view/widgets/roundedTextfield.dart';
import 'package:hotel_booking_app/view_models/homeViewModel.dart';

import 'package:flutter_session/flutter_session.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email;
  String password;
  var _formKey = GlobalKey<FormState>();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  var session = FlutterSession();

  @override
  void initState() {
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
                  "Login",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 19,
                      fontFamily: "SFproBold",
                      fontWeight: FontWeight.bold),
                ),
                Image.asset(
                  "assets/images/loginn.png",
                  height: size.height * 0.45,
                ),
                RoundedTextField(
                  hintText: "Your Email",
                  iconData: Icons.person,
                  hintcolor: Colors.black87,
                  iconcolor: Color(0xff7E57C2),
                  password: false,
                  tcontroller: emailController,
                  input: "email",
                  tType: TextInputType.emailAddress,
                ),
                RoundedTextField(
                  hintText: "Your Password",
                  iconData: Icons.lock,
                  hintcolor: Colors.black87,
                  iconcolor: Color(0xff7E57C2),
                  password: true,
                  input: "password",
                  tcontroller: passwordController,
                ),
                RoundedButton(
                  text: "LOGIN",
                  press: () async {
                    if (_formKey.currentState.validate()) {
                      if (CommonUsed.validlogin == true &&
                          CommonUsed.isValidemail == true) {
                        pr.show();
                        print(emailController.text.toString());
                        print(passwordController.text.toString());
                        getUserID(
                                email: emailController.text.toString(),
                                password: passwordController.text.toString())
                            .then((value) {
                          pr.hide();
                          if (value.status == "success") {
                            session.set("id", value.userId.toString());
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return ChangeNotifierProvider<HomeViewModel>(
                                  create: (context) => HomeViewModel(),
                                  child: HomeScreen());
                            }));
                          } else {
                            CommonUsed.showFloatingFlushbar(
                                context,
                                value.message ?? "Error",
                                [Colors.red, Colors.redAccent]);
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return EmailConfirmScreen();
                        },
                      ),
                    );
                  },
                  child: Text(
                    "Forget Password?",
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
