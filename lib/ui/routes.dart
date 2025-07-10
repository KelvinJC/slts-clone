import 'package:flutter/material.dart';
import 'package:slts_enforcer_app/features/violation/presentation/screens/vehicle_impounded_screen.dart';
import '../features/auth/presentation/screens/2fa_screen.dart';
import 'package:slts_enforcer_app/features/profile/presentation/screens/profile_screen.dart';
import 'package:slts_enforcer_app/features/settings/presentation/screens/settings_screen.dart';
import 'package:slts_enforcer_app/features/violation/presentation/screens/create_violation_screen.dart';
import '../features/auth/presentation/screens/fingerprint_login_screen.dart';
import '../features/auth/presentation/screens/forgot_password_screen.dart';
import '../features/home/presentation/screens/home_screen.dart';
import '../features/home/presentation/screens/patrol_mode_screen.dart';
import '../features/home/presentation/screens/recent_captures_screen.dart';
import '../features/search/presentation/screens/search_screen.dart';
import '../features/auth/presentation/screens/password_reset_link_screen.dart';
import '../features/auth/presentation/screens/splash_screen.dart';
// import '../features/auth/presentation/screens/onboarding_screen.dart';
import '../features/auth/presentation/screens/login_screen.dart';
import '../features/violation/presentation/screens/id_collection_notification_screen.dart';
import '../features/violation/presentation/screens/share_link_screen.dart';
import '../features/violation/presentation/screens/id_collected_screen.dart';
import '../features/violation/presentation/screens/vehicle_impound_notification_screen.dart';

final Map<String, WidgetBuilder> appRoutes = {
  '/': (_) => const SplashScreen(),
  // '/onboarding': (_) => const OnboardingScreen(),
  '/login': (_) => const LoginScreen(),
  '/biometrics': (_) => const FingerprintLoginScreen(),
  '/forgotPassword': (_) => const ForgotPasswordScreen(),
  '/passwordResetNotification': (_) => const PasswordResetLinkNotificationScreen(),
  '/2fa': (_) => const TwoFactorAuthScreen(),
  '/home': (_) => const HomeScreen(),
  '/search': (_) => const SearchScreen(),
  '/recentCaptures': (_) => const RecentCapturesScreen(),
  '/patrol': (_) => const PatrolModeScreen(),
  '/createViolation': (_) => const CreateViolationScreen(),
  '/settings': (_) => const SettingsScreen(),
  '/profile': (_) => const ProfileScreen(),
  '/resendViolationLink': (_) => const ShareLinkScreen(),
  '/idCollected': (_) => const IdCollectedScreen(),
  '/idCollectionNotification': (_) => const IdCollectionNotificationScreen(),
  '/vehicleImpounded': (_) => const VehicleImpoundedScreen(),
  '/vehicleImpoundedNotification': (_) => const VehicleImpoundNotificationScreen(),
  // TODO: Add '/register', '/home', etc.
};
