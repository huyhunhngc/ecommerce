import 'package:dutstore/base/BaseViewModel.dart';
import 'package:dutstore/models/Cart.dart';
import 'package:dutstore/models/DeliveryOption.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tuple/tuple.dart';

class PlaceOrderViewModel extends BaseViewModel {
  //Inputs
  final deliveryType = BehaviorSubject<int>.seeded(0);
  final deliveryFee = BehaviorSubject<int>.seeded(0);
  final totalMRP = BehaviorSubject<int>.seeded(0);
  final discount = BehaviorSubject<int>.seeded(0);
  final orderTotal = BehaviorSubject<int>.seeded(0);
  final userLocation = BehaviorSubject<LatLng>();
  final userFullName = BehaviorSubject<String>();
  final userPhoneNumber = BehaviorSubject<String>();
  //Outputs
  final totalAmount = BehaviorSubject<int>.seeded(0);
  final deliveryTime = BehaviorSubject<int>();
  final userAddress = BehaviorSubject<String>();

  Tuple2<int, List<CartItem>> orderProduct = Get.arguments['orderProduct'];
  List<String> deliveryTypes = () {
    return DeliveryType.values.map((e) => e.displayValue()).toList();
  }();
  List<String> deliveryTypesAsset = () {
    return DeliveryType.values.map((e) => e.assetValues()).toList();
  }();

  @override
  void onInit() {
    super.onInit();
    deliveryType.listen((index) {
      deliveryFee.add(DeliveryType.values[index].deliveryFee());
      deliveryTime.add(DeliveryType.values[index].hourDelivery());
      refeshTotalAmount();
    });
    totalMRP.add(getTotalMRP());
    orderTotal.add(orderProduct.item1);
    discount.add(getTotalMRP() - orderProduct.item1);
    userFullName.add("Tran Van Khanh");
    userPhoneNumber.add("0326787895");
    refeshTotalAmount();
  }

  refeshTotalAmount() {
    totalAmount.add(orderProduct.item1 + (deliveryFee.value ?? 0));
  }

  @override
  void onClose() {
    super.onClose();
    totalAmount.close();
    deliveryType.close();
    deliveryFee.close();
    totalMRP.close();
    discount.close();
    orderTotal.close();
    userAddress.close();
    userLocation.close();
    userFullName.close();
    userPhoneNumber.close();
  }
}

extension _PlaceOrder on PlaceOrderViewModel {
  int getTotalMRP() {
    int total = 0;
    for (CartItem item in orderProduct.item2) {
      total += (item.product?.price ?? 0) * (item.numOfItem ?? 0);
    }
    return total;
  }
}
