import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dutstore/utils/Assets.dart';
import 'package:dutstore/utils/AppSize.dart';

class Status extends StatelessWidget {
  final double? size;
  final bool online;

  const Status({Key? key, this.size = 10, required this.online})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(right: 2.0),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: online ? Colors.green : Colors.grey),
            height: size,
            width: size,
          ),
          Text(
            online ? 'Online' : 'Offline',
            style: TextStyle(
              fontFamily: FONT_REGULAR,
              fontSize: 9.0.sp,
            ),
          ),
        ],
      ),
    );
  }
}
