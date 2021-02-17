import 'package:flutter/material.dart';

class CartItemProvider with ChangeNotifier {
  int _badge= 0;

  int get badge => _badge;

  void minusBadge() {
    _badge = _badge - 1;
    notifyListeners();
  }

  void plusBadge(){
    _badge = _badge + 1;
    notifyListeners();
  }

  void resetBadge(){
    _badge = 0;
    notifyListeners();
  }
}