import 'package:dutstore/scences/PlaceOrderScreen/ChangeAddressScreen/ChangeAddressViewModel.dart';
import 'package:get/get.dart';

class ChangeAddressBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<ChangeAddressViewModel>(ChangeAddressViewModel());
  }
}
