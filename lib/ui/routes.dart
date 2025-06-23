import 'package:flutter/material.dart';
import 'package:slts_enforcer_app/features/home/presentation/screens/home_screen.dart';
import '../features/auth/presentation/screens/splash_screen.dart';
import '../features/auth/presentation/screens/onboarding_screen.dart';
import '../features/auth/presentation/screens/login_screen.dart';

final Map<String, WidgetBuilder> appRoutes = {
  '/': (_) => const SplashScreen(),
  '/onboarding': (_) => const OnboardingScreen(),
  '/login': (_) => const LoginScreen(),
  '/home': (_) => const HomeScreen(),
  // TODO: Add '/register', '/home', etc.
};
