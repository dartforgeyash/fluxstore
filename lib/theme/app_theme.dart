import 'package:fluxstore/constant/app_text_styles.dart';
import 'package:fluxstore/constant/colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  // Common page transitions for both themes
  static const _pageTransitionsTheme = PageTransitionsTheme(
    builders: {
      TargetPlatform.android: FadeSwipePageTransitionsBuilder(),
      TargetPlatform.iOS: FadeSwipePageTransitionsBuilder(),
    },
  );

  /// 🌞 Light Theme
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.kWhite,
      primaryColor: AppColors.primary,
      fontFamily: 'Montserrat',
      pageTransitionsTheme: _pageTransitionsTheme, // Added cleanly

      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.cardBackground,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ), // Dark icons for light mode
        titleTextStyle: AppTextStyles.heading2.copyWith(color: Colors.black),
      ),
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        brightness: Brightness.light,
        onSurface: Colors.black,
        onBackground: Colors.black,
      ),
      textTheme:
          TextTheme(
            headlineLarge: AppTextStyles.heading1,
            headlineMedium: AppTextStyles.heading2,
            headlineSmall: AppTextStyles.heading3,
            bodyLarge: AppTextStyles.title,
            bodyMedium: AppTextStyles.title,
            bodySmall: AppTextStyles.label,
            labelLarge: AppTextStyles.label,
            labelMedium: AppTextStyles.small,
          ).apply(
            bodyColor: Colors.black,
            displayColor: Colors.black,
          ), // Force Dark text

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          textStyle: AppTextStyles.button,
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.cardBackground,
        hintStyle: AppTextStyles.title.copyWith(color: Colors.grey),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 14,
          horizontal: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
      ),

      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        backgroundColor: Colors.black87, // Dark snackbar for light theme
        contentTextStyle: const TextStyle(color: Colors.white),
      ),

      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: AppColors.primary, // Fixed: Was White earlier
        circularTrackColor: Colors.grey.shade200,
        linearTrackColor: Colors.grey.shade200,
      ),

      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.cardBackground,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textSecondary,
        showUnselectedLabels: true,
      ),
    );
  }

  /// 🌙 Dark Theme
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: const Color(0xFF121212),
      primaryColor: AppColors.primary,
      fontFamily: 'Montserrat',
      pageTransitionsTheme: _pageTransitionsTheme, // Fixed: Was missing earlier

      appBarTheme: AppBarTheme(
        backgroundColor: const Color(0xFF1E1E1E),
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ), // Light icons for dark mode
        titleTextStyle: AppTextStyles.heading2.copyWith(color: Colors.white),
      ),

      textTheme:
          TextTheme(
            headlineLarge: AppTextStyles.heading1,
            headlineMedium: AppTextStyles.heading2,
            headlineSmall: AppTextStyles.heading3,
            bodyLarge: AppTextStyles.title,
            bodyMedium: AppTextStyles.title,
            bodySmall: AppTextStyles.label,
            labelLarge: AppTextStyles.label,
            labelMedium: AppTextStyles.small,
          ).apply(
            bodyColor: Colors.white,
            displayColor: Colors.white,
          ), // Force Light text

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          textStyle: AppTextStyles.button,
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFF1E1E1E),
        hintStyle: AppTextStyles.title.copyWith(color: Colors.grey),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 14,
          horizontal: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
      ),

      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        backgroundColor: const Color(
          0xFF2C2C2C,
        ), // Proper contrast dark background
        contentTextStyle: const TextStyle(color: Colors.white),
      ),

      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.primary,
        circularTrackColor: Colors.white12,
        linearTrackColor: Colors.white12,
      ),

      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Color(0xFF1E1E1E),
        selectedItemColor: AppColors.primary,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
      ),
    );
  }
}

class FadeSwipePageTransitionsBuilder extends PageTransitionsBuilder {
  const FadeSwipePageTransitionsBuilder();

  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    if (route.isFirst) return child;

    return AnimatedBuilder(
      animation: animation,
      builder: (context, _) {
        return Opacity(
          opacity: animation.value.clamp(0.0, 1.0),
          child: GestureDetector(
            onHorizontalDragUpdate: (details) {
              if (details.primaryDelta != null &&
                  details.primaryDelta! > 20 &&
                  Navigator.of(context).canPop()) {
                Navigator.of(context).pop();
              }
            },
            child: child,
          ),
        );
      },
    );
  }
}
