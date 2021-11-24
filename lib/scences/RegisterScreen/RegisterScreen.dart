import 'package:dutstore/config/AppColors.dart';
import 'package:dutstore/scences/LoginScreen/Component/LoginForm.dart';
import 'package:dutstore/scences/RegisterScreen/Component/RegisterForm.dart';
import 'package:dutstore/scences/RegisterScreen/RegisterViewModel.dart';
import 'package:dutstore/utils/AppSize.dart';
import 'package:dutstore/utils/Assets.dart';
import 'package:dutstore/widgets/Item/SocialCard.dart';
import 'package:dutstore/widgets/Loading/CustomLoadingIndicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class RegisterScreen extends StatelessWidget {
  final RegisterViewModel _viewModel = Get.find();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: kPrimaryColor,
      ),
    );
    return GetBuilder<RegisterViewModel>(
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
                        child: RegisterForm(),
                      ),
                      SizedBox(height: 4.0.h),
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
}
