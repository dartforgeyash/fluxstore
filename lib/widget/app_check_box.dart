import 'package:fluxstore/core/extensions/app_extensions.dart';
import 'package:fluxstore/widget/app_text.dart';
import 'package:flutter/material.dart';

class AppCheckbox extends StatelessWidget {
  final Widget? child;
  final String? label;
  final bool value;
  final ValueChanged<bool?> onChanged;

  const AppCheckbox({
    super.key,
    this.child,
    this.label,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: Padding(
        padding: 4.verticalPadding,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 16.hx,
              width: 16.wx,
              child: Checkbox(
                value: value,
                onChanged: onChanged,
                activeColor: Theme.of(context).primaryColor,
                checkColor: Colors.white,
                // visualDensity: VisualDensity.adaptivePlatformDensity,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
            8.horizontalSpace,
            if (child != null) Flexible(child: child!),
            if (label != null) Flexible(child: AppText(label!)),
          ],
        ),
      ),
    );
  }
}
