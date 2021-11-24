import 'package:dutstore/base/BaseViewModel.dart';
import 'package:dutstore/scences/RootView/RootViewModel.dart';
import 'package:dutstore/services/Network/UserService.dart';
import 'package:dutstore/utils/Keys.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginViewModel extends BaseViewModel {
  // Inputs
  final userPhoneEmailTrigger = BehaviorSubject<String?>();
  final passwordTrigger = BehaviorSubject<String?>();
  final loginButtonTrigger = BehaviorSubject<void>();

  //Outputs
  final userPhoneEmailErrorMessage = BehaviorSubject<String?>();
  final passwordErrorMessage = BehaviorSubject<String?>();
  final loginButtonEnabled = BehaviorSubject.seeded(false);

  final UserService _userService = Get.find();
  final RootViewModel _rootViewModel = Get.find();

  @override
  void onInit() {
    super.onInit();

    userPhoneEmailTrigger.listen((value) {
      userPhoneEmailValidation();
    });

    passwordTrigger.listen((value) {
      passwordValidation();
    });

    CombineLatestStream([userPhoneEmailTrigger, passwordTrigger], (_) {
      return userPhoneEmailValidation() && passwordValidation();
    }).listen((value) {
      loginButtonEnabled.add(value);
    });

    loginButtonTrigger.throttleTime(Duration(milliseconds: 500)).listen((_) {
      isLoading.add(true);
      _userService
          .signInWithEmailPassword(
              userPhoneEmailTrigger.value!, passwordTrigger.value!)
          .then((success) {
        if (success) {
          saveSessionLogin();
          _rootViewModel.showNeededScreen();
        }
      }).catchError((error, _) {
        _rootViewModel.showError(error);
      }).whenComplete(() {
        isLoading.add(false);
      });
    });
  }

  @override
  void onClose() {
    userPhoneEmailTrigger.close();
    passwordTrigger.close();
    userPhoneEmailErrorMessage.close();
    passwordErrorMessage.close();
    loginButtonEnabled.close();
    loginButtonTrigger.close();
    super.onClose();
  }
}

// Privates
extension _LoginViewModel on LoginViewModel {
  bool userPhoneEmailValidation() {
    String? _userPhoneEmail = userPhoneEmailTrigger.value;
    if (_userPhoneEmail == null || _userPhoneEmail.length > 0) {
      userPhoneEmailErrorMessage.add(null);
      return true;
    } else {
      userPhoneEmailErrorMessage.add('FIELD_NULL_ERROR_MESSAGE'.tr);
      return false;
    }
  }

  bool passwordValidation() {
    String? _password = passwordTrigger.value;
    if (_password == null || _password.length > 5) {
      passwordErrorMessage.add(null);
      return true;
    } else if (_password.length < 6) {
      passwordErrorMessage.add('LENGTH_PASSWORD_ERROR_MESSAGE');
      return false;
    } else {
      passwordErrorMessage.add('INVALID_PASSWORD_ERROR_MESSAGE'.tr);
      return false;
    }
  }

  Future saveSessionLogin() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool(IS_LOGGED, true);
  }

  void storageTokenUserData(String token) async {
    final storageToken = FlutterSecureStorage();
    await storageToken.write(key: TOKEN, value: token);
  }
}
