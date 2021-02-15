import 'package:flutter/cupertino.dart';
import 'package:hotel_booking_app/models/homeScreen_model.dart';
import 'package:hotel_booking_app/models/roomDetail_model.dart';
import 'package:hotel_booking_app/services/web_service.dart';

class RoomDetailViewModel extends ChangeNotifier {
  String status;
  List<RoomTypeViewModel> roomType = List<RoomTypeViewModel>();
  List<AmenityViewModel> amenities = List<AmenityViewModel>();
  List<ImageViewModel> image = List<ImageViewModel>();

  Future fetchRoomDetail({String id}) async {
    final result = await getRoomDetail(id: id);

    this.status = result.status;
    this.roomType =
        result.roomType.map((e) => RoomTypeViewModel(roomtypevm: e)).toList();
    this.amenities =
        result.amenities.map((e) => AmenityViewModel(amenityvm: e)).toList();
    this.image = result.image.map((e) => ImageViewModel(imagevm: e)).toList();

    notifyListeners();
  }
}

class RoomTypeViewModel {
  final RoomType roomtypevm;

  RoomTypeViewModel({this.roomtypevm});

  get roomType {
    return this.roomtypevm;
  }
}

class AmenityViewModel {
  final Amenity amenityvm;

  AmenityViewModel({this.amenityvm});

  get amenity {
    return this.amenityvm;
  }
}

class ImageViewModel {
  final Imagee imagevm;

  ImageViewModel({this.imagevm});

  get imagee {
    return this.imagevm;
  }
}
