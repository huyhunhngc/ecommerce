import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dutstore/utils/Assets.dart';
import 'package:flutter/material.dart';
import 'package:dutstore/config/AppColors.dart';

class ImageBlur extends StatelessWidget {
  final String url;

  const ImageBlur({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      //blur image
      imageBuilder: (context, imageProvider) => Stack(
        children: [
          ImageFiltered(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(image: imageProvider, fit: BoxFit.fill),
              ),
            ),
            imageFilter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
          ),
          Container(
            decoration: BoxDecoration(
              image:
                  DecorationImage(image: imageProvider, fit: BoxFit.fitHeight),
            ),
          ),
        ],
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
    );
  }
}
