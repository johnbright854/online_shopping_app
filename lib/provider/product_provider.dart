import 'package:flutter/cupertino.dart';
import 'package:online_store/model/products.dart';

class CartModel extends ChangeNotifier{
  final List<Products> _cartItems = [];
  final List<Products> _wishItems = [];

  List<Products> get cartItems => _cartItems;
  List<Products> get wishItem => _wishItems;


  void addToCart(Products product) {
    final index = _cartItems.indexWhere((item) => item.id == product.id);
    if (index != -1) {
      // Product is already in cart, so we increase its quantity
      _cartItems[index].quantity += 1;
    } else {
      // New product, set initial quantity to 1 and add to cart
      product.quantity = 1;
      _cartItems.add(product);
    }
    notifyListeners();
  }

  void removeFromCart(Products product) {
    final index = _cartItems.indexWhere((item) => item.id == product.id);
    if (index != -1 && _cartItems[index].quantity > 1) {
      // Decrease quantity if more than one
      _cartItems[index].quantity -= 1;
    } else {
      // Remove product if quantity is 1 or less
      _cartItems.removeAt(index);
    }
    notifyListeners();
  }

  int get totalItems => _cartItems.length;
  int get totalWishItems => _wishItems.length;

  // Updated total price calculation based on quantity
  double get totalPrice => _cartItems.fold(
      0.0, (total, product) => total + (product.price! * product.quantity)).roundToDouble();

  int countProductOccurrences(Products product) {
    final index = _cartItems.indexWhere((item) => item.id == product.id);
    return index != -1 ? _cartItems[index].quantity : 0;
  }
  void toggleWishlist(Products product){
    _wishItems.contains(product) ? _wishItems.remove(product) : _wishItems.add(product);
    notifyListeners();
  }

  bool inWishlist(Products product){
    print('To check wishItem $wishItem');
    return _wishItems.contains(product);
  }

}

