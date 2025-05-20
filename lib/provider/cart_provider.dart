import 'package:core_retail/data/bill/models/line/line_model.dart';
import 'package:core_retail/data/bill/models/line/restaurant_line_model.dart';
import 'package:core_retail/data/bill/models/line/topping_line_model.dart';
import 'package:core_retail/data/price_list/models/assortment/topping_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart'; // Pentru listEquals

class CartProvider extends ChangeNotifier {
  final List<LineModel> _items = [];
  bool _isPackage = false;

  List<LineModel> get items => _items;
  bool get isPackage => _isPackage;

  // Total items in cart (for badge)
  int get totalItems => _items.length;

  // Total price of all items (inclusiv topinguri)
  double get totalPrice => _items.isEmpty?0:_items.map((e)=>(e.salePrice??0) * e.quantity).reduce((a,b)=> a+b);

  void toggleOrderType() {
    _isPackage = !_isPackage;
    notifyListeners();
  }

  // void addToCart(RestaurantLineModel item) {
  //   final index = _items.indexWhere((i) =>
  //   i.productId == item.productId &&
  //       i.isPackage == item.isPackage &&
  //       // Verificăm dacă topingurile sunt identice
  //       listEquals(
  //           i.selectedToppings.map((t) => t.id).toList()..sort(),
  //           item.selectedToppings.map((t) => t.id).toList()..sort()
  //       ));
  //
  //   if (index >= 0) {
  //     _items[index] = _items[index].copyWith(
  //       quantity: _items[index].quantity + item.quantity,
  //       selectedToppings: item.selectedToppings,
  //     );
  //   } else {
  //     // Dacă nu există, adăugăm un nou item
  //     _items.add(item);
  //   }
  //   notifyListeners();
  // }
  void addToCart(LineModel item) {

      _items.add(item);

    notifyListeners();
  }

  void updateQuantity(String productId, int newQuantity, {List<ToppingLineModel>? toppings}) {
    final index = _items.indexWhere((item) =>
    item.id == productId &&
        (toppings == null || listEquals(
            item.toppings?.map((t) => t.toppingData.id).toList()?..sort(),
            toppings.map((t) => t.toppingData.id).toList()..sort()
        ))
    );

    if (index >= 0) {
      _items[index] = _items[index].copyWith(
        quantity: newQuantity.toDouble(),
        toppings: toppings ,
      );

      if (_items[index].quantity <= 0) {
        _items.removeAt(index);
      }
      notifyListeners();
    }
  }
  void removeFromCart(String productId) {
    // Șterge primul produs care are ID-ul dat (ignoră toppingurile)
    _items.removeWhere((item) => item.id == productId);
    notifyListeners();
  }

  void removeFromCartWithToppings(String productId, List<ToppingLineModel> toppings) {
    // Șterge doar dacă ID-ul și toppingurile se potrivesc
    _items.removeWhere((item) =>
    item.id == productId &&
        listEquals(
            item.toppings?.map((t) => t.toppingData.id).toList()?..sort(),
            toppings.map((t) => t.toppingData.id).toList()..sort()
        )
    );
    notifyListeners();
  }
  //
  // void removeFromCart(String productId, {List<ToppingLineModel>? toppings}) {
  //   _items.removeWhere((item) =>
  //   item.id == productId &&
  //       (toppings == null || listEquals(
  //           item.toppings?.map((t) => t.toppingData.id).toList()?..sort(),
  //           toppings.map((t) => t.toppingData.id).toList()..sort()
  //       ))
  //   );
  //   notifyListeners();
  // }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }

  // Funcție helper pentru a găsi un item în coș după ID și topinguri
  LineModel? findItem(String productId, List<ToppingModel> toppings) {
    return _items.firstWhereOrNull((item) =>
    item.id == productId &&
        listEquals(
            item.toppings?.map((t) => t.toppingData.id).toList()?..sort(),
            toppings.map((t) => t.id).toList()..sort()
        )
    );
  }
}

// Extensie helper pentru firstWhereOrNull
extension FirstWhereOrNullExtension<E> on Iterable<E> {
  E? firstWhereOrNull(bool Function(E) test) {
    for (E element in this) {
      if (test(element)) return element;
    }
    return null;
  }
}