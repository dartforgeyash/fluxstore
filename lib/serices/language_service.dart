import 'dart:ui';

import 'package:shared_preferences/shared_preferences.dart';

class LanguageService {
  static const String _key = 'user_language';

  // Language save karne ke liye
  static Future<void> saveLanguage(String languageCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, languageCode);
  }

  // Saved language wapas lane ke liye
  static Future<Locale> getLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    String code = prefs.getString(_key) ?? 'en'; // Default English
    return Locale(code);
  }
}
