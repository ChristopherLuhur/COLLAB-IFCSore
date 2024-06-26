import 'package:flutter/material.dart';
import 'package:travel_apps/models/cart.dart';

class Carts with ChangeNotifier {
  List<Cart> carts = [];
  List<Cart> history = [];

  int get cartCount {
    return carts.length;
  }

  void addCart(Cart cart) {
    notifyListeners();
    carts.add(cart);
  }

  int get totalPrice {
    int total = 0;
    if (carts.isEmpty) {
      return total;
    }

    for (var cart in carts) {
      total += cart.travel.hargaTiket;
    }

    return total;
  }

  void removeCart(Cart cart) {
    notifyListeners();
    carts.remove(cart);
  }

  void moveItemsToHistory() {
    history.addAll(carts);
    carts.clear();
    notifyListeners();
  }
}
