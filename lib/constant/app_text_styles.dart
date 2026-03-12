import 'package:fluxstore/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:fluxstore/core/extensions/app_extensions.dart';

class AppTextStyles {
  AppTextStyles._();

  // Headings
  static TextStyle heading1 = TextStyle(
    fontSize: 22.spx,
    fontWeight: FontWeight.bold,
    color: AppColors.kBlack,
  );

  static TextStyle heading2 = TextStyle(
    fontSize: 18.spx,
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.bold,
    color: AppColors.kBlack,
  );

  static TextStyle heading3 = TextStyle(
    fontSize: 16.spx,
    fontWeight: FontWeight.w600,
    fontFamily: 'Montserrat',
    color: AppColors.kBlack,
  );

  // Body
  static TextStyle title = TextStyle(
    fontSize: 15.spx,
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w600,
    color: AppColors.kBlack,
  );

  static TextStyle label = TextStyle(
    fontSize: 14.spx,
    fontWeight: FontWeight.normal,
    fontFamily: 'Montserrat',
    color: AppColors.kBlack,
  );

  static TextStyle small = TextStyle(
    fontSize: 12.spx,
    fontWeight: FontWeight.normal,
    fontFamily: 'Montserrat',
    color: AppColors.kBlack,
  );

  // Buttons
  static TextStyle button = TextStyle(
    fontSize: 15.spx,
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.bold,
    color: Colors.white,
    letterSpacing: 0.5,
  );

  // Status Text
  static TextStyle success = TextStyle(
    fontSize: 14.spx,
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w600,
    color: AppColors.success,
  );

  static TextStyle error = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 11.spx,
    fontWeight: FontWeight.w500,
    color: AppColors.error,
  );
}
