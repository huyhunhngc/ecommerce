import 'package:dutstore/config/AppColors.dart';
import 'package:dutstore/config/AppPages.dart';
import 'package:dutstore/scences/LoginScreen/Component/LoginForm.dart';
import 'package:dutstore/utils/Assets.dart';
import 'package:dutstore/widgets/Item/SocialCard.dart';
import 'package:dutstore/widgets/Loading/CustomLoadingIndicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dutstore/utils/AppSize.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'LoginViewModel.dart';

class LoginScreen extends StatelessWidget {
  final LoginViewModel _viewModel = Get.find();
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: kPrimaryColor,
      ),
    );
    return GetBuilder<LoginViewModel>(
      initState: (state) {
        _viewModel.isLoading.listen(
          (isLoading) {
            isLoading
                ? LoadingIndicator.show(context)
                : LoadingIndicator.hide();
          },
        );
      },
      builder: (_) {
        return Scaffold(
          body: SafeArea(
            child: SizedBox(
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 1.0.sfh),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 4.0.h),
                      Container(
                        height: 180,
                        child: Image(
                          image: AssetImage(LAUNCH_IMAGE),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(25.0),
                        child: LoginForm(),
                      ),
                      SizedBox(height: 4.0.h),
                      builNoAccountText(context),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(40, 0, 40, 5),
                        child: Row(
                          children: [
                            Expanded(
                              child: Divider(
                                thickness: 1.5,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 8.0, right: 8.0),
                              child: Text(
                                'OR',
                                style: TextStyle(
                                    fontFamily: FONT_LIGHT, fontSize: 12.0.sp),
                              ),
                            ),
                            Expanded(
                                child: Divider(
                              thickness: 1.5,
                            )),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SocialCard(
                            icon: "assets/icons/google-icon.svg",
                            onPress: () {},
                          ),
                          SocialCard(
                            icon: "assets/icons/facebook-2.svg",
                            onPress: () {},
                          ),
                          SocialCard(
                            icon: "assets/icons/twitter.svg",
                            onPress: () {},
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget builNoAccountText(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don’t have an account? ",
          style: TextStyle(fontSize: 11.0.sp, fontFamily: FONT_SEMI),
        ),
        GestureDetector(
          onTap: () {
            Get.toNamed(Routes.REGISTER);
          },
          child: Text(
            "Sign Up",
            style: TextStyle(
                fontSize: 11.0.sp, color: kPrimaryColor, fontFamily: FONT_BOLD),
          ),
        ),
      ],
    );
  }
}
