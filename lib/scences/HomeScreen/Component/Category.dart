import 'package:dutstore/utils/Assets.dart';
import 'package:flutter/cupertino.dart';
import 'package:dutstore/utils/AppSize.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Categories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> categories = [
      {"icon": ICONS_PHONE, "text": "Smart phone"},
      {"icon": ICONS_TABLET, "text": "Tablet"},
      {"icon": ICONS_LAPTOP, "text": "Laptop"},
      {"icon": ICONS_WATCH, "text": "Watch"},
      {"icon": ICONS_HEADPHONE, "text": "Accessories"},
    ];
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(
          categories.length,
          (index) => CategoryCard(
            icon: categories[index]["icon"],
            text: categories[index]["text"],
            press: () {},
          ),
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key? key,
    @required this.icon,
    @required this.text,
    @required this.press,
  }) : super(key: key);

  final String? icon, text;
  final GestureTapCallback? press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: SizedBox(
        width: 50,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: Color(0xFFFFECDF),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Image(
                image: AssetImage(icon!),
              ),
            ),
            SizedBox(height: 5),
            Text(
              text!,
              textAlign: TextAlign.center,
              style: TextStyle(fontFamily: FONT_LIGHT, fontSize: 10.0.sp),
            )
          ],
        ),
      ),
    );
  }
}
