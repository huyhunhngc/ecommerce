import 'package:flutter/cupertino.dart';

class SizeUtils {
  static MediaQueryData? _mediaQueryData;
  static double? _width;
  static double? _height;
  static Orientation? _orientation;
  static double? _safeAreaHorizontal;
  static double? _safeAreaVertical;

  inIt(BuildContext context, BoxConstraints constraints,
      Orientation orientation) {
    _orientation = orientation;
    _mediaQueryData = MediaQuery.of(context);
    if (orientation == Orientation.portrait) {
      _width = _mediaQueryData!.size.width;
      _height = _mediaQueryData!.size.height;
    } else {
      _width = _mediaQueryData!.size.height;
      _height = _mediaQueryData!.size.width;
    }

    _safeAreaHorizontal =
        _mediaQueryData!.padding.left + _mediaQueryData!.padding.right;
    _safeAreaVertical =
        _mediaQueryData!.padding.top + _mediaQueryData!.padding.bottom;
  }

  static height(var i) {
    return _height! * i / 100;
  }

  static width(var i) {
    return _width! * i / 100;
  }

  static sp(var i) {
    return _width! / 100 * (i / 3);
  }

  static safeHorizon() {
    return _safeAreaHorizontal;
  }

  static safeVertical() {
    return _safeAreaVertical;
  }

  static get orientation => _orientation;
}

extension SizerExt on double {
  double get h => SizeUtils.height(this);
  double get w => SizeUtils.width(this);
  double get sp => SizeUtils.sp(this);
  double get sfh => SizeUtils.safeHorizon();
  double get sfv => SizeUtils.safeVertical();
}
