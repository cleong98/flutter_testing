import 'package:flutter/material.dart';
import 'package:flutter_testing/pages/shopping_cart/model/cart_item.dart';
import 'package:collection/collection.dart';

class CartController extends ValueNotifier<List<BilItem>> {
  CartController(this._bilList): super(_bilList);
  final List<BilItem> _bilList;

  void addCart(CartItem item) {
    final BilItem? bilItem = _bilList.firstWhereOrNull((bilItem) => bilItem.id == item.id);
    if (bilItem == null) {
      _bilList.add(BilItem.fromCartItem(item));
    } else {
      final bilItemIndex = _bilList.indexWhere((bilItem) => item.id == bilItem.id);
      _bilList[bilItemIndex].quantity = _bilList[bilItemIndex].quantity + 1;
    }
    notifyListeners();
  }

  void removeCart(CartItem item) {
    final BilItem? bilItem = _bilList.firstWhereOrNull((bilItem) => bilItem.id == item.id);
    if (bilItem == null) {
      return;
    }
    if (bilItem.quantity == 1) {
      _bilList.removeWhere((BilItem bilItem) => item.id == bilItem.id);
    } else {
      final bilItemIndex = _bilList.indexWhere((bilItem) => item.id == bilItem.id);
      _bilList[bilItemIndex].quantity = _bilList[bilItemIndex].quantity - 1;
    }
    notifyListeners();
  }
  
  double get bilTotalPrice {
    return _bilList.fold(0, (previous, current) => previous + ( current.price * current.quantity));
  }

  List<BilItem> get bilList {
     _bilList.sort((previous, current) => previous.id.compareTo(current.id));
     return _bilList;
  }

  int get totalQuantity {
    return _bilList.fold(0, (previousValue, currentItem) => previousValue + currentItem.quantity);
  }

  int bilListQuantity(CartItem item) {
    final bilItem = _bilList.firstWhereOrNull((cartItem) => cartItem.id  == item.id);
    if (bilItem == null) {
      return 0;
    }
    return bilItem.quantity;
  }

}
