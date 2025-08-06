import 'package:flutter/material.dart';
import '../features/auth/presentation/screens/2fa_screen.dart';
import 'package:slts_enforcer_app/features/profile/presentation/screens/profile_screen.dart';
import 'package:slts_enforcer_app/features/settings/presentation/screens/settings_screen.dart';
import 'package:slts_enforcer_app/features/violation/presentation/screens/create_violation_screen.dart';
import '../features/auth/presentation/screens/forgot_password_screen.dart';
import '../features/home/presentation/screens/home_screen.dart';
import '../features/home/presentation/screens/patrol_mode_screen.dart';
import '../features/home/presentation/screens/recent_captures_screen.dart';
import '../features/search/presentation/screens/search_screen.dart';
import '../features/auth/presentation/screens/splash_screen.dart';
import '../features/auth/presentation/screens/login_screen.dart';

final Map<String, WidgetBuilder> appRoutes = {
  '/': (_) => const SplashScreen(),
  '/login': (_) => const LoginScreen(),
  '/forgotPassword': (_) => const ForgotPasswordScreen(),
  '/2fa': (_) => const TwoFactorAuthScreen(),
  '/home': (_) => const HomeScreen(),
  '/search': (_) => const SearchScreen(),
  '/recentCaptures': (_) => const RecentCapturesScreen(),
  '/patrol': (_) => const PatrolModeScreen(),
  '/createViolation': (_) => const CreateViolationScreen(),
  '/settings': (_) => const SettingsScreen(),
  '/profile': (_) => const ProfileScreen(),
  // TODO: Add '/register', '/home', etc.
};
