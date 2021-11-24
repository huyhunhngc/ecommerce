class OrderProduct {
  late final int totalAmount;
  late final List<OrderItem> orderList;
  OrderProduct({required this.totalAmount, required this.orderList});
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalAmount'] = this.totalAmount;
    data['productDetail'] = this.orderList;
    return data;
  }
}

class OrderItem {
  late final String productId;
}
