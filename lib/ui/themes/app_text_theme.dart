import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Define global text styles
class AppTextTheme {
  static TextTheme get light => TextTheme(
    // TODO: Style using app_colors/app_text_theme
    headlineLarge: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
    labelSmall: const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.normal,
      color: AppColors.primary,
    ),
  );
}
