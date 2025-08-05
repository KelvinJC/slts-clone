import 'package:flutter/material.dart';
import 'package:slts_enforcer_app/ui/utils/responsive.dart';
import 'package:slts_enforcer_app/ui/themes/app_colors.dart';
import 'package:slts_enforcer_app/ui/widgets/blurry_gradient_background.dart';
import '../widgets/2fa_token_form_widget.dart';
import '../widgets/app_logo_avatar.dart';
// import '../providers/auth_notifier.dart';


class TwoFactorAuthScreen extends StatelessWidget {
  const TwoFactorAuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final hp = context.hp;
    final wp = context.wp;

    return Scaffold(
      body: Stack(
        children: [
          BlurryGradientBackground(colors: AppColors.homeGradient),
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: hp(5)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppLogoAvatar(),
                    SizedBox(height: wp(3)),
                    Column(
                      children: [
                        Text(
                          'Two-Factor',
                          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              fontWeight: FontWeight.w900,
                              fontSize: 23
                          ),
                        ),
                        Text(
                          'Authentication',
                          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              fontWeight: FontWeight.w900,
                              fontSize: 23
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: hp(1)),
                    Text(
                        'Enter the 2FA code linked to your account.',
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            color: AppColors.onBackgroundSurface,
                            fontSize: 13
                        )
                    ),
                    SizedBox(height: hp(5)),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: wp(2)),
                          child: const FractionallySizedBox(
                            widthFactor: 1,
                            child: TwoFactorAuthForm(),
                          ),
                        ),
                        // Padding(
                        //     padding: EdgeInsets.symmetric(horizontal: wp(2)),
                        //     child: TwoFactorAuthForm(),
                        // ),
                        SizedBox(height: hp(4)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
