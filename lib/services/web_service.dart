import 'dart:convert';

import 'package:hotel_booking_app/models/bookingsByRestaurant.dart';
import 'package:hotel_booking_app/models/cartItem_model.dart';
import 'package:hotel_booking_app/models/changePass_model.dart';
import 'package:hotel_booking_app/models/checkAvailability_model.dart';
import 'package:hotel_booking_app/models/checkByBookingId.dart';
import 'package:hotel_booking_app/models/checkHallAvailability_model.dart';
import 'package:hotel_booking_app/models/city_model.dart';
import 'package:hotel_booking_app/models/country_model.dart';
import 'package:hotel_booking_app/models/foodmain_model.dart';
import 'package:hotel_booking_app/models/forgetPass_model.dart';
import 'package:hotel_booking_app/models/getRestaurant.dart';
import 'package:hotel_booking_app/models/hallDetail_model.dart';
import 'package:hotel_booking_app/models/hallsByDate_model.dart';
import 'package:hotel_booking_app/models/homeScreen_model.dart';
import 'package:hotel_booking_app/models/login_model.dart';
import 'package:hotel_booking_app/models/myBokking_model.dart';
import 'package:hotel_booking_app/models/myPayments_model.dart';
import 'package:hotel_booking_app/models/oderConfirmRestaurant.dart';
import 'package:hotel_booking_app/models/payOnArrival_model.dart';
import 'package:hotel_booking_app/models/paymentKey_model.dart';
import 'package:hotel_booking_app/models/register_model.dart';
import 'package:hotel_booking_app/models/roomBookingA_model.dart';
import 'package:hotel_booking_app/models/roomDetail_model.dart';
import 'package:hotel_booking_app/models/roomsByDate_model.dart';
import 'package:hotel_booking_app/models/speedyCheckInByDate_model.dart';
import 'package:hotel_booking_app/models/speedyCheckInHall.dart';
import 'package:hotel_booking_app/models/speedyInfo_model.dart';
import 'package:hotel_booking_app/models/state_model.dart';
import 'package:hotel_booking_app/models/stripePay_model.dart';
import 'package:hotel_booking_app/models/updateProfile_model.dart';
import 'package:hotel_booking_app/models/userProfile_model.dart';
import 'package:hotel_booking_app/view/screens/food/foodMain.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

String url = 'http://sub72.protegeglobal.com/hms/api';

//Order Confirm API:
Future<OrderConfirmRestaurant> orderConfirm(
    {String guest_id,
    String rest_id,
    String order_id,
    String room_id,
    var products}) async {
  final http.Response response = await http.post(
    '$url/food/order',
    headers: <String, String>{
      'Content-type': 'application/json',
      'Accept': 'application/json',
    },
    body: json.encode(<String, dynamic>{
      "guest_id": guest_id,
      "rest_id": rest_id,
      "order_id": order_id,
      "room_id": room_id,
      "products": products
    }),
  );

  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    print(response.body);
    return orderConfirmRestaurantFromJson(response.body);
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception("Unable to perform request!");
  }
}

//Validate Booking Ids API:
Future<CheckByBookingId> checkBookingId(String id) async {
  final http.Response response = await http.get(
    '$url/food/checkOrderDate/$id',
  );

  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    print(response.body);

    return checkByBookingIdFromJson(response.body);
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception("Unable to perform request!");
  }
}

//Get Booking Ids API:
Future<BookingsByRestaurant> getBookingsOnRestaurant(String id) async {
  final http.Response response = await http.get(
    '$url/food/checkYourOrders/$id',
  );

  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    print(response.body);

    return bookingsByRestaurantFromJson(response.body);
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception("Unable to perform request!");
  }
}

//Get Food API:
Future<FoodMainModel> getFood() async {
  final http.Response response = await http.get(
    '$url/food/categories',
  );

  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    print(response.body);

    return foodMainModelFromJson(response.body);
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception("Unable to perform request!");
  }
}

//Get Restaurant API:
Future<GetRestaurant> getRestaurant() async {
  final http.Response response = await http.get(
    '$url/food/all_stores',
  );

  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    print(response.body);

    return getRestaurantFromJson(response.body);
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception("Unable to perform request!");
  }
}

//MyPayments API:
Future<MyPayments> getMyPayments({String id}) async {
  final http.Response response = await http.get(
    '$url/account/my_payments/$id',
  );

  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    print(response.body);

    return myPaymentsFromJson(response.body);
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception("Unable to perform request!");
  }
}

//MyBookings API:
Future<MyBookings> getMyBookings({String id}) async {
  final http.Response response = await http.get(
    '$url/account/my_booking/$id',
  );

  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    print(response.body);

    return myBookingsFromJson(response.body);
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception("Unable to perform request!");
  }
}

//Update Profile API:
Future<ForgetPassModel> updatePassword({String id, String pass}) async {
  final http.Response response = await http.post(
    '$url/account/password_update',
    headers: <String, String>{"Content-Type": "application/json"},
    body: json.encode(<String, dynamic>{"id": id, "passowrd": pass}),
  );

  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    print(response.body);
    return forgetPassModelFromJson(response.body);
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception("Unable to perform request!");
  }
}

//Update Profile API:
Future<UpdateProfile> updateProfile(
    {String id,
    String fname,
    String lname,
    String gender,
    String dob,
    String email,
    String countryId,
    String stateId,
    String cityId,
    String address,
    String mobile,
    String idtype,
    String idno,
    String pass}) async {
  final http.Response response = await http.post(
    '$url/account/profile/',
    headers: <String, String>{"Content-Type": "application/json"},
    body: json.encode(<String, dynamic>{
      "id": id,
      "firstname": fname,
      "lastname": lname,
      "gender": gender,
      "dob": dob,
      "email": email,
      "country_id": countryId,
      "state_id": stateId,
      "city_id": cityId,
      "address": address,
      "mobile": mobile,
      "id_type": idtype,
      "id_no": idno
    }),
  );

  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    print(response.body);
    return updateProfileFromJson(response.body);
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception("Unable to perform request!");
  }
}

//City API:
Future<Cities> getCity({String id}) async {
  final http.Response response = await http.get(
    '$url/account/cities/$id',
  );

  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    print(response.body);

    return citiesFromJson(response.body);
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception("Unable to perform request!");
  }
}

//State API:
Future<StateModel> getState({String id}) async {
  final http.Response response = await http.get(
    '$url/account/states/$id',
  );

  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    print(response.body);

    return stateFromJson(response.body);
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception("Unable to perform request!");
  }
}

//Country API:
Future<Country> getCountry() async {
  final http.Response response = await http.get(
    '$url/account/countries/',
  );

  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    print(response.body);

    return countryFromJson(response.body);
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception("Unable to perform request!");
  }
}

//User Profile API:
Future<UserProfile> getProfileInfo({String id}) async {
  final http.Response response = await http.get(
    '$url/account/profile/$id',
  );

  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    print(response.body);

    return userProfileFromJson(response.body);
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception("Unable to perform request!");
  }
}

//Pay On Arrival API:
Future<StripePayModel> stripepayhall(
    {String roomTytpe,
    String datefrom,
    String dateto,
    String timefrom,
    String timeto,
    String kids,
    String adults,
    List<String> paidServices,
    String paymentype,
    String adv,
    String paymentGateway,
    String coupon,
    String guestId,
    String keyless,
    String selectedRoom,
    String pm}) async {
  final http.Response response = await http.post(
    '$url/book/stripe',
    headers: <String, String>{"Content-Type": "application/json"},
    body: json.encode(<String, dynamic>{
      "date_from": dateto,
      "date_to": dateto,
      "time_to": timeto,
      "time_from": timefrom,
      "adults": "1",
      "kids": "1",
      "hall_type": roomTytpe,
      "paid_services": paidServices,
      "payment_type_check": paymentype,
      "advance_payment": adv,
      "payment_gateway": paymentGateway,
      "coupon": "",
      "pay": "Pay To Book",
      "guest_id": guestId,
      "keyless": keyless,
      "selected_room": selectedRoom,
      "paymentId": pm
    }),
  );

  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    print(response.body);
    return stripePayModelFromJson(response.body);
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    print(response.body);
    throw Exception("Unable to perform request!");
  }
}

//Pay On Arrival API:
Future<StripePayModel> stripepay(
    {String roomTytpe,
    String datefrom,
    String dateto,
    String kids,
    String adults,
    List<String> paidServices,
    String paymentype,
    String adv,
    String paymentGateway,
    String coupon,
    String guestId,
    String keyless,
    String selectedRoom,
    String pm}) async {
  final http.Response response = await http.post(
    '$url/book/stripe',
    headers: <String, String>{"Content-Type": "application/json"},
    body: json.encode(<String, dynamic>{
      "date_from": datefrom,
      "date_to": dateto,
      "adults": adults,
      "kids": kids,
      "room_type": roomTytpe,
      "paid_services": paidServices,
      "payment_type_check": paymentype,
      "advance_payment": adv,
      "payment_gateway": paymentGateway,
      "coupon": coupon,
      "pay": "Pay To Book",
      "guest_id": guestId,
      "keyless": keyless,
      "selected_room": selectedRoom,
      "paymentId": pm
    }),
  );

  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    print(response.body);
    return stripePayModelFromJson(response.body);
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    print(response.body);
    throw Exception("Unable to perform request!");
  }
}

//Pay On Arrival API:
Future<SpeedyInfo> speedyInfo(
    {String fname,
    String lname,
    String address,
    String email,
    String cnic,
    int useId}) async {
  final http.Response response = await http.post(
    '$url/book/step2',
    headers: <String, String>{"Content-Type": "application/json"},
    body: json.encode(<String, dynamic>{
      "fname": fname,
      "lname": lname,
      "email": email,
      "id_no": cnic,
      "address": address,
      "id": useId
    }),
  );

  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    print(response.body);
    return speedyInfoFromJson(response.body);
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception("Unable to perform request!");
  }
}

//Pay On Arrival API:
Future<SpeedyCheckInByDateHall> speedycheckinHall(
    {String roomTytpe,
    String dateTo,
    String dateFrom,
    String adult,
    String kids}) async {
  final http.Response response = await http.post(
    '$url/book/contactless',
    headers: <String, String>{"Content-Type": "application/json"},
    body: json.encode(<String, dynamic>{
      "date_from": dateTo,
      "date_to": dateTo,
      "adults": "",
      "kids": "",
      "hall_type": roomTytpe
    }),
  );

  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    print(response.body);
    return speedyCheckInByDateHallFromJson(response.body);
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    print(response.body);
    throw Exception("Unable to perform request!");
  }
}

//Pay On Arrival API:
Future<SpeedyCheckInByDate> speedycheckin(
    {String roomTytpe,
    String dateTo,
    String dateFrom,
    String adult,
    String kids}) async {
  final http.Response response = await http.post(
    '$url/book/contactless',
    headers: <String, String>{"Content-Type": "application/json"},
    body: json.encode(<String, dynamic>{
      "date_from": dateFrom,
      "date_to": dateTo,
      "adults": adult,
      "kids": kids,
      "room_type": roomTytpe
    }),
  );

  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    print(response.body);
    return speedyCheckInByDateFromJson(response.body);
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception("Unable to perform request!");
  }
}

//Stripe Payment KEY API:
Future<StripPaymentKey> getPaymentKey() async {
  final http.Response response = await http.get(
    '$url/book/stripe_api',
  );

  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    print(response.body);

    return stripPaymentKeyFromJson(response.body);
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception("Unable to perform request!");
  }
}

//Pay On Arrival API:
Future<PayOnArrival> payOnArrivalHall({
  String roomTytpe,
  String date,
  String timefrom,
  String timeto,
  String kids,
  String adults,
  String paymentype,
  String adv,
  String paymentGateway,
  String coupon,
  String guestId,
}) async {
  final http.Response response = await http.post(
    '$url/book/payment',
    headers: <String, String>{"Content-Type": "application/json"},
    body: json.encode(<String, dynamic>{
      "date_from": date,
      "date_to": date,
      "time_from": timefrom ?? "1",
      "time_to": timeto ?? "5",
      "adults": adults,
      "kids": kids,
      "room_type": "",
      "hall_type": roomTytpe,
      "paid_services": "",
      "payment_type_check": paymentype,
      "advance_payment": adv,
      "payment_gateway": paymentGateway,
      "coupon": "",
      "pay": "Pay To Book",
      "guest_id": guestId,
    }),
  );

  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    print(response.body);
    return payOnArrivalFromJson(response.body);
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception("Unable to perform request!");
  }
}

//Pay On Arrival API:
Future<PayOnArrival> payOnArrival({
  String roomTytpe,
  String datefrom,
  String dateto,
  String kids,
  String adults,
  List<String> paidServices,
  String paymentype,
  String adv,
  String paymentGateway,
  String coupon,
  String guestId,
}) async {
  final http.Response response = await http.post(
    '$url/book/payment',
    headers: <String, String>{"Content-Type": "application/json"},
    body: json.encode(<String, dynamic>{
      "date_from": datefrom,
      "date_to": dateto,
      "time_from": "",
      "time_to": "",
      "adults": adults,
      "kids": kids,
      "room_type": roomTytpe,
      "paid_services": paidServices,
      "payment_type_check": paymentype,
      "advance_payment": adv,
      "payment_gateway": paymentGateway,
      "coupon": coupon,
      "pay": "Pay To Book",
      "guest_id": guestId
    }),
  );

  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    print(response.body);
    return payOnArrivalFromJson(response.body);
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception("Unable to perform request!");
  }
}

//Booking Hall Step 1 By Date API:
Future<RoomBookingA> bookingHallA(
    {String hallTytpe,
    String date,
    String kids,
    String adults,
    String timeTo,
    String timeFrom}) async {
  final http.Response response = await http.post(
    '$url/book/hall_step1',
    headers: <String, String>{"Content-Type": "application/json"},
    body: json.encode(<String, dynamic>{
      "date_from": date ?? "2020-10-19",
      "date_to": date ?? "2020-10-19",
      "adults": adults,
      "kids": kids,
      "time_to": timeTo,
      "time_from": timeFrom,
      "hall_type": hallTytpe,
      "paid_services": ""
    }),
  );

  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    print(response.body);
    return roomBookingAFromJson(response.body);
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception("Unable to perform request!");
  }
}

//Booking Room Step 1 By Date API:
Future<RoomBookingA> bookingRoomA(
    {String roomTytpe,
    String datefrom,
    String dateto,
    String kids,
    String adults,
    List<String> paidServices}) async {
  final http.Response response = await http.post(
    '$url/book/step1',
    headers: <String, String>{"Content-Type": "application/json"},
    body: json.encode(<String, dynamic>{
      "date_from": datefrom ?? "2020-10-19",
      "date_to": dateto ?? "2020-10-19",
      "adults": adults,
      "kids": kids,
      "room_type": roomTytpe,
      "paid_services": paidServices
    }),
  );

  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    print(response.body);
    return roomBookingAFromJson(response.body);
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception("Unable to perform request!");
  }
}

//Check Hall Availability By Date API:
Future<CheckHallAvailability> getHallsAvailability(
    {String from,
    String to,
    String toTime,
    String fromTime,
    String typeId}) async {
  final http.Response response = await http.post(
    '$url/book/check_availability_halls',
    headers: <String, String>{"Content-Type": "application/json"},
    body: json.encode(<String, String>{
      "date_from": from ?? "2020-10-19",
      "date_to": to ?? "2020-10-19",
      "time_from": fromTime ?? "2",
      "time_to": toTime ?? "2",
      "hall_type": typeId
    }),
  );

  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    print(response.body);
    return checkHallAvailabilityFromJson(response.body);
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception("Unable to perform request!");
  }
}

//Check RoomAvailability By Date API:
Future<CheckRoomAvailability> getRoomsAvailability(
    {String from, String to, String adult, String kid, String typeId}) async {
  final http.Response response = await http.post(
    '$url/book/check_availability',
    headers: <String, String>{"Content-Type": "application/json"},
    body: json.encode(<String, String>{
      "date_from": from ?? "2020-10-19",
      "date_to": to ?? "2020-10-19",
      "adults": adult ?? "2",
      "kids": kid ?? "2",
      "room_type": typeId
    }),
  );

  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    print(response.body);
    return checkRoomAvailabilityFromJson(response.body);
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception("Unable to perform request!");
  }
}

//Halls By Date API:
Future<HallsByDate> getHallsByDate(
    {String from, String timeto, String timeFrom}) async {
  final http.Response response = await http.post(
    '$url/book/book_halls',
    headers: <String, String>{"Content-Type": "application/json"},
    body: json.encode(<String, String>{
      "date_from": from,
      "time_from": timeFrom,
      "time_to": timeto
    }),
  );

  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    print(response.body);

    return hallsByDateFromJson(response.body);
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception("Unable to perform request!");
  }
}

//Rooms By Date API:
Future<RoomsByDate> getRoomsByDate({String from, String to}) async {
  final http.Response response = await http.post(
    '$url/book/book_rooms',
    headers: <String, String>{"Content-Type": "application/json"},
    body: json.encode(<String, String>{"date_from": from, "date_to": to}),
  );

  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    print(response.body);

    return roomsByDateFromJson(response.body);
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception("Unable to perform request!");
  }
}

//Hall Detail API:
Future<HallDetaillModel> getHallDetail({String id}) async {
  final http.Response response = await http.get('$url/home/hall_details/$id');

  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    print(response.body);

    return hallDetaillModelFromJson(response.body);
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception("Unable to perform request!");
  }
}

//Room Detail API:
Future<RoomDeatlModel> getRoomDetail({String id}) async {
  final http.Response response = await http.get('$url/home/room_details/$id');

  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    print(response.body);

    return roomDeatlModelFromJson(response.body);
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception("Unable to perform request!");
  }
}

//Home API:
Future<HomeModel> getHome() async {
  final http.Response response = await http.get('$url/home/rooms_halls');

  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    print(response.body);

    return homeModelFromJson(response.body);
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception("Unable to perform request!");
  }
}

//Forget Password API:
Future<ChangePassModel> changePassword(
    {String password, String confirm, String id}) async {
  final http.Response response = await http.post(
    '$url/login/reset_password',
    headers: <String, String>{"Content-Type": "application/json"},
    body: json.encode(<String, String>{
      "user_id": id,
      "password": password,
      "confirm": confirm
    }),
  );

  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    print(response.body);

    return changePassModelFromJson(response.body);
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception("Unable to perform request!");
  }
}

//Forget Password API:
Future<ForgetPassModel> getUserEmail({String email}) async {
  final http.Response response = await http.post(
    '$url/login/get_password_link',
    headers: <String, String>{"Content-Type": "application/json"},
    body: json.encode(<String, String>{
      "email": email ?? "libangalal@gmail.com",
    }),
  );

  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    print(response.body);

    return forgetPassModelFromJson(response.body);
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception("Unable to perform request!");
  }
}

//Login API:
Future<LoginModel> getUserID({String email, String password}) async {
  final http.Response response = await http.post(
    '$url/login/auth',
    headers: <String, String>{"Content-Type": "application/json"},
    body: json.encode(<String, String>{
      "email": email ?? "libangalal@gmail.com",
      "password": password ?? "123456"
    }),
  );

  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    print(response.body);

    return loginModelFromJson(response.body);
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception("Unable to perform request!");
  }
}

//Register API:
Future<RegisterModel> registerUser(
    {String email,
    String password,
    String confirm,
    String contact,
    String fname,
    String lname}) async {
  final http.Response response = await http.post(
    '$url/login/register',
    headers: <String, String>{"Content-Type": "application/json"},
    body: json.encode(<String, String>{
      "firstname": fname,
      "lastname": lname,
      "mobile": contact,
      "email": email,
      "password": password,
      "confirm": confirm
    }),
  );

  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    print(response.body);

    return registerModelFromJson(response.body);
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception("Unable to perform request!");
  }
}
