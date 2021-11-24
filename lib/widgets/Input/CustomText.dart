import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final colorText;
  final fontFamily;
  final Color backgroundText;
  final double radius;
  final double paddingTop;
  final double paddingBottom;
  final double paddingLeft;
  final double paddingRight;
  final double fontSize;
  final TextAlign textAlign;

  const CustomText(
      {Key? key,
      this.paddingTop = 0,
      this.paddingBottom = 0,
      this.paddingLeft = 0,
      this.paddingRight = 0,
      this.fontSize = 15,
      this.text = 'text',
      this.textAlign = TextAlign.left,
      this.colorText = Colors.black,
      this.fontFamily = 'OpenSansRegular',
      this.backgroundText = Colors.transparent,
      this.radius = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: paddingTop,
          bottom: paddingBottom,
          left: paddingLeft,
          right: paddingRight),
      decoration: BoxDecoration(
        color: backgroundText,
        borderRadius: BorderRadius.all(Radius.circular(radius)),
      ),
      child: Text(
        text,
        textAlign: textAlign,
        style: TextStyle(
            color: colorText, fontFamily: fontFamily, fontSize: fontSize),
      ),
    );
  }
}
