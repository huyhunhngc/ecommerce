import 'dart:async';

import 'package:dutstore/services/TranslationService.dart';
import 'package:dutstore/widgets/Loading/JumpingDots.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dutstore/utils/AppSize.dart';
import 'package:dutstore/scences/RootView/RootViewModel.dart';
import 'package:dutstore/utils/Assets.dart';

import 'RootViewModel.dart';

class RootView extends StatelessWidget {
  final RootViewModel _viewModel = Get.find();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(
          builder: (context, orientation) {
            SizeUtils().inIt(context, constraints, orientation);
            return GetBuilder<RootViewModel>(
              initState: _initState(context),
              builder: (_) {
                return Scaffold(
                  body: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 200,
                          child: Image(
                            image: AssetImage(LAUNCH_IMAGE),
                          ),
                        ),
                        JumpingDots()
                      ],
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  _initState(BuildContext context) {
    _viewModel.nextScreen.listen(
      (value) {
        Timer(Duration(seconds: 1), () {
          TranslationService()
              .changeLocale(_viewModel.selectedLocale.valueWrapper!.value!);
          Get.offAllNamed(value);
        });
      },
    );
    _viewModel.appError.listen(
      (value) {
        Get.dialog(
            CupertinoAlertDialog(
              title: Text('error'.tr),
              content: Text(value.message),
              actions: [
                CupertinoDialogAction(
                  child: Text('OK'.tr),
                  isDefaultAction: true,
                  onPressed: () => Get.back(),
                )
              ],
            ),
            barrierDismissible: false);
      },
    );
  }
}
