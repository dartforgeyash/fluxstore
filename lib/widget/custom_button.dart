import 'package:fluxstore/constant/app_text_styles.dart';
import 'package:fluxstore/core/extensions/app_extensions.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isEnabled; // Added to control manual enable/disable
  final IconData? icon;
  final bool autoHideKeyboard;
  final Color? backgroundColor;

  const CustomButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.backgroundColor,
    this.isLoading = false,
    this.isEnabled = true, // Default to true
    this.autoHideKeyboard = true,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    // Logic: Disable if loading OR if isEnabled is false
    final bool isDisabled = !isEnabled || isLoading;

    return SizedBox(
      width: double.infinity,
      height: 44.hx,
      child: ElevatedButton(
        // Setting onPressed to null is the Flutter way to disable a button
        onPressed: isDisabled
            ? null
            : () {
                if (autoHideKeyboard) {
                  FocusScope.of(context).unfocus();
                }

                // User ka original function call karein
                onPressed?.call();
              },
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? const Color(0xFF3F51B5),
          // Style for when the button is disabled
          disabledBackgroundColor: Colors.grey.shade400,
          disabledForegroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          elevation: isDisabled ? 0 : 2,
        ),
        child: isLoading
            ? Center(
                child: AspectRatio(
                  aspectRatio: 1,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.5,
                    // backgroundColor: foregroundColor,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Color(0xFF3D7BFF),
                    ),
                  ),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != null) ...[
                    Icon(icon, size: 20.hx),
                    SizedBox(width: 8.wx),
                  ],
                  Text(
                    label,
                    style: AppTextStyles.title.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
