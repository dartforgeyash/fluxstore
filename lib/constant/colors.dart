import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static Color kDarkMode = Color(0xFF191919);
  static const Color kWhite = Color(0xFFFFFFFF); // White cards
  static const Color kBlack = Color(0xFF000000);
  static const Color dropShadow = Color(0xFFE6B566);
  static const Color closeSession = Color(0xFFFFEEEB);
  static const Color runningSession = Color(0xFFF4E7D5);
  static const Color tabIndicator = Color(0xFF94390A);
  static const Color tabDivider = Color(0xFFF5D9A1);
  static const Color creamLight = Color(0xFFFFFAE8);
  static const Color softCream = Color(0xFFFFF7DE);
  static const Color brickRed = Color(0xFFBB4B0C);
  static const Color charcoalBrown = Color(0xFF210D02);
  static const Color liteOrange = Color(0xFFFFECB9);
  static const Color softPeach = Color(0xFFFFCFB4);

  static Color lightWight1 = Color(0xFFF5F5F5);
  static Color txtFieldHintDark = Color(0xFF707C8E);

  // Brand Colors
  static const Color primary = Color(0xFF027A48); // Deep Orange
  static const Color primaryProfileBg = Color(0xFF8AABFF); // Deep Orange
  static const Color primaryLight = Color(0xFFD66A33); // Lighter orange
  static const Color primaryDark = Color(0xFFE65100); // Darker orange
  static const Color secondary = Color(0xFFFFD54F); // Golden yellow

  static const List<Color> exerciseBgColors = [
    Color(0xFFEDE7F6), // Relaxation  — soft lavender
    Color(0xFFFCE4EC), // Meditation  — soft pink
    Color(0xFFFFF3E0), // Breathing   — soft amber
    Color(0xFFE3F2FD), // Yoga        — soft blue
  ];

  // Gradient
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFFFFA726), Color(0xFFE65100)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static LinearGradient primaryGradientLight = LinearGradient(
    colors: [Color(0xFFFFE7DB).withAlpha(30), AppColors.kWhite],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  // Backgrounds
  static const Color background = Color(0xFFFFF8E1); // Cream background
  static const Color cardBackground = Color(0xFFFFFFFF); // White cards

  // Text Button Color
  static const Color textButton = Color(0xFF792E08);
  static const Color closedStatusButton = Color(0xFF9E0003);
  static const Color runningStatusButton = Color(0xFF108B05);
  static const Color textShadow = Color(0xFFFFE5BC);

  // Text
  static const Color textPrimary = Color(0xFF212121); // Dark grey / black
  static const Color textSecondary = Color(0xFF242121); // Medium grey
  static const Color textLight = Color(0xFF9A9A9A); // Light grey

  // Status
  static const Color success = Color(0xFF4CAF50); // Green (running)
  static const Color error = Color(0xFFD32F2F); // Red (closed)
  static const Color warning = Color(0xFFFFA000); // Orange warning/Pending
  static const Color processing = Color(0xFF3D74FF); // Blue Processing

  // Borders & Icons
  static const Color border = Color(0xFFFFCB5F);
  static const Color icon = Color(0xFF616161);
  static const Color charcoalGrey = Color(0xFF484C52);
  static const Color grey = Color(0xFF9BA5B0);
  static const Color buttonGrey = Color(0xFFe1e1e1);
  static const Color lightGrey = Color(0xFFF5F5F5);
  static const Color divider = Color(0xFFDDDDDD);
  static const Color tabGreen = Color(0xFF77CC00);

  static const Color black = Colors.black;
  static const Color white = Colors.white;

  static const Color purple = Color(0xFF7B4FBE);
  static const Color purpleLight = Color(0xFFF3EEFF);
  static const Color textDark = Color(0xFF1A1A2E);
  static const Color textGrey = Color(0xFF8A8A9A);
  static const Color bgGrey = Color(0xFFF7F7FB);

  /// Returns [grey] for 0, [success] for positive, [brickRed] for negative.
  static Color getPnlColor(double value) {
    if (value == 0) return textLight;
    return value > 0 ? success : brickRed;
  }
}
