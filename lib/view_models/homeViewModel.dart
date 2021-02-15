import 'package:flutter/cupertino.dart';
import 'package:hotel_booking_app/models/homeScreen_model.dart';
import 'package:hotel_booking_app/services/web_service.dart';

class HomeViewModel extends ChangeNotifier {
  List<RoomViewModel> rooms = List<RoomViewModel>();
  List<HallViewModel> halls = List<HallViewModel>();

  Future fetchHome() async {
    final result = await getHome();

    this.halls = result.halls.map((e) => HallViewModel(hallm: e)).toList();
    this.rooms = result.rooms.map((e) => RoomViewModel(roomvm: e)).toList();
    print(halls);
    print(rooms);
    notifyListeners();
  }
}

class RoomViewModel {
  final roomvm;

  RoomViewModel({this.roomvm});

  get room {
    return this.roomvm;
  }
}

class HallViewModel {
  final Hall hallm;

  HallViewModel({this.hallm});

  get hall {
    return this.hallm;
  }
}
