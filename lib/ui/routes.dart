import 'package:flutter/material.dart';
import 'package:slts_enforcer_app/features/home/presentation/screens/home_screen.dart';
import 'package:slts_enforcer_app/features/home/presentation/screens/recent_captures_screen.dart';
import 'package:slts_enforcer_app/features/search/presentation/screens/search_screen.dart';
import '../features/auth/presentation/screens/splash_screen.dart';
import '../features/auth/presentation/screens/onboarding_screen.dart';
import '../features/auth/presentation/screens/login_screen.dart';

final Map<String, WidgetBuilder> appRoutes = {
  '/': (_) => const SplashScreen(),
  '/onboarding': (_) => const OnboardingScreen(),
  '/login': (_) => const LoginScreen(),
  '/home': (_) => const HomeScreen(),
  '/search': (_) => const SearchScreen(),
  '/recentCaptures': (_) => const RecentCapturesScreen(),
  // TODO: Add '/register', '/home', etc.
};
