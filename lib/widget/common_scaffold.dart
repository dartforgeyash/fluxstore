// ignore_for_file: unused_local_variable

import 'package:flutter/services.dart';
import 'package:fluxstore/core/utils/auto_hide_keyboard.dart';
import 'package:flutter/material.dart';

class CommonScaffold extends StatelessWidget {
  final Widget body;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;
  final PreferredSizeWidget? appBar;
  final bool safeAreaTop;
  final bool? resizeToAvoidBottomInset;
  final Color? backgroundColor;

  const CommonScaffold({
    super.key,
    required this.body,
    this.floatingActionButton,
    this.bottomNavigationBar,
    this.appBar,
    this.backgroundColor,
    this.safeAreaTop = false,
    this.resizeToAvoidBottomInset,
  });

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark, // For Android
        statusBarBrightness: Brightness.light, // For iOS
      ),
      child: AutoHideKeyboard(
        child: Scaffold(
          backgroundColor: backgroundColor ?? const Color(0xFFFFFFFF),
          extendBody: true,
          floatingActionButtonLocation:
              FloatingActionButtonLocation.miniCenterDocked,
          resizeToAvoidBottomInset: resizeToAvoidBottomInset ?? true,
          appBar: appBar,
          body: SafeArea(top: safeAreaTop, bottom: true, child: body),
          floatingActionButton: floatingActionButton,
          bottomNavigationBar: bottomNavigationBar,
        ),
      ),
    );
  }
}
