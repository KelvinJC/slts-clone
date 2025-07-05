import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:slts_enforcer_app/ui/utils/responsive.dart';
import 'package:slts_enforcer_app/ui/themes/app_colors.dart';
import 'package:slts_enforcer_app/ui/widgets/blurry_gradient_background.dart';
import 'package:slts_enforcer_app/ui/utils/app_assets.dart';

import '../widgets/app_logo_avatar.dart';
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
            child: Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: hp(5)),
                  AppLogoAvatar(),
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
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: wp(9)),
              child: Container(
                height: hp(40),
                width: wp(100),
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
                    Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          icon: Icon(
                              size: 25.0,
                              Icons.cancel,
                              color: AppColors.onBackgroundSurface
                          ),
                          onPressed: () => Navigator.pop(context),
                        )
                    ),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset(
                            AppAssets.passwordReset,
                            width: wp(20),
                            height: hp(20),
                          ),
                          Column(
                            children: [
                              Text(
                                'A reset link has been sent to',
                                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                    color: AppColors.onBackgroundSurface,
                                    fontSize: 12
                                ),
                              ),
                              Text(
                                'oye******@gmail.com.',
                                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                    color: AppColors.onBackgroundSurface,
                                    fontSize: 12
                                ),
                              ),
                              Text(
                                'Click the link to reset your password',
                                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                    color: AppColors.onBackgroundSurface,
                                    fontSize: 12
                                ),
                              )
                            ],
                          ),
                        ]
                    ),
                  ],
                )
              ),
            ),
          )
        ],
      ),
    );
  }
}
