import 'package:dutstore/scences/LoginScreen/LoginViewModel.dart';
import 'package:dutstore/scences/RegisterScreen/RegisterViewModel.dart';
import 'package:dutstore/scences/RootView/RootViewModel.dart';
import 'package:dutstore/services/Network/UserService.dart';
import 'package:dutstore/services/Network/WebService.dart';
import 'package:get/get.dart';

class RootBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<WebService>(WebService(), permanent: true);
    Get.put<UserService>(UserService(), permanent: true);
    Get.put<RootViewModel>(RootViewModel(), permanent: true);
    Get.put<LoginViewModel>(LoginViewModel(), permanent: true);
    Get.put<RegisterViewModel>(RegisterViewModel());
  }
}
