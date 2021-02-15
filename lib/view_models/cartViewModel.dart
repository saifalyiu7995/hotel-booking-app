import 'package:flutter/foundation.dart';
import 'package:hotel_booking_app/common.dart';
import 'package:hotel_booking_app/models/cartItem_model.dart';

class CartModel extends ChangeNotifier {
  /// Internal, private state of the cart.
  final List<Item> _items = [];

  /// An unmodifiable view of the items in the cart.
  //UnmodifiableListView<Item> get items => UnmodifiableListView(_items);

  /// The current total price of all items (assuming all items cost $42).
  List<Item> get cartLst => _items;
  int itemlength = 0;

  void getitemlength(int val) {
    itemlength = val;
    notifyListeners();
  }

  /// Adds [item] to cart. This and [removeAll] are the only ways to modify the
  /// cart from the outside.
  void add(Item item) {
    // _items.add(item);
    CommonUsed.lstfood.add(item);

    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  void update(Item item, int indx) {
    // _items[indx] = item;
    CommonUsed.lstfood[indx] = item;

    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  void remove(Item item) {
    // _items.remove(item);
    CommonUsed.lstfood.remove(item);
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  /// Removes all items from the cart.
  void removeAll() {
    // _items.clear();
    CommonUsed.lstfood.clear();
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }
}
