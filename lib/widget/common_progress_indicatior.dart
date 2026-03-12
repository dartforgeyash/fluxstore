import 'package:flutter/material.dart';
import 'package:fluxstore/constant/colors.dart';

class CommonProgressIndicator extends StatelessWidget {
  final bool isLoading; // Loader dikhana ya nahi
  final Widget child; // Main content
  final double strokeWidth;
  final Color loaderColor;
  final Color overlayColor;

  const CommonProgressIndicator({
    super.key,
    required this.isLoading,
    required this.child,
    this.strokeWidth = 2.4,
    this.loaderColor = AppColors.primary,
    this.overlayColor = Colors.transparent, // 🔥 Transparent background
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child, // 👈 Background content will always be visible
        if (isLoading)
          Positioned.fill(
            child: Container(
              color: overlayColor.withAlpha(10), // Light transparent effect
              child: Center(
                child: CircularProgressIndicator(
                  strokeWidth: strokeWidth,
                  valueColor: AlwaysStoppedAnimation<Color>(loaderColor),
                  backgroundColor: AppColors.kWhite,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
