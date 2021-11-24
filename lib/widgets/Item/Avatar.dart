import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:dutstore/helper/StringHelper.dart';
import 'package:dutstore/widgets/Item/ErrorAvatar.dart';

class Avatar extends StatelessWidget {
  final StringHelper helper = StringHelper();
  late final String? avatarURL;
  late final double? size;
  Avatar({required this.avatarURL, this.size = 40});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      child: CachedNetworkImage(
        imageUrl: helper.getURLavatar(avatarURL!),
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(size! / 2),
            ),
            image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
          ),
        ),
        placeholder: (context, url) => ErrorAvatar(size: size),
        errorWidget: (context, url, error) => ErrorAvatar(size: size),
      ),
    );
  }
}
