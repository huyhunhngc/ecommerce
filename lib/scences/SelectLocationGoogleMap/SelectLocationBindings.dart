import 'package:dutstore/scences/SelectLocationGoogleMap/SelectLocationViewModel.dart';
import 'package:dutstore/services/Network/MapService.dart';
import 'package:get/get.dart';

class SelectLocationBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<GoogleMapService>(GoogleMapService());
    Get.put<SelectLocationViewModel>(SelectLocationViewModel());
  }
}
