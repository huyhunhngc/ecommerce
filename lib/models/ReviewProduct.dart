class ReviewProduct {
  final String id;
  late final String? customerId;
  late final String? description;
  late final String? productId;
  late final int? numberStar;
  late final String? createdAt;
  late final String? updateAt;

  ReviewProduct(
      {required this.id,
      this.customerId,
      this.description,
      this.productId,
      this.numberStar,
      this.createdAt,
      this.updateAt});

  factory ReviewProduct.fromJson(Map<String, dynamic> json) {
    return ReviewProduct(
      id: json['id'],
      customerId: json['customerId'],
      description: json['description'],
      productId: json['productId'],
      numberStar: json['numberStar'],
      createdAt: json['createdAt'],
      updateAt: json['updateAt'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['customerId'] = this.customerId;
    data['description'] = this.description;
    data['productId'] = this.productId;
    data['numberStar'] = this.numberStar;
    data['createdAt'] = this.createdAt;
    data['updateAt'] = this.updateAt;
    return data;
  }
}
