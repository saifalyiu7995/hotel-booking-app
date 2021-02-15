import 'package:flutter/foundation.dart';

class MyState extends ChangeNotifier {
  String _kids, _adults, _to, _from;

  String get kids => _kids;
  String get adults => _adults;
  String get to => _to;
  String get from => _from;

  set kids(String kid) {
    _kids = kid;
    notifyListeners();
  }

  set adults(String adult) {
    _adults = adult;
    notifyListeners();
  }

  set to(String todate) {
    _to = todate;
    notifyListeners();
  }

  set from(String fromdate) {
    _from = fromdate;
    notifyListeners();
  }
}
