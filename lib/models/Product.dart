import 'package:flutter/cupertino.dart';

class Product {
  final String id;
  final String name;
  late final String? categorical;
  late final int? price;
  late final int? priceDiscount;
  late final double? rating;
  late final int? quantity;
  late final String? description;
  late final String? brandName;
  late final String? productImage;
  late final String? createBy;
  late final String? thumbnail;
  late final List<String>? images;
  late final List<Color>? colors;
  late final String? createAt;
  late final String? updateAt;

  Product(
      {required this.id,
      this.images,
      this.colors,
      required this.name,
      this.categorical,
      this.price,
      this.priceDiscount,
      this.quantity,
      this.description,
      this.brandName,
      this.productImage,
      this.thumbnail,
      this.createBy});

  factory Product.fromJson(Map<String, dynamic> json) {
    List<String> imageData =
        (json['productPictures'] as List).map((e) => e.toString()).toList();
    final discountPercent = json['discount'] as int;
    final price = json['price'] as int;

    return Product(
      images: imageData,
      id: json['id'],
      name: json['name'],
      categorical: json['categorical'],
      price: price,
      priceDiscount: price - price*discountPercent~/100,
      quantity: json['quantity'],
      description: json['description'],
      brandName: json['brandName'],
      productImage: json['productImage'],
      thumbnail: json['thumbnail'],
      createBy: json['createBy'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['categorical'] = this.categorical;
    data['price'] = this.price;
    data['priceDiscount'] = this.priceDiscount;
    data['quantity'] = this.quantity;
    data['description'] = this.description;
    data['brandName'] = this.brandName;
    data['productImage'] = this.productImage;
    data['thumbnail'] = this.thumbnail;
    data['createBy'] = this.createBy;
    return data;
  }

  int get realPrice {
    return priceDiscount ?? price ?? 0;
  }

  int get disCountPercent {
    double percent = 0;
    double price = (this.price ?? 0).toDouble();
    double priceDiscount = (this.priceDiscount ?? 0).toDouble();
    try {
      percent = (price - priceDiscount) / price;
    } on IntegerDivisionByZeroException {
      return 0;
    }
    return (percent * 100).toInt();
  }
}
