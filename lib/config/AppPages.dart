import 'package:dutstore/scences/AllResultProductScreen/AllResultProductBindings.dart';
import 'package:dutstore/scences/AllResultProductScreen/AllResultProductScreen.dart';
import 'package:dutstore/scences/CartScreen/CartBindings.dart';
import 'package:dutstore/scences/CartScreen/CartScreen.dart';
import 'package:dutstore/scences/EditProfileScreen/EditProfileBindings.dart';
import 'package:dutstore/scences/EditProfileScreen/EditProfileScreen.dart';
import 'package:dutstore/scences/PlaceOrderScreen/PlaceOrderBindings.dart';
import 'package:dutstore/scences/PlaceOrderScreen/PlaceOrderScreen.dart';
import 'package:dutstore/scences/RegisterScreen/RegisterBindings.dart';
import 'package:dutstore/scences/RegisterScreen/RegisterScreen.dart';
import 'package:dutstore/scences/SearchScreen/SearchBindings.dart';
import 'package:dutstore/scences/SearchScreen/SearchScreen.dart';
import 'package:dutstore/scences/SelectLocationGoogleMap/SelectLocationBindings.dart';
import 'package:dutstore/scences/SelectLocationGoogleMap/SelectLocationScreen.dart';
import 'package:dutstore/scences/SettingScreen/SettingBindings.dart';
import 'package:dutstore/scences/SettingScreen/SettingScreen.dart';
import 'package:get/get.dart';
import 'package:dutstore/scences/LoginScreen/LoginBindings.dart';
import 'package:dutstore/scences/LoginScreen/LoginScreen.dart';
import 'package:dutstore/scences/MainScreen/MainBindings.dart';
import 'package:dutstore/scences/MainScreen/MainScreen.dart';
import 'package:dutstore/scences/RootView/RootBindings.dart';
import 'package:dutstore/scences/RootView/RootView.dart';

part 'AppRoutes.dart';

class AppPages {
  static const INITIAL = Routes.ROOT;

  static final routes = [
    GetPage(
      name: Routes.ROOT,
      page: () => RootView(),
      binding: RootBindings(),
    ),
    GetPage(
      name: Routes.LOGIN,
      page: () => LoginScreen(),
      binding: LoginBindings(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: Routes.MAIN,
      page: () => MainScreen(),
      binding: MainBindings(),
      transition: Transition.noTransition,
    ),
    // GetPage(
    GetPage(
      name: Routes.SEARCH,
      page: () => SearchScreen(),
      binding: SearchBindings(),
      transition: Transition.fade,
    ),

    GetPage(
      name: Routes.CART,
      page: () => CartScreen(),
      binding: CartBindings(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: Routes.PLACE_ORDER,
      page: () => PlaceOrderScreen(),
      binding: PlaceOrderBindings(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: Routes.GOOGLE_MAP_PICK,
      page: () => SelectLocationScreen(),
      binding: SelectLocationBindings(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: Routes.SETTING,
      page: () => SettingScreen(),
      binding: SettingBindings(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: Routes.EDIT_PROFILE,
      page: () => EditProfileScreen(),
      binding: EditProfileBindings(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: Routes.ALL_RESULT,
      page: () => AllResultProductScreen(),
      binding: AllResultProductBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: Routes.REGISTER,
      page: () => RegisterScreen(),
      binding: RegisterBindings(),
      transition: Transition.rightToLeft,
    ),
    // GetPage(
    //   name: Routes.FORGOT_PASSWORD,
    //   page: () => ForgotPasswordScreen(),
    //   binding: ForgotPasswordBindings(),
    //   transition: Transition.rightToLeft,
    // ),
  ];
}
