// import 'package:flutter/cupertino.dart';
// import 'package:hotel_booking_app/services/web_service.dart';

// class RoomByDateViewModel extends ChangeNotifier {
//   String status;
//   List<RoomByDateDataViewModel> roomList = List<RoomByDateDataViewModel>();

//   Future fetchRoomsByDate({String to, String from}) async {
//     final result = await getRoomsByDate(to: to, from: from);

//     this.status = result.status;
//     this.roomList = result.data.roomTypes
//         .map((e) => RoomByDateDataViewModel(rooms: e))
//         .toList();
//     // this.rooms = result.data.roomTypes
//     //     .map((e) => RoomByDateDataViewModel(data: e))
//     //     .toList();
//     print(result);
//     notifyListeners();
//   }
// }

// class RoomByDateDataViewModel {
//   final dynamic rooms;

//   RoomByDateDataViewModel({this.rooms});

//   get roomsByDate {
//     return this.rooms;
//   }
// }
