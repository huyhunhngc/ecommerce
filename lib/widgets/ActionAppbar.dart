import 'package:dutstore/config/AppColors.dart';
import 'package:dutstore/config/AppPages.dart';
import 'package:dutstore/utils/Assets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:dutstore/utils/AppSize.dart';
import 'package:get/get.dart';

class ActionCart extends StatelessWidget {
  final int? count;

  const ActionCart({Key? key, this.count = 0}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.toNamed(Routes.CART),
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.all(8),
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0x4091a0c4),
            ),
            child: Center(
              child: SvgPicture.asset(
                ICONS_CART,
                height: 20,
                color: primaryColor,
              ),
            ),
          ),
          Positioned(
            right: 7,
            top: 7,
            child: Container(
              constraints: BoxConstraints(maxHeight: 21, minWidth: 21),
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.red,
                border: Border.all(color: Colors.white),
              ),
              child: Center(
                child: Text(
                  count.toString(),
                  style: TextStyle(
                      fontSize: 8.0.sp,
                      color: Colors.white,
                      fontFamily: FONT_REGULAR),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
