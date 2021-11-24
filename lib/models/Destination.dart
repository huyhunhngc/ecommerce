import 'package:flutter/cupertino.dart';

class Destination {
  Destination(this.title, this.icon, this.screen);

  Destination.optionMore({this.title, this.icon});

  final String? title;
  final String? icon;
  late final Widget screen;
}
