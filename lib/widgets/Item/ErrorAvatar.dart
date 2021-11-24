import 'package:flutter/material.dart';
import 'package:dutstore/utils/Assets.dart';

class ErrorAvatar extends StatelessWidget {
  late final double? size;
  ErrorAvatar({required this.size});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(size! / 2),
        ),
        image: DecorationImage(
          image: AssetImage(AVATAR_PLACEHOLDER),
        ),
      ),
    );
  }
}
