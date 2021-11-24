import 'package:dutstore/config/AppColors.dart';
import 'package:dutstore/utils/Assets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';

class SalePanel extends StatelessWidget {
  final int percentDiscount;
  const SalePanel({Key? key, required this.percentDiscount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          child: CustomPaint(
            painter: SalePainter(),
            size: Size(25, 35),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 3.0, vertical: 5.0),
              child: Center(
                child: Column(
                  children: [
                    Text(
                      "$percentDiscount%",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: FONT_BOLD,
                          color: primaryColor,
                          fontSize: 10.0),
                    ),
                    Text(
                      "sale".tr,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: FONT_BOLD,
                          color: Colors.white,
                          fontSize: 10.0),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class SalePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Colors.yellow[700]!;
    Path path = Path()
      ..moveTo(0, 0)
      ..lineTo(0, size.height)
      ..lineTo(size.width * 0.125, size.height - 2)
      ..lineTo(size.width * 0.25, size.height)
      ..lineTo(size.width * 0.375, size.height - 2)
      ..lineTo(size.width * 0.5, size.height)
      ..lineTo(size.width * 0.625, size.height - 2)
      ..lineTo(size.width * 0.75, size.height)
      ..lineTo(size.width * 0.875, size.height - 2)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width, 0)
      ..lineTo(0, 0);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
