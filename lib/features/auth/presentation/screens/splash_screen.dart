import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:slts_enforcer_app/features/auth/presentation/screens/login_screen.dart';
import 'package:slts_enforcer_app/ui/utils/responsive.dart';
import 'package:slts_enforcer_app/ui/utils/app_assets.dart';
import 'package:slts_enforcer_app/ui/themes/app_colors.dart';
import 'package:slts_enforcer_app/features/home/presentation/screens/home_screen.dart';
import '../providers/splash_state.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stage = ref.watch(splashStageProvider);
    final wp = context.wp;
    final hp = context.hp;

    // Navigate to login when splash is done
    if (stage == SplashStage.done) {
      Future.microtask(() {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const HomeScreen()),
        );
      });
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: switch (stage) {
          SplashStage.street => SizedBox(
            width: wp(100),
            height: hp(100),
            child: Stack(
              children: [
                Image.asset(
                  AppAssets.trafficScene,
                  width: wp(100),
                  height: hp(100),
                  fit: BoxFit.cover,
                ),
                Container(
                  width: wp(100),
                  height: hp(100),
                  color: AppColors.primary, // bluish overlay
                ),
              ],
            ),
          ),
          SplashStage.appLogo => ImageIcon(
            AssetImage(AppAssets.appLogo),
            size: wp(40),
            color: AppColors.primary,
          ),
          SplashStage.done =>
            const SizedBox.shrink(), // placeholder while navigating
        },
      ),
    );
  }
}
