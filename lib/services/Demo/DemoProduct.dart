import 'dart:ui';

import 'package:dutstore/models/Cart.dart';
import 'package:dutstore/models/Product.dart';
import 'package:flutter/material.dart';

List<Product> demoProducts = [
  Product(
    id: '1',
    images: [
      "assets/images/ip12-1.jpg",
      "assets/images/ip12-2.jpg",
      "assets/images/ip12-3.jpg",
      "assets/images/ip12-4.jpg",
      "assets/images/ip12-4.jpg",
      "assets/images/ip12-4.jpg",
      "assets/images/ip12-4.jpg",
      "assets/images/ip12-4.jpg",
      "assets/images/ip12-4.jpg",
      "assets/images/ip12-4.jpg",
      "assets/images/ip12-4.jpg",
      "assets/images/ip12-4.jpg",
      "assets/images/ip12-4.jpg",
      "assets/images/ip12-4.jpg",
      "assets/images/ip12-4.jpg",
      "assets/images/ip12-4.jpg",
    ],
    colors: [
      Color(0xFFF6625E),
      Color(0xFF836DB8),
      Color(0xFFDECB9C),
      Colors.white,
    ],
    name: "Wireless Controller for PS4™",
    price: 6400000,
    priceDiscount: 5000000,
    description: description,
    quantity: 4,
  ),
  Product(
    id: '2',
    images: [
      "assets/images/ip12-3.jpg",
    ],
    colors: [
      Color(0xFFF6625E),
      Color(0xFF836DB8),
      Color(0xFFDECB9C),
      Colors.white,
    ],
    name: "Nike Sport White - Man Pant",
    price: 50,
    description: description,
    quantity: 3,
  ),
  Product(
    id: '3',
    images: [
      "assets/images/ip12-1.jpg",
    ],
    colors: [
      Color(0xFFF6625E),
      Color(0xFF836DB8),
      Color(0xFFDECB9C),
      Colors.white,
    ],
    name: "Gloves XC Omega - Polygon",
    price: 36,
    priceDiscount: 30,
    description: description,
    quantity: 1,
  ),
  Product(
    id: '4',
    images: [
      "assets/images/ip12-2.jpg",
      "assets/images/ip12-2.jpg",
      "assets/images/ip12-2.jpg",
      "assets/images/ip12-2.jpg",
    ],
    colors: [
      Color(0xFFF6625E),
      Color(0xFF836DB8),
      Color(0xFFDECB9C),
      Colors.white,
    ],
    name: "Logitech Head",
    price: 20,
    description: description,
    quantity: 2,
  ),
];

const String description =
    "Wireless Controller for PS4™ gives you what you want in your gaming from over precision control your games to sharing, want in your gaming from over precision control your games to sharing";
List<CartItem> listProduct = [

];
Cart demoCarts = Cart(listItem: listProduct, selectedItem: []);
