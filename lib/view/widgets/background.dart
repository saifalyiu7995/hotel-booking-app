import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Widget child;
  const Background({
    Key key,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; //Total height and width of screen
    return Container(
      height: size.height,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            top: 0,
            child: Image.asset(
              "assets/images/bgtop.png",
              width: size.width,
            ),
          ),
          Positioned(
            top: 0,
            child: Image.asset(
              "assets/images/top.png",
              width: size.width,
            ),
          ),
          Positioned(
            bottom: 0,
            child: Image.asset(
              "assets/images/bottom.png",
              width: size.width,
            ),
          ),
          child,
        ],
      ),
    );
  }
}
