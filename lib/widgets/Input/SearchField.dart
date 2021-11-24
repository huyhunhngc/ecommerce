import 'package:dutstore/config/AppColors.dart';
import 'package:dutstore/utils/Assets.dart';
import 'package:flutter/cupertino.dart';
import 'package:dutstore/utils/AppSize.dart';
import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  final Function()? onPress;
  SearchField({
    Key? key,
    this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        padding: EdgeInsets.only(left: 10),
        height: 10.0.w,
        decoration: BoxDecoration(
          color: Color(0x4091a0c4),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Icon(
              Icons.search,
              color: primaryColor,
            ),
            Container(
              width: 5,
            ),
            Text(
              'Search',
              style: TextStyle(
                  color: primaryColor,
                  fontFamily: FONT_REGULAR,
                  fontSize: 10.0.sp),
            ),
          ],
        ),
      ),
    );
  }
}
