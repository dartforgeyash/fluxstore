import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CopyIconButton extends StatelessWidget {
  final String textToCopy;
  final double iconSize;
  final Color? iconColor;

  const CopyIconButton({
    super.key,
    required this.textToCopy,
    this.iconSize = 18,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      // 1. Set padding to zero
      padding: EdgeInsets.zero,

      // 2. Add empty constraints to override the default 48x48 tap area
      constraints: const BoxConstraints(),

      // 3. (Optional) A dense visual density helps shrink the button
      visualDensity: VisualDensity(horizontal: -4, vertical: -4),

      style: ButtonStyle(
        iconSize: WidgetStateProperty.all(iconSize),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,

      ),
      icon: Icon(
        Icons.content_copy,
        size: iconSize,
        color: iconColor ?? Theme.of(context).hintColor,
      ),
      onPressed: () {
        Clipboard.setData(ClipboardData(text: textToCopy));

        // Hide the current SnackBar if one is showing
        ScaffoldMessenger.of(context).hideCurrentSnackBar();


      },
    );
  }
}