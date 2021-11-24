import 'package:dutstore/config/AppColors.dart';
import 'package:dutstore/utils/Assets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dutstore/utils/AppSize.dart';

class CustomElevatedButton extends StatelessWidget {
  final Function()? onPress;
  final String? text;
  final bool autofocus;
  final String fontFamily;
  final Color? colorButton;
  final Color? colorText;
  final Color? borderColor;
  final double? width;
  final FontWeight? fontWeightText;
  final double borderRadius;
  final double? borderSize;
  final double? height;
  final double marginHorizon;
  final double marginVerti;
  final double paddingHorizontal;
  final double paddingVertical;
  final double? fontSize;
  final bool isUpperCaseText;
  final Widget? leading;

  const CustomElevatedButton(
      {Key? key,
      this.onPress,
      this.fontFamily = FONT_BOLD,
      this.text,
      this.autofocus = false,
      this.colorButton,
      this.colorText,
      this.isUpperCaseText = false,
      this.fontSize,
      this.borderColor,
      this.marginHorizon = 0,
      this.marginVerti = 0,
      this.paddingHorizontal = 0,
      this.paddingVertical = 0,
      this.borderRadius = 30.0,
      this.borderSize, //3
      this.width,
      this.height,
      this.fontWeightText,
      this.leading})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: marginHorizon, vertical: marginVerti),
      width: width ?? MediaQuery.of(context).size.width,
      height: height,
      child: ElevatedButton(
        autofocus: autofocus,
        style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: paddingHorizontal, vertical: paddingVertical),
            primary: colorButton ?? kPrimaryColor,
            side:
                borderSize != null && borderColor != null ? BorderSide(width: borderSize!, color: borderColor!) : null,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            shadowColor: Colors.transparent),
        onPressed: onPress,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            leading ?? Container(),
            Flexible(
              child: Text(
                isUpperCaseText == true ? text!.toUpperCase() : text!,
                textAlign: TextAlign.center,
                overflow: TextOverflow.visible,
                maxLines: 1,
                style: TextStyle(
                    fontFamily: fontFamily,
                    color: colorText,
                    fontWeight: fontWeightText,
                    fontSize: fontSize ?? 15.0.sp),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
