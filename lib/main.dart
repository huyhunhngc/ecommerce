import 'package:dutstore/config/AppColors.dart';
import 'package:dutstore/config/AppTheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'config/AppPages.dart';
import 'models/UserProfile.dart';
import 'services/TranslationService.dart';

late String cookie;
late UserProfile profile;
bool isLogged = false;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      enableLog: true,
      theme: lightTheme,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      locale: TranslationService.locale,
      fallbackLocale: TranslationService.fallbackLocale,
      translations: TranslationService(),
    );
  }
}
