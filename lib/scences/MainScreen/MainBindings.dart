import 'package:dutstore/scences/ActivitiesScreen/ActivitiesViewModel.dart';
import 'package:dutstore/scences/HomeScreen/HomeViewModel.dart';
import 'package:dutstore/scences/MainScreen/MainViewModel.dart';
import 'package:dutstore/scences/MoreScreen/MoreViewModel.dart';
import 'package:get/get.dart';

class MainBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<ActivitiesViewModel>(ActivitiesViewModel());
    Get.put<MoreViewModel>(MoreViewModel());
    Get.put<HomeViewModel>(HomeViewModel());
    Get.put<MainViewModel>(MainViewModel());
  }
}
