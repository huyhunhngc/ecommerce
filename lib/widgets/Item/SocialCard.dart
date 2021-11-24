import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:dutstore/utils/AppSize.dart';

class SocialCard extends StatelessWidget {
  SocialCard({
    Key? key,
    this.icon,
    this.onPress,
  }) : super(key: key);

  late final String? icon;
  late final Function()? onPress;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        padding: EdgeInsets.all(10),
        height: 6.0.h,
        width: 6.0.h,
        decoration: BoxDecoration(
          color: Color(0x3091a0c4),
          shape: BoxShape.circle,
        ),
        child: SvgPicture.asset(icon!),
      ),
    );
  }
}
