import 'package:ar_visionary_explora/screens/main/cart/models/Product.dart';

class ShoppingCart {
  List<Product> _items = [];

  void addItem(Product product) {
    _items.add(product);
  }

  void removeItem(Product product) {
    _items.remove(product);
  }

  double calculateTotal() {
    return _items.fold(0, (total, product) => total + product.price);
  }

  List<Product> get items => _items;
}
