import 'package:flutter/widgets.dart';

extension Responsive on BuildContext {
  Size get screenSize => MediaQuery.of(this).size;
  double get screenWidth => screenSize.width;
  double get screenHeight => screenSize.height;

  /// width percentage: e.g. 5.wp == 5% of screen width
  double wp(double percent) => screenWidth * percent / 100;

  /// height percentage
  double hp(double percent) => screenHeight * percent / 100;
}
