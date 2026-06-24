import 'package:flutter/foundation.dart';
import '../data/menu_item.dart';

class CartLine {
  final MenuItem item;
  final PriceOption size;
  int qty;

  CartLine({required this.item, required this.size, this.qty = 1});

  double get lineTotal => size.price * qty;

  /// Same item, different size = different line. Same item, same size = merge.
  String get key => '${item.id}::${size.label}';
}

class CartModel extends ChangeNotifier {
  final List<CartLine> _lines = [];
  bool _isDelivery = true;

  List<CartLine> get lines => List.unmodifiable(_lines);

  int get itemCount => _lines.fold(0, (sum, l) => sum + l.qty);

  double get subtotal => _lines.fold(0.0, (sum, l) => sum + l.lineTotal);

  bool get isDelivery => _isDelivery;

  double get deliveryFee => _isDelivery ? 2.00 : 0.00;

  double get total => subtotal + deliveryFee;

  void setDelivery(bool value) {
    if (_isDelivery == value) return;
    _isDelivery = value;
    notifyListeners();
  }

  void add(MenuItem item, PriceOption size, {int qty = 1}) {
    final key = '${item.id}::${size.label}';
    final match = _lines.where((l) => l.key == key);
    if (match.isNotEmpty) {
      match.first.qty += qty;
    } else {
      _lines.add(CartLine(item: item, size: size, qty: qty));
    }
    notifyListeners();
  }

  void setQty(CartLine line, int qty) {
    if (qty <= 0) {
      _lines.removeWhere((l) => l.key == line.key);
    } else {
      final match = _lines.where((l) => l.key == line.key);
      if (match.isNotEmpty) match.first.qty = qty;
    }
    notifyListeners();
  }

  void removeLine(CartLine line) {
    _lines.removeWhere((l) => l.key == line.key);
    notifyListeners();
  }

  void clear() {
    _lines.clear();
    notifyListeners();
  }
}
