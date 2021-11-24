import 'package:dutstore/scences/SettingScreen/SettingViewModel.dart';
import 'package:get/get.dart';

class SettingBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<SettingViewModel>(SettingViewModel());
  }
}
