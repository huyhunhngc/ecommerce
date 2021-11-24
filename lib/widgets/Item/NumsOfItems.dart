import 'package:dutstore/config/AppColors.dart';
import 'package:dutstore/utils/Assets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NumOfItems extends StatelessWidget {
  final double size;
  late final int num;
  late final Function()? onTapIncrease;
  late final Function()? onTapDecrease;

  NumOfItems(
      {Key? key,
      required this.num,
      this.onTapIncrease,
      this.onTapDecrease,
      this.size = 40})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      height: size,
      width: size * 3.2,
      child: Row(
        children: [
          InkWell(
            onTap: onTapDecrease,
            child: Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                  color: onTapDecrease != null
                      ? kPrimaryColor.withAlpha(200)
                      : Colors.grey,
                  shape: BoxShape.circle),
              child: Icon(
                Icons.remove,
                color: Colors.white,
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                '$num',
                style: TextStyle(fontFamily: FONT_REGULAR, fontSize: 14),
              ),
            ),
          ),
          InkWell(
            onTap: onTapIncrease,
            child: Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                  color: onTapIncrease != null
                      ? kPrimaryColor.withAlpha(200)
                      : Colors.grey,
                  shape: BoxShape.circle),
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
