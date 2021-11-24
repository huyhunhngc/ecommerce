import 'package:dutstore/config/AppColors.dart';
import 'package:dutstore/utils/Assets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    Key? key,
    @required this.text,
    @required this.icon,
    this.press,
  }) : super(key: key);

  final String? text, icon;
  final VoidCallback? press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: TextButton(
        style: TextButton.styleFrom(
            textStyle: TextStyle(fontFamily: FONT_REGULAR, color: primaryColor),
            padding: EdgeInsets.all(20),
            side: BorderSide(width: 0.2),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            backgroundColor: Colors.white),
        onPressed: press,
        child: Row(
          children: [
            SvgPicture.asset(
              icon!,
              color: kPrimaryColor,
              width: 22,
            ),
            SizedBox(width: 20),
            Expanded(
              child: Text(
                text!,
                style:
                    TextStyle(fontFamily: FONT_BOLD, color: Colors.grey[800]),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
