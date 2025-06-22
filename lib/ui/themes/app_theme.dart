import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_text_theme.dart';

final lightTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    primary: AppColors.primary,
    secondary: AppColors.secondary,
    // background: AppColors.background,
    // surface: AppColors.surface,
    // error: AppColors.error,
    // onPrimary: AppColors.onPrimary,
    // onBackground: AppColors.onBackground,
  ),
  textTheme: AppTextTheme.light,
);

final darkTheme = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    primary: AppColors.primary,
    secondary: AppColors.secondary,
    // background: Colors.black,
    // surface: AppColors.surface,
    // error: AppColors.error,
    // onPrimary: AppColors.onPrimary,
    // onBackground: AppColors.onBackground,
  ),
  textTheme: AppTextTheme.light.apply(bodyColor: Colors.white),
);
