import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

class CustomSurffixIcon extends StatelessWidget {
  const CustomSurffixIcon({
    Key? key,
    required this.svgIcon,
  }) : super(key: key);

  final String svgIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 20, 5, 20),
      child: SvgPicture.asset(
        svgIcon,
      ),
    );
  }
}
