import 'package:dutstore/services/Demo/DemoProduct.dart';

import 'Product.dart';

class Cart {
  final List<CartItem>? listItem;
  final List<int>? selectedItem;

  Cart({this.listItem, this.selectedItem});
}

class CartItem {
  final Product? product;
   int? numOfItem;

  CartItem({required this.product, this.numOfItem = 0});
}
