import 'package:dutstore/config/AppColors.dart';
import 'package:dutstore/scences/RegisterScreen/RegisterViewModel.dart';
import 'package:dutstore/utils/Assets.dart';
import 'package:dutstore/widgets/Input/CustomElevatedButton.dart';
import 'package:dutstore/widgets/Input/CustomSurffixIcon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class RegisterForm extends StatelessWidget {
  final RegisterViewModel _viewModel = Get.find();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StreamBuilder<String?>(
          stream: _viewModel.userPhoneEmailErrorMessage,
          builder: (context, snapshot) {
            return TextFormField(
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) {
                _viewModel.userPhoneEmailTrigger.add(value);
              },
              decoration: InputDecoration(
                labelStyle: TextStyle(fontFamily: FONT_REGULAR),
                border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                errorText: snapshot.data,
                labelText: "Email",
                hintText: "Enter your email",
                suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
              ),
            );
          },
        ),
        Container(
          height: 20,
        ),
        StreamBuilder<String?>(
          stream: _viewModel.passwordErrorMessage,
          builder: (context, snapshot) {
            return TextField(
              obscureText: true,
              onChanged: (value) {
                _viewModel.passwordTrigger.add(value);
              },
              decoration: InputDecoration(
                labelStyle: TextStyle(fontFamily: FONT_REGULAR),
                border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                hintText: "PASSWORD".tr,
                labelText: "PASSWORD".tr,
                errorText: snapshot.data,
                suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
              ),
            );
          },
        ),
        Container(
          height: 20,
        ),
        StreamBuilder<String?>(
          stream: _viewModel.passwordErrorMessage,
          builder: (context, snapshot) {
            return TextField(
              obscureText: true,
              onChanged: (value) {
                _viewModel.passwordTrigger.add(value);
              },
              decoration: InputDecoration(
                labelStyle: TextStyle(fontFamily: FONT_REGULAR),
                border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                hintText: "NAME".tr,
                labelText: "NAME".tr,
                errorText: snapshot.data,
                suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
              ),
            );
          },
        ),
        Container(
          height: 20,
        ),
        StreamBuilder<String?>(
          stream: _viewModel.passwordErrorMessage,
          builder: (context, snapshot) {
            return TextField(
              obscureText: true,
              onChanged: (value) {
                _viewModel.passwordTrigger.add(value);
              },
              decoration: InputDecoration(
                labelStyle: TextStyle(fontFamily: FONT_REGULAR),
                border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                hintText: "EMAIL".tr,
                labelText: "EMAIL".tr,
                errorText: snapshot.data,
                suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/.svg"),
              ),
            );
          },
        ),
        Container(
          height: 20,
        ),
        StreamBuilder<bool>(
          stream: _viewModel.loginButtonEnabled,
          builder: (context, snapshot) {
            return CustomElevatedButton(
              borderColor: kPrimaryColor,
              fontWeightText: FontWeight.bold,
              height: 60,
              colorText: Colors.white,
              colorButton: kPrimaryColor,
              onPress: snapshot.data == true
                  ? () {
                //FocusScope.of(context).requestFocus(FocusNode());
                _viewModel.loginButtonTrigger.add(null);
              }
                  : null,
              text: 'register'.tr,
            );
          },
        ),
      ],
    );
  }
}
