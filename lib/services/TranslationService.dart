import 'dart:ui';

import 'package:get/get.dart';
import 'package:dutstore/utils/Localize/LocalizeEN.dart';
import 'package:dutstore/utils/Localize/LocalizeJP.dart';
import 'package:dutstore/utils/Localize/LocalizeVN.dart';

class TranslationService extends Translations {
  // Default locale
  static final locale = Get.deviceLocale;

  // fallbackLocale saves the day when the locale gets in trouble
  static final fallbackLocale = Locale('en', 'US');

  //Supported languages
  // Needs to be order with locales
  static final langs = ['English', '日本', 'Việt Nam'];

  // Supported locales
  // Needs to be same order with langs
  static final locales = [
    Locale('en', 'US'),
    Locale('ja', 'JP'),
    Locale('vi', 'VN'),
  ];

  //Keys and their translation
  //Translation are separated maps in `lang` file
  @override
  Map<String, Map<String, String>> get keys =>
      {'en_US': EN, 'ja_JP': JP, 'vi_VN': VN};

  //Gets locale from language and updates the locale
  void changeLocale(String lang) {
    final locale = getLocaleFromLanguage(lang);
    Get.updateLocale(locale!);
  }

  Locale? getLocaleFromLanguage(String lang) {
    for (int i = 0; i < langs.length; i++) {
      if (lang == langs[i]) return locales[i];
    }
    return Get.locale;
  }
}
