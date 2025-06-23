// lib/ui/themes/app_theme.dart

import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_text_theme.dart';

final lightTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
    primary: AppColors.primary,
    secondary: AppColors.secondary,
    background: AppColors.background,
    surface: AppColors.surface,
    error: AppColors.error,
    onPrimary: AppColors.onPrimary,
    onBackground: AppColors.onBackground,
    onSurface: AppColors.onSurface,
  ),
  textTheme: AppTextTheme.light,
);

final darkTheme = ThemeData(
  brightness: Brightness.dark,
  colorScheme: const ColorScheme.dark(
    primary: AppColors.primary,
    secondary: AppColors.secondary,
    background: Colors.black,
    surface: AppColors.surface,
    error: AppColors.error,
    onPrimary: AppColors.onPrimary,
    onBackground: AppColors.onBackground,
    onSurface: AppColors.onSurface,
  ),
  textTheme: AppTextTheme.light, // or define a dark-specific variant
);
