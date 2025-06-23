import 'package:flutter/material.dart';

/// Define your brand colors here
class AppColors {
  static const primary = Color(0xFF002C98);
  static const primaryVariant = Color(0xFF0041A8);
  static const secondary = Color(0xFF16D0C5);
  static const background = Color(0xFFF5F5F5);
  static const surface = Colors.white;
  static const error = Color(0xFFB00020);
  static const onPrimary = Colors.white;
  static const onSecondary = Colors.white;
  static const onBackground = Colors.black;
  static const onSurface = Colors.black;
  static const onBackgroundSurface = Color(0xFF66758B);
  static const onBackgroundSurface2 = Color(0xFFC4CAD4);
  static const onBackgroundSurface3 = Color(0xFFE0E9FF);
  static const buttonGradient = [Color(0xFF002C98), Color(0xFF16D0C5)];
  static final homeGradient = [
    primary.withOpacity(0.1),
    secondary.withOpacity(0.1),
  ];

  static final primary30 = primary.withOpacity(0.3);
}
