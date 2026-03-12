import 'package:flutter/material.dart';
import 'package:fluxstore/constant/app_text_styles.dart';
import 'package:fluxstore/core/extensions/app_extensions.dart';
import 'package:fluxstore/widget/app_text.dart';

class AppButton extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isSecondary;
  final Widget? icon;
  final double? width;
  final bool autoHideKeyboard;

  const AppButton({
    super.key,
    required this.title,
    this.autoHideKeyboard = true,
    this.onPressed,
    this.isLoading = false,
    this.isSecondary = false,
    this.icon,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    final backgroundColor = isSecondary
        ? const Color(0xFFF5F5F5)
        : const Color(0xFF3D7BFF);

    final foregroundColor = isSecondary ? Colors.black : Colors.white;

    return SizedBox(
      width: width ?? double.infinity,
      height: 44.hx,
      child: ElevatedButton(
        onPressed: (isLoading || onPressed == null)
            ? null
            : () {
                if (autoHideKeyboard) {
                  FocusScope.of(context).unfocus();
                }

                onPressed?.call();
              },
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          disabledBackgroundColor: backgroundColor.withValues(alpha: 0.6),
          elevation: 0,
          padding: EdgeInsets.symmetric(horizontal: 16.wx),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8), // Thoda soft corners
          ),
        ),
        child: isLoading
            ? Center(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      // backgroundColor: foregroundColor,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        backgroundColor,
                      ),
                    ),
                  ),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (icon != null) ...[icon!, SizedBox(width: 8.wx)],
                  AppText(
                    title,
                    style: AppTextStyles.title.copyWith(
                      color: foregroundColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
