import 'package:dutstore/utils/Assets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dutstore/utils/AppSize.dart';

class CustomBottomNavBar extends StatelessWidget {
  late final Color? backgroundColor;
  late final Color? itemColor;
  late final List<CustomBottomNavItem>? children;
  late final Function(int)? onChange;
  late final int? currentIndex;

  CustomBottomNavBar(
      {Key? key,
      this.backgroundColor,
      this.itemColor,
      this.onChange,
      this.currentIndex,
      this.children})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 8.0.h,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            width: 0.1,
            color: Colors.grey,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: children!.map((item) {
          var color = item.color;
          var icon = item.icon;
          var label = item.label;
          int index = children!.indexOf(item);
          return InkWell(
            onTap: () {
              _changeIndex(index);
            },
            child: AnimatedContainer(
              duration: Duration(milliseconds: 200),
              width: currentIndex == index
                  ? MediaQuery.of(context).size.width / children!.length + 20
                  : 50,
              padding: EdgeInsets.only(left: 10, right: 10),
              margin: EdgeInsets.only(top: 10, bottom: 10),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: currentIndex == index
                    ? color!.withOpacity(0.2)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  SvgPicture.asset(
                    icon!,
                    height: currentIndex == index ? 22 : 20,
                    color:
                        currentIndex == index ? color : color!.withOpacity(0.8),
                  ),
                  currentIndex == index
                      ? Expanded(
                          flex: 2,
                          child: Text(
                            label ?? '',
                            overflow: TextOverflow.fade,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 10.0.sp,
                              fontFamily: FONT_REGULAR,
                              color: currentIndex == index
                                  ? color
                                  : color!.withOpacity(0.5),
                            ),
                          ),
                        )
                      : Container()
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  void _changeIndex(int index) {
    if (onChange != null) {
      onChange!(index);
    }
  }
}

class CustomBottomNavItem {
  const CustomBottomNavItem(
      {@required this.icon, @required this.label, this.color});
  final String? icon;
  final String? label;
  final Color? color;
}
