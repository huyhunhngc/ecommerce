import 'package:dutstore/config/AppColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:dutstore/utils/AppSize.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class IntroSlider extends StatelessWidget {
  final controller = PageController();
  final List<String> image = [
    "assets/images/slide/1.png",
    "assets/images/slide/2.png",
    "assets/images/slide/3.png",
    "assets/images/slide/4.png",
    "assets/images/slide/5.png",
    "assets/images/slide/6.png",
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20.0.h,
      child: Stack(
        alignment: Alignment.center,
        children: [
          PageView(
            controller: controller,
            physics: ClampingScrollPhysics(),
            children: image
                .map(
                  (path) => Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(path),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
          Positioned(
            bottom: 10,
            child: Center(
              child: SmoothPageIndicator(
                count: image.length,
                controller: controller,
                effect: WormEffect(
                  dotHeight: 0.2.h,
                  dotWidth: 1.5.h,
                  dotColor: Colors.grey,
                  activeDotColor: primaryColor,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
