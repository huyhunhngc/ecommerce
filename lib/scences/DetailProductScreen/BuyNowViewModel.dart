import 'package:dutstore/base/BaseViewModel.dart';
import 'package:dutstore/config/AppPages.dart';
import 'package:dutstore/models/Cart.dart';
import 'package:dutstore/models/Product.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tuple/tuple.dart';

class BuyNowViewModel extends BaseViewModel {
  //Inputs
  final checkoutButtonTrigger = PublishSubject<void>();
  final selectedIndexOption = BehaviorSubject<int>();
  final changeNumsOfItemTrigger = BehaviorSubject<int>.seeded(1);
  final product = BehaviorSubject<Product>();

  //Outputs
  final orderProduct = BehaviorSubject<Tuple2<int, List<CartItem>>>();
  final outputOptions = BehaviorSubject<int>();
  final price = BehaviorSubject.seeded(0);

  List<String> values = [
    '64GB-8GB',
    '128GB-8GB',
    '32GB-3GB',
    '64GB-4GB',
    '128GB-8GB',
    '512GB-16GB'
  ];

  @override
  void onInit() {
    checkoutButtonTrigger.listen((value) {
      preparePlaceOrder();
      Get.toNamed(Routes.PLACE_ORDER,
          arguments: {"orderProduct": orderProduct.value});
    });
    super.onInit();
  }

  void changeItemsCount(bool isIncrease) {
    final recent = changeNumsOfItemTrigger.value ?? 1;
    if (isIncrease) {
      changeNumsOfItemTrigger.add(recent + 1);
    } else {
      if (recent == 1) return;
      changeNumsOfItemTrigger.add(recent - 1);
    }
  }

  void preparePlaceOrder() {
    orderProduct.add(Tuple2(
        (changeNumsOfItemTrigger.value ?? 1) * (price.value ?? 1), [
      CartItem(
          product: product.value, numOfItem: changeNumsOfItemTrigger.value ?? 1)
    ]));
  }

  @override
  void onClose() {
    super.onClose();
    checkoutButtonTrigger.close();
    orderProduct.close();
    outputOptions.close();
    selectedIndexOption.close();
    changeNumsOfItemTrigger.close();
    price.close();
    product.close();
  }
}
