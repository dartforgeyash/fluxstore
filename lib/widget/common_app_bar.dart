import 'package:fluxstore/constant/app_text_styles.dart';
import 'package:fluxstore/constant/colors.dart';
import 'package:fluxstore/widget/app_text.dart';
import 'package:flutter/material.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final TextStyle? titleStyle;
  final List<Widget>? actions;
  final Widget? leading;
  final bool centerTitle;
  final Color? backgroundColor;

  const CommonAppBar({
    super.key,
    required this.title,
    this.titleStyle,
    this.actions,
    this.leading,
    this.centerTitle = false,
    this.backgroundColor,
  });

  static const double _customLeadingWidth = 64;

  @override
  Widget build(BuildContext context) {
    final bool hasCustomLeading = leading != null;

    return AppBar(
      // Let Flutter show the default back-arrow when no custom widget is given.
      automaticallyImplyLeading: !hasCustomLeading,

      // Prevent AppBar from pushing the custom widget into a tiny box.
      leadingWidth: hasCustomLeading ? _customLeadingWidth : 56,

      // Wrap the custom widget in a Center + left padding so it sits at the
      // same visual baseline as the default icon, matching the screenshot.
      leading: hasCustomLeading
          ? Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Center(child: leading),
            )
          : null,

      forceMaterialTransparency: true,
      title: AppText(
        title,
        style:
            titleStyle ??
            AppTextStyles.heading3.copyWith(color: AppColors.kBlack),
      ),
      centerTitle: centerTitle,
      backgroundColor: backgroundColor ?? AppColors.kWhite,
      actions: actions,
      elevation: 0,

      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(height: 1, color: AppColors.divider),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 1);
}
