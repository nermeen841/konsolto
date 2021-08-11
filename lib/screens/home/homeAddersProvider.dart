import 'package:flutter/material.dart';

class HomeAddressProvider extends ChangeNotifier {
  bool isAddNewAdress = false;
  updataisAddNewAdress() {
    isAddNewAdress = !isAddNewAdress;
    notifyListeners();
  }
}

class CartProductProvider extends ChangeNotifier {
  bool isRemovedfromCart = false;
  updateCartRemoveProduct() {
    isRemovedfromCart = !isRemovedfromCart;
    notifyListeners();
  }
}

class CartItemCount extends ChangeNotifier {
  int count = 0;
  double totalPrice = 0;
  incremertConut({double price}) {
    count++;
    this.totalPrice += price;

    notifyListeners();
  }

  getintData({int cont, double price}) {
    this.count = cont;
    this.totalPrice = price;
  }

  decremertConut({double price}) {
    if (count > 0) {
      count--;
    }
    if (totalPrice > 0) {
      this.totalPrice -= price;
    }
    notifyListeners();
  }
}
