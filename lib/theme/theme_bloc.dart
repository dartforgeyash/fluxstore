import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluxstore/constant/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

enum ThemePreference { system, light, dark }

class ThemeBloc extends Cubit<ThemeData> with WidgetsBindingObserver {
  static const String themeKey = "themePreference";
  ThemePreference _currentPreference = ThemePreference.system;

  ThemeBloc() : super(AppThemes.lightTheme) {
    WidgetsBinding.instance.addObserver(this); // listen to brightness changes
    _loadTheme();
  }

  ThemePreference get currentPreference => _currentPreference;

  @override
  void didChangePlatformBrightness() {
    if (_currentPreference == ThemePreference.system) {
      final brightness = WidgetsBinding.instance.window.platformBrightness;
      final theme = brightness == Brightness.dark
          ? AppThemes.darkTheme
          : AppThemes.lightTheme;
      emit(theme);
      _updateSystemUIOverlay(theme.brightness);
    }
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final prefString = prefs.getString(themeKey);
    _currentPreference = _parsePreference(prefString);

    final theme = _getThemeFromPreference(_currentPreference);
    emit(theme);
    _updateSystemUIOverlay(theme.brightness);
  }

  ThemePreference _parsePreference(String? pref) {
    switch (pref) {
      case 'light':
        return ThemePreference.light;
      case 'dark':
        return ThemePreference.dark;
      default:
        return ThemePreference.system;
    }
  }

  ThemeData _getThemeFromPreference(ThemePreference pref) {
    switch (pref) {
      case ThemePreference.light:
        return AppThemes.lightTheme;
      case ThemePreference.dark:
        return AppThemes.darkTheme;
      case ThemePreference.system:
        final brightness = WidgetsBinding.instance.window.platformBrightness;
        return brightness == Brightness.dark
            ? AppThemes.darkTheme
            : AppThemes.lightTheme;
    }
  }

  Future<void> setThemePreference(ThemePreference preference) async {
    final prefs = await SharedPreferences.getInstance();
    _currentPreference = preference;
    await prefs.setString(themeKey, preference.name);

    final theme = _getThemeFromPreference(preference);
    emit(theme.copyWith()); // force new instance to trigger rebuild
    _updateSystemUIOverlay(theme.brightness);
  }

  @override
  Future<void> close() {
    WidgetsBinding.instance.removeObserver(this);
    return super.close();
  }
}

void _updateSystemUIOverlay(Brightness brightness) {
  // Light theme ke liye: status bar white, icons dark
  // Dark theme ke liye: status bar dark, icons light
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: brightness == Brightness.dark
          ? AppColors.kDarkMode
          : AppColors.kWhite,
      statusBarIconBrightness: brightness == Brightness.dark
          ? Brightness.light
          : Brightness.dark,
      statusBarBrightness: brightness == Brightness.dark
          ? Brightness.dark
          : Brightness.light,
      systemNavigationBarColor: brightness == Brightness.dark
          ? AppColors.kDarkMode
          : AppColors.kWhite,
      systemNavigationBarIconBrightness: brightness == Brightness.dark
          ? Brightness.light
          : Brightness.dark,
    ),
  );
}

// Updated App Themes Configuration
class AppThemes {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    pageTransitionsTheme: PageTransitionsTheme(
      builders: Map<TargetPlatform, PageTransitionsBuilder>.fromIterable(
        TargetPlatform.values,
        value: (_) => const FadeForwardsPageTransitionsBuilder(
          backgroundColor: AppColors.kWhite,
        ),
      ),
    ),
    brightness: Brightness.light,
    primaryColor: AppColors.primary,
    dividerColor: AppColors.kDarkMode,
    primaryIconTheme: const IconThemeData(color: AppColors.kBlack),
    appBarTheme: const AppBarTheme(
      // Remove or make systemOverlayStyle null to let the app handle it
      systemOverlayStyle: null,
      backgroundColor: Colors.transparent,
      elevation: 0,
    ),
    scaffoldBackgroundColor: Colors.white,
    iconTheme: IconThemeData(color: AppColors.kDarkMode),
    cardTheme: CardThemeData(
      color: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
    fontFamily: "Roboto",
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        color: Colors.black87,
        fontSize: 32,
        fontWeight: FontWeight.bold,
      ),
      displayMedium: TextStyle(
        color: Colors.black87,
        fontSize: 28,
        fontWeight: FontWeight.w600,
      ),
      displaySmall: TextStyle(
        color: Colors.black87,
        fontSize: 24,
        fontWeight: FontWeight.w500,
      ),
      headlineLarge: TextStyle(
        color: Colors.black87,
        fontSize: 22,
        fontWeight: FontWeight.w600,
      ),
      headlineMedium: TextStyle(
        color: Colors.black87,
        fontSize: 20,
        fontWeight: FontWeight.w500,
      ),
      headlineSmall: TextStyle(
        color: Colors.black87,
        fontSize: 18,
        fontWeight: FontWeight.w400,
      ),
      titleLarge: TextStyle(
        color: Colors.black87,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
      titleMedium: TextStyle(
        color: Colors.black87,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      titleSmall: TextStyle(
        color: Colors.black87,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      bodyLarge: TextStyle(color: Colors.black87, fontSize: 16),
      bodyMedium: TextStyle(color: Colors.black87, fontSize: 14),
      bodySmall: TextStyle(color: Colors.black87, fontSize: 12),
      labelLarge: TextStyle(
        color: Colors.black87,
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
      labelMedium: TextStyle(
        color: Colors.black87,
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
      labelSmall: TextStyle(
        color: Colors.black87,
        fontSize: 10,
        fontWeight: FontWeight.w400,
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    dividerColor: AppColors.lightWight1,
    pageTransitionsTheme: PageTransitionsTheme(
      builders: Map<TargetPlatform, PageTransitionsBuilder>.fromIterable(
        TargetPlatform.values,

        value: (_) => FadeForwardsPageTransitionsBuilder(
          backgroundColor: AppColors.kDarkMode,
        ),
      ),
    ),
    brightness: Brightness.dark,
    primaryColor: Colors.blue[700],
    iconTheme: const IconThemeData(color: AppColors.kWhite),
    primaryIconTheme: const IconThemeData(color: AppColors.kWhite),
    scaffoldBackgroundColor: Colors.grey[900],
    appBarTheme: const AppBarTheme(
      // Remove or make systemOverlayStyle null
      systemOverlayStyle: null,
      backgroundColor: Colors.transparent,
      elevation: 0,
    ),
    cardTheme: CardThemeData(
      color: Colors.grey[850],
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
    fontFamily: "Roboto",
    textTheme: TextTheme(
      displayLarge: const TextStyle(
        color: Colors.white,
        fontSize: 32,
        fontWeight: FontWeight.bold,
      ),
      displayMedium: const TextStyle(
        color: Colors.white,
        fontSize: 28,
        fontWeight: FontWeight.w600,
      ),
      displaySmall: const TextStyle(
        color: Colors.white,
        fontSize: 24,
        fontWeight: FontWeight.w500,
      ),
      headlineLarge: const TextStyle(
        color: Colors.white,
        fontSize: 22,
        fontWeight: FontWeight.w600,
      ),
      headlineMedium: const TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w500,
      ),
      headlineSmall: const TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.w400,
      ),
      titleLarge: const TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
      titleMedium: const TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      titleSmall: const TextStyle(
        color: Colors.white,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      bodyLarge: TextStyle(color: AppColors.txtFieldHintDark, fontSize: 16),
      bodyMedium: const TextStyle(color: Colors.white, fontSize: 14),
      bodySmall: const TextStyle(color: AppColors.kWhite, fontSize: 12),
      labelLarge: const TextStyle(
        color: Colors.white,
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
      labelMedium: const TextStyle(
        color: Colors.white,
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
      labelSmall: const TextStyle(
        color: Colors.white,
        fontSize: 10,
        fontWeight: FontWeight.w400,
      ),
    ),
  );
}

class LocaleBloc extends Cubit<Locale> {
  LocaleBloc() : super(const Locale('en'));

  void changeLocale(Locale locale) => emit(locale);
}
