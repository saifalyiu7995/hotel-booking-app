import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:hotel_booking_app/common.dart';

class RoundedTextField extends StatelessWidget {
  final String hintText;
  final IconData iconData;
  final Color hintcolor, iconcolor;
  final bool password;
  final String input;
  final TextEditingController tcontroller;
  final TextInputType tType;

  const RoundedTextField({
    Key key,
    @required this.hintText,
    @required this.iconData,
    @required this.hintcolor,
    this.iconcolor,
    this.password,
    this.input,
    this.tcontroller,
    this.tType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      width: size.width * 0.9,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(29),
        boxShadow: [
          BoxShadow(
            color: Color(0xff7E57C2).withOpacity(0.5),
            offset: Offset(0, 0),
            blurRadius: 5,
          ),
        ],
        color: Color(0xFFffffff),
      ),
      child: TextFormField(
        controller: tcontroller,
        obscureText: password,
        keyboardType: tType,
        maxLength: input == "number" ? 11 : 60,
        buildCounter: (BuildContext context,
                {int currentLength, int maxLength, bool isFocused}) =>
            null,
        textInputAction: TextInputAction.next,
        validator: (String value) {
          if (!password && input == "email") {
            bool isValid = EmailValidator.validate(value);
            if (!isValid) {
              CommonUsed.isValidemail = false;
              return CommonUsed.showFloatingFlushbar(context, "Invalid email",
                  [Colors.red.shade900, Colors.redAccent.shade400]);
            } else {
              CommonUsed.isValidemail = true;
            }
          } else if (password == true && input == "password") {
            if (value.length < 6) {
              CommonUsed.validlogin = false;
              return CommonUsed.showFloatingFlushbar(
                  context,
                  "Invalid Password",
                  [Colors.red.shade900, Colors.redAccent.shade400]);
            } else {
              CommonUsed.validlogin = true;
            }
          } else if (!password && input == "number") {
            if (value.length < 11) {
              CommonUsed.isValidnum = false;
              return CommonUsed.showFloatingFlushbar(context, "Invalid Number",
                  [Colors.red.shade900, Colors.redAccent.shade400]);
            } else {
              CommonUsed.isValidnum = true;
            }
          } else if (!password && input == "name") {
            if (value.length < 3) {
              CommonUsed.isValidname = false;
              return CommonUsed.showFloatingFlushbar(context, "Invalid Name",
                  [Colors.red.shade900, Colors.redAccent.shade400]);
            } else {
              CommonUsed.isValidname = true;
            }
          } else if (!password && input == "fname") {
            if (value.length < 3) {
              CommonUsed.isValidfname = false;
              return CommonUsed.showFloatingFlushbar(context, "Invalid Name",
                  [Colors.red.shade900, Colors.redAccent.shade400]);
            } else {
              CommonUsed.isValidfname = true;
            }
          }
        },
        decoration: InputDecoration(
            // suffixIcon: password
            //     ? InkWell(
            //         onTap: () {

            //         },
            //         child: (Icon(
            //           Icons.visibility,
            //           color: iconcolor,
            //         )),
            //       )
            //     : null,
            border: InputBorder.none,
            icon: Icon(
              iconData,
              color: iconcolor,
            ),
            hintText: hintText,
            hintStyle: TextStyle(color: hintcolor),
            errorStyle: TextStyle(
              fontSize: 14,
            )),
      ),
    );
  }
}
