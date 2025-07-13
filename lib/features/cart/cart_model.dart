import 'package:flutter/material.dart';
import 'package:test_meat_gastronom/features/models/product.dart';

class CartModel extends ChangeNotifier {
  final List<Product> _products = [];

  List<Product> get products => _products;

  int get totalItems => _products.length;

  double get totalPrice => _products.fold(0, (sum, item) => sum + item.price);

  void addProduct(Product product) {
    _products.add(product);
    product.isAdded = true;
    notifyListeners();
  }

  bool isProductInCart(Product product) {
    return _products.any((p) => p.id == product.id);
  }

  void removeProduct(Product product) {
    _products.removeWhere((p) => p.id == product.id);
    product.isAdded = false;
    notifyListeners();
  }
}