import 'package:dutstore/scences/MainScreen/MainViewModel.dart';
import 'package:get/get.dart';

class DetailProductBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<MainViewModel>(MainViewModel());
  }
}
