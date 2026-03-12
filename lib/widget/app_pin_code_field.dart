import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:fluxstore/core/extensions/app_extensions.dart';

class AppPinCodeField extends StatelessWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final Function(String)? onCompleted;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final String? errorText;
  final bool forceErrorState;
  final int length;

  const AppPinCodeField({
    super.key,
    this.controller,
    this.focusNode,
    this.onCompleted,
    this.onChanged,
    this.validator,
    this.errorText,
    this.forceErrorState = false,
    this.length = 6,
  });

  @override
  Widget build(BuildContext context) {
    // Base Theme
    final defaultPinTheme = PinTheme(
      width: 50.wx,
      height: 55.hx,
      textStyle: TextStyle(
        fontSize: 20.spx,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(width: 1.5, color: Colors.grey)),
      ),
    );

    return Pinput(
      length: length,
      controller: controller,
      focusNode: focusNode,
      onCompleted: onCompleted,
      onChanged: onChanged,
      showCursor: true,
      autofillHints: const [AutofillHints.oneTimeCode],

      // Error Handling logic
      forceErrorState: forceErrorState,
      errorText: errorText,
      pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,

      validator: validator,

      // Custom Error Builder (The text below the lines)
      errorBuilder: (errorText, value) {
        return Padding(
          padding: EdgeInsets.only(top: 8.hx),
          child: Center(
            child: Text(
              errorText ?? '',
              style: TextStyle(
                color: Colors.red,
                fontSize: 14.spx,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        );
      },

      // Themes
      defaultPinTheme: defaultPinTheme,

      focusedPinTheme: defaultPinTheme.copyWith(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 2.wx, color: Colors.blue),
          ),
        ),
      ),

      errorPinTheme: defaultPinTheme.copyWith(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 2.wx, color: Colors.red),
          ),
        ),
      ),

      submittedPinTheme: defaultPinTheme.copyWith(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 1.5.wx, color: Colors.grey.shade400),
          ),
        ),
      ),

      // Cursor Customization
      cursor: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [Container(width: 20.wx, height: 2.hx, color: Colors.blue)],
      ),
    );
  }
}
