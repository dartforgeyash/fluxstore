import 'package:flutter/material.dart';
// Apne extension aur localization file ko yahan import karein
// import 'package:transport_app/extensions/context_extension.dart';

class AppText extends StatelessWidget {
  final String data;
  final TextStyle? style;
  final TextAlign? align;
  final int? maxLines;
  final TextOverflow? overflow;
  final bool isLocalized;

  const AppText(
      this.data, {
        super.key,
        this.style,
        this.align,
        this.maxLines,
        this.overflow,
        this.isLocalized = true,
      });

  @override
  Widget build(BuildContext context) {
    final base = Theme.of(context).textTheme.bodyMedium!;

    // 1. Translation Logic
    String displayContent = data;

    if (isLocalized) {
      try {
        // context.l10n use karke dynamic key fetch kar rahe hain
        // Note: l10n.data (ya jo bhi aapki ARB key hai) ko access karne ke liye
        // niche diya gaya dynamic method use hota hai
        displayContent = _translate(context, data);
      } catch (e) {
        displayContent = data; // Agar key nahi mili toh original text dikhao
      }
    }

    return Text(
      displayContent,
      style: base.merge(style),
      textAlign: align,
      overflow: overflow,
      maxLines: maxLines,
    );
  }

  // Dynamic translation helper
  String _translate(BuildContext context, String key) {
    // Agar aapka localization setup standard hai (gen-l10n),
    // toh aap keys ko dynamic map ki tarah use kar sakte hain
    // Ya phir direct l10n object se call kar sakte hain:

    // Example for a specific key:
    // return context.l10n.translate(key); // Agar aapne custom method banaya hai

    return data; // Placeholder: yahan aapki translation library ka logic aayega
  }
}