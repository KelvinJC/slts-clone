import 'package:flutter/material.dart';
import 'package:slts_enforcer_app/features/violation/presentation/screens/add_payment_card_screen.dart';
import 'package:slts_enforcer_app/features/violation/presentation/screens/pay_now_screen.dart';
import 'package:slts_enforcer_app/features/violation/presentation/screens/resend_link_notification_screen.dart';
import 'package:slts_enforcer_app/features/violation/presentation/screens/resend_link_screen.dart';
import 'package:slts_enforcer_app/features/violation/presentation/screens/vehicle_impounded_screen.dart';
import 'package:slts_enforcer_app/features/violation/presentation/screens/violation_report_screen.dart';
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
import '../features/violation/presentation/screens/share_link_screen.dart';
import '../features/violation/presentation/screens/id_collected_screen.dart';
import '../features/violation/presentation/screens/enforcement_notification.dart';

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
  '/shareViolationLink': (_) => const ShareLinkScreen(),
  '/idCollected': (_) => const IdCollectedScreen(),
  '/vehicleImpounded': (_) => const VehicleImpoundedScreen(),
  '/enforcementNotification': (_) => const EnforcementNotificationScreen(),
  '/payment': (_) => const PaymentScreen(),
  '/addCard': (_) => const AddPaymentCardScreen(),
  '/reportViolation': (_) => const ViolationReportScreen(),
  '/resendViolationLink': (_) => const ResendLinkScreen(),
  '/violationLinkNotification': (_) => const ResendLinkNotificationScreen(),
  // TODO: Add '/register', '/home', etc.
};
