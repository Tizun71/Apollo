import 'package:apollo/entity/productModel.dart';
import 'package:flutter/material.dart';

class CartItem {
  ProductModel product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});
}

class ShoppingCart {
  static List<CartItem> items = [];
  static CartItem? lastAddedItem;

  List<CartItem> getCart() {
    return items;
  }

  void addItemInCart(ProductModel p, {int quantity = 1}) {
    for (var item in items) {
      if (item.product.name == p.name) {
        item.quantity += quantity;
        lastAddedItem = null;
        return;
      }
    }

    lastAddedItem = CartItem(product: p, quantity: quantity);
    items.add(lastAddedItem!);
  }

  void undoLastAdd() {
    if (lastAddedItem != null) {
      remove(lastAddedItem!);
      lastAddedItem = null;
    }
  }

  void decreaseItemQuantity(CartItem item) {
    if (item.quantity > 1) {
      item.quantity--;
    }
  }

  void increaseItemQuantity(CartItem item) {
    item.quantity++;
  }

  void remove(CartItem item) {
    items.removeWhere((element) => element.product.name == item.product.name);
  }

  void delete() {
    items.clear();
  }

  static double getTotal() {
    return items.fold(
        0, (sum, item) => sum + item.product.price! * item.quantity);
  }

  int getTotalQuantity() {
    return items.fold(
        0, (totalQuantity, item) => totalQuantity + item.quantity);
  }
}
