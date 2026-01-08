import 'product.dart';

class InventoryItem {
  final Product product;
  int quantity;

  InventoryItem({
    required this.product,
    this.quantity = 1,
  });
}
