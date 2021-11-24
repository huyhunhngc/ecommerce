import 'package:dutstore/scences/PlaceOrderScreen/PlaceOrderViewModel.dart';
import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';

class PlaceOrderBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<PlaceOrderViewModel>(PlaceOrderViewModel());
  }
}
