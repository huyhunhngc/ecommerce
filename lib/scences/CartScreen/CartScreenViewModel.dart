import 'package:dutstore/base/BaseViewModel.dart';
import 'package:dutstore/config/AppPages.dart';
import 'package:dutstore/models/Cart.dart';
import 'package:dutstore/services/Demo/DemoProduct.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tuple/tuple.dart';

class CartViewModel extends BaseViewModel {
  //inputs
  final checkoutButtonTrigger = PublishSubject<void>();
  final totalAmount = BehaviorSubject<int>.seeded(0);
  final selectedCartItemList = BehaviorSubject<List<int>>.seeded([]);
  final listCartItem = BehaviorSubject<List<CartItem>>.seeded([]);
  final deleteItemTrigger = BehaviorSubject<int>();

  //outputs
  final orderProduct = BehaviorSubject<Tuple2<int, List<CartItem>>>();
  @override
  void onInit() {
    checkoutButtonTrigger.listen((_) {
      if (orderProduct.value?.item2.isNotEmpty ?? false) {
        Get.toNamed(Routes.PLACE_ORDER,
            arguments: {"orderProduct": orderProduct.value});
      }
    });
    deleteItemTrigger.listen((value) {
      deleteItemOnCart(value);
    });
    updateCart();
    super.onInit();
  }

  @override
  void onClose() {
    checkoutButtonTrigger.close();
    orderProduct.close();
    totalAmount.close();
    selectedCartItemList.close();
    listCartItem.close();
    deleteItemTrigger.close();
    super.onClose();
  }

  void updateCart() {
    totalAmount.add(updateTotalAmount());
    listCartItem.add(demoCarts.listItem ?? []);
    var listCart = listCartItem.value ?? [];
    List<CartItem> orderProductList =
        selectedCartItemList.value!.map((index) => listCart[index]).toList();
    orderProduct.add(Tuple2(totalAmount.value!, orderProductList));
  }

  void updateCartItem(int index, int updateValue) {
    listCartItem.value?[index].numOfItem = updateValue;
    updateCart();
  }

  void addItemToOrder(int index) {
    List<int> currentList = selectedCartItemList.value ?? [];
    currentList.add(index);
    selectedCartItemList.add(currentList);
    updateCart();
  }

  void removeItemFromOrder(int index) {
    List<int> currentList = selectedCartItemList.value ?? [];
    currentList.removeWhere((element) => element == index);
    selectedCartItemList.add(currentList);
    updateCart();
  }

  void deleteItemOnCart(int index) {
    demoCarts.listItem!.removeAt(index);
    updateCart();
  }

  bool checkItemIsSelected(int index) {
    if (selectedCartItemList.value?.contains(index) ?? false) return true;
    return false;
  }
}

extension _CartViewModel on CartViewModel {
  int updateTotalAmount() {
    int total = 0;
    final currentList = listCartItem.value ?? [];
    final currentSelectIndex = selectedCartItemList.value ?? [];
    List<CartItem> selectedItem = currentList
        .where((element) =>
            currentSelectIndex.contains(currentList.indexOf(element)))
        .toList();
    for (CartItem item in selectedItem) {
      total += (item.product?.realPrice ?? 0) * (item.numOfItem ?? 0);
    }
    return total;
  }
}
