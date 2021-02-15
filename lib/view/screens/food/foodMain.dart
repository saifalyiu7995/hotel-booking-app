import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:hotel_booking_app/common.dart';
import 'package:hotel_booking_app/models/foodmain_model.dart';
import 'package:hotel_booking_app/services/web_service.dart';
import 'package:hotel_booking_app/view/screens/food/foodDetail.dart';
import 'package:hotel_booking_app/view/widgets/foodItemDetailpPopUp.dart';
import 'package:hotel_booking_app/view_models/cartViewModel.dart';
import 'package:provider/provider.dart';

class FoodMainScreen extends StatefulWidget {
  String rest_id, order_no, room_no;
  FoodMainScreen({this.rest_id, this.order_no, this.room_no});
  @override
  _FoodMainScreenState createState() => _FoodMainScreenState();
}

class _FoodMainScreenState extends State<FoodMainScreen> {
  int _current;
  Future<FoodMainModel> futueFood;

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  List<String> imageList = [
    "https://img.freepik.com/free-psd/restaurant-banner-template_23-2148466832.jpg?size=626&ext=jpg&ga=GA1.2.1062332203.1583731871",
    "https://img.freepik.com/free-psd/banner-template-american-food_23-2148473296.jpg?size=626&ext=jpg&ga=GA1.2.1062332203.1583731871",
    "https://image.freepik.com/free-psd/lava-chocolate-special-menu-banner-template_23-2148663902.jpg",
    "https://image.freepik.com/free-psd/banner-juice-bar-template_23-2148681988.jpg",
    "https://image.freepik.com/free-psd/brunch-theme-banner-template_23-2148437611.jpg"
  ];

  List<String> foodimages = [
    "https://image.freepik.com/free-psd/food-social-media-promotion-banner-post-design-template_202595-327.jpg",
    "https://image.freepik.com/free-vector/american-food-flyer-template_23-2148664240.jpg",
    "https://image.freepik.com/free-psd/food-social-media-banner-post-template_202595-356.jpg",
    "https://image.freepik.com/free-psd/food-social-media-promotion-instagram-banner-post-design-template_202595-245.jpg",
    "https://image.freepik.com/free-psd/delicious-burger-food-menu-social-media-banner-template_106176-337.jpg",
    "https://image.freepik.com/free-psd/food-social-media-promotion-instagram-banner-post-design-template_202595-244.jpg",
    "https://image.freepik.com/free-psd/food-social-media-promotion-banner-post-design-template_202595-274.jpg",
    "https://image.freepik.com/free-psd/delicious-burger-food-menu-social-media-banner-template_106176-338.jpg",
    "https://image.freepik.com/free-psd/delicious-food-social-media-post-template_202595-379.jpg"
  ];

  Future<bool> _onPressItem(
      var image, var name, var desc, var price, var options, String i) {
    var screenSize = MediaQuery.of(context).size;

    return showDialog(
          context: context,
          builder: (context) => ChangeNotifierProvider(
            create: (ctx) => CartModel(),
            child: new AlertDialog(
              // title: Center(
              //     child: Text(
              //   'Enter Your Booking ID',
              //   style: TextStyle(
              //       color: Color(0xff7E57C2),
              //       fontFamily: "SFpro",
              //       fontSize: 18,
              //       fontWeight: FontWeight.w600),
              // )),
              content: FoodItemDetailPopUp(
                  screenSize: screenSize,
                  name: name,
                  desc: desc,
                  image: image,
                  options: options,
                  price: price,
                  id: i),
            ),
          ),
        ) ??
        false;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futueFood = getFood();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return ChangeNotifierProvider(
      create: (ctx) => CartModel(),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(
              color: Colors.black, //change your color here
            ),
            title: Center(
              child: Text(
                "Restaurant",
                style: TextStyle(
                    color: Colors.deepPurple,
                    fontFamily: "SFproBold",
                    fontSize: 22),
              ),
            ),
            backgroundColor: Colors.white,
            elevation: 0,
            actions: [
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FoodDetailScreen(
                            rest_id: widget.rest_id,
                            order_no: widget.order_no,
                            room_no: widget.room_no),
                      ));
                },
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Image(
                        height: 25,
                        image: AssetImage("assets/images/shopping-cart.png"),
                      ),
                    ),
                    Positioned(
                      bottom: 35,
                      right: 19,
                      child: Container(
                        height: 12,
                        width: 12,
                        decoration: BoxDecoration(
                            // borderRadius: BorderRadius.circular(100),
                            shape: BoxShape.circle,
                            color: Colors.red),
                        child: Center(
                          child: Consumer<CartModel>(
                            builder: (ctx, cart, _) => Text(
                              CommonUsed.lstfood.length.toString() == "null"
                                  ? "0"
                                  : CommonUsed.lstfood.length.toString(),
                              // CommonUsed.lstfood.length.toString(),
                              //Provider.of<CartModel>(context).itemlength.toString(),
                              style: TextStyle(fontSize: 9),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: FutureBuilder<FoodMainModel>(
                future: futueFood,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: [
                        Stack(
                          children: [
                            Container(
                              height: screenSize.height * 0.32,
                              width: double.infinity,
                              child: CarouselSlider(
                                  options: CarouselOptions(
                                      height: MediaQuery.of(context).size.width,
                                      autoPlay: true,
                                      onPageChanged: (index, reason) {
                                        setState(() {
                                          _current = index;
                                        });
                                      },
                                      viewportFraction: 1.0),
                                  items: imageList
                                      .map(
                                        (e) => Image(
                                          image: NetworkImage(e),
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                      .toList()),
                            ),
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                height: 20,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.5),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children:
                                      map<Widget>(imageList, (index, url) {
                                    return Container(
                                      width: 15.0,
                                      height: 15.0,
                                      margin: EdgeInsets.symmetric(
                                          vertical: 6.0, horizontal: 1.0),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: _current == index
                                            ? Colors.deepPurple
                                            : Colors.white,
                                      ),
                                    );
                                  }),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          height: screenSize.height * 0.66,
                          child: ListView.builder(
                            itemCount: 2,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  SizedBox(
                                    height: screenSize.height * 0.02,
                                  ),
                                  Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        snapshot.data.categories[index].name ??
                                            "Desi Food",
                                        style: TextStyle(
                                            fontFamily: "SFproBold",
                                            fontSize: 20),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: screenSize.height * 0.27,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: snapshot
                                          .data.categories[index].data.length,
                                      itemBuilder: (context, indexx) {
                                        return InkWell(
                                          onTap: () {
                                            _onPressItem(
                                                snapshot.data.categories[index]
                                                    .data[indexx].photothumb,
                                                snapshot.data.categories[index]
                                                    .data[indexx].name,
                                                snapshot.data.categories[index]
                                                    .data[indexx].description,
                                                snapshot.data.categories[index]
                                                    .data[indexx].price,
                                                snapshot.data.categories[index]
                                                    .data[indexx].options,
                                                snapshot.data.categories[index]
                                                    .data[indexx].id);
                                          },
                                          child: Container(
                                            width: screenSize.width * 0.33,
                                            margin: EdgeInsets.all(6),
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Colors.deepPurple
                                                          .withOpacity(0.6),
                                                      blurRadius: 3,
                                                      offset: Offset(0, 0))
                                                ]),
                                            child: Column(
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  child: Image(
                                                    height: screenSize.height *
                                                        0.17,
                                                    image: NetworkImage(snapshot
                                                        .data
                                                        .categories[index]
                                                        .data[indexx]
                                                        .photothumb),
                                                    fit: BoxFit.fill,
                                                    loadingBuilder: (BuildContext
                                                            context,
                                                        Widget child,
                                                        ImageChunkEvent
                                                            loadingProgress) {
                                                      if (loadingProgress ==
                                                          null) return child;
                                                      return Center(
                                                        child:
                                                            CircularProgressIndicator(
                                                          value: loadingProgress
                                                                      .expectedTotalBytes !=
                                                                  null
                                                              ? loadingProgress
                                                                      .cumulativeBytesLoaded /
                                                                  loadingProgress
                                                                      .expectedTotalBytes
                                                              : null,
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 8.0),
                                                  child: Text(
                                                    snapshot
                                                        .data
                                                        .categories[index]
                                                        .data[indexx]
                                                        .name,
                                                    maxLines: 1,
                                                    style:
                                                        TextStyle(fontSize: 15),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(2.0),
                                                  child: Text(
                                                    "\$" +
                                                        snapshot
                                                            .data
                                                            .categories[index]
                                                            .data[indexx]
                                                            .price,
                                                    maxLines: 1,
                                                    style:
                                                        TextStyle(fontSize: 15),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Container(
                      height: screenSize.height,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                }),
          ),
        ),
      ),
    );
  }
}
