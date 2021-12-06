import 'package:a_plants_life/data/Product.dart';
import 'package:flutter/cupertino.dart';

class Cart extends ChangeNotifier {
  List<Product> products = [];

  addProduct(Product product) {
    products.add(product);
    notifyListeners();
  }

  deleteProduct(Product product) {
    products.remove(product);
    notifyListeners();
  }
}
