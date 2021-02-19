import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DropMenu extends StatefulWidget {
  final List<Icon> icons;
  final List<String> name;
  final BorderRadius borderRadius;
  final Color backgroundColor;
  final Color iconColor;
  final ValueChanged<int> onChange;
  bool closeMenu;

  DropMenu({
    Key key,
    this.icons,
    this.name,
    this.borderRadius,
    this.backgroundColor = Colors.deepPurpleAccent,
    this.iconColor = Colors.black,
    this.closeMenu,
    this.onChange,
  })  : assert(icons != null),
        super(key: key);
  @override
  _DropMenuState createState() => _DropMenuState();
}

class _DropMenuState extends State<DropMenu>
    with SingleTickerProviderStateMixin {
  GlobalKey _key;
  bool isMenuOpen = false;
  Offset buttonPosition;
  Size buttonSize;
  OverlayEntry _overlayEntry;
  BorderRadius _borderRadius;
  AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 250),
    );
    _borderRadius = widget.borderRadius ?? BorderRadius.circular(4);
    _key = LabeledGlobalKey("button_icon");
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  closeMenuOutSide() {
    setState(() {
      closeMenu();
    });
  }

  findButton() {
    RenderBox renderBox = _key.currentContext.findRenderObject();
    buttonSize = renderBox.size;
    buttonPosition = renderBox.localToGlobal(Offset.zero);
  }

  void closeMenu() {
    _overlayEntry.remove();
    _animationController.reverse();
    isMenuOpen = !isMenuOpen;
  }

  void openMenu() {
    findButton();
    _animationController.forward();
    _overlayEntry = _overlayEntryBuilder();
    Overlay.of(context).insert(_overlayEntry);
    isMenuOpen = !isMenuOpen;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: _key,
      decoration: BoxDecoration(
        borderRadius: _borderRadius,
      ),
      child: GestureDetector(
        onTap: () {
          if (isMenuOpen) {
            closeMenu();
          } else {
            openMenu();
          }
        },
        child: Image(
          image: AssetImage("assets/images/menu.png"),
          height: 25,
          width: 25,
        ),
      ),
    );
  }

  OverlayEntry _overlayEntryBuilder() {
    return OverlayEntry(
      builder: (context) {
        return Positioned(
          top: buttonPosition.dy + buttonSize.height,
          right: 20,
          child: Material(
            color: Colors.transparent,
            child: Stack(
              children: <Widget>[
                // Align(
                //   alignment: Alignment.topCenter,
                //   child: ClipPath(
                //     clipper: ArrowClipper(),
                //     child: Container(
                //       width: 100,
                //       height: 10,
                //       color: widget.backgroundColor ?? Color(0xFFF),
                //     ),
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Container(
                    height: widget.icons.length * buttonSize.height * 2.2,
                    width: widget.icons.length * buttonSize.height * 1.5,
                    decoration: BoxDecoration(
                      color: Color(0xff7E57C2),
                      borderRadius: _borderRadius,
                    ),
                    child: Theme(
                      data: ThemeData(
                        iconTheme: IconThemeData(
                          color: widget.iconColor,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: List.generate(widget.icons.length, (index) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    widget.onChange(index);
                                    closeMenu();
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Container(
                                      width: buttonSize.width,
                                      height: buttonSize.height,
                                      child: widget.icons[index],
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    widget.onChange(index);
                                    closeMenu();
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: SizedBox(
                                      width: 90,
                                      child: Text(
                                        widget.name[index] ?? "",
                                        maxLines: 1,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: "sfroundbold"),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class ArrowClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, size.height);
    path.lineTo(size.width / 2, size.height / 6);
    path.lineTo(size.width, size.height);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
