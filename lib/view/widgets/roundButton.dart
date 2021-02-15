import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  Function ontap;
  String name;
  RoundButton({
    this.ontap,
    this.name,
    Key key,
    @required this.screenSize,
  }) : super(key: key);

  final Size screenSize;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: ontap ?? () {},
        child: Container(
          width: screenSize.width * 0.85,
          height: screenSize.height * 0.07,
          decoration: BoxDecoration(
              color: Color(0xff7E57C2),
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                    color: Color(0xffFFFFFF).withOpacity(0.45),
                    blurRadius: 8,
                    offset: Offset(0, 0))
              ]),
          child: Center(
            child: Text(
              name ?? "BUTTON",
              style: TextStyle(
                  fontSize: 17,
                  fontFamily: "SFproBold",
                  fontWeight: FontWeight.w600,
                  color: Color(0xffFFFFFF)),
            ),
          ),
        ),
      ),
    );
  }
}
