import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

// class AppRichText extends StatelessWidget {
//   final List<TextSpanItem> items;
//   final TextAlign textAlign;
//   final int? maxLines;
//   final TextOverflow overflow;
//
//   const AppRichText({
//     super.key,
//     required this.items,
//     this.textAlign = TextAlign.start,
//     this.maxLines,
//     this.overflow = TextOverflow.clip,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return RichText(
//       textAlign: textAlign,
//       maxLines: maxLines,
//       overflow: overflow,
//       text: TextSpan(
//         children: items.map((item) {
//           return TextSpan(
//             text: item.text,
//             style: Theme.of(context).textTheme.bodyMedium?.merge(item.style),
//             recognizer: item.onTap != null
//                 ? (TapGestureRecognizer()..onTap = item.onTap)
//                 : null,
//           );
//         }).toList(),
//       ),
//     );
//   }
// }

class AppRichText extends StatelessWidget {
  final List<TextSpanItem> items;
  final TextAlign textAlign;
  final int? maxLines;
  final TextOverflow overflow;

  const AppRichText({
    super.key,
    required this.items,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.overflow = TextOverflow.clip,
  });

  @override
  Widget build(BuildContext context) {
    final defaultStyle = Theme.of(context).textTheme.bodyMedium;

    return Text.rich(
      TextSpan(
        children: items.map((item) {
          return TextSpan(
            text: item.text,
            style: defaultStyle?.merge(item.style),
            recognizer: item.onTap != null
                ? (TapGestureRecognizer()..onTap = item.onTap)
                : null,
          );
        }).toList(),
      ),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      textScaler: MediaQuery.of(context).textScaler, // 🔥 important
    );
  }
}

class TextSpanItem {
  final String text;
  final TextStyle? style;
  final VoidCallback? onTap;

  TextSpanItem({
    required this.text,
    this.style,
    this.onTap,
  });
}