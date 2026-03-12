import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension SizeExtension on num {
  // Height Or Width
  double get hx => h;

  double get wx => w;

  // Font size
  double get spx => sp;

  // Radius
  double get rx => r;

  // Spacing
  Widget get verticalSpace => SizedBox(height: h);

  Widget get horizontalSpace => SizedBox(width: w);
}

extension PaddingExtension on num {

  /// All sides
  EdgeInsets get allPadding => EdgeInsets.all(toDouble());

  /// Vertical + Horizontal
  EdgeInsets vh(double horizontal) {
    return EdgeInsets.symmetric(
      vertical: toDouble(),
      horizontal: horizontal,
    );
  }

  /// Only vertical
  EdgeInsets get verticalPadding =>
      EdgeInsets.symmetric(vertical: toDouble());

  /// Only horizontal
  EdgeInsets get horizontalPadding =>
      EdgeInsets.symmetric(horizontal: toDouble());

  /// 🔥 NEW: Only top
  EdgeInsets get topPadding =>
      EdgeInsets.only(top: toDouble());

  /// 🔥 NEW: Only bottom
  EdgeInsets get bottomPadding =>
      EdgeInsets.only(bottom: toDouble());

  /// 🔥 NEW: Only left
  EdgeInsets get leftPadding =>
      EdgeInsets.only(left: toDouble());

  /// 🔥 NEW: Only right
  EdgeInsets get rightPadding =>
      EdgeInsets.only(right: toDouble());

  /// 🔥 NEW: Custom combination (most useful)
  EdgeInsets onlyPadding({
    double top = 0,
    double bottom = 0,
    double left = 0,
    double right = 0,
  }) {
    return EdgeInsets.only(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
    );
  }
}