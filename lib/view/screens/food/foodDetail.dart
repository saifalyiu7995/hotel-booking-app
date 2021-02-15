import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hotel_booking_app/common.dart';
import 'package:hotel_booking_app/models/cartItem_model.dart';
import 'package:hotel_booking_app/services/web_service.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:hotel_booking_app/view/screens/done.dart';
import 'package:progress_dialog/progress_dialog.dart';

class FoodDetailScreen extends StatefulWidget {
  String rest_id, order_no, room_no;
  FoodDetailScreen({this.rest_id, this.order_no, this.room_no});
  @override
  _FoodDetailScreenState createState() => _FoodDetailScreenState();
}

class _FoodDetailScreenState extends State<FoodDetailScreen> {
  @override
  Widget build(BuildContext context) {
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
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Padding(
          padding: const EdgeInsets.only(right: 18.0),
          child: Center(
            child: Text(
              "Order Items",
              style: TextStyle(
                  color: Colors.deepPurple,
                  fontFamily: "SFproBold",
                  fontSize: 22),
            ),
          ),
        ),
        actions: [
          Icon(
            Icons.account_balance_wallet_rounded,
            color: Colors.white,
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: CommonUsed.lstfood.length != 0
            ? Column(
                children: [
                  Container(
                    height: screenSize.height * 0.75,
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: CommonUsed.lstfood.length,
                      itemBuilder: (context, index) {
                        if (CommonUsed.lstfood.length == 0 ||
                            CommonUsed.lstfood.length == null) {
                          return Center(
                            child: Text(
                              "Nothing Yet!",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 22),
                            ),
                          );
                        } else {
                          return Dismissible(
                            key: UniqueKey(),
                            background: Container(color: Colors.red),
                            onDismissed: (direction) {
                              setState(() {
                                CommonUsed.lstfood.removeAt(index);

                                CommonUsed.itemsInCart.removeAt(index);
                              });
                              // print(CommonUsed.lstfood[index].name);
                            },
                            child: Container(
                                height: screenSize.height * 0.1,
                                margin: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.deepPurple
                                              .withOpacity(0.3),
                                          blurRadius: 5,
                                          offset: Offset(0, 0))
                                    ]),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            CommonUsed.lstfood[index].name,
                                            style: TextStyle(fontSize: 22),
                                          ),
                                          Text(
                                            "\$" +
                                                CommonUsed.lstfood[index].price,
                                            style: TextStyle(fontSize: 22),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Qty:",
                                            style: TextStyle(fontSize: 18),
                                          ),
                                          Text(
                                            CommonUsed.lstfood[index].qty,
                                            style: TextStyle(fontSize: 18),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                )),
                          );
                        }
                      },
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: InkWell(
                        highlightColor: Colors.white,
                        onTap: () {
                          print(CommonUsed.lstfood
                              .map((e) => {
                                    "id": e.id,
                                    "name": e.name,
                                    "price": e.price,
                                    "qty": e.qty
                                  })
                              .toList());
                          pr.show();
                          FlutterSession().get('id').then((id) {
                            print(id.toString() +
                                widget.order_no.toString() +
                                widget.rest_id.toString() +
                                widget.room_no.toString());
                            orderConfirm(
                                    guest_id: id.toString() ?? "",
                                    order_id: widget.order_no.toString(),
                                    rest_id: widget.rest_id.toString(),
                                    products: CommonUsed.lstfood
                                        .map((e) => {
                                              "id": e.id,
                                              "name": e.name,
                                              "price": e.price,
                                              "qty": e.qty
                                            })
                                        .toList(),
                                    room_id: widget.room_no.toString())
                                .then((value) {
                              pr.hide();
                              print(value.status);
                              if (value.status == "success") {
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) => DoneScreen()),
                                    (Route<dynamic> route) => false);
                              }
                            });
                          });
                        },
                        child: Container(
                          height: screenSize.height * 0.06,
                          width: screenSize.width * 0.5,
                          decoration: BoxDecoration(
                              color: Colors.deepPurple,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 5,
                                    color: Colors.deepPurple,
                                    offset: Offset(0, 0))
                              ]),
                          child: Center(
                            child: Text(
                              "CONFIRM ORDER",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            : Container(
                height: screenSize.height * 0.8,
                child: Center(
                  child: Text(
                    "No Orders Yet!",
                    style: TextStyle(color: Colors.black, fontSize: 22),
                  ),
                ),
              ),
      ),
    );
  }
}
