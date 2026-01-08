import 'package:flutter/foundation.dart';

class CouponProvider with ChangeNotifier {
  bool _hasBombCoupon = false;

  bool get hasBombCoupon => _hasBombCoupon;

  void addBombCoupon() {
    _hasBombCoupon = true;
    notifyListeners();
  }

  void useBombCoupon() {
    _hasBombCoupon = false;
    notifyListeners();
  }
}
