import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:slts_enforcer_app/ui/utils/responsive.dart';
import 'package:slts_enforcer_app/ui/themes/app_colors.dart';
import 'package:slts_enforcer_app/ui/widgets/blurry_gradient_background.dart';
import 'package:slts_enforcer_app/ui/widgets/gradient_button.dart';

import '../../../../ui/utils/app_assets.dart';

// import '../providers/auth_notifier.dart';

class PasswordResetLinkNotificationScreen extends ConsumerWidget {
  const PasswordResetLinkNotificationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hp = context.hp;
    final wp = context.wp;

    return Scaffold(
      body: Stack(
        children: [
          BlurryGradientBackground(colors: AppColors.homeGradient),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.all(hp(5)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: wp(10),
                    backgroundColor: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(12), // Adjust padding to shrink the logo
                      child: Image.asset(
                        AppAssets.appLogo,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  SizedBox(height: hp(3)),
                  Text(
                    'Forgot password',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w900,
                      fontSize: 23
                    ),
                  ),
                  SizedBox(height: hp(1)),
                  Text(
                    'Enter the email address linked to your account',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: AppColors.onBackgroundSurface,
                      fontSize: 13
                    )
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: wp(100),
            height: hp(100),
            color: AppColors.grayOverlay,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: wp(5), vertical: hp(30)),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: wp(5)),

              decoration: BoxDecoration(
                  color: AppColors.onPrimary,
                  borderRadius: BorderRadius.circular(wp(5)),
                  border: Border.all(
                    color: AppColors.onBackgroundSurface2,
                    width: 0.5,
                  )
              ),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: wp(75)),
                    child: Icon(
                        color: AppColors.onBackgroundSurface,
                        size: 25.0,
                        Icons.cancel
                    ),
                  ),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset(
                          AppAssets.passwordReset,
                          width: wp(25),
                          height: hp(20),
                        ),
                        Column(
                          children: [
                            Text(
                              'A reset link has been sent to',
                              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                  color: AppColors.onBackgroundSurface,
                                  fontSize: 13
                              ),
                            ),
                            Text(
                              'oye******@gmail.com.',
                              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                  color: AppColors.onBackgroundSurface,
                                  fontSize: 13
                              ),
                            ),
                            Text(
                              'Click the link to reset your password',
                              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                  color: AppColors.onBackgroundSurface,
                                  fontSize: 13
                              ),
                            )
                          ],
                        ),
                      ]
                  ),
                ],
              )
            ),
          )
        ],
      ),
    );
  }
}
