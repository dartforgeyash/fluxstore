// widgets/custom_text_field.dart
import 'package:fluxstore/constant/app_text_styles.dart';
import 'package:fluxstore/constant/colors.dart';
import 'package:fluxstore/core/extensions/app_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluxstore/widget/app_text_rich.dart';

/// A unified, reusable CustomTextField widget that can be used across all screens
/// Combines all features from both previous implementations
class CustomTextField extends StatelessWidget {
  final String label;
  final String hintText;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final bool obscureText;
  final bool isRequired;
  final bool isCounter;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final bool readOnly;
  final int? maxLines;
  final int? maxLength;
  final int? minLines;
  final String? helperText;
  final bool enabled;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(String)? onSubmitted;
  final EdgeInsetsGeometry? contentPadding;
  final double borderRadius;
  final Color? fillColor;
  final Color? borderColor;
  final Color? focusedBorderColor;
  final Color? errorBorderColor;
  final TextStyle? labelStyle;
  final TextStyle? hintStyle;
  final TextStyle? textStyle;
  final BoxConstraints? prefixIconConstraints;
  final BoxConstraints? suffixIconConstraints;

  const CustomTextField({
    super.key,
    required this.label,
    required this.hintText,
    required this.controller,
    this.keyboardType,
    this.obscureText = false,
    this.isRequired = true,
    this.isCounter = false,
    this.validator,
    this.suffixIcon,
    this.prefixIcon,
    this.onChanged,
    this.onTap,
    this.readOnly = false,
    this.maxLines = 1,
    this.maxLength = 30,
    this.minLines,
    this.helperText,
    this.enabled = true,
    this.focusNode,
    this.textInputAction,
    this.inputFormatters,
    this.onSubmitted,
    this.contentPadding,
    this.borderRadius = 8.0,
    this.fillColor,
    this.borderColor,
    this.focusedBorderColor,
    this.errorBorderColor,
    this.labelStyle,
    this.hintStyle,
    this.textStyle,
    this.prefixIconConstraints,
    this.suffixIconConstraints,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label with required indicator
        if (label.isNotEmpty) ...[
          AppRichText(
            textAlign: TextAlign.start,
            items: [
              TextSpanItem(
                text: label,
                style:
                    labelStyle ??
                    AppTextStyles.small.copyWith(fontWeight: FontWeight.w600),
              ),
              if (isRequired)
                TextSpanItem(
                  text: " *",
                  style:
                      labelStyle?.copyWith(color: Colors.red) ??
                      AppTextStyles.label.copyWith(color: Colors.red),
                ),
            ],
          ),
          const SizedBox(height: 4),
        ],

        // Text Field
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          obscureText: obscureText,
          onChanged: onChanged,
          onTap: onTap,
          readOnly: readOnly,
          maxLength: maxLength,
          maxLines: obscureText ? 1 : maxLines,
          minLines: minLines,
          enabled: enabled,
          cursorColor: AppColors.kBlack,
          cursorHeight: 22,
          focusNode: focusNode,
          textInputAction: textInputAction,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          onFieldSubmitted: onSubmitted,
          inputFormatters: inputFormatters,

          style:
              textStyle ??
              TextStyle(fontSize: 15, color: AppColors.textPrimary),
          decoration: InputDecoration(
            hintText: hintText,
            counterText: isCounter ? null : "",
            isDense: true,
            isCollapsed: true,

            hintStyle:
                hintStyle ??
                TextStyle(
                  color: AppColors.textLight,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
            helperText: helperText,
            helperStyle: TextStyle(
              color: AppColors.textLight,
              fontSize: 12.spx,
            ),
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            filled: true,
            fillColor: fillColor ?? const Color(0xFFF5F5F5),

            // Border styles
            // border: OutlineInputBorder(
            //   borderRadius: BorderRadius.circular(borderRadius),
            //   borderSide: BorderSide(color: borderColor ?? const Color(0xFFE2E8F0)),
            // ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.transparent),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.transparent),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.transparent),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.transparent),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.transparent),
            ),
            // enabledBorder: InputBorder.none,
            // focusedBorder: InputBorder.none,
            // errorBorder: InputBorder.none,
            border: InputBorder.none,
            errorStyle: AppTextStyles.error,
            contentPadding: contentPadding ?? 14.vh(16),
            prefixIconConstraints:
                prefixIconConstraints ??
                const BoxConstraints(minWidth: 40, minHeight: 0),
            suffixIconConstraints:
                suffixIconConstraints ??
                const BoxConstraints(minWidth: 40, minHeight: 0),
          ),
          validator:
              validator ??
              (isRequired
                  ? (value) {
                      if (value == null || value.isEmpty) {
                        return 'This field is required';
                      }
                      return null;
                    }
                  : null),
        ),
      ],
    );
  }
}
