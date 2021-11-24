import 'package:cached_network_image/cached_network_image.dart';
import 'package:dutstore/config/AppColors.dart';
import 'package:dutstore/helper/StringHelper.dart';
import 'package:dutstore/scences/DetailProductScreen/DetailProductViewModel.dart';
import 'package:dutstore/services/Network/WebService.dart';
import 'package:dutstore/utils/AppSize.dart';
import 'package:dutstore/utils/Assets.dart';
import 'package:dutstore/utils/Keys.dart';
import 'package:dutstore/widgets/Item/ImageBlur.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductImage extends StatelessWidget {
  late final List<String>? images;

  final StringHelper helper = StringHelper();
  final DetailProductViewModel viewModel;

  ProductImage({required this.viewModel, required this.images});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30.0.h,
      child: Stack(
        alignment: Alignment.center,
        children: [
          PageView(
            onPageChanged: (index) {
              viewModel.selectedChangeImage.add(index);
            },
            controller: viewModel.pageController,
            physics: AlwaysScrollableScrollPhysics(),
            children: images!
                .map(
                  (path) => ImageBlur(
                    url: path,
                  ),
                )
                .toList(),
          ),
          Positioned(
            bottom: 15,
            child: Center(
              child: SmoothPageIndicator(
                count: images!.length,
                controller: viewModel.pageController,
                effect: WormEffect(
                  dotHeight: 1.0.h,
                  dotWidth: 1.0.h,
                  dotColor: Colors.grey.withOpacity(0.6),
                  activeDotColor: kPrimaryColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTapSelect(BuildContext context) {
    return StreamBuilder<int>(
      stream: viewModel.selectedChangeImage,
      builder: (context, snapshot) {
        return Container(
          padding: EdgeInsets.only(left: 10, top: 10),
          height: 8.0.h,
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...List.generate(
                  images!.length,
                  (index) => buildSmallProductPreview(snapshot.data!, index),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  GestureDetector buildSmallProductPreview(int currentIndex, int index) {
    return GestureDetector(
      onTap: () {
        viewModel.selectedTapImage.add(index);
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        margin: EdgeInsets.only(right: 10),
        padding: EdgeInsets.all(5),
        height: 6.0.h,
        width: 6.0.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: currentIndex == index ? primaryColor : Colors.grey[400]!,
          ),
        ),
        child: CachedNetworkImage(
          imageUrl: images![index],
          //blur image
          imageBuilder: (context, imageProvider) => Container(
            decoration: BoxDecoration(
              image:
                  DecorationImage(image: imageProvider, fit: BoxFit.fitHeight),
            ),
          ),
          placeholder: (context, url) => Center(
            child: Container(
              height: 30,
              width: 30,
              child: CircularProgressIndicator(
                strokeWidth: 3.0,
                valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
              ),
            ),
          ),
          errorWidget: (context, url, error) => Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(LAUNCH_IMAGE), fit: BoxFit.fitHeight),
            ),
          ),
        ),
      ),
    );
  }
}
