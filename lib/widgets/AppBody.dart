import 'package:dutstore/utils/Assets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppBody extends StatelessWidget {
  AppBody({
    required this.child,
    this.shouldAvoidKeyboard = false,
    this.hasBackgroundImage = true,
    this.paddingLeft = 20,
    this.paddingRight = 20,
    this.scrollController,
  });

  final Widget child;
  final bool shouldAvoidKeyboard;
  final bool hasBackgroundImage;
  final double paddingLeft;
  final double paddingRight;
  ScrollController? scrollController;

  @override
  Widget build(BuildContext context) {
    Widget coverPadding() {
      return Padding(
        padding: EdgeInsets.only(
            left: paddingLeft,
            right: paddingRight,
            bottom: shouldAvoidKeyboard ? Get.mediaQuery.viewInsets.bottom : 0),
        child: child,
      );
    }

    Widget coverScrollView() {
      return SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.only(
                left: paddingLeft,
                right: paddingRight,
                bottom:
                    shouldAvoidKeyboard ? Get.mediaQuery.viewInsets.bottom : 0),
            child: child,
          ),
          controller: scrollController);
    }

    Widget childWidget(BuildContext context) {
      if (hasBackgroundImage) {
        return Stack(children: [
          Container(
              height: Get.mediaQuery.size.height - 200,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(AVATAR_PLACEHOLDER),
                      fit: BoxFit.cover))),
          shouldAvoidKeyboard ? coverScrollView() : coverPadding()
        ]);
      } else {
        return shouldAvoidKeyboard ? coverScrollView() : coverPadding();
      }
    }

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: childWidget(context),
    );
  }
}
