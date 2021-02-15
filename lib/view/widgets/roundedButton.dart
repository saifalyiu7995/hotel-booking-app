import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final Function press;
  final Color textColor, color;
  const RoundedButton({
    Key key,
    @required this.text,
    @required this.press,
    @required this.textColor,
    @required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; //Total height and width of screen

    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.8,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child: FlatButton(
          onPressed: press,
          color: color,
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
          child: Text(
            text,
            style: TextStyle(
                color: textColor, fontFamily: "SFproBold", fontSize: 17),
          ),
        ),
      ),
    );
  }
}
