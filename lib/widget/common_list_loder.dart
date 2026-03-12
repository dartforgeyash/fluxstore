import 'package:flutter/material.dart';
import 'package:fluxstore/constant/colors.dart';

class CommonListLoader extends StatelessWidget {
  final EdgeInsetsGeometry padding;
  final Color color;
  final double strokeWidth;

  const CommonListLoader({
    super.key,
    this.padding = const EdgeInsets.all(16.0),
    this.color = AppColors.primary, // default primary color
    this.strokeWidth = 2.4,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      alignment: Alignment.center,
      child: CircularProgressIndicator(
        strokeWidth: strokeWidth,
        valueColor: AlwaysStoppedAnimation<Color>(color),
        backgroundColor: color.withAlpha(20),
      ),
    );
  }
}
