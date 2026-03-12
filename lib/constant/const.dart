import 'package:flutter/material.dart';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
final RouteObserver<ModalRoute> routeObserver = RouteObserver<ModalRoute>();

class AppConstants {
  AppConstants._();
  static const String appName = "Trading Platform";
  static const String appVersion = "1.0.0";
  static const String appLogo = "my_account/images/app_logo.png";
  static const int otpTimer = 120;
  static const String registerKey = 'REGISTER-PHONE-OTP-VERIFICATION';

static Future<String?> getDeviceUniqueId() async {
  var deviceInfo = DeviceInfoPlugin();
  
  if (Platform.isIOS) {
    var iosDeviceInfo = await deviceInfo.iosInfo;
    return iosDeviceInfo.identifierForVendor; // Yeh iOS ke liye unique ID hai
  } else if (Platform.isAndroid) {
    var androidDeviceInfo = await deviceInfo.androidInfo;
    return androidDeviceInfo.id; // Yeh Android ID (SSAID) hai
  }
  return null;
}
}