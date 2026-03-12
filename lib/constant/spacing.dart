import 'package:flutter/material.dart';

class Gaps {
  static Widget vGap(double height) => SizedBox(height: height);
  static Widget hGap(double width) => SizedBox(width: width);

  static const s = SizedBox(height: 8, width: 8);
  static const m = SizedBox(height: 12, width: 12);
  static const l = SizedBox(height: 16, width: 16);
}

class Corners {
  static const r8 = Radius.circular(8);
  static const r12 = Radius.circular(12);
  static const r16 = Radius.circular(16);
}

class Insets {
  static const all16 = EdgeInsets.all(16);
  static const h16v12 = EdgeInsets.symmetric(horizontal: 16, vertical: 12);
  static const h24v14 = EdgeInsets.symmetric(horizontal: 16, vertical: 12);
}
