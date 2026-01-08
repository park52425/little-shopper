import 'package:flutter/foundation.dart';
import '../models/product.dart';
import '../models/inventory_item.dart';

class GameProvider with ChangeNotifier {
  double _hp = 100.0;
  final double _maxHp = 100.0;
  final Map<String, InventoryItem> _inventory = {};

  double get hp => _hp;
  double get maxHp => _maxHp;
  Map<String, InventoryItem> get inventory => {..._inventory};
  
  int get inventoryCount {
    return _inventory.values.fold(0, (sum, item) => sum + item.quantity);
  }

  // 배낭에 아이템 추가
  void addToInventory(Product product, int quantity) {
    if (_inventory.containsKey(product.id)) {
      _inventory[product.id]!.quantity += quantity;
    } else {
      _inventory[product.id] = InventoryItem(product: product, quantity: quantity);
    }
    notifyListeners();
  }

  // 음식 사용 (HP 회복)
  void useFood(String productId) {
    if (_inventory.containsKey(productId)) {
      final item = _inventory[productId]!;
      
      // HP 회복량 계산 (가격에 비례, 최대 30)
      double healAmount = (item.product.price / 1000).clamp(5.0, 30.0);
      _hp = (_hp + healAmount).clamp(0.0, _maxHp);
      
      // 아이템 수량 감소
      item.quantity--;
      if (item.quantity <= 0) {
        _inventory.remove(productId);
      }
      
      notifyListeners();
    }
  }

  // 폭탄 사용
  void useBomb(String productId) {
    if (_inventory.containsKey(productId)) {
      final item = _inventory[productId]!;
      
      // 아이템 수량 감소
      item.quantity--;
      if (item.quantity <= 0) {
        _inventory.remove(productId);
      }
      
      notifyListeners();
    }
  }

  // HP 감소 (테스트용)
  void decreaseHp(double amount) {
    _hp = (_hp - amount).clamp(0.0, _maxHp);
    notifyListeners();
  }
}
