import 'package:dutstore/scences/AllResultProductScreen/AllResultProductViewModel.dart';
import 'package:get/get.dart';

class AllResultProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<AllResultProductViewModel>(AllResultProductViewModel());
  }

}