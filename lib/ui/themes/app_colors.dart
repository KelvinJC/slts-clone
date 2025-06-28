// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

/// Define your brand colors here
class AppColors {
  static const primary = Color(0xFF002C98); // Deep blue – brand primary
  static const primaryVariant = Color(0xFF0041A8); // Slightly lighter blue – used for emphasis or variants
  static const secondary = Color(0xFF16D0C5); // Teal – accent/secondary brand color

  static const background = Color(0xFFF5F5F5); // Light gray – page background
  static const surface = Colors.white; // White – cards, sheets, input fields

  static const error = Color(0xFFB00020); // Red – error states
  static const notification = Color(0xFFDC2626); // Bright red – notifications, alerts
  static const success = Color(0xFF0B835B); // Green – success messages or states
  static const danger = Color(0xFF8E1717); // Dark red – dangerous actions, delete
  static const warning = Color(0xFFFFC107); // Yellow – warning indicators

  static const onPrimary = Colors.white; // Text/icon color on primary backgrounds
  static const onSecondary = Colors.white; // Text/icon color on secondary backgrounds
  static const onBackground = Colors.black; // Default text color on light backgrounds
  static const onSurface = Colors.black; // Text color on white or light surfaces

  static const onBackgroundSurface = Color(0xFF66758B); // Muted gray-blue – secondary text
  static const onBackgroundSurface2 = Color(0xFFC4CAD4); // Light gray – borders or dividers
  static const onBackgroundSurface3 = Color(0xFFE0E9FF); // Pale blue – disabled or inactive backgrounds

  static const buttonGradient = [Color(0xFF002C98), Color(0xFF16D0C5)]; // Blue-to-teal gradient – button background
  static final homeGradient = [
    primary.withOpacity(0.1), // Lightened primary – soft background tint
    secondary.withOpacity(0.1), // Lightened secondary – soft background tint
  ];

  static final primary30 = primary.withOpacity(0.3); // 30% opacity primary – overlay or pressed state
  static const blueOverlay = Color(0xCF002C98); // Semi-transparent deep blue – image overlay or splash mask
}
