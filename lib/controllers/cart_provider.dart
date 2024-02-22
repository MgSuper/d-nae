import 'package:deenae/views/shared/widgets/export_packages.dart';

class CartProvider extends ChangeNotifier {
  final _cartBox = Hive.box('cart_box');
  List<dynamic> _cart = [];

  List<dynamic> get cart => _cart;

  set cart(List<dynamic> newCart) {
    _cart = newCart;
    notifyListeners();
  }

  int _counter = 0;

  int get counter => _counter;

  void increment() {
    _counter++;
    notifyListeners();
  }

  void decrement() {
    if (_counter >= 0) {
      _counter--;
      notifyListeners();
    }
  }

  getCart() {
    final cartData = _cartBox.keys.map((key) {
      final item = _cartBox.get(key);
      print('item[sizes] ${item['sizes']}');
      return {
        'key': key,
        'id': item['id'],
        'name': item['name'],
        'category': item['category'],
        'sizes': item['sizes'],
        'imageUrl': item['imageUrl'],
        'price': item['price'],
        'qty': item['qty']
      };
    }).toList();
    _cart = cartData.reversed.toList();
  }

  Future<void> deleteCart(int key) async {
    await _cartBox.delete(key);
  }

  Future<void> createCart(Map<String, dynamic> newCart) async {
    await _cartBox.add(newCart);
  }
}
