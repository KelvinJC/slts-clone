import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTextTheme {
  static TextTheme get light {
    final base = TextTheme(
      displayLarge: const TextStyle(
        fontSize: 57,
        height: 64 / 57,
        fontWeight: FontWeight.w400,
        letterSpacing: -0.25,
      ),
      displayMedium: const TextStyle(
        fontSize: 45,
        height: 52 / 45,
        fontWeight: FontWeight.w400,
      ),
      displaySmall: const TextStyle(
        fontSize: 36,
        height: 44 / 36,
        fontWeight: FontWeight.w400,
      ),
      headlineLarge: const TextStyle(
        fontSize: 32,
        height: 40 / 32,
        fontWeight: FontWeight.w400,
      ),
      headlineMedium: const TextStyle(
        fontSize: 28,
        height: 36 / 28,
        fontWeight: FontWeight.w400,
      ),
      headlineSmall: const TextStyle(
        fontSize: 24,
        height: 32 / 24,
        fontWeight: FontWeight.w400,
      ),
      titleLarge: const TextStyle(
        fontSize: 22,
        height: 28 / 22,
        fontWeight: FontWeight.w400,
      ),
      titleMedium: const TextStyle(
        fontSize: 16,
        height: 24 / 16,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.15,
      ),
      titleSmall: const TextStyle(
        fontSize: 14,
        height: 20 / 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
      ),
      bodyLarge: const TextStyle(
        fontSize: 16,
        height: 24 / 16,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.5,
      ),
      bodyMedium: const TextStyle(
        fontSize: 14,
        height: 20 / 14,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
      ),
      bodySmall: const TextStyle(
        fontSize: 12,
        height: 16 / 12,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.4,
      ),
      labelLarge: const TextStyle(
        fontSize: 14,
        height: 20 / 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
      ),
      labelMedium: const TextStyle(
        fontSize: 12,
        height: 16 / 12,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
      ),
      labelSmall: const TextStyle(
        fontSize: 11,
        height: 16 / 11,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
      ),
    );

    return GoogleFonts.interTextTheme(base).apply(
      bodyColor: AppColors.onBackground,
      displayColor: AppColors.onBackground,
    );
  }
}
