import 'package:flutter/material.dart';
import 'package:flutter_food_ordering/model/food_model.dart';

class CartModel extends ChangeNotifier {
  List<Food> items = [];

  List<Food> get cartItems => items;

  void addItem(Food food) {
    items.add(food);
    notifyListeners();
  }

  void clearCart() {
    items.clear();
    notifyListeners();
  }

  void removeItem(Food food) {
    items.removeWhere((f) {
      return food.name == f.name;
    });
    notifyListeners();
  }
}
