import 'package:flutter/cupertino.dart';
import 'package:hotel_booking_app/models/hallDetail_model.dart';
import 'package:hotel_booking_app/services/web_service.dart';

class HallDetailViewModel extends ChangeNotifier {
  String status;
  List<HallTypeViewModel> hallType = List<HallTypeViewModel>();
  List<AmenityViewModel> amenities = List<AmenityViewModel>();
  List<ImageViewModel> image = List<ImageViewModel>();

  Future fetchHallDetail({String id}) async {
    final result = await getHallDetail(id: id);

    this.status = result.status;
    this.hallType =
        result.hallType.map((e) => HallTypeViewModel(halltypevm: e)).toList();
    this.amenities =
        result.amenities.map((e) => AmenityViewModel(amenityvm: e)).toList();
    this.image = result.images.map((e) => ImageViewModel(imagevm: e)).toList();

    notifyListeners();
  }
}

class HallTypeViewModel {
  final HallType halltypevm;

  HallTypeViewModel({this.halltypevm});

  get hallType {
    return this.halltypevm;
  }
}

class AmenityViewModel {
  final AmenityHall amenityvm;

  AmenityViewModel({this.amenityvm});

  get amenity {
    return this.amenityvm;
  }
}

class ImageViewModel {
  final ImageHall imagevm;

  ImageViewModel({this.imagevm});

  get imagee {
    return this.imagevm;
  }
}
