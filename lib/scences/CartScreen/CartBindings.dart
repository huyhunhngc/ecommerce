import 'package:get/get.dart';

import 'CartScreenViewModel.dart';

class CartBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<CartViewModel>(CartViewModel());
  }
}
