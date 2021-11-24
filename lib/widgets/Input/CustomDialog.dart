import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dutstore/config/AppColors.dart';
import 'package:dutstore/utils/AppSize.dart';
import 'package:dutstore/utils/Assets.dart';

import 'CustomElevatedButton.dart';
import 'CustomText.dart';

class CustomDialog extends StatelessWidget {
  final IconData iconTitle;
  final Color? colorIcon;
  final String textTitle;
  final String textContent;
  final String? textButtonConfirm;
  final String? textButtonCancel;
  final Function()? confirmOnPress;

  const CustomDialog(
      {Key? key,
      this.confirmOnPress,
      this.iconTitle = Icons.warning_amber_sharp,
      this.textTitle = 'title',
      this.textContent = '',
      this.textButtonConfirm,
      this.textButtonCancel,
      this.colorIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.all(8.0.w),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(23.0),
      ),
      elevation: 0,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(23.0),
          color: Colors.white,
        ),
        padding: EdgeInsets.symmetric(vertical: 5.0.w, horizontal: 1.5.h),
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              iconTitle,
              color: colorIcon ?? Theme.of(context).accentColor,
              size: 70,
            ),
            SizedBox(
              height: 1.5.h,
            ),
            Center(
              child: CustomText(
                fontSize: 16.0.sp,
                colorText: greyColorTextDialog,
                fontFamily: FONT_BOLD,
                text: textTitle.tr,
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: textContent == '' ? 0 : 0.5.h,
            ),
            CustomText(
              fontSize: 13.0.sp,
              textAlign: TextAlign.center,
              colorText: greyColorTextDialog,
              text: textContent == '' ? '' : textContent.tr + ' !',
            ),
            SizedBox(
              height: textContent == '' ? 0 : 3.0.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomElevatedButton(
                  width: 100,
                  fontSize: 13.0.sp,
                  fontFamily: FONT_BOLD,
                  borderRadius: 30,
                  paddingVertical: 1.5.h,
                  paddingHorizontal: 6.0.w,
                  colorButton: Colors.greenAccent,
                  onPress: confirmOnPress,
                  text: textButtonConfirm!.tr,
                ),
                textButtonCancel != null
                    ? SizedBox(
                        width: 3.0.w,
                      )
                    : Container(),
                textButtonCancel != null
                    ? CustomElevatedButton(
                        width: 100,
                        fontSize: 13.0.sp,
                        fontFamily: FONT_BOLD,
                        paddingVertical: 1.5.h,
                        paddingHorizontal: 10.0,
                        borderRadius: 30,
                        colorButton: primaryColor,
                        onPress: () {
                          Get.back();
                        },
                        text: textButtonCancel!.tr,
                      )
                    : Container(),
              ],
            )
          ],
        ),
      ),
    );
  }
}
