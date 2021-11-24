import 'dart:convert';

import 'package:dutstore/main.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dutstore/base/BaseViewModel.dart';
import 'package:dutstore/config/AppPages.dart';
import 'package:dutstore/models/UserProfile.dart';
import 'package:dutstore/services/TranslationService.dart';
import 'package:dutstore/utils/Failure.dart';
import 'package:dutstore/utils/Keys.dart';

class RootViewModel extends BaseViewModel {
  final storage = FlutterSecureStorage();

  final selectedLocale = BehaviorSubject<String?>();

  @override
  void onInit() {
    super.onInit();
    showNeededScreen();
    init();
  }

  @override
  void onClose() {
    selectedLocale.close();
    super.onClose();
  }
}

extension RootViewModelX on RootViewModel {
  void init() async {
    updateLocale();
    getTokenUser().then((value) => cookie = value);
  }

  Future<String> getTokenUser() async {
    return await storage.read(key: TOKEN) ?? '';
  }

  Future<UserProfile> getUserData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return UserProfile.fromJson(jsonDecode(pref.getString('userData')!));
  }

  Future<void> clearTokenUser() async {
    await storage.delete(key: TOKEN);
  }

  Future<void> clearSharedPref() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.clear();
  }

  void showNeededScreen() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    //token = await getTokenUser();
    if (pref.getBool(IS_LOGGED) == null) {
      nextScreen.add(Routes.LOGIN);
    } else {
      nextScreen.add(Routes.MAIN);
    }
  }

  void showError(Failure error) {
    appError.add(error);
  }

  Future<void> handleLogout() async {
    await clearSharedPref();
    await clearTokenUser();

    nextScreen.add(Routes.LOGIN);
  }

  Future<String?> getSelectedLocale() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.getString(SELECTED_LANG) != null) {
      return pref.getString(SELECTED_LANG);
    } else {
      return TranslationService.langs[0];
    }
  }

  void updateLocale() async {
    await getSelectedLocale().then((value) {
      return selectedLocale.add(value!);
    });
  }
}
