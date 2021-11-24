import 'package:dutstore/base/BaseViewModel.dart';
import 'package:dutstore/scences/MoreScreen/MoreViewModel.dart';
import 'package:dutstore/services/Network/UserService.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

class EditProfileViewModel extends BaseViewModel {
  final UserService _userService = Get.find();
  final MoreViewModel _moreViewModel = Get.find();
  final usernameTrigger = BehaviorSubject<String?>();
  final emailTrigger = BehaviorSubject<String?>();
  final phoneTrigger = BehaviorSubject<String?>();
  final updateTrigger = BehaviorSubject<void>();

  @override
  void onInit() {
    super.onInit();
    updateTrigger.listen((value) {
      _moreViewModel.userName.add(usernameTrigger.value ?? "khanhtv");
      _moreViewModel.userEmail.add(emailTrigger.value ?? "khanhtv@gmail.com");
      isLoading.add(true);
      _userService.updateInformation(
          usernameTrigger.value ?? "khanhtv",
          emailTrigger.value ?? "khanhtv@gmail.com",
          phoneTrigger.value ?? "03234543545").whenComplete(() {
            Get.back();
            isLoading.add(false);
          });
    });
  }

  @override
  void onClose() {
    phoneTrigger.close();
    emailTrigger.close();
    usernameTrigger.close();
    // TODO: implement onClose
    super.onClose();
  }
}
