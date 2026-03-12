import 'package:fluxstore/constant/app_text_styles.dart';
import 'package:fluxstore/constant/colors.dart';
import 'package:fluxstore/core/extensions/app_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flash/flash.dart';

class AppSnackBar {
  static void success({
    required String message,
    required BuildContext context,
  }) {
    if (message.isEmpty || message == "") {
      return;
    }

    _show(
      context: context,
      message: message,
      colors: const [Color(0xFF6366F1), Color(0xFF4F46E5)],
      icon: Icons.check_rounded,
    );
  }

  static void error({required String message, required BuildContext context}) {
    if (message.isEmpty || message == "") {
      return;
    }
    _show(
      context: context,
      message: message,
      colors: const [Color(0xFFF97373), Color(0xFFDC2626)],
      icon: Icons.error_outline_rounded,
    );
  }

  static void info({required String message, required BuildContext context}) {
    _show(
      context: context,
      message: message,
      colors: const [Color(0xFF60A5FA), Color(0xFF2563EB)],
      icon: Icons.info_outline_rounded,
    );
  }

  static void _show({
    required String message,
    required List<Color> colors,
    required BuildContext context,
    required IconData icon,
  }) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          elevation: 0,
          margin: const EdgeInsets.only(bottom: 12, left: 12, right: 12),
          padding: EdgeInsets.zero,
          duration: const Duration(seconds: 2),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          content: ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 32),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: colors,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.16),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    backgroundColor: AppColors.kWhite,
                    minRadius: 5,
                    child: Icon(icon, size: 16, color: AppColors.primary),
                  ),
                  const SizedBox(width: 6),
                  Flexible(
                    child: Text(
                      message,
                      style: AppTextStyles.success.copyWith(
                        color: Colors.white,
                        fontSize: 13.spx,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
  }
}

class FlashHelper {
  // Common method for all snackbars
  static Future<T?> showSnackBar<T>(
    BuildContext context, {
    required String message,
    String? title,
    Color? backgroundColor,
    IconData? icon,
    Duration duration = const Duration(seconds: 3),
    bool isError = false,
  }) {
    return showFlash<T>(
      context: context,
      duration: duration,
      builder: (context, controller) {
        return FlashBar(
          useSafeArea: true,
          padding: EdgeInsets.all(8),
          controller: controller,
          position: FlashPosition.top, // Upar se dikhega (Sleek look)
          behavior: FlashBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          margin: const EdgeInsets.all(10),
          backgroundColor:
              backgroundColor ?? (isError ? Colors.redAccent : Colors.black87),
          icon: Icon(
            icon ?? (isError ? Icons.error : Icons.check_circle),
            color: Colors.white,
          ),
          title: title != null
              ? Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                )
              : null,
          content: Text(
            message,
            style: const TextStyle(color: Colors.white, fontSize: 13),
          ),
          dismissDirections: const [FlashDismissDirection.startToEnd],
        );
      },
    );
  }
}

// Ease of use ke liye Extension
extension FlashContext on BuildContext {
  void showSuccess(String message, {String? title}) {
    if (message.isEmpty || message == "") {
      return;
    }
    FlashHelper.showSnackBar(
      this,
      message: message,
      title: title,
      backgroundColor: Colors.green,
    );
  }

  void showError(String message, {String? title}) {
    if (message.isEmpty || message == "") {
      return;
    }
    FlashHelper.showSnackBar(
      this,
      message: message,
      title: title,
      isError: true,
    );
  }

  void showInfo(String message, {String? title}) {
    if (message.isEmpty || message == "") {
      return;
    }
    FlashHelper.showSnackBar(
      this,
      message: message,
      title: title,
      backgroundColor: Colors.blueAccent,
      icon: Icons.info,
    );
  }
}


// Success Message dikhane ke liye:
// context.showSuccess("Data save ho gaya!");


// Error Message dikhane ke liye:
// context.showError("Kuch galat hua!");


// Info Message dikhane ke liye:
// context.showInfo("Yeh ek important note hai.");

