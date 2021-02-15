import 'package:flutter/material.dart';
import 'package:hotel_booking_app/common.dart';
import 'package:hotel_booking_app/models/cartItem_model.dart';
import 'package:hotel_booking_app/view_models/cartViewModel.dart';
import 'package:provider/provider.dart';

class FoodItemDetailPopUp extends StatefulWidget {
  FoodItemDetailPopUp({
    Key key,
    this.image,
    this.desc,
    this.name,
    this.options,
    this.price,
    this.id,
    @required this.screenSize,
  }) : super(key: key);

  final Size screenSize;
  var name, image, options, price, desc, id;

  @override
  _FoodItemDetailPopUpState createState() => _FoodItemDetailPopUpState();
}

class _FoodItemDetailPopUpState extends State<FoodItemDetailPopUp> {
  int qty = 1;

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartModel>(context);
    return Container(
      height: widget.options.length != 0
          ? widget.screenSize.height * 0.5
          : widget.screenSize.height * 0.40,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Image(
              height: widget.screenSize.height * 0.2,
              width: double.infinity,
              image: NetworkImage(widget.image),
              fit: BoxFit.fill,
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes
                        : null,
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 3.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 150,
                  child: Text(
                    widget.name ?? "",
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
                Text(
                  "\$" + (int.parse(widget.price) * qty).toString() ?? "",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 3,
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Text(
              widget.desc ?? "",
              maxLines: 2,
              style: TextStyle(
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                  color: Colors.grey),
            ),
          ),
          widget.options.length != 0
              ? SizedBox(
                  height: widget.screenSize.height * 0.02,
                )
              : SizedBox(),
          widget.options.length != 0
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "￩",
                      style: TextStyle(color: Colors.deepPurple, fontSize: 28),
                    ),
                    Container(
                      height: 30,
                      width: widget.screenSize.width * 0.5,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: widget.options.length ?? 2,
                        itemBuilder: (context, index) {
                          return Container(
                            height: 30,
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image(
                                      height: 20,
                                      image: AssetImage(
                                          "assets/images/radio_on.png")),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    widget.options[index] ?? "name",
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Text(
                      "￫",
                      style: TextStyle(color: Colors.deepPurple, fontSize: 28),
                    ),
                  ],
                )
              : SizedBox(),
          SizedBox(
            height: widget.screenSize.height * 0.01,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Qty:"),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () {
                      print(CommonUsed.lstfood.length);
                      setState(() {
                        qty > 0 ? qty-- : qty = 1;
                      });
                    },
                    child: Image(
                      height: 25,
                      image: AssetImage("assets/images/minus.png"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(qty.toString() ?? "1"),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        qty++;
                      });
                    },
                    child: Image(
                      height: 25,
                      image: AssetImage("assets/images/plus.png"),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: widget.screenSize.height * 0.01,
          ),
          Center(
            child: Container(
              width: widget.screenSize.width,
              height: widget.screenSize.height * 0.05,
              decoration: BoxDecoration(
                  color: Color(0xff7E57C2),
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                        color: Color(0xff7E57C2).withOpacity(0.25),
                        blurRadius: 8,
                        offset: Offset(0, 4))
                  ]),
              child: InkWell(
                  onTap: () {
                    // Navigator.of(context).pop(false);
                    print(widget.id);
                    // print(CommonUsed.lstfood[widget.indexx].name);
                    print(CommonUsed.itemsInCart.contains(widget.name));

                    if (!CommonUsed.itemsInCart.contains(widget.name)) {
                      cart.add(
                        Item(
                            name: widget.name,
                            price: (int.parse(widget.price) * qty).toString(),
                            qty: qty.toString() ?? "1",
                            id: widget.id),
                      );
                      CommonUsed.itemsInCart.add(widget.name);
                      cart.getitemlength(CommonUsed.lstfood.length);
                      print(CommonUsed.lstfood);
                      print(CommonUsed.lstfood.length);
                      Navigator.pop(context);
                    } else {
                      print("mojud hai");
                      print(CommonUsed.itemsInCart);
                      cart.update(
                          Item(
                              name: widget.name,
                              price: (int.parse(widget.price) * qty).toString(),
                              qty: qty.toString() ?? "1",
                              id: widget.id),
                          CommonUsed.lstfood
                              .map((e) => e.id)
                              .toList()
                              .indexOf(widget.id));

                      print(CommonUsed
                          .lstfood[CommonUsed.lstfood
                              .map((e) => e.id)
                              .toList()
                              .indexOf(widget.id)]
                          .name);
                      Navigator.pop(context);
                      // CommonUsed.showFloatingFlushbar(context, "Already Added!",
                      //     [Colors.red.shade900, Colors.redAccent.shade400]);
                    }
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Center(
                      child: Text(
                        "ADD",
                        style: TextStyle(
                            fontSize: 15,
                            fontFamily: "SFpro",
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                    ),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
