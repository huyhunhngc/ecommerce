import 'package:dutstore/scences/EditProfileScreen/EditProfileViewModel.dart';
import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';

class EditProfileBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<EditProfileViewModel>(EditProfileViewModel());
  }
}
