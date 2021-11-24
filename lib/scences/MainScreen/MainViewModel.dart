import 'package:dutstore/base/BaseViewModel.dart';
import 'package:dutstore/models/Cart.dart';
import 'package:dutstore/models/Product.dart';
import 'package:dutstore/services/Demo/DemoProduct.dart';
import 'package:dutstore/widgets/Input/CustomDialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

class MainViewModel extends BaseViewModel {
  //Inputs
  final bottomTabBarTrigger = BehaviorSubject<int>();
  ScrollController scrollController = ScrollController(keepScrollOffset: true);
  final position = BehaviorSubject.seeded(0.0);
  final addToCartTrigger = BehaviorSubject<Product>();
  final listCartItem = BehaviorSubject<List<CartItem>>.seeded([]);
  //Outputs
  final selectedIndex = BehaviorSubject.seeded(0);
  final bottomOffset = BehaviorSubject.seeded(0.0);
  final cartOrderCount = BehaviorSubject.seeded(demoCarts.listItem!.length);

  @override
  void onInit() {
    super.onInit();

    bottomTabBarTrigger.listen((index) {
      selectedIndex.add(index);
    });
    addToCartTrigger.listen((value) {
      demoCarts.listItem!.add(CartItem(product: value, numOfItem: 1));
      cartOrderCount.add(demoCarts.listItem!.length);
      showDialogAddToCart('Add success');
    });
  }

  void loadCart() {
    listCartItem.add(demoCarts.listItem ?? []);
  }

  @override
  void onClose() {
    bottomOffset.close();
    position.close();
    bottomTabBarTrigger.close();
    selectedIndex.close();
    listCartItem.close();
    super.onClose();
  }

  void showDialogAddToCart(String title) {
    Get.dialog(CustomDialog(
      textTitle: title,
      iconTitle: Icons.done_rounded,
      colorIcon: Colors.green,
      textButtonConfirm: 'OK',
      confirmOnPress: () {
        Get.back();
      },
    ));
  }
}
