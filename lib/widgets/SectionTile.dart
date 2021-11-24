import 'package:dutstore/config/AppColors.dart';
import 'package:dutstore/utils/AppSize.dart';
import 'package:dutstore/utils/Assets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle(
      {Key? key, @required this.title, this.press, this.seeMore = true})
      : super(key: key);

  final String? title;
  final GestureTapCallback? press;
  final bool? seeMore;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title!,
          style: TextStyle(
              fontSize: 15.0.sp, color: kSecondaryColor, fontFamily: FONT_BOLD),
        ),
        Visibility(
          visible: seeMore!,
          child: GestureDetector(
            onTap: press,
            child: Row(
              children: [
                Text(
                  press != null ? "See More" : "",
                  style:
                      TextStyle(color: kPrimaryColor, fontFamily: FONT_REGULAR),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 3.0),
                  child: Icon(
                    Icons.arrow_forward_ios,
                    size: 10.0.sp,
                    color: kPrimaryColor,
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
