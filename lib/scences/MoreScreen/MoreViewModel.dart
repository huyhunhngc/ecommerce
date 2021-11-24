import 'package:dutstore/base/BaseViewModel.dart';
import 'package:dutstore/config/AppPages.dart';
import 'package:dutstore/main.dart';
import 'package:dutstore/scences/RootView/RootViewModel.dart';
import 'package:dutstore/services/Network/UserService.dart';
import 'package:dutstore/utils/Keys.dart';
import 'package:get/get.dart';
import 'package:rxdart/subjects.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MoreViewModel extends BaseViewModel {
  //Inputs
  final editProfileTrigger = PublishSubject<void>();
  final settingsTrigger = PublishSubject<void>();
  final helpsTrigger = PublishSubject<void>();
  final loggoutTrigger = PublishSubject<void>();

  //Outputs
  final imageUrl = BehaviorSubject<String>();
  final userName = BehaviorSubject<String>();
  final userEmail = BehaviorSubject<String>();
  final UserService _userService = Get.find();
  final RootViewModel _rootViewModel = Get.find();

  @override
  void onInit() {
    _loadUserProfile();
    super.onInit();
    editProfileTrigger.listen((value) {
      Get.toNamed(Routes.EDIT_PROFILE);
    });
    loggoutTrigger.listen((_) {
      logOut();
    });
    loadProfile();
  }

  void loadProfile() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    _userService.getUserProfile(pref.getString(TOKEN) ?? cookie).then((value) {
      imageUrl.add(value.profilePicture ?? "wew");
      userEmail.add(value.email ?? "wewe");
      userName.add(value.username ?? "");
    });
  }

  void logOut() {
    isLoading.add(true);
    _rootViewModel.handleLogout().then((_) {}).whenComplete(() {
      isLoading.add(false);
    });
  }

  _loadUserProfile() {}

  @override
  void onClose() {
    super.onClose();
    imageUrl.close();
    userEmail.close();
    userName.close();
    editProfileTrigger.close();
    settingsTrigger.close();
    helpsTrigger.close();
    loggoutTrigger.close();
    //Outputs
  }
}
