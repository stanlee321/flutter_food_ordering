import 'package:flutter/material.dart';
import 'package:flutter_food_ordering/model/food_model.dart';

class Cart extends ChangeNotifier {
  List<CartModel> items = [];
  List<CartModel> get cartItems => items;

  void addItem(CartModel cartModel) {
    for (CartModel cart in cartItems) {
      if (cartModel.food.name == cart.food.name) {
        cartItems[cartItems.indexOf(cart)].quantity++;
        notifyListeners();
        return;
      }
    }
    items.add(cartModel);
    notifyListeners();
  }

  void clearCart() {
    items.clear();
    notifyListeners();
  }

  void removeItem(CartModel cartModel) {
    if (cartItems[cartItems.indexOf(cartModel)].quantity <= 1) {
      return;
    }
    cartItems[cartItems.indexOf(cartModel)].quantity--;
    notifyListeners();
  }

  void increaseItem(CartModel cartModel) {
    cartItems[cartItems.indexOf(cartModel)].quantity++;
    notifyListeners();
  }

  void removeAllInList(Food food) {
    cartItems.removeWhere((f) {
      return f.food.name == food.name;
    });
    notifyListeners();
  }
}

class CartModel {
  Food food;
  int quantity;

  CartModel({this.food, this.quantity});
}
