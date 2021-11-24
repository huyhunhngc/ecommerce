import 'package:cached_network_image/cached_network_image.dart';
import 'package:dutstore/config/AppColors.dart';
import 'package:dutstore/utils/Assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rxdart/rxdart.dart';

class ProfilePic extends StatelessWidget {
  final BehaviorSubject<String> imageUrlStream;
  final bool isEditable;
  const ProfilePic({
    Key? key,
    required this.imageUrlStream,
    this.isEditable = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 115,
      width: 120,
      child: Stack(
        clipBehavior: Clip.none,
        fit: StackFit.expand,
        children: [
          StreamBuilder<String>(
              stream: imageUrlStream,
              builder: (context, snapshot) {
                return CachedNetworkImage(
                  imageUrl: snapshot.data ?? '',
                  imageBuilder: (context, imageProvider) {
                    return Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: CircleAvatar(
                        backgroundImage: imageProvider,
                      ),
                    );
                  },
                  placeholder: (context, placeholder) {
                    return Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: CircularProgressIndicator(),
                    );
                  },
                  errorWidget: (context, placeholder, _) {
                    return Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: AssetImage(AVATAR_PLACEHOLDER),
                            fit: BoxFit.fill),
                      ),
                    );
                  },
                );
              }),
          Visibility(
            visible: isEditable,
            child: Positioned(
              right: -16,
              bottom: 0,
              child: SizedBox(
                height: 46,
                width: 46,
                child: TextButton(
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                      side: BorderSide(color: Colors.white),
                    ),
                    backgroundColor: Color(0xFFF5F6F9),
                  ),
                  onPressed: () {},
                  child: SvgPicture.asset("assets/icons/Camera Icon.svg"),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
