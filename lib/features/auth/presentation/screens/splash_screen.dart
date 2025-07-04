import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'login_screen.dart';
import 'package:slts_enforcer_app/ui/utils/responsive.dart';
import 'package:slts_enforcer_app/ui/utils/app_assets.dart';
import 'package:slts_enforcer_app/ui/themes/app_colors.dart';
import '../providers/splash_state.dart';


class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stage = ref.watch(splashStageProvider);
    final wp = context.wp;
    final hp = context.hp;

    if (stage == SplashStage.done) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        // prevent navigating multiple times
        if (ModalRoute.of(context)?.isCurrent != true) return;

        // Navigator.of(context).pushReplacement(
        //   PageRouteBuilder(
        //     transitionDuration: const Duration(milliseconds: 1700),
        //     pageBuilder: (_, __, ___) => const LoginScreen(),
        //     transitionsBuilder: (_, animation, __, child) =>
        //         FadeTransition(opacity: animation, child: child),
        //   ),
        // );
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 1500),
            pageBuilder: (_, __, ___) => const LoginScreen(),
            transitionsBuilder: (_, animation, __, child) {
              final curvedAnimation = CurvedAnimation(
                parent: animation,
                curve: Curves.easeInOut, // Easing curve
              );

              return SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(1.0, 0), // Start slightly below screen
                  end: Offset.zero,
                ).animate(curvedAnimation),
                child: FadeTransition(
                  opacity: curvedAnimation,
                  child: child,
                ),
              );
            },
          ),
        );

      });
    }

    // Keep showing logo or image when stage == done
    final splashContent = switch (stage) {
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
              color: AppColors.blueOverlay,
            ),
          ],
        ),
      ),
      SplashStage.appLogo || SplashStage.done => Image.asset(
        AppAssets.logoAnimation,
        width: wp(40),
        height: wp(40),
        fit: BoxFit.contain,
      )
    };

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(child: splashContent),
    );
  }
}

