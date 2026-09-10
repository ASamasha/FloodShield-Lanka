import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryBlue = Color(0xFF004B8F);
  static const Color warningOrange = Color(0xFFF57C00);
  static const Color criticalRed = Color(0xFFD32F2F);
  static const Color backgroundLight = Color(0xFFF5F7FA);
  static const Color sosBackgroundTint =
      Color(0xFFFFEBEB); // Light pink/red for SOS

  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: primaryBlue,
      scaffoldBackgroundColor: backgroundLight,
      colorScheme: const ColorScheme.light(
        primary: primaryBlue,
        secondary: warningOrange,
        error: criticalRed,
        surface: backgroundLight,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: primaryBlue,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedItemColor: primaryBlue,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
      ),
      cardTheme: CardThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 2,
        color: Colors.white,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
      fontFamily: 'Roboto',
    );
  }
}
